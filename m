From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 09/21] ARM: pxa: magician: Add OV9640 camera support
Date: Mon, 24 Aug 2015 07:53:56 +0100
Message-ID: <20150824065356.GA3247@x1>
References: <cover.1439843482.git.petr.cvek@tul.cz>
 <2889798.x6xcIzdYMU@wuerfel>
 <55D65722.9030508@tul.cz>
 <1634812.ZDaECJ9ClW@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36556 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbbHXGyC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2015 02:54:02 -0400
Received: by wicja10 with SMTP id ja10so62187247wic.1
        for <linux-pm@vger.kernel.org>; Sun, 23 Aug 2015 23:54:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1634812.ZDaECJ9ClW@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Petr Cvek <petr.cvek@tul.cz>, linux-arm-kernel@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>, linux@arm.linux.org.uk, sameo@linux.intel.com, linux-pm@vger.kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, cooloney@gmail.com, sre@kernel.org, haojian.zhuang@gmail.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, philipp.zabel@gmail.com, j.anaszewski@samsung.com, daniel@zonque.org

On Fri, 21 Aug 2015, Arnd Bergmann wrote:

> On Friday 21 August 2015 00:39:30 Petr Cvek wrote:
> > Dne 20.8.2015 v 22:26 Arnd Bergmann napsal(a):
> > > On Thursday 20 August 2015 21:48:20 Robert Jarzmik wrote:
> > >> Petr Cvek <petr.cvek@tul.cz> writes:
> > >>
> > >>> +     mdelay(3);
> > >> Okay, there are several mdelay(3) in this file.
> > >>
> > >> Could you please test if removing these mdelays prevents the cam=
era from working
> > >> ? If not, I'd like to have them removed.
> > >>
> > >>
> > >=20
> > > FWIW, it might be possible to replace some of them with msleep() =
calls,
> > > potentially after replacing spinlocks with mutexes where necessar=
y.
> > >=20
> > >       Arnd
> > >=20
> >=20
> > Datasheet says:
> >=20
> >         tS:RESET        Setting time after software/hardware reset =
     1 ms
> >=20
> > So at least one ~1 ms should be left there. Are msleep less than 20=
ms valid?=20
> >=20
> > (checkpatch: msleep < 20ms  can sleep for up to 20ms)
>=20
> On most kernels, an msleep(1) will sleep somewhere between 1 and 3 mi=
lliseconds
> (but could be much longer), while an mdelay(1) tries to sleep around =
one
> millisecond, more or less.

If high-res timers are available I'd suggest using usleep_range()
instead.  By providing suitably divergent values usleep_range
de-restricts the kernel, allowing the scheduler to bundle your
wake-up along with others.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
