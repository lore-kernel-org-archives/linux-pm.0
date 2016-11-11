From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH RESEND] tools/power/cpupower: add libcpupower.so.0.0.1 to .gitignore
Date: Fri, 11 Nov 2016 08:41:14 -0500
Message-ID: <1478871674-30599-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754011AbcKKNlQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Nov 2016 08:41:16 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Thomas Renninger <trenn@suse.com>

Commit ac5a181d065d ("cpupower: Add cpuidle parts into library") added
libcpupower.so.0.0.1 which should be hidden from git commands.  This
patch changes the ignore to all libcpupower.so.* .

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Thomas Renninger <trenn@suse.com>
---
 tools/power/cpupower/.gitignore |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/power/cpupower/.gitignore b/tools/power/cpupower/.gitignore
index d42073f12609..1f9977cc609c 100644
--- a/tools/power/cpupower/.gitignore
+++ b/tools/power/cpupower/.gitignore
@@ -1,7 +1,6 @@
 .libs
 libcpupower.so
-libcpupower.so.0
-libcpupower.so.0.0.0
+libcpupower.so.*
 build/ccdv
 cpufreq-info
 cpufreq-set
-- 
1.7.9.3

