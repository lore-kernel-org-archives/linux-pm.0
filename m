From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v4 0/3] DEVFREQ,
	DVFS framework for non-CPU devices
Date: Sat, 30 Jul 2011 23:23:05 +0200
Message-ID: <201107302323.06066.rjw@sisk.pl>
References: <1310717510-19002-1-git-send-email-myungjoo.ham@samsung.com>
	<201107291110.41801.rjw@sisk.pl>
	<CAJOA=zPL_DUBb2miytFH6s3AKqroGDBsOPts=SdCb3p0c=cP=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJOA=zPL_DUBb2miytFH6s3AKqroGDBsOPts=SdCb3p0c=cP=A@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Turquette, Mike" <mturquette@ti.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday, July 30, 2011, Turquette, Mike wrote:
> On Fri, Jul 29, 2011 at 2:10 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Friday, July 29, 2011, Turquette, Mike wrote:
> >> On Thu, Jul 28, 2011 at 3:10 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > On Friday, July 15, 2011, MyungJoo Ham wrote:
> >> >> For a usage example, please look at
> >> >> http://git.infradead.org/users/kmpark/linux-2.6-samsung/shortlog/refs/heads/devfreq
> >> >>
> >> >> In the above git tree, DVFS (dynamic voltage and frequency scaling) mechanism
> >> >> is applied to the memory bus of Exynos4210 for Exynos4210-NURI boards.
> >> >> In the example, the LPDDR2 DRAM frequency changes between 133, 266, and 400MHz
> >> >> and other related clocks simply follow the determined DDR RAM clock.
> >> >>
> >> >> The DEVFREQ driver for Exynos4210 memory bus is at
> >> >> /arch/arm/mach-exynos4/devfreq_bus.c in the git tree.
> >> >>
> >> >> MyungJoo Ham (3):
> >> >>   PM: Introduce DEVFREQ: generic DVFS framework with device-specific
> >> >>     OPPs
> >> >>   PM / DEVFREQ: add example governors
> >> >>   PM / DEVFREQ: add sysfs interface (including user tickling)
> >> >
> >> > OK, I'm going to take the patches for 3.2.
> >>
> >> Have any other platforms signed up to use this mechanism to manage
> >> their peripheral DVFS?
> >
> > Not that I know of, but one initial user is sufficient for me.
> > So if you have anything _against_ the patches, please speak up.
> 
> I do have some concerns.  Let me start by saying that I'm defining a
> "governor" as some active piece of executing code, probably a looping
> workqueue that inspects activity/idleness of a device and then makes a
> determination regarding clock frequency.
> 
> devfreq seems to be good framework for creating DVFS governors.
> However I think that most scalable devices on an SoC do *not* need a
> governor, and many scalable devices won't have performance counters or
> any other way to implement such introspection.

OK, so I'd like to see what the author of the patch series has to say
in the face of your comments below.

> Some examples include a MMC controller, which might change its clock
> rate depending on the class of card that the user has inserted.  Or
> even a "smartish" device like a GPU lacking performance counters; it's
> driver will ramp up frequency when there is work to be done and kick
> off a timeout.  If no new work comes in before the timeout then the
> driver will drop the frequency.
> 
> A governor is not required in these cases (as they are event driven)
> and devfreq is quite heavyweight for such applications.  What is
> needed is a QoS-style software layer that allows throughput requests
> to be made from an initiator device towards a target device.  This
> layer should aggregate requests since many initator devices may make
> requests to the same target device.  This layer I'm describing, which
> does not exist today, should be where the actual DVFS transition takes
> place.  That could take the form of a clk_set_rate call in the clock
> framework (as described by Colin in V1 of this series), or some other
> not-yet-realized dvfs_set_opp ,or something like Jean Pihet's
> per-device PM QoS patches or whatever.  For the purposes of this email
> I don't really care which framework implements the QoS request
> aggregation.
> 
> The point of describing this non-existant API is that devfreq should
> really be just another input into it.  A governor that can measure bus
> saturation is really cool, but it may not yield optimal results
> compared to several drivers which make QoS-style requests and insure
> that performance is guaranteed for their particular needs during their
> transactions.  The good news is that we don't have to choose between
> performance counter introspection and software QoS requests: both the
> driver requests and the governor should all feed as inputs into the
> QoS-style DVFS mechanism.
> 
> Taking that logic to its inevitable conclusion, tickle doesn't belong
> inside the governor at all.  If some device X wants to ramp up the
> frequency of device Y, it should just make a QoS-style throughput
> request towards device Y, possibly with a timeout (keeping the
> original idea of tickle intact).  This is entirely a separate idea
> from a governor's introspective workqueue loop.
> 
> For userspace, a sysfs entry for tickle would also not feed into the
> governor, but some dummy struct device *user would probably be the
> initiator device and it would simply call the QoS-style throughput
> API.
> 
> In summary my objections to this series are:
> 1) devfreq should not be the *final* software layer to invoke a DVFS
> transition as it has not taken all constraints into account.
> 2) a devfreq governor represents just one constraint out of many to be
> considered for any given scalable device.
> 
> My objection to these patches getting merged is that I think they are
> a bit ahead of their time.

Still, we're merging quite a number of patches being ahead of their time.
The resulting code is then modified as we learn what's wrong with it or
how to improve it.

Why exactly do you think this approach will not work in this particular case?

> We need to know what the real DVFS API looks like underneath devfreq first,
> since devfreq should really be built on top of it.

Well, quite frankly, if we generally adopted that point of view, much of the
useful functionality we have in the kernel right now wouldn't be merged at all.

Think of the USB subsystem, for one example, that has been rewritten from
scratch no fewer that three times.

The code appears to be reasonably isolated and simple enough to merge.
There is a subsystem wanting to use it and I don't see anyone forcing
anybody else to adopt it.  If it's not suitable to you, you won't be using it,
plain and simple.  And if you come up with some better code to replace it,
I won't have any problems with taking that too.

Thanks,
Rafael
