From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 4/4] cpuidle: (POWER) Handle power_save=off
Date: Wed, 30 Nov 2011 18:17:03 +0530
Message-ID: <20111130124701.972.7269.stgit@deepthi-ThinkPad-T420>
References: <20111130124608.972.87712.stgit@deepthi-ThinkPad-T420>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20111130124608.972.87712.stgit@deepthi-ThinkPad-T420>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: benh@kernel.crashing.org, len.brown@intel.com
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch makes pseries_idle_driver not to be registered when
power_save=off kernel boot option is specified. The
cpuidle_disable variable used here is similar to
its usage on x86. If cpuidle_disable is set then
sysfs entries for cpuidle framework are not created
and the required drivers are not loaded.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Signed-off-by: Trinabh Gupta <g.trinabh@gmail.com>
Signed-off-by: Arun R Bharadwaj <arun.r.bharadwaj@gmail.com>
---
 arch/powerpc/include/asm/processor.h            |    1 +
 arch/powerpc/platforms/pseries/processor_idle.c |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 811b7e7..b585bff 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -382,6 +382,7 @@ static inline unsigned long get_clean_sp(struct pt_regs *regs, int is_32)
 }
 #endif
 
+extern unsigned long cpuidle_disable;
 enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index 352b78a..4f59af0 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -269,6 +269,9 @@ static int pseries_idle_probe(void)
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
 		return -ENODEV;
 
+	if (cpuidle_disable != IDLE_NO_OVERRIDE)
+		return -ENODEV;
+
 	if (max_idle_state == 0) {
 		printk(KERN_DEBUG "pseries processor idle disabled.\n");
 		return -EPERM;
