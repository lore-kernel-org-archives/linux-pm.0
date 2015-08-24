From: Petr Mladek <pmladek@suse.com>
Subject: [PATCH] mm/khugepaged: Allow to interrupt allocation sleep again
Date: Mon, 24 Aug 2015 17:13:23 +0200
Message-ID: <1440429203-4039-1-git-send-email-pmladek@suse.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58912 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753923AbbHXPNh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 24 Aug 2015 11:13:37 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, David Rientjes <rientjes@google.com>, Ebru Akagunduz <ebru.akagunduz@gmail.com>, Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org, linux-pm@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Petr Mladek <pmladek@suse.com>

The commit 1dfb059b9438633b0546 ("thp: reduce khugepaged freezing
latency") fixed khugepaged to do not block a system suspend. But
the result is that it could not get interrupted before the given
timeout because the condition for the wait event is "false".

This patch puts back the original approach but it uses
freezable_schedule_timeout_interruptible() instead of
schedule_timeout_interruptible(). It does the right thing.
I am pretty sure that the freezable variant was not used in
the original fix only because it was not available at that time.

The regression has been there for ages. It was not critical. It just
did the allocation throttling a little bit more aggressively.

I found this problem when converting the kthread to kthread worker API
and trying to understand the code.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 mm/huge_memory.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7109330c5911..eb115aaa429c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2368,8 +2368,12 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 
 static void khugepaged_alloc_sleep(void)
 {
-	wait_event_freezable_timeout(khugepaged_wait, false,
-			msecs_to_jiffies(khugepaged_alloc_sleep_millisecs));
+	DEFINE_WAIT(wait);
+
+	add_wait_queue(&khugepaged_wait, &wait);
+	freezable_schedule_timeout_interruptible(
+		msecs_to_jiffies(khugepaged_alloc_sleep_millisecs));
+	remove_wait_queue(&khugepaged_wait, &wait);
 }
 
 static int khugepaged_node_load[MAX_NUMNODES];
-- 
1.8.5.6

