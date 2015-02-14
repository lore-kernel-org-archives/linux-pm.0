From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 2/8] pm: domains: avoid potential oops in
 pm_genpd_remove_device()
Date: Sat, 14 Feb 2015 15:27:35 +0000
Message-ID: <E1YMed5-00054V-QK@rmk-PC.arm.linux.org.uk>
References: <20150214152659.GI8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:41059 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbbBNP1t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 14 Feb 2015 10:27:49 -0500
In-Reply-To: <20150214152659.GI8656@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

pm_genpd_remove_device() should only be called with valid and present
pm domain.  There are circumstances where we may end up with something
that isn't a generic PM domain in dev->pm_domain (eg, vga_switcheroo
stuff.)

Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b3fbc21da2dc..11a1023fa64a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1509,7 +1509,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 
 	dev_dbg(dev, "%s()\n", __func__);
 
-	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev)
+	if (!pm_genpd_present(genpd) || IS_ERR_OR_NULL(dev)
 	    ||  IS_ERR_OR_NULL(dev->pm_domain)
 	    ||  pd_to_genpd(dev->pm_domain) != genpd)
 		return -EINVAL;
-- 
1.8.3.1

