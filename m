From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
Date: Fri, 13 Apr 2018 10:55:10 +0200
Message-ID: <2944702.qKZ0LXufY7@amdc3058>
References: <1523436077.16235.5.camel@intel.com>
        <CGME20180413053914epcas3p3b7e3c278515ffed1b4c019b2c5af3ab4@epcas3p3.samsung.com>
        <1523597945.16235.52.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1523597945.16235.52.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Li, Philip" <philip.li@intel.com>
List-Id: linux-pm@vger.kernel.org

On Friday, April 13, 2018 01:39:05 PM Zhang Rui wrote:
> Hi, Eduardo,
>=20
> On =E5=9B=9B, 2018-04-12 at 21:08 -0700, Eduardo Valentin wrote:
> > Hello,
> >=20
> > On Thu, Apr 12, 2018 at 09:55:19AM -0700, Linus Torvalds wrote:
> > >=20
> > > On Wed, Apr 11, 2018 at 10:08 PM, Zhang Rui <rui.zhang@intel.com>=

> > > wrote:
> > > >=20
> > > >=20
> > > > could you please illustrate me what the kconfig & warning is?
> > > Just "make allmodconfig" and the warning is about a uninitialized=

> > > variable.
> > >=20
> > > Line 304 in drivers/thermal/samsung/exynos_tmu.c if my shell
> > > history
> > > is to be believed.
> > >=20
> > >                 Linus
> > Yeah, this has also passed my local compilation error. Somehow my
> > gcc4.9
> > is not catching it. Using an older gcc (gcc4.6) does catch it.
> >=20
> > Anyways, given that the conversion functions are written to cover
> > for unexpected cal_type, the right way of fixing this is to rewrite=

> > the conversion functions to allow for returning error codes and
> > adjusting the callers as expected.
> >=20
> > Rui, bzolnier, please consider the following fix:
> >=20
> as it is late in this merge window, I'd prefer to
> 1. drop all the thermal-soc material in the first pull request which =
I
> will send out soon.
> 2. you can prepare another pull request containing the thermal-soc
> materials except the exynos fixes
> 3. exynos fixes with the problem solved can be queued for -rc2 or
> later.

Could you please just merge the obvious fix from Arnd instead?

[ it was posted two weeks ago and ACKed by me ]

https://patchwork.kernel.org/patch/10313313/

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
