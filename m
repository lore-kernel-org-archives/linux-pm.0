From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] Thermal: Add Linux/Thermal subsystem info in MAINTAINER file
Date: Thu, 15 Nov 2012 08:58:27 +0800
Message-ID: <1352941107.2143.12.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, durga <durgadoss.r@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, jhbird.choi@samsung.com, kuninori.morimoto.gx@renesas.com, eduardo.valentin@ti.com, "hongbo.zhang" <hongbo.zhang@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Sachin Kamat <sachin.kamat@linaro.org>
List-Id: linux-pm@vger.kernel.org

Add Linux/Thermal subsystem info in MAINTAINER file.

All the changes made to the generic thermal layer, or
platform thermal drivers that make use of the thermal layer,
should be sent to linux-pm@vger.kernel.org for discussion.

And as the maintainer, I will only apply the patches that have been
sent to linux-pm@vger.kernel.org.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 MAINTAINERS |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 59203e7..2d8512b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7210,6 +7210,14 @@ L:	linux-xtensa@linux-xtensa.org
 S:	Maintained
 F:	arch/xtensa/
 
+THERMAL
+M:      Zhang Rui <rui.zhang@intel.com>
+L:      linux-pm@vger.kernel.org
+T:      git git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
+S:      Supported
+F:      drivers/thermal/
+F:      include/linux/thermal.h
+
 THINKPAD ACPI EXTRAS DRIVER
 M:	Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>
 L:	ibm-acpi-devel@lists.sourceforge.net
-- 
1.7.9.5



