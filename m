From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC/PATCH] dt: bindings: Define bindings for device idle states
Date: Wed, 31 Aug 2016 16:19:41 +0200
Message-ID: <CAPDyKFq-WCJoew1ba7hK+Z+9r5CHecscR7zecaqD4aFaphRnGA@mail.gmail.com>
References: <1472207073-4901-1-git-send-email-ulf.hansson@linaro.org> <20160831101644.GA2508@brendan-thinkstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160831101644.GA2508@brendan-thinkstation>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brendan Jackman <brendan.jackman-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Axel Haslam <ahaslam-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 31 August 2016 at 12:16, Brendan Jackman <brendan.jackman-5wv7dgnIgG8@public.gmane.org> wrote:
> On Fri, Aug 26, 2016 at 12:24:33PM +0200, Ulf Hansson wrote:
>> A device may be capable of entering a low power state when it becomes
>> idle, which should avoid the device from wasting power.
>>
>> Unfortunate entering a such low power state for a device may often also
>> come with a cost. This because when a new request is about to be served,
>> the device must first to be woken up from its low power state. As that may
>> take a while, the request may suffer from an initial latency.
>>
>> These so called device idle states are characteristics of the hardware, so
>> let's define some DT bindings to enable us to describe them.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>
>> Similar DT bindings has been suggested earlier [1], although Rob raised
>> primarily two conserns in that approach.
>>
>> *) The bindings was probably not future proof, some more flexibility was needed.
>>
>> **) As the bindings also relates to idles states for PM domains, it seemed
>> reasonable to discuss them at the same time. As there is an ongoing discussion
>> for that right now [2], I took the opportunity to bring up the discussion for
>> device idles states again.
>>
>
> Hi Ulf,
>
> There was some previous discussion of whether device idle state bindings are
> necessary. It was proposed that rather than adding a whole new binding, we could
> just use the power domain idle state binding from [2]. We suggested that any
> device that has an idle state is, by definition, in a power domain of its own:
> rather than add a device-idle-states property to that device, we just put it in
> a power domain with a domain-idle-states property.

Yes, we can do that software wise, but is that really a proper
description of the HW!?

>
> When I say "by definition", I of course mean "by the definition of 'power
> domain' that's most convenient to my argument", but I think that definition is
> also the one that's most useful for solving our problem.
>
> Sudeep posted some examples in [3] (in the thread for [2]).
>
> Before we discuss device idle state bindings, could we finish discussing that
> idea so that everyone agrees on whether they're actually needed? It might be
> worth having that discussion in replies to [3] so that we can use Sudeep's
> examples. The 5th example in his mail is the most interesting.

Sure, I will get back to that thread.

Although as Rob told me earlier, he wanted to discuss the dev PM QoS
(device idle states) DT  bindings together with the PM domain idle
states DT bindings. So, that's why I brought this up at this point.

Perhaps we can get some input from Rob on how he thinks we should proceed!?

>
>> [1]
>> http://www.spinics.net/lists/devicetree/msg120515.html
>>
>> [2]
>> http://www.spinics.net/lists/arm-kernel/msg522023.html
>
> [3]
> http://www.spinics.net/lists/arm-kernel/msg526162.html
> ^ Message-ID: <9b2ed5d3-c071-8828-5a22-1ab6f3753d74-5wv7dgnIgG8@public.gmane.org>
>
> Cheers,
> Brendan

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
