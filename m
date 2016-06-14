From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: lm-senser can't detect thermal on thermal_zone
Date: Tue, 14 Jun 2016 21:24:18 +0800
Message-ID: <1465910658.9422.9.camel@intel.com>
References: <87posrn1oj.wl%kuninori.morimoto.gx@renesas.com>
	 <1463100287.15071.8.camel@rzhang1-mobl4>
	 <874ma2lnvw.wl%kuninori.morimoto.gx@renesas.com>
	 <87zir89iai.wl%kuninori.morimoto.gx@renesas.com>
	 <87oa7bkqvl.wl%kuninori.morimoto.gx@renesas.com>
	 <1465885934.4001.4.camel@intel.com>
	 <877fdscl6o.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <877fdscl6o.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: "edubezval@gmail.com" <edubezval@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "cm-hiep@jinso.co.jp" <cm-hiep@jinso.co.jp>
List-Id: linux-pm@vger.kernel.org

On =E4=BA=8C, 2016-06-14 at 07:03 +0000, Kuninori Morimoto wrote:
> Hi Zhang
>=20
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > struct thermal_zone_device
> > > > > *thermal_zone_device_register(xxxx)
> > > > > {
> > > > > 	...
> > > > > 	if (!tz->tzp || !tz->tzp->no_hwmon) {
> > > > > 		result =3D thermal_add_hwmon_sysfs(tz);
> > > > > 		...
> > > > > 	}
> > > > > 	...
> > > > > }
> > > > >=20
> > > > > Does this mean "thermal_zone doesn't use lm-senser" ?
> > I'd prefer to say of_thermal registered thermal_zone doesn't use
> > lm-
> > sensor.
> > If you're really want to see hwmon interface, I think you should
> > use
> > thermal API (thermal_zone_device_register) directly.
> Thank you for your feedback.
> My driver is supporting both of_thermal and thermal API.
> So, switching is not a big deal.
>=20
> But can you teach me why of_thermal doesn't use lm-senser ??

I don't know if there is a solid reason that we can not expose the
hwmon interface. But just like the comment says, "/* No hwmon because
there might be hwmon drivers registering */", given that of_thermal
just parses THERMAL data of device tree, it is reasonable to me for
exposing thermal interfaces only.

thanks,
rui
