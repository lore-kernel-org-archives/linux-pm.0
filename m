From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
Date: Fri, 13 Apr 2018 12:27:17 +0200
Message-ID: <3605298.EUomHGJ8vH@amdc3058>
References: <1523436077.16235.5.camel@intel.com>
        <CGME20180413100808epcas3p4b943a763c77624c88f73492ff11e1b0d@epcas3p4.samsung.com>
        <20180413100801.GA21913@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180413100801.GA21913@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Li, Philip" <philip.li@intel.com>
List-Id: linux-pm@vger.kernel.org

On Friday, April 13, 2018 03:08:03 AM Eduardo Valentin wrote:
> On Fri, Apr 13, 2018 at 01:39:05PM +0800, Zhang Rui wrote:
> > Hi, Eduardo,
> >=20
> > On =E5=9B=9B, 2018-04-12 at 21:08 -0700, Eduardo Valentin wrote:
> > > Hello,
> > >=20
> > > On Thu, Apr 12, 2018 at 09:55:19AM -0700, Linus Torvalds wrote:
> > > >=20
> > > > On Wed, Apr 11, 2018 at 10:08 PM, Zhang Rui <rui.zhang@intel.co=
m>
> > > > wrote:
> > > > >=20
> > > > >=20
> > > > > could you please illustrate me what the kconfig & warning is?=

> > > > Just "make allmodconfig" and the warning is about a uninitializ=
ed
> > > > variable.
> > > >=20
> > > > Line 304 in drivers/thermal/samsung/exynos_tmu.c if my shell
> > > > history
> > > > is to be believed.
> > > >=20
> > > >                 Linus
> > > Yeah, this has also passed my local compilation error. Somehow my=

> > > gcc4.9
> > > is not catching it. Using an older gcc (gcc4.6) does catch it.
> > >=20
> > > Anyways, given that the conversion functions are written to cover=

> > > for unexpected cal_type, the right way of fixing this is to rewri=
te
> > > the conversion functions to allow for returning error codes and
> > > adjusting the callers as expected.
> > >=20
> > > Rui, bzolnier, please consider the following fix:
> > >=20
> > as it is late in this merge window, I'd prefer to
> > 1. drop all the thermal-soc material in the first pull request whic=
h I
> > will send out soon.
> > 2. you can prepare another pull request containing the thermal-soc
> > materials except the exynos fixes
> > 3. exynos fixes with the problem solved can be queued for -rc2 or
> > later.
> >=20
>=20
> Agreed

What should I do now to help resolve the issue?

[ There has been no action from you on Arnd's fix for over two weeks an=
d
  also you have not commented on it now.. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
