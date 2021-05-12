Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEAFC433B4
	for <linux-pm@archiver.kernel.org>; Wed, 12 May 2021 12:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E91B61175
	for <linux-pm@archiver.kernel.org>; Wed, 12 May 2021 12:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhELMxV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 12 May 2021 08:53:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231314AbhELMxD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 May 2021 08:53:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 214F2615FF;
        Wed, 12 May 2021 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823903;
        bh=Ietk1mvu5UTwTosaWKv7VqqVrUmF5h4a2pda5HT4aXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZXhQWhUjqDlWBhz6FktXImmQEM3OKSdB1HsSYulHGRKDXCvKyZ8bursTEJCkNIXc
         dhfzHTiUD/tKWIKnqTgfmgD4fLInwjU095+Y7QfD5NlsF5pFqpSNRUJVqApKp02ZPz
         ItSJ9nwoiqQkRKZd+VOaT+9YtoHKzUGj0h0NKldgJwiUeEFj5goUZANKOwEMqPEkkn
         uzJXGOwIoKBQHdv2XacqJdC169zrnJ9GiSYZ5KZDd9OWl2QJ35T/5GVyx9SEiCTnpI
         ogS9g2dCAgOhgfer4nk5khFIJYwN5npaW8EEFEGMDcKCQPuM7qESKeg991WPC0enwC
         pYfgVI4YakIdg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoKz-0018ig-A9; Wed, 12 May 2021 14:51:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 29/40] docs: power: powercap: powercap.rst: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:33 +0200
Message-Id: <55d3ee048747fa5ad5f7eeacd4cdc2e3d83927b7.1620823573.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
and some automatic rules which exists on certain text editors like
LibreOffice turned ASCII characters into some UTF-8 alternatives that
are better displayed on html and PDF.

While it is OK to use UTF-8 characters in Linux, it is better to
use the ASCII subset instead of using an UTF-8 equivalent character
as it makes life easier for tools like grep, and are easier to edit
with the some commonly used text/source code editors.

Also, Sphinx already do such conversion automatically outside literal blocks:
   https://docutils.sourceforge.io/docs/user/smartquotes.html

So, replace the occurences of the following UTF-8 characters:

	- U+00a0 (' '): NO-BREAK SPACE

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/power/powercap/powercap.rst | 210 +++++++++++-----------
 1 file changed, 105 insertions(+), 105 deletions(-)

diff --git a/Documentation/power/powercap/powercap.rst b/Documentation/power/powercap/powercap.rst
index e75d12596dac..c99122e0a1c8 100644
--- a/Documentation/power/powercap/powercap.rst
+++ b/Documentation/power/powercap/powercap.rst
@@ -34,113 +34,113 @@ Example sysfs interface tree::
   /sys/devices/virtual/powercap
   └──intel-rapl
       ├──intel-rapl:0
-      │   ├──constraint_0_name
-      │   ├──constraint_0_power_limit_uw
-      │   ├──constraint_0_time_window_us
-      │   ├──constraint_1_name
-      │   ├──constraint_1_power_limit_uw
-      │   ├──constraint_1_time_window_us
-      │   ├──device -> ../../intel-rapl
-      │   ├──energy_uj
-      │   ├──intel-rapl:0:0
-      │   │   ├──constraint_0_name
-      │   │   ├──constraint_0_power_limit_uw
-      │   │   ├──constraint_0_time_window_us
-      │   │   ├──constraint_1_name
-      │   │   ├──constraint_1_power_limit_uw
-      │   │   ├──constraint_1_time_window_us
-      │   │   ├──device -> ../../intel-rapl:0
-      │   │   ├──energy_uj
-      │   │   ├──max_energy_range_uj
-      │   │   ├──name
-      │   │   ├──enabled
-      │   │   ├──power
-      │   │   │   ├──async
-      │   │   │   []
-      │   │   ├──subsystem -> ../../../../../../class/power_cap
-      │   │   └──uevent
-      │   ├──intel-rapl:0:1
-      │   │   ├──constraint_0_name
-      │   │   ├──constraint_0_power_limit_uw
-      │   │   ├──constraint_0_time_window_us
-      │   │   ├──constraint_1_name
-      │   │   ├──constraint_1_power_limit_uw
-      │   │   ├──constraint_1_time_window_us
-      │   │   ├──device -> ../../intel-rapl:0
-      │   │   ├──energy_uj
-      │   │   ├──max_energy_range_uj
-      │   │   ├──name
-      │   │   ├──enabled
-      │   │   ├──power
-      │   │   │   ├──async
-      │   │   │   []
-      │   │   ├──subsystem -> ../../../../../../class/power_cap
-      │   │   └──uevent
-      │   ├──max_energy_range_uj
-      │   ├──max_power_range_uw
-      │   ├──name
-      │   ├──enabled
-      │   ├──power
-      │   │   ├──async
-      │   │   []
-      │   ├──subsystem -> ../../../../../class/power_cap
-      │   ├──enabled
-      │   ├──uevent
+      │   ├──constraint_0_name
+      │   ├──constraint_0_power_limit_uw
+      │   ├──constraint_0_time_window_us
+      │   ├──constraint_1_name
+      │   ├──constraint_1_power_limit_uw
+      │   ├──constraint_1_time_window_us
+      │   ├──device -> ../../intel-rapl
+      │   ├──energy_uj
+      │   ├──intel-rapl:0:0
+      │   │   ├──constraint_0_name
+      │   │   ├──constraint_0_power_limit_uw
+      │   │   ├──constraint_0_time_window_us
+      │   │   ├──constraint_1_name
+      │   │   ├──constraint_1_power_limit_uw
+      │   │   ├──constraint_1_time_window_us
+      │   │   ├──device -> ../../intel-rapl:0
+      │   │   ├──energy_uj
+      │   │   ├──max_energy_range_uj
+      │   │   ├──name
+      │   │   ├──enabled
+      │   │   ├──power
+      │   │   │   ├──async
+      │   │   │   []
+      │   │   ├──subsystem -> ../../../../../../class/power_cap
+      │   │   └──uevent
+      │   ├──intel-rapl:0:1
+      │   │   ├──constraint_0_name
+      │   │   ├──constraint_0_power_limit_uw
+      │   │   ├──constraint_0_time_window_us
+      │   │   ├──constraint_1_name
+      │   │   ├──constraint_1_power_limit_uw
+      │   │   ├──constraint_1_time_window_us
+      │   │   ├──device -> ../../intel-rapl:0
+      │   │   ├──energy_uj
+      │   │   ├──max_energy_range_uj
+      │   │   ├──name
+      │   │   ├──enabled
+      │   │   ├──power
+      │   │   │   ├──async
+      │   │   │   []
+      │   │   ├──subsystem -> ../../../../../../class/power_cap
+      │   │   └──uevent
+      │   ├──max_energy_range_uj
+      │   ├──max_power_range_uw
+      │   ├──name
+      │   ├──enabled
+      │   ├──power
+      │   │   ├──async
+      │   │   []
+      │   ├──subsystem -> ../../../../../class/power_cap
+      │   ├──enabled
+      │   ├──uevent
       ├──intel-rapl:1
-      │   ├──constraint_0_name
-      │   ├──constraint_0_power_limit_uw
-      │   ├──constraint_0_time_window_us
-      │   ├──constraint_1_name
-      │   ├──constraint_1_power_limit_uw
-      │   ├──constraint_1_time_window_us
-      │   ├──device -> ../../intel-rapl
-      │   ├──energy_uj
-      │   ├──intel-rapl:1:0
-      │   │   ├──constraint_0_name
-      │   │   ├──constraint_0_power_limit_uw
-      │   │   ├──constraint_0_time_window_us
-      │   │   ├──constraint_1_name
-      │   │   ├──constraint_1_power_limit_uw
-      │   │   ├──constraint_1_time_window_us
-      │   │   ├──device -> ../../intel-rapl:1
-      │   │   ├──energy_uj
-      │   │   ├──max_energy_range_uj
-      │   │   ├──name
-      │   │   ├──enabled
-      │   │   ├──power
-      │   │   │   ├──async
-      │   │   │   []
-      │   │   ├──subsystem -> ../../../../../../class/power_cap
-      │   │   └──uevent
-      │   ├──intel-rapl:1:1
-      │   │   ├──constraint_0_name
-      │   │   ├──constraint_0_power_limit_uw
-      │   │   ├──constraint_0_time_window_us
-      │   │   ├──constraint_1_name
-      │   │   ├──constraint_1_power_limit_uw
-      │   │   ├──constraint_1_time_window_us
-      │   │   ├──device -> ../../intel-rapl:1
-      │   │   ├──energy_uj
-      │   │   ├──max_energy_range_uj
-      │   │   ├──name
-      │   │   ├──enabled
-      │   │   ├──power
-      │   │   │   ├──async
-      │   │   │   []
-      │   │   ├──subsystem -> ../../../../../../class/power_cap
-      │   │   └──uevent
-      │   ├──max_energy_range_uj
-      │   ├──max_power_range_uw
-      │   ├──name
-      │   ├──enabled
-      │   ├──power
-      │   │   ├──async
-      │   │   []
-      │   ├──subsystem -> ../../../../../class/power_cap
-      │   ├──uevent
+      │   ├──constraint_0_name
+      │   ├──constraint_0_power_limit_uw
+      │   ├──constraint_0_time_window_us
+      │   ├──constraint_1_name
+      │   ├──constraint_1_power_limit_uw
+      │   ├──constraint_1_time_window_us
+      │   ├──device -> ../../intel-rapl
+      │   ├──energy_uj
+      │   ├──intel-rapl:1:0
+      │   │   ├──constraint_0_name
+      │   │   ├──constraint_0_power_limit_uw
+      │   │   ├──constraint_0_time_window_us
+      │   │   ├──constraint_1_name
+      │   │   ├──constraint_1_power_limit_uw
+      │   │   ├──constraint_1_time_window_us
+      │   │   ├──device -> ../../intel-rapl:1
+      │   │   ├──energy_uj
+      │   │   ├──max_energy_range_uj
+      │   │   ├──name
+      │   │   ├──enabled
+      │   │   ├──power
+      │   │   │   ├──async
+      │   │   │   []
+      │   │   ├──subsystem -> ../../../../../../class/power_cap
+      │   │   └──uevent
+      │   ├──intel-rapl:1:1
+      │   │   ├──constraint_0_name
+      │   │   ├──constraint_0_power_limit_uw
+      │   │   ├──constraint_0_time_window_us
+      │   │   ├──constraint_1_name
+      │   │   ├──constraint_1_power_limit_uw
+      │   │   ├──constraint_1_time_window_us
+      │   │   ├──device -> ../../intel-rapl:1
+      │   │   ├──energy_uj
+      │   │   ├──max_energy_range_uj
+      │   │   ├──name
+      │   │   ├──enabled
+      │   │   ├──power
+      │   │   │   ├──async
+      │   │   │   []
+      │   │   ├──subsystem -> ../../../../../../class/power_cap
+      │   │   └──uevent
+      │   ├──max_energy_range_uj
+      │   ├──max_power_range_uw
+      │   ├──name
+      │   ├──enabled
+      │   ├──power
+      │   │   ├──async
+      │   │   []
+      │   ├──subsystem -> ../../../../../class/power_cap
+      │   ├──uevent
       ├──power
-      │   ├──async
-      │   []
+      │   ├──async
+      │   []
       ├──subsystem -> ../../../../class/power_cap
       ├──enabled
       └──uevent
-- 
2.30.2

