From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Tue, 22 Mar 2016 09:50:22 +0000
Message-ID: <20160322095022.GA23909@e106622-lin>
References: <1458311054-13524-1-git-send-email-juri.lelli@arm.com>
 <1458311054-13524-3-git-send-email-juri.lelli@arm.com>
 <56EC3F9E.4050209@nvidia.com>
 <20160321105330.GB12319@e106622-lin>
 <CAKfTPtDP3zMR+zbvvqJCBvJ5r44do8NS03wC7pAejxPd0zHTMA@mail.gmail.com>
 <20160321114956.GD12319@e106622-lin>
 <20160321121210.GQ2566@sirena.org.uk>
 <20160321172452.GE12319@e106622-lin>
 <20160321175112.GY2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160321175112.GY2566-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sai Gurrappadi <sgurrappadi-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LAK <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Morten Rasmussen <morten.rasmussen-5wv7dgnIgG8@public.gmane.org>, Dietmar Eggemann <dietmar.eggemann-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Olof
List-Id: linux-pm@vger.kernel.org

On 21/03/16 17:51, Mark Brown wrote:
> On Mon, Mar 21, 2016 at 05:24:52PM +0000, Juri Lelli wrote:
> 
> > I think this should work, but we have to understand how do we obtain the
> > max frequency of each cluster while parsing DT. OPP bindings are
> > helpful, but AFAIK there are platforms for which firmware is responsible
> > for setting up and advertise available OPPs. I'm not sure if this
> > happens later on during the boot process. We might still be able to use
> > the clock-frequency property in this case, but that might need changing
> > again if the top OPP gets removed/changed.
> 
> > OTH, we might simply want to say that capacity values are to be obtained
> > once the platform is "stable" (no additional changes to configuration,
> > OPPs, etc.). But this is maybe not acceptable?
> 
> How about we just punt and let the cpufreq driver tell us - it can parse
> DT, use built in tables or whatever?  We could even remember the raw
> values and recalculate if it ever decides to change for some reason.
> Until cpufreq comes up we'll be stuck at whatever OPP that we're at on
> startup which may not match whatever we define the numbers relative to
> anyway.
> 

OK, I'll try and see how that can be done.

Thanks,

- Juri

> > Also, I fear that for variants of a particular implementation we will
> > still have to redo the profiling anyway (like we alreaady did for Juno
> > and Juno-r2 for example).
> 
> This sometimes happens either through binning or through board design
> decisions rather than through new silicon so we might be able to reuse.


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
