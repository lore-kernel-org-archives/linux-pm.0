From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v5 05/12] PM / devfreq: Add support for policy notifiers
Date: Thu, 2 Aug 2018 16:13:43 -0700
Message-ID: <20180802231343.GS68975@google.com>
References: <CGME20180703234900epcas1p1cda806bab6bbe69228ca5ee56bc33f36@epcas1p1.samsung.com>
 <20180703234705.227473-6-mka@chromium.org>
 <5B3C6C2A.1070205@samsung.com>
 <20180706175301.GG129942@google.com>
 <5399c191-e140-e2b8-629b-72ddfbf99b0f@samsung.com>
 <20180716175050.GZ129942@google.com>
 <20180731193953.GH68975@google.com>
 <5B610B48.4030802@samsung.com>
 <20180801170824.GJ68975@google.com>
 <5B626563.1090302@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5B626563.1090302@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On Thu, Aug 02, 2018 at 10:58:59AM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> On 2018년 08월 02일 02:08, Matthias Kaehlcke wrote:
> > Hi Chanwoo,
> > 
> > On Wed, Aug 01, 2018 at 10:22:16AM +0900, Chanwoo Choi wrote:
> >> On 2018년 08월 01일 04:39, Matthias Kaehlcke wrote:
> >>> On Mon, Jul 16, 2018 at 10:50:50AM -0700, Matthias Kaehlcke wrote:
> >>>> On Thu, Jul 12, 2018 at 05:44:33PM +0900, Chanwoo Choi wrote:
> >>>>> Hi Matthias,
> >>>>>
> >>>>> On 2018년 07월 07일 02:53, Matthias Kaehlcke wrote:
> >>>>>> Hi Chanwoo,
> >>>>>>
> >>>>>> On Wed, Jul 04, 2018 at 03:41:46PM +0900, Chanwoo Choi wrote:
> >>>>>>
> >>>>>>> Firstly,
> >>>>>>> I'm not sure why devfreq needs the devfreq_verify_within_limits() function.
> >>>>>>>
> >>>>>>> devfreq already used the OPP interface as default. It means that
> >>>>>>> the outside of 'drivers/devfreq' can disable/enable the frequency
> >>>>>>> such as drivers/thermal/devfreq_cooling.c. Also, when some device
> >>>>>>> drivers disable/enable the specific frequency, the devfreq core
> >>>>>>> consider them.
> >>>>>>>
> >>>>>>> So, devfreq doesn't need to devfreq_verify_within_limits() because
> >>>>>>> already support some interface to change the minimum/maximum frequency
> >>>>>>> of devfreq device. 
> >>>>>>>
> >>>>>>> In case of cpufreq subsystem, cpufreq only provides 'cpufreq_verify_with_limits()'
> >>>>>>> to change the minimum/maximum frequency of cpu. some device driver cannot
> >>>>>>> change the minimum/maximum frequency through OPP interface.
> >>>>>>>
> >>>>>>> But, in case of devfreq subsystem, as I explained already, devfreq support
> >>>>>>> the OPP interface as default way. devfreq subsystem doesn't need to add
> >>>>>>> other way to change the minimum/maximum frequency.
> >>>>>>
> >>>>>> Using the OPP interface exclusively works as long as a
> >>>>>> enabling/disabling of OPPs is limited to a single driver
> >>>>>> (drivers/thermal/devfreq_cooling.c). When multiple drivers are
> >>>>>> involved you need a way to resolve conflicts, that's the purpose of
> >>>>>> devfreq_verify_within_limits(). Please let me know if there are
> >>>>>> existing mechanisms for conflict resolution that I overlooked.
> >>>>>>
> >>>>>> Possibly drivers/thermal/devfreq_cooling.c could be migrated to use
> >>>>>> devfreq_verify_within_limits() instead of the OPP interface if
> >>>>>> desired, however this seems beyond the scope of this series.
> >>>>>
> >>>>> Actually, if we uses this approach, it doesn't support the multiple drivers too.
> >>>>> If non throttler drivers uses devfreq_verify_within_limits(), the conflict
> >>>>> happen.
> >>>>
> >>>> As long as drivers limit the max freq there is no conflict, the lowest
> >>>> max freq wins. I expect this to be the usual case, apparently it
> >>>> worked for cpufreq for 10+ years.
> >>>>
> >>>> However it is correct that there would be a conflict if a driver
> >>>> requests a min freq that is higher than the max freq requested by
> >>>> another. In this case devfreq_verify_within_limits() resolves the
> >>>> conflict by raising p->max to the min freq. Not sure if this is
> >>>> something that would ever occur in practice though.
> >>>>
> >>>> If we are really concerned about this case it would also be an option
> >>>> to limit the adjustment to the max frequency.
> >>>>
> >>>>> To resolve the conflict for multiple device driver, maybe OPP interface
> >>>>> have to support 'usage_count' such as clk_enable/disable().
> >>>>
> >>>> This would require supporting negative usage count values, since a OPP
> >>>> should not be enabled if e.g. thermal enables it but the throttler
> >>>> disabled it or viceversa.
> >>>>
> >>>> Theoretically there could also be conflicts, like one driver disabling
> >>>> the higher OPPs and another the lower ones, with the outcome of all
> >>>> OPPs being disabled, which would be a more drastic conflict resolution
> >>>> than that of devfreq_verify_within_limits().
> >>>>
> >>>> Viresh, what do you think about an OPP usage count?
> >>>
> >>> Ping, can we try to reach a conclusion on this or at least keep the
> >>> discussion going?
> >>>
> >>> Not that it matters, but my preferred solution continues to be
> >>> devfreq_verify_within_limits(). It solves conflicts in some way (which
> >>> could be adjusted if needed) and has proven to work in practice for
> >>> 10+ years in a very similar sub-system.
> >>
> >> It is not true. Current cpufreq subsystem doesn't support external OPP
> >> control to enable/disable the OPP entry. If some device driver
> >> controls the OPP entry of cpufreq driver with opp_disable/enable(),
> >> the operation is not working. Because cpufreq considers the limit
> >> through 'cpufreq_verify_with_limits()' only.
> > 
> > Ok, we can probably agree that using cpufreq_verify_with_limits()
> > exclusively seems to have worked well for cpufreq, and that in their
> > overall purpose cpufreq and devfreq are similar subsystems.
> > 
> > The current throttler series with devfreq_verify_within_limits() takes
> > the enabled OPPs into account, the lowest and highest OPP are used as
> > a starting point for the frequency adjustment and (in theory) the
> > frequency range should only be narrowed by
> > devfreq_verify_within_limits().
> > 
> >> As I already commented[1], there is different between cpufreq and devfreq.
> >> [1] https://lkml.org/lkml/2018/7/4/80
> >>
> >> Already, subsystem already used OPP interface in order to control
> >> specific OPP entry. I don't want to provide two outside method
> >> to control the frequency of devfreq driver. It might make the confusion.
> > 
> > I understand your point, it would indeed be preferable to have a
> > single method. However I'm not convinced that the OPP interface is
> > a suitable solution, as I exposed earlier in this thread (quoted
> > below).
> > 
> > I would like you to at least consider the possibility of changing
> > drivers/thermal/devfreq_cooling.c to devfreq_verify_within_limits().
> > Besides that it's not what is currently used, do you see any technical
> > concerns that would make devfreq_verify_within_limits() an unsuitable
> > or inferior solution?
> 
> As we already discussed, devfreq_verify_within_limits() doesn't support
> the multiple outside controllers (e.g., devfreq-cooling.c).

That's incorrect, its purpose is precisely that.

Are you suggesting that cpufreq with its use of
cpufreq_verify_within_limits() (the inspiration for
devfreq_verify_within_limits()) is broken? It is used by cpu_cooling.c
and other drivers when receiving a CPUFREQ_ADJUST event, essentially
what I am proposing with DEVFREQ_ADJUST.

Could you elaborate why this model wouldn't work for devfreq? "OPP
interface is mandatory for devfreq" isn't really a technical argument,
is it mandatory for any other reason than that it is the interface
that is currently used?

> After you are suggesting the throttler core, there are at least two
> outside controllers (e.g., devfreq-cooling.c and throttler driver).
> As I knew the problem about conflict, I cannot agree the temporary
> method. OPP interface is mandatory for devfreq in order to control
> the OPP (frequency/voltage). In this situation, we have to try to
> find the method through OPP interface.

What do you mean with "temporary method"?

We can try to find a method through the OPP interface, but at this
point I'm not convinced that it is technically necessary or even
preferable.

Another inconvenient of the OPP approach for both devfreq-cooling.c
and the throttler is that they have to bother with disabling all OPPs
above/below the max/min (they don't/shouldn't have to care), instead
of just telling devfreq the max/min.

> We can refer to regulator/clock. Multiple device driver can use
> the regulator/clock without any problem. I think that usage of OPP
> is similiar with regulator/clock. As you mentioned, maybe OPP
> would handle the negative count. Although opp_enable/opp_disable()
> have to handle the negative count and opp_enable/opp_disable()
> can support the multiple usage from device drivers, I think that
> this approach is right.

The regulator/clock approach with the typical usage counts seems more
intuitive to me, personally I wouldn't write an interface with
negative usage count if I could reasonably avoid it.

> >> I want to use only OPP interface to enable/disable frequency
> >> even if we have to modify the OPP interface.
> > 
> > These are the concerns I raised earlier about a solution with OPP
> > usage counts:
> > 
> > "This would require supporting negative usage count values, since a OPP
> > should not be enabled if e.g. thermal enables it but the throttler
> > disabled it or viceversa.
> 
> Already replied	about negative usage count. I think that negative usage count
> is not problem if this approach could resolve the issue.
> 
> > 
> > Theoretically there could also be conflicts, like one driver disabling
> > the higher OPPs and another the lower ones, with the outcome of all
> > OPPs being disabled, which would be a more drastic conflict resolution
> > than that of devfreq_verify_within_limits()."
> > 
> > What do you think about these points?
> 
> It depends on how to use OPP interface on multiple device driver.
> Even if devfreq/opp provides the control method, outside device driver
> are misusing them. It is problem of user.

I wouldn't call it misusing if two independent drivers take
contradictory actions on an interface that doesn't provide
arbitration. How can driver A know that it shouldn't disable OPPs a, b
and c because driver B disabled d, e and f? Who is misusing the
interface, driver A or driver B?

> Instead, if we use the OPP interface, we can check why OPP entry
> is disabled or enabled through usage count.
> 
> > 
> > The negative usage counts aren't necessarily a dealbreaker in a
> > technical sense, though I'm not a friend of quirky interfaces that
> > don't behave like a typical user would expect (e.g. an OPP isn't
> > necessarily enabled after dev_pm_opp_enable()).
> > 
> > I can sent an RFC with OPP usage counts, though due to the above
> > concerns I have doubts it will be well received.
> 
> Please add me to Cc list.

Will do

Thanks

Matthias
