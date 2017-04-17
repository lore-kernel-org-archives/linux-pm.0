From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Mon, 17 Apr 2017 10:57:58 +0530
Message-ID: <20170417052758.GF28191@vireshk-i7>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <0a7146f9-72f1-317c-3aab-770a72462968@arm.com>
 <20170413053736.GM5910@vireshk-i7>
 <3adbef6a-7b43-528f-e88f-c2121d30a5d3@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3adbef6a-7b43-528f-e88f-c2121d30a5d3-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 13-04-17, 14:42, Sudeep Holla wrote:
> What I was referring is about power domain provider with multiple power
> domains(simply #power-domain-cells=<1> case as explained in the
> power-domain specification.

I am not sure if we should be looking to target such a situation for now, as
that would be like this:

Device controlled by Domain A. Domain A itself is controlled by Domain B and
Domain C.

Though we will end up converting the domain-performance-state property to an
array if that is required in near future.

> Yes. To simplify what not we just have power-domain for a device and
> change state of that domain to change the performance of that device.

Consider this case to understand what I have in Mind.

The power domain have its states as A, B, C, D. There can be multiple devices
regulated by that domain and one of the devices have its power states as: A1,
A2, A3, B1, B2, B3, C1, C2, C3, D1, D2, D3 and all these states have different
frequency/voltages.

IOW, the devices can have regulators as well and may want to fine tune within
the domain performance-state.

> Then put this in the hierarchy. Some thing similar to what we already
> have with new domain-idle states. In that way, we can move any
> performance control to the domain and abstract the clocks and regulators
> from the devices as the first step and from the OSPM view if there's
> firmware support.
> 
> If we are looking this power-domains with performance as just some
> *advanced regulators*, I don't like the complexity added.

In the particular case I am trying to solve (Qcom), we have some sort of
regulators which are only programmed by a M3 core. The M3 core needs integer
numbers representing state we want the domain to be in and it will put the
regulators (or whatever) in a particular state.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
