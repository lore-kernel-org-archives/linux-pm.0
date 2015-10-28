From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH] PM / Domains: Allocate memory outside domain locks
Date: Wed, 28 Oct 2015 15:19:50 -0600
Message-ID: <1446067190-42583-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36072 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756195AbbJ1VT6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 17:19:58 -0400
Received: by pacfv9 with SMTP id fv9so18433832pac.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2015 14:19:58 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: ulf.hansson@linaro.org, Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?q?Krzysztof=20Koz=C5=82owski?= <k.kozlowski@samsung.com>

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
 drivers/base/power/domain.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 6483a92..6f3b145 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1306,13 +1306,17 @@ int pm_genpd_remove_device(struct generic_pm_do=
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
@@ -1322,18 +1326,13 @@ int pm_genpd_add_subdomain(struct generic_pm_do=
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
@@ -1344,7 +1343,8 @@ int pm_genpd_add_subdomain(struct generic_pm_doma=
in *genpd,
  out:
 	mutex_unlock(&subdomain->lock);
 	mutex_unlock(&genpd->lock);
-
+	if (ret)
+		kfree(link);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pm_genpd_add_subdomain);
--=20
2.1.4

