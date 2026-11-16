# Easy Drive — Flutter starter

This is the first runnable UI prototype for Easy Drive, using the approved navy/gold brand and Botswana Pula (BWP).

## Included
- Welcome, registration and login UI
- Passenger home with destination entry and illustrative map placeholder
- Fare proposal screen with +/- fare controls
- Sample driver offers and driver selection flow
- Trip screen with chat/call/WhatsApp consent reminder
- Trips, wallet and profile tabs
- Preview dashboards for passenger, driver, fleet and operational administrator roles
- Responsive Material 3 styling and reusable UI components

## Run locally
1. Install Flutter SDK and Android Studio (or Xcode for iOS).
2. Extract this archive.
3. In this folder run:
   ```bash
   flutter pub get
   flutter run
   ```

## Important implementation status
This is a UI-first prototype, not a production ride-hailing service. Demo data and placeholder actions are used. GPS/maps, OTP authentication, live matching, fare discovery, messaging, masked calling, WhatsApp deep links, payment processing, subscriptions, credit deductions, document verification, cloud storage, audit logging and role-based server authorization still need backend/provider integration and security testing.

Before launch, implement server-side authorization so administrator restrictions cannot be bypassed from the client. Do not store bank details, card details, OTPs or payment credentials directly in the app. Use a compliant payment provider and verify payment/webhook events on the backend.

## Suggested next milestones
1. Complete all passenger screens and validation.
2. Implement driver onboarding, vehicle documents and driver trip workflow.
3. Implement company fleet registration and assignments.
4. Build owner and restricted administrator web dashboards.
5. Add Firebase/backend services, maps and payment integrations.
6. Conduct security, privacy, reliability and Botswana regulatory reviews.
