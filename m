From: Thomas Renninger <trenn@suse.com>
Subject: [PATCH 3/5] Fix cpupower manpages "NAME" section
Date: Thu, 28 Apr 2016 15:24:38 +0200
Message-ID: <1461849880-24777-3-git-send-email-trenn@suse.com>
References: <1461849880-24777-1-git-send-email-trenn@suse.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33275 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752979AbcD1NYo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 Apr 2016 09:24:44 -0400
In-Reply-To: <1461849880-24777-1-git-send-email-trenn@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, trenn@suse.com, Mattia Dongili <malattia@linux.it>

From: Mattia Dongili <malattia@linux.it>

The token before "-" should be the program name, no spaces allowed.
See man(7) and lexgrog(1).

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Thomas Renninger <trenn@suse.com>
---
 tools/power/cpupower/man/cpupower-frequency-info.1 | 2 +-
 tools/power/cpupower/man/cpupower-frequency-set.1  | 2 +-
 tools/power/cpupower/man/cpupower-idle-info.1      | 2 +-
 tools/power/cpupower/man/cpupower-idle-set.1       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/cpupower/man/cpupower-frequency-info.1 b/tools/power/cpupower/man/cpupower-frequency-info.1
index 9c85a38..6aa8d23 100644
--- a/tools/power/cpupower/man/cpupower-frequency-info.1
+++ b/tools/power/cpupower/man/cpupower-frequency-info.1
@@ -1,7 +1,7 @@
 .TH "CPUPOWER\-FREQUENCY\-INFO" "1" "0.1" "" "cpupower Manual"
 .SH "NAME"
 .LP 
-cpupower frequency\-info \- Utility to retrieve cpufreq kernel information
+cpupower\-frequency\-info \- Utility to retrieve cpufreq kernel information
 .SH "SYNTAX"
 .LP 
 cpupower [ \-c cpulist ] frequency\-info [\fIoptions\fP]
diff --git a/tools/power/cpupower/man/cpupower-frequency-set.1 b/tools/power/cpupower/man/cpupower-frequency-set.1
index 3eacc8d..b505702 100644
--- a/tools/power/cpupower/man/cpupower-frequency-set.1
+++ b/tools/power/cpupower/man/cpupower-frequency-set.1
@@ -1,7 +1,7 @@
 .TH "CPUPOWER\-FREQUENCY\-SET" "1" "0.1" "" "cpupower Manual"
 .SH "NAME"
 .LP 
-cpupower frequency\-set \- A small tool which allows to modify cpufreq settings.
+cpupower\-frequency\-set \- A small tool which allows to modify cpufreq settings.
 .SH "SYNTAX"
 .LP 
 cpupower [ \-c cpu ] frequency\-set [\fIoptions\fP]
diff --git a/tools/power/cpupower/man/cpupower-idle-info.1 b/tools/power/cpupower/man/cpupower-idle-info.1
index 7b3646a..80a1311 100644
--- a/tools/power/cpupower/man/cpupower-idle-info.1
+++ b/tools/power/cpupower/man/cpupower-idle-info.1
@@ -1,7 +1,7 @@
 .TH "CPUPOWER-IDLE-INFO" "1" "0.1" "" "cpupower Manual"
 .SH "NAME"
 .LP
-cpupower idle\-info \- Utility to retrieve cpu idle kernel information
+cpupower\-idle\-info \- Utility to retrieve cpu idle kernel information
 .SH "SYNTAX"
 .LP
 cpupower [ \-c cpulist ] idle\-info [\fIoptions\fP]
diff --git a/tools/power/cpupower/man/cpupower-idle-set.1 b/tools/power/cpupower/man/cpupower-idle-set.1
index 580c4e3..21916cf 100644
--- a/tools/power/cpupower/man/cpupower-idle-set.1
+++ b/tools/power/cpupower/man/cpupower-idle-set.1
@@ -1,7 +1,7 @@
 .TH "CPUPOWER-IDLE-SET" "1" "0.1" "" "cpupower Manual"
 .SH "NAME"
 .LP
-cpupower idle\-set \- Utility to set cpu idle state specific kernel options
+cpupower\-idle\-set \- Utility to set cpu idle state specific kernel options
 .SH "SYNTAX"
 .LP
 cpupower [ \-c cpulist ] idle\-info [\fIoptions\fP]
-- 
1.8.5.6

