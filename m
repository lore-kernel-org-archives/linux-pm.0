From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v2 10/12] ARM: mvebu: Set the start address of a CPU in a separate function
Date: Fri, 13 Sep 2013 12:06:39 +0200
Message-ID: <1379066801-16276-11-git-send-email-gregory.clement@free-electrons.com>
References: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:44179 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755360Ab3IMKHA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 06:07:00 -0400
In-Reply-To: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Chris Van Hoof <vanhoof@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Atsushi Yamagata <yamagata@plathome.co.jp>, Hironobu Shibata <h-shibata@plathome.co.jp>, Tomonori Kimura <kimura@plathome.co.jp>

Setting the start (or boot) address of A CPU is no more used only
during SMP bring up, but will also be used by the CPU idle functions
or later by the CPU hot plug ones.

This commit moves it in a separate function and exports it.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c         | 10 ++++++++--
 include/linux/armada-370-xp-pmsu.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 29ea8c5..5abca96 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -56,6 +56,13 @@ static struct of_device_id of_pmsu_table[] = {
 	{ /* end of list */ },
 };
 
+void armada_370_xp_pmsu_set_start_addr(void *start_addr, int hw_cpu)
+{
+	writel(virt_to_phys(start_addr), pmsu_mp_base +
+		PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
+}
+EXPORT_SYMBOL_GPL(armada_370_xp_pmsu_set_start_addr);
+
 #ifdef CONFIG_SMP
 int armada_xp_boot_cpu(unsigned int cpu_id, void *boot_addr)
 {
@@ -68,8 +75,7 @@ int armada_xp_boot_cpu(unsigned int cpu_id, void *boot_addr)
 
 	hw_cpu = cpu_logical_map(cpu_id);
 
-	writel(virt_to_phys(boot_addr), pmsu_mp_base +
-			PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
+	armada_370_xp_pmsu_set_start_addr(boot_addr, hw_cpu);
 
 	/* Release CPU from reset by clearing reset bit*/
 	reg = readl(pmsu_reset_base + PMSU_RESET_CTL_OFFSET(hw_cpu));
diff --git a/include/linux/armada-370-xp-pmsu.h b/include/linux/armada-370-xp-pmsu.h
index 235a40c..e09977b 100644
--- a/include/linux/armada-370-xp-pmsu.h
+++ b/include/linux/armada-370-xp-pmsu.h
@@ -14,5 +14,6 @@
 void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void);
 void armada_370_xp_pmsu_idle_prepare(bool deepidle);
 void armada_370_xp_pmsu_idle_restore(void);
+void armada_370_xp_pmsu_set_start_addr(void *start_addr, int hw_cpu);
 
 #endif	/* __ARMADA_370_XP__PMSU_H */
-- 
1.8.1.2

