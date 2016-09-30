From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH] MAINTAINERS: Switch to kernel.org email address for Javi Merino
Date: Fri, 30 Sep 2016 13:14:28 +0100
Message-ID: <1475237668-8408-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932230AbcI3MOj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 30 Sep 2016 08:14:39 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, javi.merino@kernel.org, Javi Merino <javi.merino@arm.com>

Change my email address to my kernel.org account instead of the ARM one.

Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index de22daefd9da..1dab0a156489 100644
--- a/.mailmap
+++ b/.mailmap
@@ -69,6 +69,7 @@ James Bottomley <jejb@mulgrave.(none)>
 James Bottomley <jejb@titanic.il.steeleye.com>
 James E Wilson <wilson@specifix.com>
 James Ketrenos <jketreno@io.(none)>
+Javi Merino <javi.merino@kernel.org> <javi.merino@arm.com>
 <javier@osg.samsung.com> <javier.martinez@collabora.co.uk>
 Jean Tourrilhes <jt@hpl.hp.com>
 Jeff Garzik <jgarzik@pretzel.yyz.us>
diff --git a/MAINTAINERS b/MAINTAINERS
index b003d0ca6238..f593300e310b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11626,7 +11626,7 @@ F:	Documentation/devicetree/bindings/thermal/
 THERMAL/CPU_COOLING
 M:	Amit Daniel Kachhap <amit.kachhap@gmail.com>
 M:	Viresh Kumar <viresh.kumar@linaro.org>
-M:	Javi Merino <javi.merino@arm.com>
+M:	Javi Merino <javi.merino@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/thermal/cpu-cooling-api.txt
-- 
1.9.1

