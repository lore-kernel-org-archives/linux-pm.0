From: Len Brown <lenb@kernel.org>
Subject: [PATCH 59/76] cpuidle: power_usage should be declared signed integer
Date: Fri, 30 Mar 2012 06:14:02 -0400
Message-ID: <02401c06b7f6bec65f314e3cec7894502c973501.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@amd.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Boris Ostrovsky <boris.ostrovsky@amd.com>

power_usage is always assigned a negative value and should be declared
a signed integer

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@amd.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpuidle/governors/menu.c |    2 +-
 include/linux/cpuidle.h          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 5c17ca1..0633575 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -236,7 +236,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
 	struct menu_device *data = &__get_cpu_var(menu_devices);
 	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
-	unsigned int power_usage = -1;
+	int power_usage = -1;
 	int i;
 	int multiplier;
 	struct timespec t;
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index d557bcd..6c26a3d 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -44,7 +44,7 @@ struct cpuidle_state {
 
 	unsigned int	flags;
 	unsigned int	exit_latency; /* in US */
-	unsigned int	power_usage; /* in mW */
+	int		power_usage; /* in mW */
 	unsigned int	target_residency; /* in US */
 	unsigned int    disable;
 
-- 
1.7.10.rc2.19.gfae9d

