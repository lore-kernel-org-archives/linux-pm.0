From: Chen Yu <yu.c.chen@intel.com>
Subject: [RFC V2] init: support device of major:minor:offset format
Date: Wed,  6 May 2015 08:24:14 +0800
Message-ID: <1430871854-7096-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28843 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682AbbEFAUY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 May 2015 20:20:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: snitzer@redhat.com, rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rui.zhang@intel.com, Chen Yu <yu.c.chen@intel.com>

Distribution like Ubuntu uses klibc rather than uswsusp to resume
system from hibernation, which will treat swap partition/file in
the form of major:minor:offset. For example, 8:3:0 represents a
swap partition in klibc, and klibc's resume process in initrd will
finally echo 8:3:0 to /sys/power/resume for manually restoring.
However in current implementation, 8:3:0 will be treated as an invalid
device format, and it is found that manual resumming from hibernation
will fail on lastest kernel.

This patch adds support for device with major:minor:offset format
when resumming from hibernation.

Reported-by: Prigent Christophe <christophe.prigent@intel.com>
Reported-by: Martin Steigerwald <martin@lichtvoll.de>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 init/do_mounts.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 8369ffa..e2e3538 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -225,10 +225,12 @@ dev_t name_to_dev_t(const char *name)
 #endif
 
 	if (strncmp(name, "/dev/", 5) != 0) {
-		unsigned maj, min;
+		unsigned maj, min, offset;
 		char dummy;
 
-		if (sscanf(name, "%u:%u%c", &maj, &min, &dummy) == 2) {
+		if ((sscanf(name, "%u:%u%c", &maj, &min, &dummy) == 2) ||
+		    (sscanf(name,
+			    "%u:%u:%u:%c", &maj, &min, &offset, &dummy) == 3)) {
 			res = MKDEV(maj, min);
 			if (maj != MAJOR(res) || min != MINOR(res))
 				goto fail;
-- 
1.9.1

