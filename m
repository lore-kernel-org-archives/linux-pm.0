From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] MAINTAINERS: Add devfreq-event entry
Date: Thu, 05 Nov 2015 12:00:07 +0900
Message-ID: <1446692407-18247-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36824 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031632AbbKEDAY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2015 22:00:24 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patch adds the devfreq-event[1] entry to review the patches
as just supporter. Patches will be picked up by Myungjoo Ham on
devfreq git repository.
[1] https://lkml.org/lkml/2015/1/25/573

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd18978d5ad3..07f2dfaa9236 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3340,6 +3340,15 @@ L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	drivers/devfreq/
 
+DEVICE FREQUENCY EVENT (DEVFREQ-EVENT)
+M:	Chanwoo Choi <cw00.choi@samsung.com>
+L:	linux-pm@vger.kernel.org
+S:	Supported
+F:	drivers/devfreq/event
+F:	drivers/devfreq/devfreq-event.c
+F:	include/linux/devfreq-event.h
+F:	Documentation/devicetree/bindings/devfreq/event
+
 DEVICE NUMBER REGISTRY
 M:	Torben Mathiasen <device@lanana.org>
 W:	http://lanana.org/docs/device-list/index.html
-- 
1.9.1

