From: Victor Aoqui <victora@linux.vnet.ibm.com>
Subject: [PATCH] drivers: cpuidle: Disable preemption before get_lppaca function call in pseries_idle_probe function
Date: Thu, 20 Jul 2017 14:57:35 -0300
Message-ID: <20170720175735.3957-1-victora@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, daniel.lezcano@linaro.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: ltc-interlock@lists.linux.ibm.com, victora@br.ibm.com, victora@linux.vnet.ibm.com, mauricfo@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

When CONFIG_PREEMPT=y, the following warning shows up:

BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
caller is pseries_processor_idle_init+0x58/0x21c

This warning shows up because preemption cannot occur when using
get_paca(), otherwise the paca_struct it points to may be the wrong one
just after.

For this reason, preemption needs to be disabled before
lppaca_shared_proc(get_lppaca()).

Signed-off-by: Victor Aoqui <victora@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-pseries.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index e9b3853..d6dda8c 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -233,12 +233,16 @@ static int pseries_cpuidle_driver_init(void)
  */
 static int pseries_idle_probe(void)
 {
+	int retval;
 
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)
 		return -ENODEV;
 
 	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
-		if (lppaca_shared_proc(get_lppaca())) {
+		preempt_disable();
+		retval = lppaca_shared_proc(get_lppaca());
+		preempt_enable();
+		if (retval) {
 			cpuidle_state_table = shared_states;
 			max_idle_state = ARRAY_SIZE(shared_states);
 		} else {
-- 
1.8.3.1
