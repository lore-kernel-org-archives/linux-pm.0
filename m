From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/3] arm64: Add big.LITTLE switcher stub
Date: Fri, 09 May 2014 19:57:55 +0100
Message-ID: <536D2533.6050100@arm.com>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org> <1399653631-4938-2-git-send-email-broonie@kernel.org> <536D0AF4.1040705@arm.com> <20140509175005.GT12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55363 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756599AbaEIS4R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 14:56:17 -0400
In-Reply-To: <20140509175005.GT12304@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


On 09/05/14 18:50, Mark Brown wrote:
> On Fri, May 09, 2014 at 06:05:56PM +0100, Sudeep Holla wrote:
>> On 09/05/14 17:40, Mark Brown wrote:
>
>>> From: Mark Brown <broonie@linaro.org>
>
>>> The big.LITTLE cpufreq driver is useful on arm64 big.LITTLE systems even
>>> without IKS support since it implements support for clusters with shared
>>> clocks (a common big.LITTLE configuration). In order to allow it to be
>>> built provide the non-IKS stubs for arm64, enabling cpufreq with all the
>>> cores available.
>
>> I am in process of using this driver for ARM64 and hit the same issue.
>> I don't like this approach at all. I too did similar changes/hacks which are
>> good for quick testing but not for upstream.
>
> I'm not a big fan of this either, but then as I indicated on the cpufreq
> bit of the series I'm not a massive fan of the way this is handled in
> the first place on either ARM or ARMv8.  This at least gives us parity
> between the two architectures (modulo IKS implementation) which is
> progress especially given the fact that much of the work done on this
> stuff is being done on 32 bit due to hardware availability.
>

OK good to know that you too agree that this is not a good approach.

> Given that the code isn't invasive I think the expediency tradeoff is OK
> for mainline, it's easy enough to get rid of when we come up with
> something better but in the meaintine it helps actual systems work
> better in mainline - if we didn't have the ARM implementation already I
> think it'd be different but we do.
>

I disagree, I don't see a real urgency for this on ARM64. Even on ARM32, no
single platform other than TC2 is using this(at least as I see in the mainline).

If some real platform that needs this support urgently, then we can think of
similar short-term solution as part of adding support for cpufreq on that
platform. Do you know any platform that needs this right now ?

> Perfect can be the enemy of good (or at least adequate), one of the
> problems I'm seeing right now with convincing people to work with
> mainline is that people are missing lots of important functionality when
> they look at mainline.
>

Ok fair enough. But we can take some time and see if we can workout better
solution rather than jumping to add interim solutions when is unlikely to be
used on any real platform.

>> I would like to move all the switcher code out of the driver as extension.
>> Also the core driver should be made to work with any multi-clsuter platform not
>> just big-little(bL). bL is one of them and bL switcher support should an
>> extension of it.
>
>> The main reason for this is I see some non-bL multi-cluster platform support
>> getting added, this driver should ideally support that.
>
> It is not entirely clear to me what you mean by "this driver" or "the
> core driver" in all the above, sorry.
>

I meant the core arm-big-little cpufreq driver.

> Personally the solution I'd rather see is cpufreq-cpu0 extended to
> handle shared clocks which would remove the need to use the big.LITTLE

Ideally yes. IIUC it has dependencies on CPU0 and I have not looked that
driver and all of its users to judge how feasible is that. At-least we can
have cpufreq-cpu0 for all single cluster systems w/o support for per-CPU DVFS
and another which can handle multi-cluster systems(with or w/o per-CPU DVFS).

Just a thought...

> driver on systems not doing IKS.  It isn't at all clear to me that
> cpufreq should understand clusters (or much of anything other than
> clocks) in the non-IKS case, the sharing of clocks between cores is not

Yes I agree, I had brought up this in one of the discussions around extending
OPP bindings. The cluster dependency needs to be removed and it should be
derived from the clocks.

> directly connected to their clustering.  Clustering is important to the
> scheduler and an understanding of the power and clock sharing
> constraints that come along with clusters is going to be required there
> as part of energy aware scheduling but I'm not seeing any obvious reason
> for the frequency scaling driver to know about this, even with cpufreq
> governors it's mostly the clock sharing.
>

Both CPUFreq and Energy aware scheduling need understanding of clock sharing. 
Both have similar goals(save power with little or no performance degradation), 
but EA scheduler will be more efficient(both in terms of power and performance).

Governors need this knowledge of sharing as it affects the load calculation.
(IIRC maximum load of all the cpu sharing clocks is taken)

> For IKS where we're pairing the CPUs up and telling the kernel that
> switching between the physical clusters is part of scaling the
> "frequency" of the virtual cluster presented to the rest of the system
> things are of course different and cpufreq does need to understand the
> physical clusters.
>
> Having multiple generic frequency scaling drivers feels wrong; there's
> going to be code duplication between them and it doesn't seem like there
> should be anything going on that we can't automatically figure out at
> runtime.
>

Completely agree with you.

Regards,
Sudeep

