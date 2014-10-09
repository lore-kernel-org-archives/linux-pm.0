From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 2/2] power: reset: document LTC2952 poweroff support
Date: Thu, 9 Oct 2014 09:09:36 -0700
Message-ID: <20141009160935.GF31987@roeck-us.net>
References: <1412866242-6474-1-git-send-email-frans.klaver@xsens.com>
 <1412866242-6474-3-git-send-email-frans.klaver@xsens.com>
 <20141009150756.GC18384@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:60788 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbaJIQJm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 12:09:42 -0400
Content-Disposition: inline
In-Reply-To: <20141009150756.GC18384@leverpostej>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Frans Klaver <frans.klaver@xsens.com>, Sebastian Reichel <sre@kernel.org>, =?iso-8859-1?Q?Ren=E9?= Moll <linux@r-moll.nl>, Tjerk Hofmeijer <tjerk.hofmeijer@xsens.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Oct 09, 2014 at 04:07:56PM +0100, Mark Rutland wrote:
> Hi,
>=20
> On Thu, Oct 09, 2014 at 03:50:42PM +0100, Frans Klaver wrote:
> > From: Ren=E9 Moll <linux@r-moll.nl>
> >=20
> > Signed-off-by: Ren=E9 Moll <linux@r-moll.nl>
> > Signed-off-by: Tjerk Hofmeijer <tjerk.hofmeijer@xsens.com>
> > Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
> > ---
> >  .../bindings/power/reset/ltc2952-poweroff.txt      | 31 ++++++++++=
++++++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/reset/l=
tc2952-poweroff.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/power/reset/ltc2952-=
poweroff.txt b/Documentation/devicetree/bindings/power/reset/ltc2952-po=
weroff.txt
> > new file mode 100644
> > index 0000000..c3f3d9e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/reset/ltc2952-powerof=
f.txt
> > @@ -0,0 +1,31 @@
> > +Binding for the LTC2952 PowerPath controller
> > +
> > +This chip is used to externally trigger a system shut down. Once t=
he trigger
> > +has been sent, the chips watchdog has to be reset to gracefully sh=
ut down.
>=20
> s/chips/chip's/
>=20
> > If +the Linux systems decides to shut down, it powers off the platf=
orm
> > via the +poweroff signal.
>=20
> This sentence can go; the binding should describe the hardware rather
> than the Linux behaviour.
>=20
Maybe find an operating system independent wording and describe what th=
e
implementation should do. Or is that out of scope as well ?

Thanks,
Guenter
