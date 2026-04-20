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

The script should share a link to the frontend service. Click on it and play around with the app. It's likely that no everything works. This is where the the hacking starts.

Now we're ready to build more. To take advantage of Gemini 3.1 Pro Preview, we need to use the `gemini` CLI:

```bash
gemini --model gemini-3.1-pro-preview
```

From here, you can use natural language prompts to ask questions about the codebase, fix issues, or add features.

