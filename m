From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 03/12] PM / Domains: Add notifier support for power domain
 transitions
Date: Fri, 28 Nov 2014 19:04:32 +0100
Message-ID: <5478B930.4090300@samsung.com>
References: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
 <1414986790-11940-4-git-send-email-amit.daniel@samsung.com>
 <1651173.5xzCFxz3LI@vostro.rjw.lan> <7hmw88gn3q.fsf@deeprootsystems.com>
 <CADGdYn5Prbbe6Rz=OfVMXm3dinCPrE-N0fn23dMMhZb8GzXm-Q@mail.gmail.com>
 <5458B1FA.7050401@samsung.com> <7h8ujmsvcv.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:28061 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbaK1SEp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 13:04:45 -0500
In-reply-to: <7h8ujmsvcv.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: amit daniel kachhap <amit.daniel@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, pankaj.dubey@samsung.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, LAK <linux-arm-kernel@lists.infradead.org>

On 07/11/14 19:45, Kevin Hilman wrote:
> Sylwester Nawrocki <s.nawrocki@samsung.com> writes:
>> On 04/11/14 07:44, amit daniel kachhap wrote:
>>> On Mon, Nov 3, 2014 at 11:53 PM, Kevin Hilman <khilman@kernel.org> wrote:
>>>> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>>>>> On Monday, November 03, 2014 09:23:01 AM Amit Daniel Kachhap wrote:
[...]
>> Indeed, the somehow complicated power domain power on/off sequences
>> are SoC specific.  They involve not only groups of clocks (usually
>> gate, mux clock registers of all devices in a power domain) but also
>> SoC-specific PMU (Power Management Unit) registers.
>> I assume it would be inappropriate to push such details to device 
>> drivers.  Moreover, a device driver could not be even loaded.
>>
>> Since the clocks' state is already maintained by clk driver we came 
>> up with an idea of having generic calls from power domain driver back 
>> to the clock controller driver.
> 
> For the clock tree, it still seems to me that this is better handled in
> the SoC clock driver.  For example, when a power domain is about to be
> gated, all the devices in that domain are runtime suspended, and
> presumably all of their gate clocks are disabled.  Now, doesn't the
> clock driver know the clock tree parent-child hierarchy and shouldn't it
> be capable of saving the state of parent clocks (like mux clocks) etc?
> 
> Stated diffrently, it still seems to me like we're pushing functionality
> in PM core notifiers that should be the responsibility of subsystem
> drivers. 

My apologies for not replying earlier, I got distracted by other 
activities.

I'd prefer not adding anything new to the PM core, however there are
dependencies between the power domain and clock controller driver 
which are hard to model in the current APIs.  I assume resorting to 
inter-exynos-driver API is not a good idea either.

Saving/restoring the clock hierarchy in the clock controller driver
during the power domain state transitions has a caveat that the clock
turn off/on sequences are IP/SoC subsystem specific.  So simply 
restoring saved registers from memory is not going to work.

The other detail I might have forgotten to mention is that the whole
clock controller may be in same power domain as the consumer devices.
That means the clock controller's registers must not be touched when
a related power domain is turned off.  Naturally when a power domain 
gets switched off all the clock controller's registers reset to their 
default values.  If we decided to use pm_runtime_{get_sync, put} in
the clock controller driver I'm not sure how it would need to interact
with the clk API.
In current mainline there is an issue with exynos4x12 that the system
may hang if clk_summary is attempted to read as the clock controller
driver doesn't take the ISP power domain into account.

[...]
>>>> Personally, I'm uncomfortable with notifiers like this because it
>>>> suggests that underlying frameworks are not doing the right thing, or
>>>> are not being used.  (I also don't like the implementation here where a
>>>> single global notifier list is maintained by the core, but the notifiers
>>>> are actually triggered by SoC specific code.)
>>>
>>> Yes right the global notifier block can be moved to per genpd structure.
>>> Also SoC trigger can be moved to core files.
>>>>
>>>> IIUC, the usage in this series seems to be that certain clock related
>>>> registers need to be saved/restored across a power domain transition.
>>>>
>>>> Wouldn't an alternative solution be to add a feature to the clock driver
>>>> such that the state of each clock is saved when the clock is disabled,
>>>> and restored when the clock is enabled?   That would allow any clock
>>>> context to survive any power domain transtion also, correct?
>>>
>>> I also thought about same. But the trigger point for this would be
>>> driver calling clk disable/enable and not the power domain. so this 
>>> will lead to lot of save/restore for each power domain child.
>>
>> Even though we would have saved/restored at that points still the power
>> domain driver would need to enforce some specific clock/PMU registers 
>> state before/after a power domain state transition. And this is what I 
>> found difficult with the existing APIs.
> 
> This is what I'm not understanding.
> 
> Why can't the power domain driver's power_on/power_off callback just
> call the PMU APIs and/or the clk_enable/_disable calls it needs?

I was concerned that it would not have been reliable by using the clk 
API due to the clk enable refcounting.  But that might not be a valid 
argument, since as you pointed out when a power domain is about to 
be gated related the clocks should be already disabled.

The other concern was atomicity in enabling/disabling groups of clocks,
i.e. setting group of bits in a clock gate register at once, rather
than a bit for each clock one by one.  But I'm not 100% sure about 
such a hardware requirement myself, would need to do some more testing 
and/or find a hardware engineer who could explain this. 

Additionally specifying clocks in device tree would be a bit messy and
there would very likely anyway be an additional information required 
in the power domain driver per each power domain regarding the clock 
handling sequence. 

-- 
Regards,
Sylwester
