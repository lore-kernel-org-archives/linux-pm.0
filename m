From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 1/2] MAINTAINERS: Add missing git repository and directory
 for devfreq
Date: Thu, 05 Nov 2015 13:30:17 +0900
Message-ID: <1446697818-20534-2-git-send-email-cw00.choi@samsung.com>
References: <1446697818-20534-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:54786 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932838AbbKEEaW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2015 23:30:22 -0500
In-reply-to: <1446697818-20534-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, joe@perches.com
Cc: kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patch adds the missing git repository infomation and directory for
devfreq. When using get_maintainer.pl, the result should include the
correct maintainer information.

Suggested-by: Joe Perches <joe@perches.com>
[cw00.chio: Add missing directory for devfreq]
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd18978d5ad3..7de31f44a48d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3337,8 +3337,11 @@ DEVICE FREQUENCY (DEVFREQ)
 M:	MyungJoo Ham <myungjoo.ham@samsung.com>
 M:	Kyungmin Park <kyungmin.park@samsung.com>
 L:	linux-pm@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
 S:	Maintained
 F:	drivers/devfreq/
+F:	include/linux/devfreq.h
+F:	Documentation/devicetree/bindings/devfreq/
 
 DEVICE NUMBER REGISTRY
 M:	Torben Mathiasen <device@lanana.org>
-- 
1.9.1

