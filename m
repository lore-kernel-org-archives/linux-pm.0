From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 0/6] CPUs capacity information for heterogeneous
 systems
Date: Tue, 9 Feb 2016 10:37:48 +0000
Message-ID: <20160209103748.GP11415@e106622-lin>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
 <56B92BF4.4030405@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56B92BF4.4030405-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steve Muckle <steve.muckle-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Steve,

On 08/02/16 15:59, Steve Muckle wrote:
> Hi Juri,
> 
> On 02/03/2016 03:59 AM, Juri Lelli wrote:
> >  v1: DT + sysfs [1]
> > 
> >  v2: Dynamic profiling at boot [2]
> > 
> > Third version of this patchset proposes what seems to be the solution we agreed
> > upon (see [2] for reference) to the problem of how do we init CPUs original
> > capacity: we run a bogus benchmark (stealing int_sqrt from lib/ we run that in
> > a loop to perform some integer computation, better benchmarks are welcome)
> > on the first cpu of each frequency domain (assuming no u-arch differences
> > inside domains), measure time to complete a fixed number of iterations and then
> > normalize results to SCHED_CAPACITY_SCALE (1024). This time around we also
> > added a boot time parameter to disable profiling at boot (as it can be time
> > consuming) and sysfs attributes with which default values can be overwritten.
> > The proposed solution is basically putting together bits of v1 and v2 that are
> > considered valuable and acceptable for mainline.
> 
> I'm still concerned that there's no way to obtain optimal boot time on a
> heterogeneous system. Either the dynamic benchmarking is enabled, adding
> 1 sec, or the benchmarking is skipped, and task distribution on the
> heterogeneous CPUs is determined by the platform's CPU numbering and
> chance, potentially impacting performance nondeterministically until
> userspace sets the correct capacity values via sysfs.
> 
> I believe you tested the impact on boot time of using equal capacity
> values and saw little difference. I'm wondering though, what was the CPU
> numbering on that target?
> 

My targets (Juno and TC2) had big cluster on 1,2 and little on the
remaining cpus. Why do you think this might matter?

Anyway, IMHO boot time performance is not what we are targeting here, so
I wouldn't be too worried about this particular point.

Best,

- Juri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
