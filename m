From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 03/10] pm: domains: avoid potential oops in
 pm_genpd_remove_device()
Date: Fri, 13 Mar 2015 16:23:30 +0000
Message-ID: <E1YWSN0-0006G1-I1@rmk-PC.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:43475 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163AbbCMQXx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 12:23:53 -0400
In-Reply-To: <20150312183020.GU8656@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

pm_genpd_remove_device() tries hard to validate the generic PM domain
passed to it, but the validation is not complete.

dev->pm_domain contains a struct dev_pm_domain, which is the "base
class" of generic PM domains.  Other users of dev_pm_domains include
stuff like vga_switheroo.  Hence, a device could have a generic PM
domain or a vga_switcheroo PM domain in dev->pm_domain.

We need ot be certain that the PM domain is actually valid before we
try to remove it.  We can do this easily as we have a way to get the
current validated generic PM domain for a struct device.  This must
match the generic PM domain being requested for removal.

Convert the code to use this alternative validation method instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/base/power/domain.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b9000b245e62..69fa87aa3b52 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1534,9 +1534,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 
 	dev_dbg(dev, "%s()\n", __func__);
 
-	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev)
-	    ||  IS_ERR_OR_NULL(dev->pm_domain)
-	    ||  pd_to_genpd(dev->pm_domain) != genpd)
+	if (!genpd || genpd != pm_genpd_lookup_dev(dev))
 		return -EINVAL;
 
 	genpd_acquire_lock(genpd);
-- 
1.8.3.1

