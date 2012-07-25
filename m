From: Len Brown <lenb@kernel.org>
Subject: [PATCH 29/52] ACPI: acpi_pad: rename "power_saving" thread to "acpi_pad" thread
Date: Tue, 24 Jul 2012 23:41:25 -0400
Message-ID: <150ed86fade791d82319b27e84a7a6d2de84d1fa.1343187617.git.len.brown@intel.com>
References: <1343187708-19532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1343187708-19532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
References: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

"acpi_pad/%d" is a better thread name than
generic "power_saving/%d" because users who see
these threads will know the name of the driver
that caused them.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpi_pad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index a43fa1a..1c09e1b 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -234,7 +234,7 @@ static int create_power_saving_task(void)
 
 	ps_tsks[ps_tsk_num] = kthread_run(power_saving_thread,
 		(void *)(unsigned long)ps_tsk_num,
-		"power_saving/%d", ps_tsk_num);
+		"acpi_pad/%d", ps_tsk_num);
 	rc = IS_ERR(ps_tsks[ps_tsk_num]) ? PTR_ERR(ps_tsks[ps_tsk_num]) : 0;
 	if (!rc)
 		ps_tsk_num++;
-- 
1.7.12.rc0
