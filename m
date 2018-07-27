From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: samsung: Add SPDX license
 identifier
Date: Fri, 27 Jul 2018 15:53:22 -0700
Message-ID: <20180727225321.GF4450@localhost.localdomain>
References: <CGME20180718200318epcas3p16aed6c1725d6c1e63ea6b1ad209c5756@epcas3p1.samsung.com>
 <2442216.oppRSGRAaL@amdc3058>
 <20180724200312.xs6u4nvhjckukkig@kozik-lap>
 <2385592.z8yee4uxt4@amdc3058>
 <CAJKOXPfTBE-tW81tocCfObb-pAwNmDjjv-BY6kHNkEuazm0pAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJKOXPfTBE-tW81tocCfObb-pAwNmDjjv-BY6kHNkEuazm0pAA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 25, 2018 at 06:27:59PM +0200, Krzysztof Kozlowski wrote:
> On 25 July 2018 at 16:43, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > On Tuesday, July 24, 2018 10:03:12 PM Krzysztof Kozlowski wrote:
> >> On Tue, Jul 24, 2018 at 06:46:35PM +0200, Bartlomiej Zolnierkiewicz wrote:
> >> >
> >> > Hi,
> >> >
> >> > On Wednesday, July 18, 2018 10:02:50 PM Krzysztof Kozlowski wrote:
> >> > > Replace GPL license statement with SPDX license identifier (GPL-2.0+).
> >> > >
> >> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >> > > ---
> >> > >  include/dt-bindings/thermal/thermal_exynos.h | 12 +-----------
> >> > >  1 file changed, 1 insertion(+), 11 deletions(-)
> >> > >
> >> > > diff --git a/include/dt-bindings/thermal/thermal_exynos.h b/include/dt-bindings/thermal/thermal_exynos.h
> >> > > index 0646500bca69..642e4e7f4084 100644
> >> > > --- a/include/dt-bindings/thermal/thermal_exynos.h
> >> > > +++ b/include/dt-bindings/thermal/thermal_exynos.h
> >> > > @@ -1,19 +1,9 @@
> >> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> >> >
> >> > This code should be GPL-2.0 only, original license statement is most
> >> > likely result of using wrong file as the source of copy-paste. So I
> >> > would like to have the license fixed first before doing conversion to
> >> > SPDX.
> >>
> >> If you think that's the case, then it makes sense and please go ahead.
> >> As fair as I remember this required signed-off from all contributors...
> >> so probably just Lukasz and Eduardo?
> >
> > git blame shows just Lukasz so his Ack should be enough.

You probably want to have his ack yes.

> >
> > I'm also fine with doing it in one patch like i.e. in commit a80ea4cb944e
> > ("pata_bk3710: clarify license version and use SPDX header"), if you are
> > also fine with it could you please re-spin the patch (+Cc: Lukasz)?
> 
> I do not have interest in changing the license, I do not want to deal
> with possible legal issues so I'll skip it.
> 

:-)

> I am fine however with abandoning this patch if you or someone else
> sends license change + SPDX.
> 

If that is the case, I am skipping this patch. Ping me / RESEND in case
you still want this. :-)

> Best regards,
> Krzysztof
