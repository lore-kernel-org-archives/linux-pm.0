From: malattia@linux.it
Subject: [PATCH 2/3] Fix cpupower manpages "NAME" section
Date: Wed, 16 Mar 2016 07:13:07 -0700
Message-ID: <1458137588-6126-3-git-send-email-malattia@linux.it>
References: <1458137588-6126-1-git-send-email-malattia@linux.it>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35040 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932868AbcCPONT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 10:13:19 -0400
Received: by mail-pf0-f171.google.com with SMTP id n5so76788499pfn.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 07:13:19 -0700 (PDT)
In-Reply-To: <1458137588-6126-1-git-send-email-malattia@linux.it>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, Mattia Dongili <malattia@linux.it>

From: Mattia Dongili <malattia@linux.it>

The token before "-" should be the program name, no spaces allowed.
See man(7) and lexgrog(1).

Signed-off-by: Mattia Dongili <malattia@linux.it>
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
2.7.0

