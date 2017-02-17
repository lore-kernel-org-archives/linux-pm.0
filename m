From: Markus Mayer <code@mmayer.net>
Subject: [PATCH] MAINTAINERS: cpufreq: add bmips-cpufreq.c
Date: Fri, 17 Feb 2017 10:30:50 -0800
Message-ID: <20170217183050.31889-1-code@mmayer.net>
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Ralf Baechle <ralf@linux-mips.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Markus Mayer <mmayer@broadcom.com>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

Add maintainer information for bmips-cpufreq.c.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---

This is based on PM's linux-next from today (February 17).

This patch could be squashed into patch 3/4 of the original series if that
is acceptable (see [1]) or it can remain separate.

[1] https://lkml.org/lkml/2017/2/7/775

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 107c10e..db251c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2692,6 +2692,12 @@ F:	drivers/irqchip/irq-brcmstb*
 F:	include/linux/bcm963xx_nvram.h
 F:	include/linux/bcm963xx_tag.h
 
+BROADCOM BMIPS CPUFREQ DRIVER
+M:	Markus Mayer <mmayer@broadcom.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/cpufreq/bmips-cpufreq.c
+
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
 M:	Siva Reddy Kallam <siva.kallam@broadcom.com>
 M:	Prashant Sreedharan <prashant@broadcom.com>
-- 
2.7.4
