From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Thu, 20 Apr 2017 10:55:33 +0530
Message-ID: <20170420052533.GF5436@vireshk-i7>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <0a7146f9-72f1-317c-3aab-770a72462968@arm.com>
 <20170413053736.GM5910@vireshk-i7>
 <3adbef6a-7b43-528f-e88f-c2121d30a5d3@arm.com>
 <20170417052758.GF28191@vireshk-i7>
 <95aa4b97-4e1a-13bb-f4d8-982b778012ba@arm.com>
 <20170419114740.GD5436@vireshk-i7>
 <9dee7c0d-e5f4-9fcd-3c92-bf7ec9d43a3b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9dee7c0d-e5f4-9fcd-3c92-bf7ec9d43a3b-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 19-04-17, 14:58, Sudeep Holla wrote:
> On 19/04/17 12:47, Viresh Kumar wrote:
> > On 18-04-17, 17:01, Sudeep Holla wrote:
> >> Understood. I would incline towards reusing regulators we that's what is
> > 
> > It can be just a regulator, but it can be anything else as well. That
> > entity may have its own clock/volt/current tunables, etc.
> > 
> >> changed behind the scene. Calling this operating performance point
> >> is misleading and doesn't align well with existing specs/features.
> > 
> > Yeah, but there are no voltage levels available here and that doesn't
> > fit as a regulator then.
> > 
> 
> We can't dismiss just based on that. We do have systems where
> performance index is mapped to clocks though it may not be 1:1 mapping.
> I am not disagreeing here, just trying to understand it better.

@Stephen: Can you answer here please ?

> >> Understood. We have exactly same thing with SCPI but it controls both
> >> frequency and voltage referred as operating points. In general, this OPP
> >> terminology is used in SCPI/ACPI/SCMI specifications as both frequency
> >> and voltage control. I am bit worried that this binding might introduce
> >> confusions on the definitions. But it can be reworded/renamed easily if
> >> required.
> > 
> > Yeah, so far we have been looking at OPPs as freq-voltage pairs ONLY
> > and that is changing. I am not sure if it going in the wrong
> > direction really. Without frequency also it is an operating point for
> > the domain. Isn't it?
> > 
> 
> Yes, I completely agree. I am not saying the direction is wrong. I am
> saying it's confusing and binding needs to be more clear.

What exactly isn't clear? (Yeah, there had been lots of emails and I
want to know what improvements are you looking for).

> On the contrary(playing devil's advocate here), we can treat all
> existing regulators alone as OPP then if you strip the voltages and
> treat it as abstract number.

But then we are going to have lots of platform specific code which
will program the actual hardware, etc. Which is all handled by the
regulator framework. Also note that the regulator core selects the
common voltage selected by all the children, while we want to select
the highest performance point here.

Even if we have to configure both clock and voltage for the power
domain using standard clk/regulator frameworks, OPP will work just
fine as it will do that then. So, its not that we are bypassing the
regulator framework here. It will be used if we have the voltages
available for the power-domain's performance states.

> So if the firmware handles more than just
> regulators, I agree.

I don't know the internals of that really.

> At the same time, I would have preferred firmware
> to even abstract the frequency like ACPI CPPC.

Frequency isn't required to be configured for the cases I know, but it
can be in future implementations.

> It would be good to get
> more information on what exactly that firmware handles.

@Stephen ?

> I am just more cautious here since we are designing generic bindings and
> changing generic code, we need to understand what that firmware supports
> and how it may evolve(so that we can maintain DT compatibility)

Sure, I am fine with more discussions on it :)

> I did a brief check and wanted to check if this is SMD/RPM regulators ?

Yes, Qcom calls the external core as Resource and Power manager (RPM).

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
