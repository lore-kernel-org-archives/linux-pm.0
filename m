From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 3/3] pm: domains: avoid potential oops in
 pm_genpd_remove_device()
Date: Fri, 20 Mar 2015 17:20:38 +0000
Message-ID: <E1YZ0b8-0000ss-Nq@rmk-PC.arm.linux.org.uk>
References: <20150320171941.GK8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:59748 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbbCTRU4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2015 13:20:56 -0400
In-Reply-To: <20150320171941.GK8656@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

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

Acked-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/base/power/domain.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 89d2eea7f561..5f560fa45a32 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1538,9 +1538,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 
 	dev_dbg(dev, "%s()\n", __func__);
 
-	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev)
-	    ||  IS_ERR_OR_NULL(dev->pm_domain)
-	    ||  pd_to_genpd(dev->pm_domain) != genpd)
+	if (!genpd || genpd != pm_genpd_lookup_dev(dev))
 		return -EINVAL;
 
 	genpd_acquire_lock(genpd);
-- 
1.8.3.1

