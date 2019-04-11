From: Qian Cai <cai@lca.pw>
Subject: [PATCH -next] power/domain_governor: fix a compilation error
Date: Thu, 11 Apr 2019 08:47:39 -0400
Message-ID: <20190411124739.5542-1-cai@lca.pw>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, pavel@ucw.cz, len.brown@intel.com, lina.iyer@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
List-Id: linux-pm@vger.kernel.org

The commit 50899f7d5078 ("PM / Domains: Add genpd governor for CPUs")
introduced a compilation error on arm64 with CONFIG_CPU_IDLE=n because
cpuidle_devices is undefined there.

drivers/base/power/domain_governor.o: In function `cpu_power_down_ok':
drivers/base/power/domain_governor.c:263: undefined reference to
'cpuidle_devices' ld: drivers/base/power/domain_governor.o: relocation
R_AARCH64_ADR_PREL_PG_HI21 against symbol 'cpuidle_devices' which may
bind externally can not be used when making a shared object; recompile
with -fPIC
drivers/base/power/domain_governor.c:263:(.text+0x638): dangerous
relocation: unsupported relocation
drivers/base/power/domain_governor.c:263: undefined reference to
'cpuidle_devices'
make: *** [Makefile:1047: vmlinux] Error 1

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/base/power/domain_governor.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 39c8a699cb53..252d88fcf760 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -270,11 +270,13 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	 */
 	domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
 	for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
-		dev = per_cpu(cpuidle_devices, cpu);
-		if (dev) {
-			next_hrtimer = READ_ONCE(dev->next_hrtimer);
-			if (ktime_before(next_hrtimer, domain_wakeup))
-				domain_wakeup = next_hrtimer;
+		if (IS_ENABLED(CONFIG_CPU_IDLE)) {
+			dev = per_cpu(cpuidle_devices, cpu);
+			if (dev) {
+				next_hrtimer = READ_ONCE(dev->next_hrtimer);
+				if (ktime_before(next_hrtimer, domain_wakeup))
+					domain_wakeup = next_hrtimer;
+			}
 		}
 	}
 
-- 
2.20.1 (Apple Git-117)
