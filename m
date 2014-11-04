From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 03/12] PM / Domains: Add notifier support for power domain
 transitions
Date: Tue, 04 Nov 2014 12:01:14 +0100
Message-ID: <5458B1FA.7050401@samsung.com>
References: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
 <1414986790-11940-4-git-send-email-amit.daniel@samsung.com>
 <1651173.5xzCFxz3LI@vostro.rjw.lan> <7hmw88gn3q.fsf@deeprootsystems.com>
 <CADGdYn5Prbbe6Rz=OfVMXm3dinCPrE-N0fn23dMMhZb8GzXm-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CADGdYn5Prbbe6Rz=OfVMXm3dinCPrE-N0fn23dMMhZb8GzXm-Q@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: amit daniel kachhap <amit.daniel@samsung.com>, Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, pankaj.dubey@samsung.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, LAK <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 04/11/14 07:44, amit daniel kachhap wrote:
> On Mon, Nov 3, 2014 at 11:53 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>>> On Monday, November 03, 2014 09:23:01 AM Amit Daniel Kachhap wrote:
>>>> These power domain transition notifiers will assist in carrying
>>>> out some activity associated with domain power on/off such as
>>>> some registers which may lose its contents and need save/restore
>>>> across domain power off/on.
>>
>> The runtime PM framework already provides callbacks that are useful for
>> context save/restore for devices.  Could you please describe in more
>> detail which registers in which kind of devices need to be
>> saved/restored, and why they cannot be saved/restored using existing
>> mechanisms.
>
> Basically the requirement is mandated by exynos7 manual. It tells that
> before turning off the power domain, some clock registers need to saved
> and should be restored just after turning the power domain. These clock
> registers are not necessarily gate clocks but could be mux clocks etc.
> The driver may not have all information of these clocks also. I suppose
> these are Soc specific changes but drivers should work across Socs.
> This behavior is almost similar to suspend/resume case where a whole
> list of clock registers are saved/restored.

Indeed, the somehow complicated power domain power on/off sequences
are SoC specific.  They involve not only groups of clocks (usually
gate, mux clock registers of all devices in a power domain) but also
SoC-specific PMU (Power Management Unit) registers.
I assume it would be inappropriate to push such details to device 
drivers.  Moreover, a device driver could not be even loaded.

Since the clocks' state is already maintained by clk driver we came 
up with an idea of having generic calls from power domain driver back 
to the clock controller driver.

It might not to be the prettiest solution, nevertheless I couldn't come 
up with a better one which would satisfy all the requirements.  The power
domain should only be provided for use with all the clk/PMU sequences 
handling in place.

Clocks need to also be touched before a power domain switch on or off,
so attaching the clock controller to some power domain wouldn't help,
unless we modify/add to existing power domain related callbacks for 
devices.  Another issue is the clock controller device would need to 
be attached to multiple power domains, and for each power domain the 
power on/off sequence is usually slightly different.

There are also hierarchical power domains where each: the master and
the sub-domain need they own sequence and device usually is attached
only to a sub-domain.  

> Even earlier post by Sylwester (https://lkml.org/lkml/2014/8/5/182) 
> also points to the need of this feature.
>>
>> Personally, I'm uncomfortable with notifiers like this because it
>> suggests that underlying frameworks are not doing the right thing, or
>> are not being used.  (I also don't like the implementation here where a
>> single global notifier list is maintained by the core, but the notifiers
>> are actually triggered by SoC specific code.)
>
> Yes right the global notifier block can be moved to per genpd structure.
> Also SoC trigger can be moved to core files.
>>
>> IIUC, the usage in this series seems to be that certain clock related
>> registers need to be saved/restored across a power domain transition.
>>
>> Wouldn't an alternative solution be to add a feature to the clock driver
>> such that the state of each clock is saved when the clock is disabled,
>> and restored when the clock is enabled?   That would allow any clock
>> context to survive any power domain transtion also, correct?
>
> I also thought about same. But the trigger point for this would be
> driver calling clk disable/enable and not the power domain. so this 
> will lead to lot of save/restore for each power domain child.

Even though we would have saved/restored at that points still the power
domain driver would need to enforce some specific clock/PMU registers 
state before/after a power domain state transition. And this is what I 
found difficult with the existing APIs.

--
Thanks,
Sylwester
