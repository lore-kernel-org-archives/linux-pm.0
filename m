From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 2/5] pm: domains: avoid potential oops in
 pm_genpd_remove_device()
Date: Sun, 27 Apr 2014 14:28:55 +0100
Message-ID: <E1WeP8Z-0000Uk-Uu@rmk-PC.arm.linux.org.uk>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:53681 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751858AbaD0N3A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Apr 2014 09:29:00 -0400
In-Reply-To: <20140427132312.GC26756@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>

pm_genpd_remove_device() should only be called with valid and present
pm domain.  There are circumstances where we may end up with something
that isn't a generic PM domain in dev->pm_domain (eg, vga_switcheroo
stuff.)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index ea91ea0e137b..9d8faecc060c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1531,7 +1531,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 
 	dev_dbg(dev, "%s()\n", __func__);
 
-	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev)
+	if (!pm_genpd_present(genpd) || IS_ERR_OR_NULL(dev)
 	    ||  IS_ERR_OR_NULL(dev->pm_domain)
 	    ||  pd_to_genpd(dev->pm_domain) != genpd)
 		return -EINVAL;
-- 
1.8.3.1

