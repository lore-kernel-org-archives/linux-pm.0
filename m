From: Sudeep.KarkadaNagesha@arm.com
Subject: [PATCH 2/2] PM / OPP: check for existing OPP list when initialising from device tree
Date: Wed,  1 May 2013 12:11:19 +0100
Message-ID: <1367406679-21603-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1367406679-21603-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48998 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760401Ab3EALLc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2013 07:11:32 -0400
In-Reply-To: <1367406679-21603-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Shawn Guo <shawn.guo@linaro.org>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

CPUs are registered as devices and their OPPs can be initialised from
the device tree. Whenever CPUs can be hotplugged out, the corresponding
cpu devices are not removed. As a result all their OPPs remain intact
even when they are offlined.

But when they are hotplugged back-in, the cpufreq along with other cpu
related subsystem gets re-initialised. Since its almost same as secondary
cpu being brought up, no special consideration is taken in the hotplug
path. As a result of this the cpufreq will try to initialise the OPPs
again though the cpu device already contains the OPPs.

This patch checks if there exist an OPP list associated with the device,
before attempting to initialise it.

Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/base/power/opp.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 4dfdc01..66d52d2 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -706,6 +706,11 @@ static int of_init_opp_table_from_ofnode(struct device=
 *dev,
 =09const __be32 *val;
 =09int nr;
=20
+=09/* Check for existing list for 'dev' */
+=09dev_opp =3D find_device_opp(dev);
+=09if (!IS_ERR(dev_opp))
+=09=09return 0; /* Device OPP already initialized */
+
 =09prop =3D of_find_property(of_node, "operating-points", NULL);
 =09if (!prop)
 =09=09return -ENODEV;
--=20
1.7.10.4


