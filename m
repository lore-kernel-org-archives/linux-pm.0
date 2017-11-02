From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] tools/power/cpupower: add libcpupower.so.0.0.1 to .gitignore
Date: Wed,  1 Nov 2017 20:48:32 -0400
Message-ID: <20171102004832.20172-1-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932169AbdKBAse (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Nov 2017 20:48:34 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Shuah Khan <shuahkh@osg.samsung.com>

Commit ac5a181d065d ("cpupower: Add cpuidle parts into library") added
libcpupower.so.0.0.1 which should be hidden from git commands.  This
patch changes the ignore to all libcpupower.so.* .

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>
---
 tools/power/cpupower/.gitignore | 3 +--
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
2.15.0.rc0.39.g2f0e14e64
