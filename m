From: Markus Mayer <code@mmayer.net>
Subject: [PATCH 1/3] BMIPS: Enable prerequisites for CPUfreq in MIPS Kconfig.
Date: Wed,  1 Feb 2017 17:05:59 -0800
Message-ID: <20170202010601.75995-2-code@mmayer.net>
References: <20170202010601.75995-1-code@mmayer.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-out-no.shaw.ca ([64.59.134.13]:51731 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdBBBG1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2017 20:06:27 -0500
In-Reply-To: <20170202010601.75995-1-code@mmayer.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Markus Mayer <mmayer@broadcom.com>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Markus Mayer <mmayer@broadcom.com>

Turn on CPU_SUPPORTS_CPUFREQ and MIPS_EXTERNAL_TIMER for BMIPS.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 arch/mips/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3c5bde..e137eed 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1703,6 +1703,8 @@ config CPU_BMIPS
 	select WEAK_ORDERING
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_HAS_PREFETCH
+	select CPU_SUPPORTS_CPUFREQ
+	select MIPS_EXTERNAL_TIMER
 	help
 	  Support for BMIPS32/3300/4350/4380 and BMIPS5000 processors.
 
-- 
2.7.4

