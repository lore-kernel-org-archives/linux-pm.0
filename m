From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] thermal: remove power allocator from list of default
 governors
Date: Wed, 5 Aug 2015 09:35:39 -0700
Message-ID: <20150805163539.GA3603@dtor-ws>
References: <20150804163921.GA36852@dtor-ws>
 <20150805083755.GC2688@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150805083755.GC2688@e104805>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tushar Dave <tushar.n.dave@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, Punit Agrawal <Punit.Agrawal@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 05, 2015 at 09:37:55AM +0100, Javi Merino wrote:
> On Tue, Aug 04, 2015 at 05:39:21PM +0100, Dmitry Torokhov wrote:
> > As it currently stands the power allocator governor can not handle
> > thermal zones that are not specifically crafted and therefore can not be
> > used as a default governor.
> > 
> > Users need to explicitly enable this governor for thermal zones that do
> > have enough information for its operation.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/thermal/Kconfig | 8 --------
> >  1 file changed, 8 deletions(-)
> > 
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 0390044..34d05d3 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -82,14 +82,6 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
> >  	  Select this if you want to let the user space manage the
> >  	  platform thermals.
> >  
> > -config THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
> > -	bool "power_allocator"
> > -	select THERMAL_GOV_POWER_ALLOCATOR
> > -	help
> > -	  Select this if you want to control temperature based on
> > -	  system and device power allocation. This governor can only
> > -	  operate on cooling devices that implement the power API.
> > -
> 
> Currently the only way we have for a thermal zone configured from
> device tree to use a governor from the kernel boot is by using
> THERMAL_DEFAULT_GOV_*.  If we remove this option some devices won't
> have a workable thermal framework until userspace is up and running.

Why would step wise, or fair share be not workable (even if not optimal)
thermal frameworks? It doe snot take that long to get to [early]
userspace. Half of the boot time the thermal framework is not working
anyway because half of the devices that can act as colling devices are
not yet logically there.

> 
> Would you rather have the power allocator governor accept every
> thermal zone?

If it is to be one of default governors then yes, it needs to be able to
manage all thermal zones, the same way as the other 3 governors can, as
far as I know.

Thanks.

-- 
Dmitry
