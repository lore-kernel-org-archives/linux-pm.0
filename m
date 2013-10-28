From: Anton Vorontsov <anton@enomsg.org>
Subject: [PATCH] power_supply: Fix documentation for TEMP_*ALERT* properties
Date: Sun, 27 Oct 2013 22:27:43 -0700
Message-ID: <20131028052743.GA31070@teo>
References: <1382676798-27835-1-git-send-email-jonghwa3.lee@samsung.com>
 <20131025231720.GB9015@teo>
 <526DC554.30506@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:41653 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab3J1F1s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2013 01:27:48 -0400
Received: by mail-pd0-f173.google.com with SMTP id r10so6535299pdi.4
        for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2013 22:27:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <526DC554.30506@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jonghwa3.lee@samsung.com, "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-pm@vger.kernel.org, dwmw2@infradead.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, Ramakrishna Pallala <ramakrishna.pallala@intel.com>

All temperatures should be in tenth degrees Celsius.

bq24190_charger.c probably should be fixed.

Reported-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: Mark A. Greer <mgreer@animalcreek.com>
Signed-off-by: Anton Vorontsov <anton@enomsg.org>
---

On Mon, Oct 28, 2013 at 11:00:52AM +0900, jonghwa3.lee@samsung.com wrot=
e:
> >  * All voltages, currents, charges, energies, time and temperatures=
 in uV,     =20
> >  * =C2=B5A, =C2=B5Ah, =C2=B5Wh, seconds and tenths of degree Celsiu=
s unless otherwise         =20
> >  * stated
> >=20
> > So, the current code seems to be correct.
>=20
> Honestly, I missed the above paragraph you showed rather I read follo=
wing one.
>=20
> TEMP - temperature of the power supply.
> TEMP_ALERT_MIN - minimum battery temperature alert value in milli cen=
tigrade.
> TEMP_ALERT_MAX - maximum battery temperature alert value in milli cen=
tigrade.
> TEMP_AMBIENT - ambient temperature.
> TEMP_AMBIENT_ALERT_MIN - minimum ambient temperature alert value in m=
illi
> centigrade.
> TEMP_AMBIENT_ALERT_MAX - maximum ambient temperature alert value in m=
illi
> centigrade.
>=20
> So, we use different unit for properties related temperature, right?
> current temperature is in tenth of centigrade and threshold temperatu=
res and
> ambient temperature are in milli centigrade. Wouldn't it have to be i=
n same unit?

:( They should. Thanks for spotting.

The patch down below should fix the issue...

Documentation/power/power_supply_class.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/power/power_supply_class.txt b/Documentation=
/power/power_supply_class.txt
index 3f10b39..89a8816 100644
--- a/Documentation/power/power_supply_class.txt
+++ b/Documentation/power/power_supply_class.txt
@@ -135,11 +135,11 @@ CAPACITY_LEVEL - capacity level. This corresponds=
 to
 POWER_SUPPLY_CAPACITY_LEVEL_*.
=20
 TEMP - temperature of the power supply.
-TEMP_ALERT_MIN - minimum battery temperature alert value in milli cent=
igrade.
-TEMP_ALERT_MAX - maximum battery temperature alert value in milli cent=
igrade.
+TEMP_ALERT_MIN - minimum battery temperature alert.
+TEMP_ALERT_MAX - maximum battery temperature alert.
 TEMP_AMBIENT - ambient temperature.
-TEMP_AMBIENT_ALERT_MIN - minimum ambient temperature alert value in mi=
lli centigrade.
-TEMP_AMBIENT_ALERT_MAX - maximum ambient temperature alert value in mi=
lli centigrade.
+TEMP_AMBIENT_ALERT_MIN - minimum ambient temperature alert.
+TEMP_AMBIENT_ALERT_MAX - maximum ambient temperature alert.
=20
 TIME_TO_EMPTY - seconds left for battery to be considered empty (i.e.
 while battery powers a load)
--=20
1.8.3.1

