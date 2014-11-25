From: "Javi Merino" <javi.merino@arm.com>
Subject: [PATCH] thermal: lock the thermal zone when switching governors
Date: Tue, 25 Nov 2014 16:00:33 +0000
Message-ID: <1416931233-14650-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:46852 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbaKYQAn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 11:00:43 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Currently, userspace can request a governor change while the governor
itself is running.  Grab the thermal zone lock when changing the
governor to prevent this race.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/thermal_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.=
c
index 43b90709585f..c1901961f8c0 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -757,6 +757,7 @@ policy_store(struct device *dev, struct device_attribut=
e *attr,
 =09snprintf(name, sizeof(name), "%s", buf);
=20
 =09mutex_lock(&thermal_governor_lock);
+=09mutex_lock(&tz->lock);
=20
 =09gov =3D __find_governor(strim(name));
 =09if (!gov)
@@ -766,6 +767,7 @@ policy_store(struct device *dev, struct device_attribut=
e *attr,
 =09ret =3D count;
=20
 exit:
+=09mutex_unlock(&tz->lock);
 =09mutex_unlock(&thermal_governor_lock);
 =09return ret;
 }
--=20
1.9.1


