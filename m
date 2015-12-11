From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v3 12/20] MAINTAINERS: Add samsung bus frequency driver entry
Date: Fri, 11 Dec 2015 14:07:51 +0900
Message-ID: <1449810479-14763-13-git-send-email-cw00.choi@samsung.com>
References: <1449810479-14763-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1449810479-14763-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the 'SAMSUNG BUS FREQUENCY DRIVER' entry to review the
patches as supporter. Patches will be picked up by DEVFREQ maintainer
on devfreq git repository.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ff2d20173d98..89e645688a3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3434,6 +3434,15 @@ F:	drivers/devfreq/devfreq-event.c
 F:	include/linux/devfreq-event.h
 F:	Documentation/devicetree/bindings/devfreq/event/
 
+SAMSUNG BUS FREQUENCY DRIVER
+M:	Chanwoo Choi <cw00.choi@samsung.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
+S:	Supported
+F:	drivers/devfreq/exynos/exynos-bus.c
+F:	Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+
 DEVICE NUMBER REGISTRY
 M:	Torben Mathiasen <device@lanana.org>
 W:	http://lanana.org/docs/device-list/index.html
-- 
1.9.1
