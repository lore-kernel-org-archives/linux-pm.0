From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 3/3] PM / hibernate: Remove the restriction when checking memory size before/after hibernation
Date: Thu, 27 Aug 2015 15:06:26 +0800
Message-ID: <1392db911417124cd85cd8c169c5bc2de4ea5de1.1440640658.git.yu.c.chen@intel.com>
References: <cover.1440640658.git.yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52874 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752527AbbH0HDJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Aug 2015 03:03:09 -0400
In-Reply-To: <cover.1440640658.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, rjw@rjwysocki.net, pavel@ucw.cz, hpa@zytor.com
Cc: len.brown@intel.com, yinghai@kernel.org, joeyli.kernel@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Sometimes the resuming of hibernation might fail, because the
system before/after hibernation have different number of page
frames, and in current implementation, this situation will be
regarded as invalud resuming process. However, consider the following
scenario: The resuming system has a larger memory capacity than
the one before hibernation, and the former memory region is a
superset of the latter, it should be allowed to resume. For example,
someone plugs more DRAMs before resuming from hibernation.
Here's a case for this situation:

e820 memory map before hibernation:
BIOS-e820: [mem 0x0000000020200000-0x0000000077517fff] usable
BIOS-e820: [mem 0x0000000077518000-0x0000000077567fff] reserved

e820 memory map during resuming:
BIOS-e820: [mem 0x0000000020200000-0x000000007753ffff] usable
BIOS-e820: [mem 0x0000000077540000-0x0000000077567fff] reserved

In current code, the resuming process will be terminated, because
they have different memory size(usable region), but actually we should
let it continue to resume because [0x0000000020200000-0x000000007753ffff]
is a superset of [0x0000000020200000-0x0000000077517fff].

This patch removes the constraint that number of page frames should
be strictly the same before/after hibernation.

Note: This patch can only work after:
Commit ec93ef809f34 ("PM / hibernate: avoid unsafe pages in e820
 reserved regions") applied.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/power/snapshot.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index c24d5a2..5b1a071 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2072,8 +2072,12 @@ static int check_header(struct swsusp_info *info)
 	char *reason;
 
 	reason = check_image_kernel(info);
-	if (!reason && info->num_physpages != get_num_physpages())
-		reason = "memory size";
+	/*
+	 * No need to check num_physpages with get_num_physpages
+	 * as we did before(please refer to git log), because
+	 * is_nosave_page will ensure that each page is safe
+	 * to be restored.
+	 */
 	if (reason) {
 		printk(KERN_ERR "PM: Image mismatch: %s\n", reason);
 		return -EPERM;
-- 
1.8.4.2

