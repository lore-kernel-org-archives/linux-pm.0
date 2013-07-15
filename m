From: Sudeep.KarkadaNagesha@arm.com
Subject: [RFC PATCH 07/11] cpufreq: cpufreq-cpu0: remove device tree parsing for cpu nodes
Date: Mon, 15 Jul 2013 11:22:08 +0100
Message-ID: <1373883732-26303-8-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1373883732-26303-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:41630 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755094Ab3GOKW3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 06:22:29 -0400
In-Reply-To: <1373883732-26303-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: cpufreq@vger.kernel.org, arnd@arndb.de, olof@lixom.net, lorenzo.pieralisi@arm.com, rob.herring@calxeda.com, grant.likely@linaro.org, rjw@sisk.pl, viresh.kumar@linaro.org, gregkh@linuxfoundation.org, gregory.clement@free-electrons.com, kernel@pengutronix.de, shawn.guo@linaro.org, linux@arm.linux.org.uk, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes all DT parsing and uses cpu->of_node instead.

Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/cpufreq-cpu0.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.=
c
index ad1fde2..5b05c26 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -174,29 +174,17 @@ static struct cpufreq_driver cpu0_cpufreq_driver =3D =
{
=20
 static int cpu0_cpufreq_probe(struct platform_device *pdev)
 {
-=09struct device_node *np, *parent;
+=09struct device_node *np;
 =09int ret;
=20
-=09parent =3D of_find_node_by_path("/cpus");
-=09if (!parent) {
-=09=09pr_err("failed to find OF /cpus\n");
-=09=09return -ENOENT;
-=09}
-
-=09for_each_child_of_node(parent, np) {
-=09=09if (of_get_property(np, "operating-points", NULL))
-=09=09=09break;
-=09}
+=09cpu_dev =3D &pdev->dev;
=20
+=09np =3D of_node_get(cpu_dev->of_node);
 =09if (!np) {
 =09=09pr_err("failed to find cpu0 node\n");
-=09=09ret =3D -ENOENT;
-=09=09goto out_put_parent;
+=09=09return -ENOENT;
 =09}
=20
-=09cpu_dev =3D &pdev->dev;
-=09cpu_dev->of_node =3D np;
-
 =09cpu_reg =3D devm_regulator_get(cpu_dev, "cpu0");
 =09if (IS_ERR(cpu_reg)) {
 =09=09/*
@@ -269,15 +257,12 @@ static int cpu0_cpufreq_probe(struct platform_device =
*pdev)
 =09}
=20
 =09of_node_put(np);
-=09of_node_put(parent);
 =09return 0;
=20
 out_free_table:
 =09opp_free_cpufreq_table(cpu_dev, &freq_table);
 out_put_node:
 =09of_node_put(np);
-out_put_parent:
-=09of_node_put(parent);
 =09return ret;
 }
=20
--=20
1.8.1.2


