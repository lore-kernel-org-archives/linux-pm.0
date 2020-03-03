Return-Path: <SRS0=OBSp=4U=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412A0C3F2C6
	for <linux-pm@archiver.kernel.org>; Tue,  3 Mar 2020 13:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1847D21775
	for <linux-pm@archiver.kernel.org>; Tue,  3 Mar 2020 13:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583243532;
	bh=qre5Srpv8e+MQkCQYm247Dm06mD+ohXCbI5QHRiOw9Q=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=17sanL4602X8vlB20EKoUEXQnuRB4Oas7VIaIvSpgoSim0/07kORkb6ordIC4M/oX
	 bNL/+zqS/+BSYz8QzoZtZBEZeOyHfJitVKi5puMfR/8sqMu/U4HylypjGDDh/RwBB+
	 o3TlS/WDCyxg5OV6pCNaRWmigOMyxO9pQdOVYKZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgCCNwL (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:52:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728771AbgCCNwL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Mar 2020 08:52:11 -0500
Received: from mail.kernel.org (tmo-101-56.customers.d1-online.com [80.187.101.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DA1520863;
        Tue,  3 Mar 2020 13:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583243530;
        bh=qre5Srpv8e+MQkCQYm247Dm06mD+ohXCbI5QHRiOw9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qpgjGLMQr+ot+masC++0MfH4MY5+p7SzB77fhn66eyXimMn/F9h/6pkREe5Ha2lEs
         LE/smT81nLmYolkwzGZ21UvvKirldeXIns7C+UUqJMqNkUb7zhe1rbdIHrSUVc94NF
         MWYbY5K3E6cpM2Fa3JNK0MMepYjkKH6f/SN1DatI=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j97xw-001YXV-5C; Tue, 03 Mar 2020 14:52:08 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 3/5] docs: cpu-freq: convert core.txt to ReST
Date:   Tue,  3 Mar 2020 14:52:04 +0100
Message-Id: <e7bf15f0974aa509f494091d91f6b8d6f4562ff6.1583243272.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583243272.git.mchehab+huawei@kernel.org>
References: <cover.1583243272.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

- Add a SPDX header;
- Adjust the  document title, based on the original contents of
  cpu-freq/index.txt;
- Use lists where needed;
- Comment out the existing text-only index;
- use ``foo`` to mark a literal expression with asterisk;
- Adjust some title marks;
- Add table markups;
- Add notes markups;
- Some whitespace fixes and new line breaks;
- Add it to cpu-freq/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/cpu-freq/{core.txt => core.rst} | 65 ++++++++++---------
 Documentation/cpu-freq/index.rst              |  2 +
 2 files changed, 35 insertions(+), 32 deletions(-)
 rename Documentation/cpu-freq/{core.txt => core.rst} (69%)

diff --git a/Documentation/cpu-freq/core.txt b/Documentation/cpu-freq/core.rst
similarity index 69%
rename from Documentation/cpu-freq/core.txt
rename to Documentation/cpu-freq/core.rst
index ed577d9c154b..33cb90bd1d8f 100644
--- a/Documentation/cpu-freq/core.txt
+++ b/Documentation/cpu-freq/core.rst
@@ -1,31 +1,23 @@
-     CPU frequency and voltage scaling code in the Linux(TM) kernel
+.. SPDX-License-Identifier: GPL-2.0
 
+=============================================================
+General description of the CPUFreq core and CPUFreq notifiers
+=============================================================
 
-		         L i n u x    C P U F r e q
+Authors:
+	- Dominik Brodowski  <linux@brodo.de>
+	- David Kimdon <dwhedon@debian.org>
+	- Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+	- Viresh Kumar <viresh.kumar@linaro.org>
 
-			  C P U F r e q    C o r e
+.. Contents:
 
-
-		    Dominik Brodowski  <linux@brodo.de>
-		     David Kimdon <dwhedon@debian.org>
-		Rafael J. Wysocki <rafael.j.wysocki@intel.com>
-		   Viresh Kumar <viresh.kumar@linaro.org>
-
-
-
-   Clock scaling allows you to change the clock speed of the CPUs on the
-    fly. This is a nice method to save battery power, because the lower
-            the clock speed, the less power the CPU consumes.
-
-
-Contents:
----------
-1.  CPUFreq core and interfaces
-2.  CPUFreq notifiers
-3.  CPUFreq Table Generation with Operating Performance Point (OPP)
+   1.  CPUFreq core and interfaces
+   2.  CPUFreq notifiers
+   3.  CPUFreq Table Generation with Operating Performance Point (OPP)
 
 1. General Information
-=======================
+======================
 
 The CPUFreq core code is located in drivers/cpufreq/cpufreq.c. This
 cpufreq code offers a standardized interface for the CPUFreq
@@ -63,7 +55,7 @@ The phase is specified in the second argument to the notifier.  The phase is
 CPUFREQ_CREATE_POLICY when the policy is first created and it is
 CPUFREQ_REMOVE_POLICY when the policy is removed.
 
-The third argument, a void *pointer, points to a struct cpufreq_policy
+The third argument, a ``void *pointer``, points to a struct cpufreq_policy
 consisting of several values, including min, max (the lower and upper
 frequencies (in kHz) of the new policy).
 
@@ -80,10 +72,13 @@ CPUFREQ_POSTCHANGE.
 
 The third argument is a struct cpufreq_freqs with the following
 values:
-cpu	- number of the affected CPU
-old	- old frequency
-new	- new frequency
-flags	- flags of the cpufreq driver
+
+=====	===========================
+cpu	number of the affected CPU
+old	old frequency
+new	new frequency
+flags	flags of the cpufreq driver
+=====	===========================
 
 3. CPUFreq Table Generation with Operating Performance Point (OPP)
 ==================================================================
@@ -94,9 +89,12 @@ dev_pm_opp_init_cpufreq_table -
 	the OPP layer's internal information about the available frequencies
 	into a format readily providable to cpufreq.
 
-	WARNING: Do not use this function in interrupt context.
+	.. Warning::
+
+	   Do not use this function in interrupt context.
+
+	Example::
 
-	Example:
 	 soc_pm_init()
 	 {
 		/* Do things */
@@ -106,7 +104,10 @@ dev_pm_opp_init_cpufreq_table -
 		/* Do other things */
 	 }
 
-	NOTE: This function is available only if CONFIG_CPU_FREQ is enabled in
-	addition to CONFIG_PM_OPP.
+	.. note::
 
-dev_pm_opp_free_cpufreq_table - Free up the table allocated by dev_pm_opp_init_cpufreq_table
+	   This function is available only if CONFIG_CPU_FREQ is enabled in
+	   addition to CONFIG_PM_OPP.
+
+dev_pm_opp_free_cpufreq_table
+	Free up the table allocated by dev_pm_opp_init_cpufreq_table
diff --git a/Documentation/cpu-freq/index.rst b/Documentation/cpu-freq/index.rst
index 1bff3dfddd23..53501c58f41d 100644
--- a/Documentation/cpu-freq/index.rst
+++ b/Documentation/cpu-freq/index.rst
@@ -14,6 +14,8 @@ Author: Dominik Brodowski  <linux@brodo.de>
 .. toctree::
    :maxdepth: 1
 
+   core
+
 Mailing List
 ------------
 There is a CPU frequency changing CVS commit and general list where
-- 
2.24.1

