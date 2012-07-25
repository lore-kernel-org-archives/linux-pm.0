From: Len Brown <lenb@kernel.org>
Subject: [PATCH 36/52] ACPI: acpi_pad: tune round_robin_time
Date: Tue, 24 Jul 2012 23:41:32 -0400
Message-ID: <fa7584e13ac8e6a306085bba0a931f3135f1d8c4.1343187617.git.len.brown@intel.com>
References: <1343187708-19532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1343187708-19532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
References: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

In an effort to be fair to bound processes,
acpi_pad periodically moves its forced-idle threads.

The default interval for moving the threads is 10 seconds.
Measurements show that reducing this to 1 second has no
power or performance impact, so reduce default to 1 second.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpi_pad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 1c09e1b..f3e959f 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -144,7 +144,7 @@ static void exit_round_robin(unsigned int tsk_index)
 }
 
 static unsigned int idle_pct = 5; /* percentage */
-static unsigned int round_robin_time = 10; /* second */
+static unsigned int round_robin_time = 1; /* second */
 static int power_saving_thread(void *data)
 {
 	struct sched_param param = {.sched_priority = 1};
-- 
1.7.12.rc0

