From: Sudeep.KarkadaNagesha@arm.com
Subject: [RFC PATCH 08/11] cpufreq: highbank-cpufreq: remove device tree parsing for cpu nodes
Date: Mon, 15 Jul 2013 11:22:09 +0100
Message-ID: <1373883732-26303-9-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1373883732-26303-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:41509 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173Ab3GOKW2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 06:22:28 -0400
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
 drivers/cpufreq/highbank-cpufreq.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/highbank-cpufreq.c b/drivers/cpufreq/highbank-=
cpufreq.c
index b61b5a3..794123f 100644
--- a/drivers/cpufreq/highbank-cpufreq.c
+++ b/drivers/cpufreq/highbank-cpufreq.c
@@ -69,23 +69,17 @@ static int hb_cpufreq_driver_init(void)
 =09if (!of_machine_is_compatible("calxeda,highbank"))
 =09=09return -ENODEV;
=20
-=09for_each_child_of_node(of_find_node_by_path("/cpus"), np)
-=09=09if (of_get_property(np, "operating-points", NULL))
-=09=09=09break;
-
-=09if (!np) {
-=09=09pr_err("failed to find highbank cpufreq node\n");
-=09=09return -ENOENT;
-=09}
-
 =09cpu_dev =3D get_cpu_device(0);
 =09if (!cpu_dev) {
 =09=09pr_err("failed to get highbank cpufreq device\n");
-=09=09ret =3D -ENODEV;
-=09=09goto out_put_node;
+=09=09return -ENODEV;
 =09}
=20
-=09cpu_dev->of_node =3D np;
+=09np =3D of_node_get(cpu_dev->of_node);
+=09if (!np) {
+=09=09pr_err("failed to find highbank cpufreq node\n");
+=09=09return -ENOENT;
+=09}
=20
 =09cpu_clk =3D clk_get(cpu_dev, NULL);
 =09if (IS_ERR(cpu_clk)) {
--=20
1.8.1.2


