From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [RFC PATCH 2/2] PM / OPP: check for existing OPP list when initialising from device tree
Date: Tue, 30 Jul 2013 19:00:17 +0100
Message-ID: <1375207217-4433-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Sudeep.KarkadaNagesha@arm.com, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

CPUs are registered as devices and their OPPs can be initialised from
the device tree. Whenever CPUs can be hotplugged out, the corresponding
cpu devices are not removed. As a result all their OPPs remain intact
even when they are offlined.

But when they are hotplugged back-in, the cpufreq along with other cpu
related subsystem gets re-initialised. Since its almost same as secondary
cpu being brought up, no special consideration is taken in the hotplug
path. This may result in cpufreq trying to initialise the OPPs again though
the cpu device already contains the OPPs.

This patch checks if there exist an OPP list associated with the device,
before attempting to initialise it.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/base/power/opp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 9ac3c93..8a9d138 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -708,9 +708,15 @@ int of_init_opp_table(struct device *dev)
 {
 =09const struct property *prop;
 =09struct device_node *opp_node;
+=09struct device_opp *dev_opp;
 =09const __be32 *val;
 =09int nr;
=20
+=09/* Check for existing list for 'dev' */
+=09dev_opp =3D find_device_opp(dev);
+=09if (!IS_ERR(dev_opp))
+=09=09return -EEXIST; /* Device OPP already initialized */
+
 =09opp_node =3D of_parse_phandle(dev->of_node,
 =09=09=09=09=09"operating-points-phandle", 0);
 =09if (!opp_node) /* if no OPP phandle, search for OPPs in current node */
--=20
1.8.1.2


