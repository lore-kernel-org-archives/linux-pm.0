From: Sudeep.KarkadaNagesha@arm.com
Subject: [RFC PATCH v2 09/15] cpufreq: highbank-cpufreq: remove device tree parsing for cpu nodes
Date: Wed, 17 Jul 2013 15:06:18 +0100
Message-ID: <1374069984-20567-10-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Russell King <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Mark Langsdorf <mark.langsdorf@calxeda.com>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes all DT parsing and uses cpu->of_node instead.

Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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
