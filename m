From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Mon, 21 Mar 2016 17:24:52 +0000
Message-ID: <20160321172452.GE12319@e106622-lin>
References: <1458311054-13524-1-git-send-email-juri.lelli@arm.com>
 <1458311054-13524-3-git-send-email-juri.lelli@arm.com>
 <56EC3F9E.4050209@nvidia.com>
 <20160321105330.GB12319@e106622-lin>
 <CAKfTPtDP3zMR+zbvvqJCBvJ5r44do8NS03wC7pAejxPd0zHTMA@mail.gmail.com>
 <20160321114956.GD12319@e106622-lin>
 <20160321121210.GQ2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160321121210.GQ2566-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sai Gurrappadi <sgurrappadi-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LAK <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Morten Rasmussen <morten.rasmussen-5wv7dgnIgG8@public.gmane.org>, Dietmar Eggemann <dietmar.eggemann-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Olof
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On 21/03/16 12:12, Mark Brown wrote:
> On Mon, Mar 21, 2016 at 11:49:56AM +0000, Juri Lelli wrote:
> 
> > But we'll still need to normalize this w.r.t the highest score we get on
> > a specific platform, right? And while we are at normalizing it, it is
> > probably simpler if we keep the frequency component as part of the
> > number, IMHO. But, maybe keeping the frequency component separate is
> > more acceptable from a DT binding perspective?
> 
> One possible issue with that: if we keep the frequency number as part of
> the core number then that might cause issues for devices with variants
> or system deployment decisions that remove some OPPs from a table.  If
> the top OPP gets removed that would throw off the numbers.

If we want to remove the frequency number from the capacity values I
think what we could do is:

 - agree on a benchmark (it seems to me this is what Rob is also asking
   for) (e.g., sysbench); this is maybe optional, as what below should
   work for any kind of benchmark for which events/operations performed
   can be measured
 - for that benchmark measure the number of operations performed in a
   second (e.g., sysbench number of events per second or SEPS)
 - divide the number for the frequency we did the profiling at (e.g.,
   SEPS/MHz * 1024, to end up with an integer number)
 - normalize values and put them in DT (IMHO, we don't want absolute
   values there)

To compute the capacities at boot we then have to:

 - multiply the value parsed from DT by the max frequency (e.g.,
   SEPS/MHz * max_freq)
 - normalize capacities obtained with the step above w.r.t. the max
   capacity of the system

I think this should work, but we have to understand how do we obtain the
max frequency of each cluster while parsing DT. OPP bindings are
helpful, but AFAIK there are platforms for which firmware is responsible
for setting up and advertise available OPPs. I'm not sure if this
happens later on during the boot process. We might still be able to use
the clock-frequency property in this case, but that might need changing
again if the top OPP gets removed/changed.

OTH, we might simply want to say that capacity values are to be obtained
once the platform is "stable" (no additional changes to configuration,
OPPs, etc.). But this is maybe not acceptable?

Also, I fear that for variants of a particular implementation we will
still have to redo the profiling anyway (like we alreaady did for Juno
and Juno-r2 for example).

Thanks,

- Juri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
