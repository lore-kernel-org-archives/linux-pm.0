From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/3] arm64: Add big.LITTLE switcher stub
Date: Mon, 12 May 2014 09:34:04 +0100
Message-ID: <5370877C.40409@arm.com>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org> <1399653631-4938-2-git-send-email-broonie@kernel.org> <536D0AF4.1040705@arm.com> <20140509175005.GT12304@sirena.org.uk> <536D2533.6050100@arm.com> <20140509192921.GY12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:56980 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907AbaELIcR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 May 2014 04:32:17 -0400
In-Reply-To: <20140509192921.GY12304@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


On 09/05/14 20:29, Mark Brown wrote:
> On Fri, May 09, 2014 at 07:57:55PM +0100, Sudeep Holla wrote:
>> On 09/05/14 18:50, Mark Brown wrote:
>
>>> Given that the code isn't invasive I think the expediency tradeoff is OK
>>> for mainline, it's easy enough to get rid of when we come up with
>>> something better but in the meaintine it helps actual systems work
>>> better in mainline - if we didn't have the ARM implementation already I
>>> think it'd be different but we do.
>
>> I disagree, I don't see a real urgency for this on ARM64. Even on ARM32, no
>> single platform other than TC2 is using this(at least as I see in the mainline).
>
>> If some real platform that needs this support urgently, then we can think of
>> similar short-term solution as part of adding support for cpufreq on that
>> platform. Do you know any platform that needs this right now ?
>
> There's the big.LITTLE Exynos devices, at least the 5410 has shipped in
> product using IKS I believe and so should've been using the big.LITTLE
> cpufreq driver to do the cluster switching; I think some 5420 systems
> were doing the same.  Or reimplementing it which would just be sad.
> There's some other non-public devices I am aware of - the whole reason I
> wrote this series was for those.
>

Correct all these are 32-bit platforms which are now in process of upstreaming.
So far they had their own driver and never used the arm-big-little driver.
And this current series deals with 64-bit platforms.

>>> Perfect can be the enemy of good (or at least adequate), one of the
>>> problems I'm seeing right now with convincing people to work with
>>> mainline is that people are missing lots of important functionality when
>>> they look at mainline.
>
>> Ok fair enough. But we can take some time and see if we can workout better
>> solution rather than jumping to add interim solutions when is unlikely to be
>> used on any real platform.
>
> There are real users who want to use this fairly urgently.  I can't be
> specific, sorry.
>

That's fine, I understand. But the main argument is that if these platforms
will not add support for cpufreq upstream anytime soon, I don't see any value
in rushing to this short term solution.

>>> Personally the solution I'd rather see is cpufreq-cpu0 extended to
>>> handle shared clocks which would remove the need to use the big.LITTLE
>
>> Ideally yes. IIUC it has dependencies on CPU0 and I have not looked that
>> driver and all of its users to judge how feasible is that. At-least we can
>> have cpufreq-cpu0 for all single cluster systems w/o support for per-CPU DVFS
>> and another which can handle multi-cluster systems(with or w/o per-CPU DVFS).
>
>> Just a thought...
>
> It's not clear to me that having multiple clusters should require a
> different driver, the single cluster case is just a specialisation of
> the multicluster one as far as I can see.  It's possible I'm missing
> something though.
>

No you are correct, but that change would require lot of changes and testing.
So my proposal above is just first step to avoid any new drivers and then we
need to merge it with cpufreq-cpu0.

> I have to confess I didn't look in detail at cpufreq-cpu0 to make sure
> it's the best place to start from but it looks clean and does have the
> regulator stuff, though it's probably better to say that the goal is to
> merge that and the big.LITTLE driver.
>

Me either, hence I didn't want to comment much on merging everything to
cpufrq-cpu0. Need to understand all the platforms using it so that generic 
solution based on clocks continues to work.

>>> directly connected to their clustering.  Clustering is important to the
>>> scheduler and an understanding of the power and clock sharing
>>> constraints that come along with clusters is going to be required there
>>> as part of energy aware scheduling but I'm not seeing any obvious reason
>>> for the frequency scaling driver to know about this, even with cpufreq
>>> governors it's mostly the clock sharing.
>
>> Both CPUFreq and Energy aware scheduling need understanding of clock
>> sharing. Both have similar goals(save power with little or no performance
>> degradation), but EA scheduler will be more efficient(both in terms of power
>> and performance).
>
>> Governors need this knowledge of sharing as it affects the load calculation.
>> (IIRC maximum load of all the cpu sharing clocks is taken)
>
> Yes, definitely with respect to the clocks - my point was more about the
> clustering bit (which is related to but not 100% tied to clocks).
>

Ok, that makes sense.

Regards,
Sudeep

