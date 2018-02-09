From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [Query] thermal: Who is using "cooling-{min|max}-level}"
 properties ?
Date: Fri, 9 Feb 2018 14:54:21 +0530
Message-ID: <20180209092421.GL28462@vireshk-i7>
References: <20180207065959.GN28462@vireshk-i7>
 <c7bd6ed5-b93e-3a07-b4a2-4c3b1eef5fac@linaro.org>
 <20180207102446.GS28462@vireshk-i7>
 <11fbba25-7029-8a13-476e-ea2f2de6fbf9@linaro.org>
 <20180209064211.GY28462@vireshk-i7>
 <539699c7-9509-dea2-2b31-c5f6749c99c4@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <539699c7-9509-dea2-2b31-c5f6749c99c4-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Punit.Agrawal-5wv7dgnIgG8@public.gmane.org, ionela.voinescu-5wv7dgnIgG8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 09-02-18, 10:15, Daniel Lezcano wrote:
> On 09/02/2018 07:42, Viresh Kumar wrote:
> > On 07-02-18, 11:45, Daniel Lezcano wrote:
> >> Yes, that is my understanding. cooling-min-level and cooling-max-level
> >> are not used in the thermal framework code today.
> > 
> > Right.
> > 
> >> So if they are defined, we should check the cooling-device max and min
> >> are in the boundaries (if they are different from no-limit).
> > 
> > Hmm, I am not sure. We do compare those values (from maps) with the
> > max reported by the cooling driver, so there is some boundary check
> > happening. And I don't think it is worth comparing the min/max values
> > from DT cooling device's nodes. Why not just leave those for the
> > driver to return (which is already happening btw).
> > 
> > I don't think it would be correct for the thermal core to go and look
> > at the min/max properties of the cooling device directly, as those are
> > more for the thermal driver's help. The thermal core should just call
> > the get_max_state() callback and that's it.
> > 
> > Anyway, we can take decision on the binding itself after some time but
> > I will send some patches to get rid of this property from CPU nodes
> > for now. It doesn't make sense to have it there (anyway it is
> > optional), as the cpu cooling devices are kind of virtual cooling
> > devices which rely on OPP or freq-table currently. Maybe I will begin
> > by just updating one platform and once that is merged, update
> > everything else as well.

So I eventually updated everything as very small number of platforms
were actually using it.

https://lkml.kernel.org/r/cover.1518166039.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org

> What about the "cooling-cells" ? Its usage is unclear in the code and
> I'm not sure it is really needed.

As I can see, it is actually used (sometimes a bit indirectly).

- This field is used to check if a device is a cooling device or not.
  For example, the cpu-cooling device wouldn't be registered by the
  cpufreq drivers unless this property is present in the CPU node. So
  this is actually used.

- This field (and its value) also comes into picture while parsing the
  "cooling-maps". The "cooling-device" property in the map needs to
  have "cooing-cells" + 1 fields. The first one is the cooling-device
  phandle, followed by min/max states.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
