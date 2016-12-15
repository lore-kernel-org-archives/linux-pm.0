From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 1/3] MAINTAINERS: Add myself as reviewer for DEVFREQ subsystem
 support
Date: Thu, 15 Dec 2016 18:30:36 +0900
Message-ID: <1481794238-5005-2-git-send-email-cw00.choi@samsung.com>
References: <1481794238-5005-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59810 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755425AbcLOJal (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Dec 2016 04:30:41 -0500
In-reply-to: <1481794238-5005-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

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
index 1174508ee597..3b82c656d78b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3790,6 +3790,7 @@ F:	include/linux/devcoredump.h
 DEVICE FREQUENCY (DEVFREQ)
 M:	MyungJoo Ham <myungjoo.ham@samsung.com>
 M:	Kyungmin Park <kyungmin.park@samsung.com>
+R:	Chanwoo Choi <cw00.choi@samsung.com>
 L:	linux-pm@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
 S:	Maintained
-- 
1.9.1

