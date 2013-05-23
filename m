From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/3] Thermal: core: Modify temp_crit_show() to use
 proper callback function.
Date: Thu, 23 May 2013 10:19:44 +0800
Message-ID: <1369275584.2036.10.camel@rzhang1-mobl4>
References: <1368870656-1183-1-git-send-email-jonghwa3.lee@samsung.com>
	 <744357E9AAD1214791ACBA4B0B9092630110240D@SHSMSX101.ccr.corp.intel.com>
	 <519ACE88.3090503@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:45971 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756474Ab3EWCTs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 22 May 2013 22:19:48 -0400
In-Reply-To: <519ACE88.3090503@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jonghwa3.lee@samsung.com
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Dinel Kachhap <amit.kachhap@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>

On Tue, 2013-05-21 at 10:31 +0900, jonghwa3.lee@samsung.com wrote:
> On 2013=EB=85=84 05=EC=9B=94 21=EC=9D=BC 00:57, Zhang, Rui wrote:
>=20
> >=20
> >=20
> >> -----Original Message-----
> >> From: Jonghwa Lee [mailto:jonghwa3.lee@samsung.com]
> >> Sent: Saturday, May 18, 2013 5:51 PM
> >> To: linux-pm@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org; Zhang, Rui; Eduardo Valentin; Am=
it
> >> Dinel Kachhap; Jonghwa Lee; MyungJoo Ham
> >> Subject: [PATCH 2/3] Thermal: core: Modify temp_crit_show() to use
> >> proper callback function.
> >> Importance: High
> >>
> >> This patch modifies temp_crit_show() which is used to create hwmon=
's
> >> sysfs node to use .get_crit_temp callback function of thermal zone
> >> device rather than .get_trip_temp.
> >>
> >> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> >> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> >=20
> > The problem is that .get_crit_temp is optional for thermal drivers
> > that has a critical trip point.
>=20
>=20
> Actually, this is a interface for hwmon not generic thermal framework=
=2E And when
> we create this node through the thermal_add_hwmon_sysfs(), we've alre=
ady checked
> whether call back function is available. So the problem won't happen.
>=20
Oh, I see.

But back to my question, still take rcar driver for example,
it has a critical trip point but this is not shown in hwmon, which IMO
is still a problem.
So we should either make .get_crit_temp() mandatory for thermal drivers
with critical trip point or remove this callback and register hwmon
crit_temp interface via checking .get_trip_type().

thanks,
rui

> Thanks
> Jonghwa
>=20
> > At least we do not have such kind of check in thermal core.
> > Take rcar_thermal driver for example,
> > It supports critical trip point but it does not have .get_crit_type=
=2E
> >=20
> > So I'd like to see a fix in rcar thermal driver and thermal core
> > for this issue, together with this patch.
> >=20
> > Thanks,
> > rui
> >> ---
> >>  drivers/thermal/thermal_core.c |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/thermal/thermal_core.c
> >> b/drivers/thermal/thermal_core.c index f753f48..ce4384a 100644
> >> --- a/drivers/thermal/thermal_core.c
> >> +++ b/drivers/thermal/thermal_core.c
> >> @@ -924,7 +924,7 @@ temp_crit_show(struct device *dev, struct
> >> device_attribute *attr,
> >>  	long temperature;
> >>  	int ret;
> >>
> >> -	ret =3D tz->ops->get_trip_temp(tz, 0, &temperature);
> >> +	ret =3D tz->ops->get_crit_temp(tz, &temperature);
> >>  	if (ret)
> >>  		return ret;
> >>
> >> --
> >> 1.7.9.5
> >=20
> >=20
>=20
>=20


