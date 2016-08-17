From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 1/2] MAINTAINERS: update power-supply git-tree
Date: Wed, 17 Aug 2016 15:20:00 +0200
Message-ID: <1471440001-10423-1-git-send-email-sre@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56100 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539AbcHQNUI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Aug 2016 09:20:08 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

When I took over the power-supply tree, its git tree was
hosted on git.infradead.org. Since a few kernel releases
I also maintain a copy of the repository on git.kernel.org,
that is prefered by Linus, so let's switch over officially.
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c7d6762424a1..923b138836b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9329,7 +9329,7 @@ M:	Sebastian Reichel <sre@kernel.org>
 M:	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
 M:	David Woodhouse <dwmw2@infradead.org>
 L:	linux-pm@vger.kernel.org
-T:	git git://git.infradead.org/battery-2.6.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/supply/
 F:	include/linux/power_supply.h
@@ -11332,7 +11332,7 @@ M:	Sebastian Reichel <sre@kernel.org>
 M:	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
 M:	David Woodhouse <dwmw2@infradead.org>
 L:	linux-pm@vger.kernel.org
-T:	git git://git.infradead.org/battery-2.6.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/reset/
 F:	drivers/power/reset/
-- 
2.8.1

