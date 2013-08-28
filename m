From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 3/5] drivers: thermal: make usage of
 CONFIG_THERMAL_HWMON optional
Date: Wed, 28 Aug 2013 08:13:56 +0800
Message-ID: <1377648836.2335.252.camel@rzhang-lenovo>
References: <1377295396-17289-1-git-send-email-eduardo.valentin@ti.com>
	 <4832825.8PCMQe7StP@vostro.rjw.lan> <521CEF61.6040504@ti.com>
	 <8131326.8QGX41MW6c@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <8131326.8QGX41MW6c@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Matthew Garrett <matthew.garrett@nebula.com>, Peter Feuerer <peter@piie.net>, platform-driver-x86@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Lan Tianyu <tianyu.lan@intel.com>
List-Id: linux-pm@vger.kernel.org

On =E4=BA=8C, 2013-08-27 at 23:17 +0200, Rafael J. Wysocki wrote:
> On Tuesday, August 27, 2013 02:26:41 PM Eduardo Valentin wrote:
> > On 23-08-2013 19:08, Rafael J. Wysocki wrote:
> > > On Friday, August 23, 2013 06:03:14 PM Eduardo Valentin wrote:
> > >> When registering a new thermal_device, the thermal framework
> > >> will always add a hwmon sysfs interface.
> > >>
> > >> This patch adds a flag to make this behavior optional. Now
> > >> when registering a new thermal device, the caller needs
> > >> to say if the hwmon interface is required.
> > >>
> > >> In order to keep same behavior as of today, all current
> > >> calls will by default create the hwmon interface.
> > >=20
> > > Well, instead of modifying all of the callers this way, why don't
> > > you add new versions taking the additional argument as, for examp=
le,
> > >=20
> > > thermal_zone_device_register_full()
> > >=20
> > > and redefine the old ones as static inline wrappers, for example
> > >=20
> > > static inline struct thermal_zone_device *thermal_zone_device_reg=
ister(args)
> > > {
> > > 	return thermal_zone_device_register_full(args, true);
> > > }
> > >=20
> > > ?
> >=20
> > Yeah, that is another way to go and I thought of doing it like that=
=2E I
> > just could not come out with a good API naming:
> >=20
> > thermal_zone_device_register_full(all args)
> >=20
> > thermal_zone_device_register(args) /* on hwmon =3D=3D true */
> > thermal_zone_device_register_no_hwmon(args) /* on hwmon =3D=3D fals=
e */
> >=20
> > Would this sound reasonable naming?
>=20
> Yeah, sounds good to me.
>=20
Well, actually, Tianyu is working on a patch set to move all the
thermal_zone_device_register() parameters to struct thermal_zone_params=
=2E

But with that patch set done, what you need to do next is just to
introduce a new field in struct thermal_zone_params and make sure 0
means registering hwmon sysfs I/F.

thanks,
rui

> Thanks,
> Rafael
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
