From: dbasehore@chromium.org
Subject: [PATCH v3 3/5] x86, apic: Add timed freeze support
Date: Wed,  8 Jun 2016 20:08:56 -0700
Message-ID: <1465441738-7972-4-git-send-email-dbasehore@chromium.org>
References: <1465441738-7972-1-git-send-email-dbasehore@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465441738-7972-1-git-send-email-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dbasehore@chromium.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, tglx@linutronix.de, gnomes@lxorguk.ukuu.org.uk, peterz@infradead.org
List-Id: linux-pm@vger.kernel.org

From: Derek Basehore <dbasehore@chromium.org>

This adds support to the clock event devices created by apic to use
timed freeze. The apic is able to run a timer during freeze with near
izero impact on modern CPUs such as skylake. This will allow S0ix,
suspend-to-idle, to be validated on Intel CPUs that support it.

This is needed because bugs with power settings on the SoC can prevent
S0ix entry. There is also no way to check this before idling all of
the CPUs.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 arch/x86/kernel/apic/apic.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 60078a6..f0c5f92 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -475,6 +475,26 @@ static int lapic_next_deadline(unsigned long delta,
 	return 0;
 }
 
+static bool lapic_event_expired(struct clock_event_device *evt)
+{
+	u32 cct;
+
+	cct = apic_read(APIC_TMCCT);
+	return cct == 0;
+}
+
+static bool lapic_deadline_expired(struct clock_event_device *evt)
+{
+	u64 msr;
+
+	/*
+	 * When the timer interrupt is triggered, the register is cleared, so a
+	 * non-zero value indicates a pending timer event.
+	 */
+	rdmsrl(MSR_IA32_TSC_DEADLINE, msr);
+	return msr == 0;
+}
+
 static int lapic_timer_shutdown(struct clock_event_device *evt)
 {
 	unsigned int v;
@@ -529,12 +549,14 @@ static struct clock_event_device lapic_clockevent = {
 	.name			= "lapic",
 	.features		= CLOCK_EVT_FEAT_PERIODIC |
 				  CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP
-				  | CLOCK_EVT_FEAT_DUMMY,
+				  | CLOCK_EVT_FEAT_DUMMY |
+				  CLOCK_EVT_FEAT_FREEZE,
 	.shift			= 32,
 	.set_state_shutdown	= lapic_timer_shutdown,
 	.set_state_periodic	= lapic_timer_set_periodic,
 	.set_state_oneshot	= lapic_timer_set_oneshot,
 	.set_next_event		= lapic_next_event,
+	.event_expired		= lapic_event_expired,
 	.broadcast		= lapic_timer_broadcast,
 	.rating			= 100,
 	.irq			= -1,
@@ -562,6 +584,7 @@ static void setup_APIC_timer(void)
 		levt->features &= ~(CLOCK_EVT_FEAT_PERIODIC |
 				    CLOCK_EVT_FEAT_DUMMY);
 		levt->set_next_event = lapic_next_deadline;
+		levt->event_expired = lapic_deadline_expired;
 		clockevents_config_and_register(levt,
 						(tsc_khz / TSC_DIVISOR) * 1000,
 						0xF, ~0UL);
-- 
2.8.0.rc3.226.g39d4020
