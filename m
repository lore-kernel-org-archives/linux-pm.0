From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC V2] OPP: Redefine bindings to overcome shortcomings
Date: Fri, 30 Jan 2015 10:47:15 +0530
Message-ID: <CAKohpokig+CA00SSPhHfdMMgVm8PYHMRf+PLy0cGPbFYF6XT=w@mail.gmail.com>
References: <cbe949d7a69c3b16a3e9d6e5429eb81d3ae9d8b9.1422009157.git.viresh.kumar@linaro.org>
	<20150128200600.GR21293@sirena.org.uk>
	<CAKohpokxdpF2nTeOnDpofNM1vW3aZRyDBE3WKmvZ8wJedf-TGw@mail.gmail.com>
	<CAL_Jsq+mhuR-DnjXo9Mmgpazgb_3R+sm+Ztkd7+6Q3iVw0aKOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_Jsq+mhuR-DnjXo9Mmgpazgb_3R+sm+Ztkd7+6Q3iVw0aKOA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Abhilash Kesavan <kesavan.abhilash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linaro Kernel Mailman List <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, santosh shilimkar <santosh.shilimkar-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mike Turquette <mike.turquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 29 January 2015 at 21:12, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, Jan 28, 2015 at 7:39 PM, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

>> The goal is to choose the driver which we want to probe for a platform. There
>> can be multiple DT enabled cpufreq drivers present in a build and the platform
>> needs some way to choose one of them.
>
> That was not my original thought, but rather it is versioning the
> binding and a way to find OPP nodes. That doesn't mean we can't do
> things to make it easier to match to drivers.

Okay.

>> For example, if both cpufreq-dt, exynos-cpufreq and arm-big-little drivers are
>> present in a kernel build, the how do we specify which one a platform wants to
>> use.
>
> What does the exynos driver do that the other 2 don't?

There are efforts going on to start using cpufreq-dt instead
of exynos drivers. So, they might die at some point of time.

Anyway, there can be cpufreq drivers which co-exist
cpufreq-dt, even if they are parsing the same bindings.

> I will likely nak any such strings that are solely there to match to
> these 2 drivers. The information is there in DT already. It's just not
> a single property to match on. You can tell it is a big.LITTLE system
> by the fact your have 2 different cpu types. You can use the top level
> compatible strings when you need a machine specific driver. I would
> not be trying to get cpufreq platform devices to be created by
> of_platform_populate. The other issue I have is you may not always
> have 2 drivers for bL and non-bL. Really symmetric multi-cluster or
> single cluster should be a subset of functionality of bL.
>
> I think you just need to have an initcall which does this:
>
> if (of_find_matching_node_and_match(machine_specific_driver_match list))
>   platform_device_create(match->data);
> else if (is_big_little() && has_opp)
>   platform_device_create(big_little_device);
> else if (has_opp)
>   platform_device_create(cpufreq_dt_device);
>
> Or perhaps you handle the generic ones late in boot only if no machine
> specific driver has been probed. There is no generic solution ATM for
> selecting the best driver when there are multiple matches.

One thing is clear. The compatibility string here isn't going to be
like what I had in mind. So, let it just define the versioning
here and I will see how can I solve the driver-probe problem.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
