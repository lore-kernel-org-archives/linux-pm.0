From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: lm-senser can't detect thermal on thermal_zone
Date: Tue, 14 Jun 2016 14:32:14 +0800
Message-ID: <1465885934.4001.4.camel@intel.com>
References: <87posrn1oj.wl%kuninori.morimoto.gx@renesas.com>
	 <1463100287.15071.8.camel@rzhang1-mobl4>
	 <874ma2lnvw.wl%kuninori.morimoto.gx@renesas.com>
	 <87zir89iai.wl%kuninori.morimoto.gx@renesas.com>
	 <87oa7bkqvl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16586 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbcFNGcU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Jun 2016 02:32:20 -0400
In-Reply-To: <87oa7bkqvl.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: "edubezval@gmail.com" <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "cm-hiep@jinso.co.jp" <cm-hiep@jinso.co.jp>

On Thu, 2016-06-09 at 03:07 +0000, Kuninori Morimoto wrote:
>=20
> Hi Zhang
>=20
> Can you check this email ?
>=20
> >=20
> > >=20
> > > Thank you for your help
> > >=20
> > > >=20
> > > > >=20
> > > > > 	non thermal-zon
> > > > > 	=C2=A0=C2=A0sensor command: OK
> > > > > 	=C2=A0=C2=A0read from /sys/class/thermal/thermal_zone0 : OK
> > > > >=20
> > > > > 	thermal-zon
> > > > > 	=C2=A0=C2=A0sensor command: NG
> > > > > 	=C2=A0=C2=A0read from /sys/class/thermal/thermal_zone0 : OK
> > > > config THERMAL_HWMON
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prompt "Expose =
thermal sensors as hwmon device"
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on HWMO=
N=3Dy || HWMON=3DTHERMAL
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default y
> > > >=20
> > > > please check if the thermal subsystem is built in, while hwmon
> > > > subsystem
> > > > is built as module.
> > > > you should either set CONFIG_HWMON=3Dy, or set both CONFIG_HWMO=
N
> > > > and
> > > > CONFIG_THERMAL as module.
> > > Thanks. but it seems our system has it.
> > >=20
> > > I noticed that thermal_zone case uses of_parse_thermal_zones()
> > > and it has this.
> > >=20
> > > 		/* No hwmon because there might be hwmon drivers
> > > registering */
> > > 		tzp->no_hwmon =3D true;
> > >=20
> > > and on thermal_zone_device_register() check this for hwmon
> > >=20
> > > struct thermal_zone_device *thermal_zone_device_register(xxxx)
> > > {
> > > 	...
> > > 	if (!tz->tzp || !tz->tzp->no_hwmon) {
> > > 		result =3D thermal_add_hwmon_sysfs(tz);
> > > 		...
> > > 	}
> > > 	...
> > > }
> > >=20
> > > Does this mean "thermal_zone doesn't use lm-senser" ?

I'd prefer to say of_thermal registered thermal_zone doesn't use lm-
sensor.
If you're really want to see hwmon interface, I think you should use
thermal API (thermal_zone_device_register) directly.

thanks,
rui
