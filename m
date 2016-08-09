From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 0/8] CPUs capacity information for heterogeneous
 systems
Date: Tue, 9 Aug 2016 11:08:57 +0100
Message-ID: <20160809100857.GB23236@e106622-lin>
References: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
 <20160808164937.GH6879@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160808164937.GH6879-ndre7Fmf5hadTX5a5knrm8zTDFooKrT+cvkQGrU6aU0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 08/08/16 18:49, Peter Zijlstra wrote:
> On Tue, Jul 19, 2016 at 01:40:40PM +0100, Juri Lelli wrote:
> > Patches high level description:
> > 
> >  o 01/08 introduces documentation for the new optional DT binding
> >  o [02-06]/08 add cpu-capacity attribute to TC2, Juno and Juno r2 DTs and
> >    provide parsing of such information at boot time
> >  o [07-08]/08 introduce sysfs attribute
> > 
> 
> So generally ok with me;

Thanks for reviewing.

> there does seem to be an unfortunate
> duplication of code between arm and arm64 but other than that it looks
> fine.
> 

Yes, I know. I'm failing to see how we can cleanly remove that
duplication, though (sysfs interface and callback functions being good
candidates for a common place).

Anyone any ideas?

Best,

- Juri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
