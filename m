From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: v3.16-rc1 regression? unexpected usb_autopm_get_interface error
Date: Mon, 16 Jun 2014 17:53:33 +0200
Message-ID: <8738f426ma.fsf@nemi.mork.no>
References: <Pine.LNX.4.44L0.1406161106470.1292-100000@iolanthe.rowland.org>
	<874mzkga1p.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:43250 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984AbaFPPxk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 16 Jun 2014 11:53:40 -0400
In-Reply-To: <874mzkga1p.fsf@nemi.mork.no> (=?utf-8?Q?=22Bj=C3=B8rn?=
 Mork"'s message of "Mon, 16
	Jun 2014 17:15:46 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dan Williams <dan.j.williams@intel.com>, USB list <linux-usb@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B8rn Mork <bjorn@mork.no> writes:
> Alan Stern <stern@rowland.harvard.edu> writes:
>> On Mon, 16 Jun 2014, Bj=C3=B8rn Mork wrote:
>>> Bj=C3=B8rn Mork <bjorn@mork.no> writes:
>>>=20
>>> > So the problem is related to runtime suspend before first use. I
>>> > strongly suspect=20
>>> >
>>> >  aae4518b3124 PM / sleep: Mechanism to avoid resuming runtime-suspend=
ed devices unnecessarily
>>>=20
>>> Nope, that was not it. So if blind guessing isn't going to work, then I
>>> guess there is no way around a bisect :-)
>>
>> You could simply wait for someone who knows the code to answer the=20
>> question.  :-)
>
> Wait? Do I look like I'm patient :-)
>
> Besides, it was actually relieving to bisect a reliably reproducible
> non-crashing bug for once ;-)
>
>> I'm pretty sure this resulted from one of Dan Williams's changes to USB=
=20
>> port runtime PM.  A whole bunch of them were added in 3.15-rc1.
>
> You are *so* much better at guessing than me:
>
> 9262c19d14c433a6a1ba25c3ff897cb89e412309 is the first bad commit

And for completeness, I just tried the following partial revert on top
of v3.16-rc1 and can confirm that it works fine for me:


--=-=-=
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: inline;
 filename=0001-usb-fix-port-runtime-pm-regression.patch
Content-Transfer-Encoding: quoted-printable

>From f8cba987220ae6cca98d662704256839968c6a61 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Bj=3DC3=3DB8rn=3D20Mork?=3D <bjorn@mork.no>
Date: Mon, 16 Jun 2014 17:26:05 +0200
Subject: [PATCH] usb: fix port runtime pm regression
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

This is a partial revert of commit 9262c19d14c4 ("usb: disable port
power control if not supported in wHubCharacteristics")

Fixes: 9262c19d14c4 ("usb: disable port power control if not supported in w=
HubCharacteristics")
Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>
---
 drivers/usb/core/port.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 62036faf56c0..13a2ffb4b18a 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -411,15 +411,12 @@ int usb_hub_create_port_device(struct usb_hub *hub, i=
nt port1)
=20
 	pm_runtime_set_active(&port_dev->dev);
=20
-	/*
-	 * Do not enable port runtime pm if the hub does not support
-	 * power switching.  Also, userspace must have final say of
-	 * whether a port is permitted to power-off.  Do not enable
-	 * runtime pm if we fail to expose pm_qos_no_power_off.
+	/* It would be dangerous if user space couldn't
+	 * prevent usb device from being powered off. So don't
+	 * enable port runtime pm if failed to expose port's pm qos.
 	 */
-	if (hub_is_port_power_switchable(hub)
-			&& dev_pm_qos_expose_flags(&port_dev->dev,
-			PM_QOS_FLAG_NO_POWER_OFF) =3D=3D 0)
+	if (!dev_pm_qos_expose_flags(&port_dev->dev,
+			PM_QOS_FLAG_NO_POWER_OFF))
 		pm_runtime_enable(&port_dev->dev);
=20
 	device_enable_async_suspend(&port_dev->dev);
--=20
1.7.10.4


--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



But I'm not submitting that patch as I assume Dan wants to fix this up
properly.  Whatever that is... I don't understand any of the port magic.


Bj=C3=B8rn

--=-=-=--
