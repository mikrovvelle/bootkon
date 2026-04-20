## Lab 4: Run the App

One last setup step, let's deploy a VectorAI Search store. Run the following script:

```bash
./search-store.sh
```

With everything else in place, we will attempt to run the backend and frontend services.

To start, run the debug script:

```bash
./debug_local.sh
```

This mimics the Cloud Run environment locally using Docker and a Bastion host tunnel. If that looks ok, go ahead and cancel it with `ctrl-c`, deploy the app using the deploy script:

```bash
./deploy.sh
```



