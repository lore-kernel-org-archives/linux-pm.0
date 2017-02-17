From: Markus Mayer <code@mmayer.net>
Subject: [PATCH v2] MAINTAINERS: cpufreq: add bmips-cpufreq.c
Date: Fri, 17 Feb 2017 12:27:03 -0800
Message-ID: <20170217202704.33596-1-code@mmayer.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-out-no.shaw.ca ([64.59.134.9]:48719 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934810AbdBQU1Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2017 15:27:16 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Markus Mayer <mmayer@broadcom.com>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Markus Mayer <mmayer@broadcom.com>

Add maintainer information for bmips-cpufreq.c.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---

This is based on PM's linux-next from today (February 17).

This patch could be squashed into patch 3/4 of the original series if that
is acceptable (see [1]) or it can remain separate.

[1] https://lkml.org/lkml/2017/2/7/775

Changes in v2:
  - added bcm-kernel-feedback-list@broadcom.com

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 107c10e..d4ac248 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2692,6 +2692,13 @@ F:	drivers/irqchip/irq-brcmstb*
 F:	include/linux/bcm963xx_nvram.h
 F:	include/linux/bcm963xx_tag.h
 
+BROADCOM BMIPS CPUFREQ DRIVER
+M:	Markus Mayer <mmayer@broadcom.com>
+M:	bcm-kernel-feedback-list@broadcom.com
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/cpufreq/bmips-cpufreq.c
+
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
 M:	Siva Reddy Kallam <siva.kallam@broadcom.com>
 M:	Prashant Sreedharan <prashant@broadcom.com>
-- 
2.7.4
