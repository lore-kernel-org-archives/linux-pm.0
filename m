From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2] MAINTAINERS: power_supply: update maintainership
Date: Wed, 16 Jul 2014 20:14:30 +0200
Message-ID: <1405534470-7888-1-git-send-email-sre@kernel.org>
References: <1402759929-15418-1-git-send-email-sre@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:40577 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932418AbaGPSOt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Jul 2014 14:14:49 -0400
In-Reply-To: <1402759929-15418-1-git-send-email-sre@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>

Take over maintanence for orphaned power supply subsystem
and assign linux-pm@vger.kernel.org as mailing list.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
Changes since PATCHv1 [0]:
 * Add linux-pm@vger.kernel.org as mailing list for
   the power supply subsystem
 * Do not change the git tree
   (I will get access to the tree on infradead.org)
 * Do not remove existing maintainers
   (So that they can can take over again when they return)

[0] https://lkml.org/lkml/2014/6/14/89
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c484ac..14e227b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6928,8 +6928,10 @@ F:	include/linux/timer*
 F:	kernel/*timer*
 
 POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
+M:	Sebastian Reichel <sre@kernel.org>
 M:	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
 M:	David Woodhouse <dwmw2@infradead.org>
+L:	linux-pm@vger.kernel.org
 T:	git git://git.infradead.org/battery-2.6.git
 S:	Maintained
 F:	include/linux/power_supply.h
-- 
2.0.1

