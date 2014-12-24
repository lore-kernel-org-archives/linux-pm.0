From: Michal Privoznik <mprivozn@redhat.com>
Subject: [PATCH] cpupower: Correctly detect if running as root
Date: Wed, 24 Dec 2014 12:08:13 +0100
Message-ID: <560101059564609c5c4808eb7aeb8203b6f5c214.1419419293.git.mprivozn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56847 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbaLXLI1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Dec 2014 06:08:27 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Some operations, like frequency-set, need root privileges. However,
the way that this is detected is not correct. The getuid() is called,
while in fact geteuid() should be. This way we can allow
distributions or users to set SETUID flags on the cpupower binary if
they want to and let regular users change the cpu frequency governor.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Acked-by: Thomas Renninger <trenn@suse.de>
---
 tools/power/cpupower/utils/cpupower.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
index 7cdcf88..9ea9143 100644
--- a/tools/power/cpupower/utils/cpupower.c
+++ b/tools/power/cpupower/utils/cpupower.c
@@ -199,7 +199,7 @@ int main(int argc, const char *argv[])
 	}
 
 	get_cpu_info(0, &cpupower_cpu_info);
-	run_as_root = !getuid();
+	run_as_root = !geteuid();
 	if (run_as_root) {
 		ret = uname(&uts);
 		if (!ret && !strcmp(uts.machine, "x86_64") &&
-- 
2.0.5

