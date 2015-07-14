From: kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH pm] PM / hibernate: swsusp_page_is_valid() can be static
Date: Tue, 14 Jul 2015 16:23:38 +0800
Message-ID: <20150714082338.GA66904@snb>
References: <201507141612.6eLYehfL%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55908 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbbGNIYj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Jul 2015 04:24:39 -0400
Content-Disposition: inline
In-Reply-To: <201507141612.6eLYehfL%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: kbuild-all@01.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 snapshot.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index ebbb995..0e4112f4 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -925,7 +925,7 @@ static void swsusp_unset_page_forbidden(struct page *page)
 		memory_bm_clear_bit(forbidden_pages_map, page_to_pfn(page));
 }
 
-int swsusp_page_is_valid(struct page *page)
+static int swsusp_page_is_valid(struct page *page)
 {
 	return valid_pages_map ?
 		memory_bm_test_bit(valid_pages_map, page_to_pfn(page)) : 0;
