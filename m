From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] intel_idle: Add CPU model 74 (Atom Z34xx series)
Date: Fri, 17 Jun 2016 12:17:03 +0300
Message-ID: <1466155023.30123.151.camel@linux.intel.com>
References: <1465232806-138619-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <CAJvTdKmDWQPtfHBtTEF2-_Ax=PvUpc6E56wR=6GjJcKf-kjXQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:53632 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754850AbcFQJRG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 Jun 2016 05:17:06 -0400
In-Reply-To: <CAJvTdKmDWQPtfHBtTEF2-_Ax=PvUpc6E56wR=6GjJcKf-kjXQw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On Wed, 2016-06-15 at 21:14 -0400, Len Brown wrote:
> Hi Andy,
>=20
> Is this a patch from the Android kernel tree?

Nope. Though official Intel Yocto BSP containts almost same values for
this CPU, except for C1 (I decided no to take their since they also
provide different values for that state for BayTrail. And latter one is
in upstream).=C2=A0

> Is there anybody testing the upstream kernel on this hardware?

I did. It works and I see changing values under sysfs. I'm not sure wha=
t
should I get from turbostat. Do I need to patch it as well to be able t=
o
get something useful?

>=20
> Past efforts to support old hardware that nobody tests upstream
> have resulted in all pain and no gain, and I'm not eager to
> repeat that experience.
>=20
> thanks,
> -Len
>=20
>=20
> On Mon, Jun 6, 2016 at 1:06 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > Add CPU ID for Atom Z34xx processors. Datasheets indicate support
> > for this,
> > detailed information about potential quirks or limitations are
> > missing, though.
> > So we just reuse the definition for the previous ATOM series. The
> > quite similar
> > values (C1 is slightly deviated) are used in the official Intel
> > Edison BSP.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > =C2=A0drivers/idle/intel_idle.c | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> > index c966492..bb52275 100644
> > --- a/drivers/idle/intel_idle.c
> > +++ b/drivers/idle/intel_idle.c
> > @@ -1033,6 +1033,7 @@ static const struct x86_cpu_id
> > intel_idle_ids[] __initconst =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ICPU(0x2d, idle_cpu=
_snb),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ICPU(0x36, idle_cpu=
_atom),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ICPU(0x37, idle_cpu=
_byt),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ICPU(0x4a, idle_cpu_atom=
),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ICPU(0x4c, idle_cpu=
_cht),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ICPU(0x3a, idle_cpu=
_ivb),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ICPU(0x3e, idle_cpu=
_ivt),
> > --
> > 2.8.1
> >=20
>=20
>=20
>=20

--=20

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
