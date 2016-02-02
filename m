From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 3/9] pinctrl: convert to use match_string() helper
Date: Tue, 02 Feb 2016 10:08:44 +0200
Message-ID: <1454400524.23271.8.camel@linux.intel.com>
References: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1453986865-133572-4-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20160201220230.92810bde.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:60246 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753843AbcBBIKT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Feb 2016 03:10:19 -0500
In-Reply-To: <20160201220230.92810bde.akpm@linux-foundation.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Rasmus Villemoes <linux@rasmusvillemoes.dk>

On Mon, 2016-02-01 at 22:02 -0800, Andrew Morton wrote:
> On Thu, 28 Jan 2016 15:14:19 +0200 Andy Shevchenko <andriy.shevchenko
> @linux.intel.com> wrote:
>=20
> > The new helper returns index of the mathing string in an array. We
> > would use it
> > here.
> >=20
> > --- a/drivers/pinctrl/pinmux.c
> > +++ b/drivers/pinctrl/pinmux.c
> > @@ -334,7 +334,6 @@ int pinmux_map_to_setting(struct pinctrl_map
> > const *map,
> > =C2=A0	unsigned num_groups;
> > =C2=A0	int ret;
> > =C2=A0	const char *group;
> > -	int i;
> > =C2=A0
> > =C2=A0	if (!pmxops) {
> > =C2=A0		dev_err(pctldev->dev, "does not support mux
> > function\n");
> > @@ -363,19 +362,13 @@ int pinmux_map_to_setting(struct pinctrl_map
> > const *map,
> > =C2=A0		return -EINVAL;
> > =C2=A0	}
> > =C2=A0	if (map->data.mux.group) {
> > -		bool found =3D false;
> > =C2=A0		group =3D map->data.mux.group;
> > -		for (i =3D 0; i < num_groups; i++) {
> > -			if (!strcmp(group, groups[i])) {
> > -				found =3D true;
> > -				break;
> > -			}
> > -		}
> > -		if (!found) {
> > +		ret =3D match_string(groups, num_groups, group);
> > +		if (ret < 0) {
> > =C2=A0			dev_err(pctldev->dev,
> > =C2=A0				"invalid group \"%s\" for function
> > \"%s\"\n",
> > =C2=A0				group, map->data.mux.function);
> > -			return -EINVAL;
> > +			return ret;
>=20
> Changes the return value from -EINVAL to -ENODATA.

Yeah, Al is concerned about this as well [1]. That's why I emphasized
this in cover letter.

> =C2=A0=C2=A0I'm not reeeeeealy
> sure what ENODATA means - it seems mostly a networking thing?=C2=A0=C2=
=A0People
> use it in various places because it kinda sounds like whatever it is
> that just went wrong.
>=20
> But the question is: what will the end user think when this error
> comes
> out of the kernel?=C2=A0=C2=A0Given that he/she has just tried to mis=
configure
> the pinctrl system, ENODATA will cause much head-scratching.=C2=A0=C2=
=A0EINVAL
> is
> more appropriate?=C2=A0=C2=A0"You tried to do something invalid".

Yeah, my arguments still the same, our error reporting from 70s sucks.

Since few people are concerned about EINVAL vs. ENODATA, I will re-do
patches 1 and 2 to follow this default instead of ENODATA.

[1]=C2=A0http://www.spinics.net/lists/kernel/msg2157541.html

> > =C2=A0		}
> > =C2=A0	} else {
> > =C2=A0		group =3D groups[0];

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

