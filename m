From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v5 3/5] x86, apic: Add freeze event support
Date: Fri,  7 Jul 2017 17:03:01 -0700
Message-ID: <20170708000303.21863-3-dbasehore@chromium.org>
References: <20170708000303.21863-1-dbasehore@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170708000303.21863-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, x86@kernel.org, platform-driver-x86@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Derek Basehore <dbasehore@chromium.org>
List-Id: linux-pm@vger.kernel.org

This adds support to the clock event devices created by apic to use
freeze events. The apic is able to run a timer during freeze with near
zero power impact on modern CPUs such as skylake. This will allow
S0ix, suspend-to-idle, to be validated on Intel CPUs that support it.

This is needed because bugs with power settings on the SoC can prevent
S0ix entry. There is also no way to check this before idling all of
the CPUs.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 arch/x86/kernel/apic/apic.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 98b3dd8cf2bf..adc69d2f11ce 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -480,6 +480,26 @@ static int lapic_next_deadline(unsigned long delta,
 	return 0;
 }
 
+static int lapic_event_expired(struct clock_event_device *evt)
+{
+	u32 cct;
+
+	cct = apic_read(APIC_TMCCT);
+	return cct == 0 ? 1 : 0;
+}
+
+static int lapic_deadline_expired(struct clock_event_device *evt)
+{
+	u64 msr;
+
+	/*
+	 * When the timer interrupt is triggered, the register is cleared, so a
+	 * non-zero value indicates a pending timer event.
+	 */
+	rdmsrl(MSR_IA32_TSC_DEADLINE, msr);
+	return msr == 0 ? 1 : 0;
+}
+
 static int lapic_timer_shutdown(struct clock_event_device *evt)
 {
 	unsigned int v;
@@ -534,7 +554,8 @@ static struct clock_event_device lapic_clockevent = {
 	.name				= "lapic",
 	.features			= CLOCK_EVT_FEAT_PERIODIC |
 					  CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP
-					  | CLOCK_EVT_FEAT_DUMMY,
+					  | CLOCK_EVT_FEAT_DUMMY
+					  | CLOCK_EVT_FEAT_FREEZE_NONSTOP,
 	.shift				= 32,
 	.set_state_shutdown		= lapic_timer_shutdown,
 	.set_state_periodic		= lapic_timer_set_periodic,
@@ -644,6 +665,7 @@ static void setup_APIC_timer(void)
 		levt->features &= ~(CLOCK_EVT_FEAT_PERIODIC |
 				    CLOCK_EVT_FEAT_DUMMY);
 		levt->set_next_event = lapic_next_deadline;
+		levt->event_expired = lapic_deadline_expired;
 		clockevents_config_and_register(levt,
 						tsc_khz * (1000 / TSC_DIVISOR),
 						0xF, ~0UL);
-- 
2.13.2.725.g09c95d1e9-goog
