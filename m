From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 2/2] MAINTAINERS: Add devfreq-event entry
Date: Thu, 05 Nov 2015 13:30:18 +0900
Message-ID: <1446697818-20534-3-git-send-email-cw00.choi@samsung.com>
References: <1446697818-20534-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35673 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932655AbbKEEaW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2015 23:30:22 -0500
In-reply-to: <1446697818-20534-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, joe@perches.com
Cc: kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patch adds the devfreq-event[1] entry to review the patches
as just supporter. Patches will be picked up by Myungjoo Ham on
devfreq git repository.
[1] https://lkml.org/lkml/2015/1/25/573

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7de31f44a48d..3d7e4077567b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3343,6 +3343,16 @@ F:	drivers/devfreq/
 F:	include/linux/devfreq.h
 F:	Documentation/devicetree/bindings/devfreq/
 
+DEVICE FREQUENCY EVENT (DEVFREQ-EVENT)
+M:	Chanwoo Choi <cw00.choi@samsung.com>
+L:	linux-pm@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
+S:	Supported
+F:	drivers/devfreq/event/
+F:	drivers/devfreq/devfreq-event.c
+F:	include/linux/devfreq-event.h
+F:	Documentation/devicetree/bindings/devfreq/event/
+
 DEVICE NUMBER REGISTRY
 M:	Torben Mathiasen <device@lanana.org>
 W:	http://lanana.org/docs/device-list/index.html
-- 
1.9.1

