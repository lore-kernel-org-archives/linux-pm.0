From: Eric Anholt <eric@anholt.net>
Subject: [PATCH] PM / Domains: Fix bad of_node_put() in failure paths of genpd_dev_pm_attach()
Date: Tue,  1 Dec 2015 09:39:31 -0800
Message-ID: <1448991571-20301-1-git-send-email-eric@anholt.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:39474 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756169AbbLARjd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2015 12:39:33 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, Eric Anholt <eric@anholt.net>

It looks like these meant to be unreffing the
of_parse_phandle_with_args() node, since the error paths above it
don't do of_node_put.  That function returns a new ref in pd_args.np,
though, not a new ref on dev->of_node.  Also, it would have leaked the
ref in the success case.

Fixes "ERROR: Bad of_node_put()" on bcm2835 when hitting the
-EPROBE_DEFER case.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/base/power/domain.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e03b1ad..167418e 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1775,10 +1775,10 @@ int genpd_dev_pm_attach(struct device *dev)
 	}
 
 	pd = of_genpd_get_from_provider(&pd_args);
+	of_node_put(pd_args.np);
 	if (IS_ERR(pd)) {
 		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
 			__func__, PTR_ERR(pd));
-		of_node_put(dev->of_node);
 		return -EPROBE_DEFER;
 	}
 
@@ -1796,7 +1796,6 @@ int genpd_dev_pm_attach(struct device *dev)
 	if (ret < 0) {
 		dev_err(dev, "failed to add to PM domain %s: %d",
 			pd->name, ret);
-		of_node_put(dev->of_node);
 		goto out;
 	}
 
-- 
2.6.2

