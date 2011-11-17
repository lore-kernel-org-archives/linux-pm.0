From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 4/4] cpuidle: (POWER) Handle power_save=off
Date: Thu, 17 Nov 2011 16:59:12 +0530
Message-ID: <20111117112906.9191.54050.stgit__14223.0823323645$1321529976$gmane$org@localhost6.localdomain6>
References: <20111117112815.9191.2322.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20111117112815.9191.2322.stgit@localhost6.localdomain6>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch makes pseries_idle_driver not to be registered when
power_save=off kernel boot option is specified. The
boot_option_idle_override variable used here is similar to
its usage on x86.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Signed-off-by: Trinabh Gupta <g.trinabh@gmail.com>
Signed-off-by: Arun R Bharadwaj <arun.r.bharadwaj@gmail.com>
---
 arch/powerpc/include/asm/processor.h            |    1 +
 arch/powerpc/platforms/pseries/processor_idle.c |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 811b7e7..b286fb7 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -382,6 +382,7 @@ static inline unsigned long get_clean_sp(struct pt_regs *regs, int is_32)
 }
 #endif
 
+extern unsigned long  boot_option_idle_override;
 enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index b5addd7..5f74b4e 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -260,6 +260,10 @@ static int pseries_idle_probe(void)
 		return -EPERM;
 	}
 
+	if (boot_option_idle_override != IDLE_NO_OVERRIDE) {
+		return -ENODEV;
+	}
+
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR)) {
 		printk(KERN_DEBUG "Using default idle\n");
 		return -ENODEV;
