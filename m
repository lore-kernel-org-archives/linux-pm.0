From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V8 0/3] OPP: Allow OPP table to be used for power-domains
Date: Wed, 3 Jan 2018 12:50:47 +0530
Message-ID: <20180103072047.GD15166@vireshk-i7>
References: <cover.1513591822.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1513591822.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 18-12-17, 15:51, Viresh Kumar wrote:
> Hi,
> 
> Now that the performance state of PM domains are supported by the kernel
> (merged in linux-next), I am trying once again to define the bindings
> which we dropped until the code is merged first.
> 
> Summary:
> 
> Power-domains can also have their active states and this patchset
> enhances the OPP binding to define those.
> 
> The power domains can use the OPP bindings mostly as is. Though there
> are some changes required to support special cases:
> 
> - Allow "operating-points-v2" to contain multiple phandles for power
>   domain providers providing multiple domains.
> 
> - A new property "required-opp" is added for the devices to specify the
>   minimum required OPP of the master domain or any other type of device.
> 
> - Allow some of the OPP properties to accept magic values (firmware
>   dependent) as the OS doesn't know the real freq/voltage values.
> 
> V7->V8:
> - V7 1/2 divided into two patches. 1/3 is unchanged from V7.
> - 2/3 renamed the property from "power-domain-opp" to "required-opp", as
>   suggested by Rob.
> - Added Ulf's reviewed-by for 1/3 and 3/3.
> 
> --
> viresh
> 
> Viresh Kumar (3):
>   OPP: Allow OPP table to be used for power-domains
>   OPP: Introduce "required-opp" property

>   OPP: Allow "opp-hz" and "opp-microvolt" to contain magic values

Discussions are still going on for the last commit, though the first
two are already Acked by Rob and Ulf and are quite independent of the
third one.

Any objections to getting the first two merged for 4.16-rc1 ? I will
send them to Rafael on Friday if no one objects.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
