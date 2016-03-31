From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v7 10/20] MAINTAINERS: Add samsung bus frequency driver entry
Date: Thu, 31 Mar 2016 18:05:55 +0900
Message-ID: <1459415165-32613-11-git-send-email-cw00.choi@samsung.com>
References: <1459415165-32613-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1459415165-32613-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the 'BUS FREQUENCY DRIVER FOR SAMSUNG EXYNOS' entry to review the
patches as maintainer. I can access the all datasheet of Exynos SoC and test it
on some Exynos-based board. Patches will be picked up by DEVFREQ maintainer
on devfreq git repository.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03e00c7c88eb..a7d276d0a9f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3539,6 +3539,15 @@ F:	drivers/devfreq/devfreq-event.c
 F:	include/linux/devfreq-event.h
 F:	Documentation/devicetree/bindings/devfreq/event/
 
+BUS FREQUENCY DRIVER FOR SAMSUNG EXYNOS
+M:	Chanwoo Choi <cw00.choi@samsung.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
+S:	Maintained
+F:	drivers/devfreq/exynos-bus.c
+F:	Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+
 DEVICE NUMBER REGISTRY
 M:	Torben Mathiasen <device@lanana.org>
 W:	http://lanana.org/docs/device-list/index.html
-- 
1.9.1
