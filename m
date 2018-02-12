From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [Query] thermal: Who is using "cooling-{min|max}-level}"
 properties ?
Date: Mon, 12 Feb 2018 11:40:15 +0530
Message-ID: <20180212061015.GO28462@vireshk-i7>
References: <20180207065959.GN28462@vireshk-i7>
 <c7bd6ed5-b93e-3a07-b4a2-4c3b1eef5fac@linaro.org>
 <20180207102446.GS28462@vireshk-i7>
 <11fbba25-7029-8a13-476e-ea2f2de6fbf9@linaro.org>
 <20180209064211.GY28462@vireshk-i7>
 <539699c7-9509-dea2-2b31-c5f6749c99c4@linaro.org>
 <20180209092421.GL28462@vireshk-i7>
 <5722441d-c8be-4d29-fab7-28b4e5716961@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5722441d-c8be-4d29-fab7-28b4e5716961-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Punit.Agrawal-5wv7dgnIgG8@public.gmane.org, ionela.voinescu-5wv7dgnIgG8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 09-02-18, 13:14, Daniel Lezcano wrote:
> Right. The semantic is unclear. The expected cooling-cells value is
> always 2 (the code ignore values greater than two and yell if it is less
> than 2). And the cooling-device binding tells there are two states.

They are fixed to 2 as we don't need to use it differently for now.
But that's more about how Linux is using this stuff. The binding still
needs to provide a way to have more cells than just 2.

> So the question is why do we need a cooling-cells as the information is
> pointless here (always 2) ?

To show that the device is a "cooling-device" and I see that
consistent with everything else in DT, for example: interrupt-cells,
gpio-cells, clock-cells, reset-cells, dma-cells. The "*-cells"
properties is used widely to tell what the device can behave as, i.e.
a cooling-device in our case.

Now we always use 2 parameters exactly is a different thing all
together :)

> I see this field is artificially used to tell the cpufreq driver "please
> register me as a cooling device". This is inconsistent from my pov.

But that's how its used for every other controller, what's different
here ?

> Furthermore, the thermal-zone with the cooling device binds with the CPU
> phandle, not the cooling-cells.

Yeah, because that's the device really.

> Putting apart the device binding changes discussion for the moment. Why
> not register the cpufreq driver in all the cases and then drop

s/cpufreq driver/cpufreq cooling driver/ ??

> cooling-cells ? So when the opps are present, its registers in the
> cpufreq->ready callback.

How will someone tell if they don't need the cooling infrastructure ?
Specially for multiplatform thing.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
