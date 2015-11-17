From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / OPP: Add entry in MAINTAINERS
Date: Tue, 17 Nov 2015 14:36:06 +0530
Message-ID: <391a7a0b860973b772894ac53de41ad5f361128a.1447750994.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>, open list <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

Add entry for operating performance points into MAINTAINERS file. This
will also allow get_maintainers to list OPP stakeholders properly.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Hi Rafael,

As discussed separately, I have pointed the tree to my (new) repository,
where I have created two new branches opp/next and opp/fixes for
applying OPP changes.

 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9caa4b28828..bcd7cf801f0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7901,6 +7901,18 @@ S:	Maintained
 F:	net/openvswitch/
 F:	include/uapi/linux/openvswitch.h
 
+OPERATING PERFORMANCE POINTS (OPP)
+M:	Viresh Kumar <vireshk@kernel.org>
+M:	Nishanth Menon <nm@ti.com>
+M:	Stephen Boyd <sboyd@codeaurora.org>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
+F:	drivers/base/power/opp/
+F:	include/linux/pm_opp.h
+F:	Documentation/power/opp.txt
+F:	Documentation/devicetree/bindings/opp/
+
 OPL4 DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-- 
2.6.2.198.g614a2ac
