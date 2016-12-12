From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 1/8] Documentation: arm: define DT cpu
 capacity-dmips-mhz bindings
Date: Mon, 12 Dec 2016 13:33:53 +0000
Message-ID: <20161212133353.GB27472@e106622-lin>
References: <1473085372-2840-1-git-send-email-juri.lelli@arm.com>
 <1473085372-2840-2-git-send-email-juri.lelli@arm.com>
 <20161212124005.GA19177@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161212124005.GA19177@red-moon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni@free-ele>
List-Id: linux-pm@vger.kernel.org

On 12/12/16 12:40, Lorenzo Pieralisi wrote:
> On Mon, Sep 05, 2016 at 03:22:45PM +0100, Juri Lelli wrote:
> 
> [...]
> 
> > +===========================================
> > +5 - References
> > +===========================================
> > +
> > +[1] ARM Linux Kernel documentation - CPUs bindings
> > +    Documentation/devicetree/bindings/arm/cpus.txt
> > diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> > index e6782d50cbcd..c1dcf4cade2e 100644
> > --- a/Documentation/devicetree/bindings/arm/cpus.txt
> > +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> > @@ -241,6 +241,14 @@ nodes to be present and contain the properties described below.
> >  			# List of phandles to idle state nodes supported
> >  			  by this cpu [3].
> >  
> > +	- capacity-dmips-mhz
> > +		Usage: Optional
> > +		Value type: <u32>
> > +		Definition:
> > +			# u32 value representing CPU capacity [3] in
> > +			  DMIPS/MHz, relative to highest capacity-dmips-mhz
> > +			  in the system.
> > +
> >  	- rockchip,pmu
> >  		Usage: optional for systems that have an "enable-method"
> >  		       property value of "rockchip,rk3066-smp"
> > @@ -464,3 +472,5 @@ cpus {
> >  [2] arm/msm/qcom,kpss-acc.txt
> >  [3] ARM Linux kernel documentation - idle states bindings
> >      Documentation/devicetree/bindings/arm/idle-states.txt
> > +[3] ARM Linux kernel documentation - cpu capacity bindings
> > +    Documentation/devicetree/bindings/arm/cpu-capacity.txt
> 
> Trivia: bumped into this while reviewing something else, too many
> threes, you will have to fix the added reference up.

Argh! Fixed locally, thanks for catching it.

Best,

- Juri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
