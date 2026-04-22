## Lab 4: Run the App

### Debug (optional)

With everything else in place, we will attempt to run the backend and frontend services.

To start, run the debug script:

```bash
./debug_local.sh
```

This mimics the Cloud Run environment locally using Docker and a Bastion host tunnel. 

### Deploy

If the previous step looks ok, go ahead and cancel it with `ctrl-c`, deploy the app using the deploy script:

```bash
./deploy.sh
```

The script should share a link to the frontend service. Click on it and play around with the app. Try out "AlloyDB NL" and "Semantic" searches. 

"Vector AI Search" is still not wired up yet. We'll tackle that in the next and final lab.
