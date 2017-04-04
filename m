From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v5 2/5] PM / Domains: Do not check if simple providers have phandle cells
Date: Mon, 3 Apr 2017 21:47:29 -0500
Message-ID: <20170404024732.32699-3-d-gerlach@ti.com>
References: <20170404024732.32699-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:58411 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbdDDCsp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2017 22:48:45 -0400
In-Reply-To: <20170404024732.32699-1-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, Sudeep Holla <sudeep.holla@arm.com>, Olof Johansson <olof@lixom.net>

There is no reason that a platform genpd driver registered using
of_genpd_add_provider_simple needs to be constrained to having no cells
in the "power-domains" phandle. Currently the genpd framework will fail
if any arguments are passed with for a simple provider but the framework
does not actually care, so remove the check for phandle argument count.

This will allow greater flexibility for genpd providers to use their own
arguments that are passed in the phandle and interpret them however they
see fit.

Acked-by: Kevin Hilman <khilman@baylibre.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/base/power/domain.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e697dec9d25b..8e0550c27394 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1622,8 +1622,6 @@ static struct generic_pm_domain *genpd_xlate_simple(
 					struct of_phandle_args *genpdspec,
 					void *data)
 {
-	if (genpdspec->args_count != 0)
-		return ERR_PTR(-EINVAL);
 	return data;
 }
 
-- 
2.11.0
