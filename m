From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] MAINTAINERS: thermal: Remove Eduardo's git tree
Date: Sun, 24 Sep 2017 14:18:23 -0700
Message-ID: <20170924211843.11451-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: code@mmayer.net, mmayer@broadcom.com, rui.zhang@intel.com, Florian Fainelli <f.fainelli@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Eduardo's git tree at:
git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git

has not been updated in months, remove it to avoid any confusing and
patch submissions to stall.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
This is agains Rui's next branch

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 209306019483..cc5bc8d0b48e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13210,7 +13210,6 @@ M:	Zhang Rui <rui.zhang@intel.com>
 M:	Eduardo Valentin <edubezval@gmail.com>
 L:	linux-pm@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
 Q:	https://patchwork.kernel.org/project/linux-pm/list/
 S:	Supported
 F:	drivers/thermal/
-- 
2.11.0
