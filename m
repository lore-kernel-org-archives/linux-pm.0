From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v6 11/21] MAINTAINERS: Add samsung bus frequency driver entry
Date: Mon, 28 Mar 2016 08:38:00 +0900
Message-ID: <1459121890-4601-12-git-send-email-cw00.choi@samsung.com>
References: <1459121890-4601-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:57104 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365AbcC0Xi0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Mar 2016 19:38:26 -0400
In-reply-to: <1459121890-4601-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This patch adds the 'BUS FREQUENCY DRIVER FOR SAMSUNG EXYNOS' entry to review the
patches as maintainer. Patches will be picked up by DEVFREQ maintainer
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

