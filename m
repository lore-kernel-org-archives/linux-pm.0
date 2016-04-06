From: Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH V1 7/7] MAINTAINERS: add Loongson1 architecture entry
Date: Wed,  6 Apr 2016 20:34:55 +0800
Message-ID: <1459946095-7637-8-git-send-email-keguang.zhang@gmail.com>
References: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-mips@linux-mips.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Ralf Baechle <ralf@linux-mips.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Kelvin Cheung <keguang.zhang@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch adds Loongson1 architecture entry.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03e00c7..f6032a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7271,6 +7271,15 @@ S:	Supported
 F:	Documentation/mips/
 F:	arch/mips/
 
+MIPS/LOONGSON1 ARCHITECTURE
+M:	Keguang Zhang <keguang.zhang@gmail.com>
+L:	linux-mips@linux-mips.org
+S:	Maintained
+F:	arch/mips/loongson32/
+F:	arch/mips/include/asm/mach-loongson32/
+F:	drivers/*/*loongson1*
+F:	drivers/*/*/*loongson1*
+
 MIROSOUND PCM20 FM RADIO RECEIVER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
-- 
1.9.1

