From: NeilBrown <neilb@suse.de>
Subject: [PATCH] bq27x00_battery: register as non-wakeup power supply.
Date: Tue, 24 Feb 2015 14:17:32 +1100
Message-ID: <20150224141732.5c937402@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/t+T_QAb.XWOYS6shn5KmrGP"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59742 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028AbbBXDRo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Feb 2015 22:17:44 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, GTA04 owners <gta04-owner@goldelico.com>

--Sig_/t+T_QAb.XWOYS6shn5KmrGP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


power_supply status changes for the bq27x00 are only
noticed via polling, not via interrupts.  So they are never
the source of events which should reliably wake the system
from suspend.
So it is appropriate to register as a no_ws power source,
just like the ACPI battery.

This removes some debugging messages which occasionally
confusingly identify bq27x00 as a wakeup source.

Signed-off-by: NeilBrown <neilb@suse.de>

diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_batter=
y.c
index b72ba7c1bd69..93d2b7f910f1 100644
--- a/drivers/power/bq27x00_battery.c
+++ b/drivers/power/bq27x00_battery.c
@@ -755,7 +755,7 @@ static int bq27x00_powersupply_init(struct bq27x00_devi=
ce_info *di)
 	INIT_DELAYED_WORK(&di->work, bq27x00_battery_poll);
 	mutex_init(&di->lock);
=20
-	ret =3D power_supply_register(di->dev, &di->bat);
+	ret =3D power_supply_register_no_ws(di->dev, &di->bat);
 	if (ret) {
 		dev_err(di->dev, "failed to register battery: %d\n", ret);
 		return ret;

--Sig_/t+T_QAb.XWOYS6shn5KmrGP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVOvtTTnsnt1WYoG5AQJADQ/8CwFDapw7Uh1MNa1S/uGuObAXsDaMgxx8
eScal8rs9BZW043jLrxK7mP8khPbVw5IExRfhDgu3WILEogK/xOFFWZ9C5q8XMqY
Laqy8opdKYBXCHTUDZNR+ItNPxZ+wBN6pLQ4N2RxFlXoICvzoEz5StBSaD4TQACy
SACnhYKPn7MxOP3F8xSV6eXUocYgKreY+63kZwYeG3fk/Wyy1ULlYic4Xj8UT+2P
t/rFXB9iUHjMDxm3EL7p0OI7TXrvlF0WTw9giYoovsKECWD3bKJn7cEty/Kx/KVO
hbcEktKl5pa91i0RPJOWtoqy7gqEFeOAe+f3zFU1l5rdUgu0d454UbcKRarva73S
B3520htENJ0JEgMuMxXfdumcQsVzxirc42QG7vzd5bLw/DjoM3+q7fXbCkCtM8hT
Vko5uetowN0kA8CuVNLSz/jkNCSln4YlqpHUxbfaO2LRZLzNbi+UVzx7/LVthYJF
6+xo8WzHoAsLodkSD+PNRi8goa4kcENQKY40hBhqq/U7FwnX6AQLvZMbP0JpD1uW
c6FBTutZwDq322Jid22ZqFvLSDRCI5szOmzeYZbjpStDwACnsTW4fLeJYQVWKMAH
FuVtTMkOnMLwc8XE9s3SZeIFg+Ir2fjQXPO3gA1R6suIhW7gI+vH+Hd4jc2VK8T3
71cyjQD6rck=
=GUye
-----END PGP SIGNATURE-----

--Sig_/t+T_QAb.XWOYS6shn5KmrGP--
