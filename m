From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 5/9] arm, arm64: factorize common cpu capacity default
 code
Date: Mon, 10 Apr 2017 17:23:06 +0100
Message-ID: <20170410162306.GH30804@e106622-lin>
References: <20170327131825.32134-1-juri.lelli@arm.com>
 <20170327131825.32134-6-juri.lelli@arm.com>
 <20170410081806.GB27538@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170410081806.GB27538-M2fw3Uu6cmfZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 10/04/17 09:18, Catalin Marinas wrote:
> On Mon, Mar 27, 2017 at 02:18:21PM +0100, Juri Lelli wrote:
> > arm and arm64 share lot of code relative to parsing CPU capacity
> > information from DT, using that information for appropriate scaling and
> > exposing a sysfs interface for chaging such values at runtime.
> > 
> > Factorize such code in a common place (driver/base/arch_topology.c) in
> > preparation for further additions.
> > 
> > Suggested-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> > Suggested-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> > Suggested-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
> > Cc: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
> > Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
> > Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> > Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
> > Signed-off-by: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
> > ---
> > 
> > Changes from v2:
> >  - make capacity_scale and raw_capacity static
> >  - added SPDX header
> >  - improved indent
> >  - misc. whitespaces/newlines fixes
> > 
> > Changes from v1:
> >  - keep the original GPLv2 header
> > ---
> >  arch/arm/Kconfig             |   1 +
> >  arch/arm/kernel/topology.c   | 213 ++-----------------------------------
> >  arch/arm64/Kconfig           |   1 +
> >  arch/arm64/kernel/topology.c | 219 +--------------------------------------
> >  drivers/base/Kconfig         |   8 ++
> >  drivers/base/Makefile        |   1 +
> >  drivers/base/arch_topology.c | 242 +++++++++++++++++++++++++++++++++++++++++++
> 
> For arm64:
> 
> Acked-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>

Thanks for reviewing the series.

Best,

- Juri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
