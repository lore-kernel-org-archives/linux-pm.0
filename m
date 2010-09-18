From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: Re: Improving High-Load Performance with the Ondemand
 Governor [PATCH ATTACHED]
Date: Sat, 18 Sep 2010 15:43:03 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703118AFD38__31206.3226163902$1284804831$gmane$org@dbde02.ent.ti.com>
References: <4C88EF04.1030908@verisign.com> <4C928094.7080207@verisign.com>
	<201009171125.44403.trenn@suse.de> <4C9370DC.6080805@verisign.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C9370DC.6080805@verisign.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David C Niemi <dniemi@verisign.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>
Cc: "discuss@lesswatts.org" <discuss@lesswatts.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

David,

> -----Original Message-----
> From: linux-pm-bounces@lists.linux-foundation.org [mailto:linux-pm-
> bounces@lists.linux-foundation.org] On Behalf Of David C Niemi
> Sent: Friday, September 17, 2010 7:15 PM
> To: cpufreq@vger.kernel.org
> Cc: discuss@lesswatts.org; linux-pm@lists.linux-foundation.org; Arjan van de Ven
> Subject: Re: [linux-pm] Improving High-Load Performance with the Ondemand
> Governor [PATCH ATTACHED]
> 
> Thomas Renninger wrote:
> > On Thursday 16 September 2010 22:39:48 David C Niemi wrote:
> >
> >> I've been doing more testing, and have a couple of observations.  I'm
> >> attaching a minimal form of my changes as a patch for the latest
> >> 2.6.pre36 git version of the driver.  However, it is difficult for me to
> >> test under anything other than 2.6.32 (RHEL 6 beta 2), and there are
> >> some minor differences, though I don't believe they are relevant to my
> >> results.
> >>
> > ...
> > Adrian van dev Van "pre-announced" changes in the cpufreq area about
> > half a year ago:
> >
> I saw his message.  I expect substantial changes are needed in the long
> run, but good alternatives to the Ondemand governor are not ready yet
> and will have to go through a long period of testing on many kinds of
> hardware.  The patch I sent is much more tactical in nature.  It
> intended to be a light-touch, low-risk change, adding one tunable (under
> a name that existed previously in the Conservative governor) and without
> changing default behavior in any way.
> 
> > http://www.betriebssysteme.org/Aktivitaeten/Treffen/2009-
> Bommerholz/Programm/docs/Talks/richling.pdf
> >
> Thanks for the link.  I think integration with the scheduler makes a lot
> of sense in the long run.  I see that particular paper as being a bit
> one-dimensional, though:
> - It focused energy consumption and performance while completing a
> defined task, not power consumption on a mix of tasks and idle time.
> Energy consumed in a defined task is an interesting data point, but not
> even close to the only one; power consumption while in idle or switching
> in and out of idle is how most of our CPU cores spend most of their time.
> - There is no inherent reason the Ondemand governor should be inferior
> to the Performance governor on long-running tasks (at least with my patch).
> - They only looked at AMD hardware.  Intel CPUs behave a lot
> differently, relying a lot more on C-States than P-States for power
> savings, and they may differ in other ways too.
> - There will need to be some tunables, even with a very smart governor
> integrated with the scheduler.  For example, where along the
> performance/power consumption tradeoff should the scheduler/governor be
> aiming?  Should it be optimizing for single-thread or many-thread
> performance?  Should it try to shut down a whole CPU (or core)
> completely whenever possible, or keep everything running in active
> idle?  How important is it to react quickly at the onset of load?
> - Ultimately we need to know something about which P-states do the most
> work per unit energy, and that is not going to be the same for every
> CPU.  I'm skeptical having a wide range of P-States makes much sense.
> There should perhaps be 3 states only per core: (A) minimum power active
> idle, (B) maximum efficiency in terms of work done per unit energy, and
> (C) maximum performance with no regard for energy consumption per se.
> There are certain special steady-state workloads where an intermediate
> power state is truly helpful, like Blu-Ray playback, but that one in
> particular is being taken on by firmware over time, and I'm not sure
> they are worth optimizing for.
> - Ideally the hardware/firmware should have the task of making sure it
> doesn't burn itself up, managing voltages and turning things on/off
> appropriate for each P-state and/or C-state, giving the operating system
> visibility into what is going on with respect to power consumption and
> states, and otherwise following orders from the operating system about
> what needs to be done.  I think some implementations have gone too far
> in the direction of trying to implement governor-like smarts into the
> firmware or CPU, while inherently lacking the operating system's more
> complete view of what is trying to be accomplished.
> 
> > Interesting is:
> > ---------------------
> > I've testing on a dual Xeon X5680 system
> > (other times I've been testing on 2-year-old dual Opterons).
> > I observe about a 10W power consumption reduction at idle between the
> > "performance" governor and the "ondemand" governor.
> > ---------------------
> > On the Opteron or Xeon system? That would mean that reducing frequency
> > from OS still is an important power consumption knob even on latest Westmere
> > systems.
> >
> 
> That was on the 32nm (Westmere) CPUs, with hyperthreading on.  On
> Opterons power consumption differences between Performance and Ondemand
> are much larger, like I mentioned AMD and Intel behave a lot differently
> here.  They also change behavior over time -- older Intel CPUs
> (Woodcrest) had almost negligible power consumption differences by
> changing clock speed, and some of them were not even capable of changing
> clock speed at all.  AMD has tended to allow very slow idle states,
> around 1 GHz, while Intel's minimum is at 1.596 GHz; but Intel has been
> more aggressive about shutting off inactive parts of caches and cores.
> 
> So anyway, I believe the Ondemand governor will continue to have a lot
> of relevance for another year at least, until a replacement is (a) fully
> implemented, (b) widely tested, and (c) works its way downstream to
> distributions.  Without something like this patch, I'll be stuck with
> the Performance governor in the mean time, which is far worse.

Do you mind sharing this patch again? The subject says patch attached, but could not find this patch in the mailing list :-(

Thanks
Vishwa
> 
> David C Niemi
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
