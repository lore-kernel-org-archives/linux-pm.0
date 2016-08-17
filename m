From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 2/2] MAINTAINERS: Remove power-supply co-maintainers
Date: Wed, 17 Aug 2016 15:20:01 +0200
Message-ID: <1471440001-10423-2-git-send-email-sre@kernel.org>
References: <1471440001-10423-1-git-send-email-sre@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56138 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539AbcHQNUM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Aug 2016 09:20:12 -0400
In-Reply-To: <1471440001-10423-1-git-send-email-sre@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

This documents the status quo and keeps everyones
cc/to-list a bit shorter.
---
 CREDITS     | 4 ++++
 MAINTAINERS | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/CREDITS b/CREDITS
index 2a3fbcd229e6..af13d1d2f4fb 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1090,6 +1090,10 @@ S: 6350 Stoneridge Mall Road
 S: Pleasanton, CA 94588
 S: USA
 
+N: Dmitry Eremin-Solenikov
+E: dbaryshkov@gmail.com
+D: Power Supply Maintainer from v3.14 - v3.15
+
 N: Doug Evans
 E: dje@cygnus.com
 D: Wrote Xenix FS (part of standard kernel since 0.99.15)
diff --git a/MAINTAINERS b/MAINTAINERS
index 923b138836b9..9074e68baa47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9326,8 +9326,6 @@ F:	drivers/powercap/
 
 POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
 M:	Sebastian Reichel <sre@kernel.org>
-M:	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
-M:	David Woodhouse <dwmw2@infradead.org>
 L:	linux-pm@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 S:	Maintained
@@ -11329,8 +11327,6 @@ F:	drivers/mfd/syscon.c
 
 SYSTEM RESET/SHUTDOWN DRIVERS
 M:	Sebastian Reichel <sre@kernel.org>
-M:	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
-M:	David Woodhouse <dwmw2@infradead.org>
 L:	linux-pm@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 S:	Maintained
-- 
2.8.1

