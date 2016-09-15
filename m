From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2] PM / Domains: Allow holes in genpd_data.domains array
Date: Thu, 15 Sep 2016 14:05:23 +0200
Message-ID: <1473941123-15090-1-git-send-email-tomeu.vizoso@collabora.com>
References: <5256c34e-5afb-2cfe-9818-8e6a6e1f0fa3@nvidia.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36633 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbcIOMGc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Sep 2016 08:06:32 -0400
In-Reply-To: <5256c34e-5afb-2cfe-9818-8e6a6e1f0fa3@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Jon Hunter <jonathanh@nvidia.com>, Heiko Stuebner <heiko@sntech.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

In platforms such as Rockchip's, the array of domains isn't always
filled without holes, as which domains are present depend on the
particular SoC revision.

By allowing holes to be in the array, such SoCs can still use a single
set of constants to index the array of power domains.

Fixes: 0159ec670763 ("PM / Domains: Verify the PM domain is present when adding a provider")
Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Heiko Stuebner <heiko@sntech.de>

---

v2: Also skip holes in the error path.
---
 drivers/base/power/domain.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b0cf46dcae73..83ae3d7d3fdd 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1581,6 +1581,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 	mutex_lock(&gpd_list_lock);
 
 	for (i = 0; i < data->num_domains; i++) {
+		if (!data->domains[i])
+			continue;
 		if (!pm_genpd_present(data->domains[i]))
 			goto error;
 
@@ -1598,6 +1600,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 
 error:
 	while (i--) {
+		if (!data->domains[i])
+			continue;
 		data->domains[i]->provider = NULL;
 		data->domains[i]->has_provider = false;
 	}
-- 
2.7.4

