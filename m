From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
Date: Fri, 13 Apr 2018 13:21:45 +0200
Message-ID: <5312146.KITRp36PIx@amdc3058>
References: <1523436077.16235.5.camel@intel.com>
        <10298074.ogKH1ypqfx@amdc3058> <2093381.eDLEWQi9DB@amdc3058>
        <CGME20180413112148epcas1p3f657cb50af4151d41f8c404e6b0d5fab@epcas1p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <2093381.eDLEWQi9DB@amdc3058>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Li, Philip" <philip.li@intel.com>
List-Id: linux-pm@vger.kernel.org

On Friday, April 13, 2018 01:12:39 PM Bartlomiej Zolnierkiewicz wrote:
> On Friday, April 13, 2018 12:41:18 PM Bartlomiej Zolnierkiewicz wrote:
> > On Friday, April 13, 2018 12:30:04 PM Daniel Lezcano wrote:
> > > On 13/04/2018 11:28, Bartlomiej Zolnierkiewicz wrote:
> > > 
> > > [ ... ]
> > > 
> > > >>> It is okay to return 0 because this code-path (the default one) will be
> > > >>> never hit by the driver (probe makes sure of it) - the default case is
> > > >>> here is just to silence compilation errors..
> > > >>
> > > >> The init function is making sure cal_type is one or another. Can you fix
> > > >> it correctly by replacing the 'switch' by a 'if' instead of adding dead
> > > >> branches to please gcc?
> > > >>
> > > >> if (data->cal_type == TYPE_TWO_POINT_TRIMMING) {
> > > >> 	return ...;
> > > >> }
> > > >>
> > > >> return ...;
> > > > 
> > > > I'm not the one that added this switch statement (it has been there since
> > > > 2011) and I would be happy to remove it. 
> > > 
> > > Actually the switch statement was fine until the cleanup.
> > 
> > I don't see how it was fine before as the driver has never used the default
> > case (always used TYPE_ONE_POINT_TRIMMING or TYPE_TWO_POINT_TRIMMING).
> > 
> > Could you please explain this more?
> > 
> > > > However could we please defer
> > > > this to v4.17 and merge the current set of Exynos thermal fixes/cleanups
> > > > (they simplify the driver a lot and make ground for future changes)?
> > > 
> > > Regarding the latest comment, this can be fixed properly by 'return' (or
> > > whatever you want which does not get around of gcc warnings).
> > 
> > Do you mean that you want the patch with switch statement removal?
> > 
> > Is incremental fix OK or do you want something else?
> 
> Danial has already posted it, I hope the fix is fine with you.

should have been:

Eduardo: Daniel has already posted it, I hope the fix is fine with you.

(& sorry for the typo)

> Also sorry for the delay with handling issue - I was on holiday last two
> days and for some reason I was under (wrong) impression that the previous
> fix has been in thermal tree (so I was quite surprised today reading this
> mail thread).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
