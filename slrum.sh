# Start salloc in the background
salloc --time=1:00:00 --cpus-per-task=4 --mem=64G --gpus-per-node=1 &
SALLOC_PID=$!

# Poll for the allocation to be ready
while true; do
    # Check if SLURM has assigned nodes to the job
    if squeue --job "$SALLOC_PID" | grep -q " R "; then
        break
    fi
    # Sleep for a few seconds before checking again
    sleep 5
done

# Retrieve GPU information once resources are allocated
GPU_INFO=$(nvidia-smi --query-gpu=name,memory.total --format=csv,noheader,nounits)

# Send the Discord notification
WEBHOOK_URL="https://discord.com/api/webhooks/1304906181919244378/bCm_a9BZVvLZLaQzpI_vwlNUUbHhS6wIb_pqfJeL1MC-BUpoZ8ZM3RbNPyWn9j02rPSv"
curl -X POST -H 'Content-type: application/json' \
  --data "{\"content\":\"Your Slurm allocation is ready! GPU Info: ${GPU_INFO}\"}" \
  $WEBHOOK_URL

# Wait for the actual salloc job to complete
wait $SALLOC_PID
