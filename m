From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 1/7] PM / Domains: Allocate memory outside domain locks
Date: Thu,  3 Sep 2015 13:58:28 -0600
Message-ID: <1441310314-8857-2-git-send-email-lina.iyer@linaro.org>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34814 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbbICT6q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2015 15:58:46 -0400
Received: by padfa1 with SMTP id fa1so274545pad.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2015 12:58:46 -0700 (PDT)
In-Reply-To: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, geert@linux-m68k.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

In preparation for supporting IRQ-safe domains, allocate domain data
outside the domain locks. These functions are not called in an atomic
context, so we can always allocate memory using GFP_KERNEL. By
allocating memory before the locks, we can safely lock the domain using
spinlocks instead of mutexes.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Koz=C5=82owski <k.kozlowski@samsung.com>
Reviewed-by: Kevin Hilman <khilman@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/domain.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e45a0ef..ef8d19f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1381,13 +1381,17 @@ int pm_genpd_remove_device(struct generic_pm_do=
main *genpd,
 int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 			   struct generic_pm_domain *subdomain)
 {
-	struct gpd_link *link;
+	struct gpd_link *link, *itr;
 	int ret =3D 0;
=20
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain)
 	    || genpd =3D=3D subdomain)
 		return -EINVAL;
=20
+	link =3D kzalloc(sizeof(*link), GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+
 	mutex_lock(&genpd->lock);
 	mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
=20
@@ -1397,18 +1401,13 @@ int pm_genpd_add_subdomain(struct generic_pm_do=
main *genpd,
 		goto out;
 	}
=20
-	list_for_each_entry(link, &genpd->master_links, master_node) {
-		if (link->slave =3D=3D subdomain && link->master =3D=3D genpd) {
+	list_for_each_entry(itr, &genpd->master_links, master_node) {
+		if (itr->slave =3D=3D subdomain && itr->master =3D=3D genpd) {
 			ret =3D -EINVAL;
 			goto out;
 		}
 	}
=20
-	link =3D kzalloc(sizeof(*link), GFP_KERNEL);
-	if (!link) {
-		ret =3D -ENOMEM;
-		goto out;
-	}
 	link->master =3D genpd;
 	list_add_tail(&link->master_node, &genpd->master_links);
 	link->slave =3D subdomain;
@@ -1419,7 +1418,8 @@ int pm_genpd_add_subdomain(struct generic_pm_doma=
in *genpd,
  out:
 	mutex_unlock(&subdomain->lock);
 	mutex_unlock(&genpd->lock);
-
+	if (ret)
+		kfree(link);
 	return ret;
 }
=20
@@ -1510,17 +1510,17 @@ int pm_genpd_attach_cpuidle(struct generic_pm_d=
omain *genpd, int state)
 	if (IS_ERR_OR_NULL(genpd) || state < 0)
 		return -EINVAL;
=20
+	cpuidle_data =3D kzalloc(sizeof(*cpuidle_data), GFP_KERNEL);
+	if (!cpuidle_data)
+		return -ENOMEM;
+
 	mutex_lock(&genpd->lock);
=20
 	if (genpd->cpuidle_data) {
 		ret =3D -EEXIST;
-		goto out;
-	}
-	cpuidle_data =3D kzalloc(sizeof(*cpuidle_data), GFP_KERNEL);
-	if (!cpuidle_data) {
-		ret =3D -ENOMEM;
-		goto out;
+		goto err_drv;
 	}
+
 	cpuidle_drv =3D cpuidle_driver_ref();
 	if (!cpuidle_drv) {
 		ret =3D -ENODEV;
--=20
2.1.4

