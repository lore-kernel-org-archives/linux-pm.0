From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 1/3] MAINTAINERS: Add myself as reviewer for DEVFREQ
 subsystem support
Date: Wed, 28 Dec 2016 20:52:34 +0900
Message-ID: <1482925956-19044-2-git-send-email-cw00.choi@samsung.com>
References: <1482925956-19044-1-git-send-email-cw00.choi@samsung.com>
 <CGME20161228115241epcas5p4820960ae4518b271350157db7d9c6145@epcas5p4.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:35676 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbcL1Lxf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2016 06:53:35 -0500
In-reply-to: <1482925956-19044-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: chanwoo@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

Add myself to the DEVFREQ entry as reviewer, I've been helping reviewing
and tesing the devfreq support patches for the couple of years. Also,
I'm going to contribute the improvement for devfreq subsystem. It would
be easier for me for review if I'm cc'ed for patches.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cfff2c9e3d94..1a857698ac80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3800,6 +3800,7 @@ F:	include/linux/devcoredump.h
 DEVICE FREQUENCY (DEVFREQ)
 M:	MyungJoo Ham <myungjoo.ham@samsung.com>
 M:	Kyungmin Park <kyungmin.park@samsung.com>
+R:	Chanwoo Choi <cw00.choi@samsung.com>
 L:	linux-pm@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
 S:	Maintained
-- 
1.9.1

