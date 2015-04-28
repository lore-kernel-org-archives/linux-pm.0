From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH] ARM: tegra: cpuidle: implement cpuidle_state.enter_freeze()
Date: Tue, 28 Apr 2015 17:07:14 +0200
Message-ID: <CAAObsKBOZM0qdkrtgQFqMhAq3M2UXUHzZ3jqhrrv0vLrqJgyYA@mail.gmail.com>
References: <1428490480-10144-1-git-send-email-tomeu.vizoso@collabora.com>
 <20150408115546.GA24271@red-moon> <552643E1.3060200@collabora.com>
 <285738930.THBQOWvsah@vostro.rjw.lan> <20150410100844.GC23730@red-moon>
 <CAAObsKAihF1k1yzZxQEs_jpPnCdV3HQbLaYHWu1QNsNd5zqiOg@mail.gmail.com>
 <20150417140819.GB2347@red-moon> <CAAObsKATZy9+Tn0pJcDCaNzpxLX6GqX0TO_t7w8tgirWQgJF9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAObsKATZy9+Tn0pJcDCaNzpxLX6GqX0TO_t7w8tgirWQgJF9w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 17 April 2015 at 17:02, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org> wrote:
> On 17 April 2015 at 16:08, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org> wrote:
>> On Thu, Apr 16, 2015 at 03:37:19PM +0100, Tomeu Vizoso wrote:
>>
>> [...]
>>
>>> >> I don't know what FIQs are. :-)
>>> >
>>> > In short, fast IRQs, it is a separate IRQ line handled as a separate
>>> > exception source with some private (banked) registers that minimize registers
>>> > saving/restoring. They are not identical to NMI on x86, since
>>> > their behaviour (handling) may be overriden by platforms and they
>>> > can be masked.
>>> >
>>> >> ->enter_freeze is entered with interrupts disabled on the local CPU.  It is
>>> >> not supposed to re-enable them.  That is, while in the ->enter_freeze callback
>>> >> routine, the CPU must not be interrupted aby anything other than NMI.
>>> >
>>> > It boils down to what FIQs handlers are allowed to do with tick frozen
>>> > and what they are (may be) currently used for.
>>> >
>>> > Russell has more insights on this than I do, in particular what FIQs are
>>> > currently used for on ARM and if we can leave them enabled safely with tick
>>> > frozen.
>>>
>>> But even if it's currently safe to leave them enabled, is there any
>>> reason for not disabling them?
>>
>> Ok, the point here is: either it is safe, and you leave them enabled,
>> or it is not and we must disable them *before* enter_freeze() is entered.
>>
>> Disabling them in the platform enter_freeze() hook does not make sense,
>> because this means we run with FIQs enabled with tick frozen, either
>> it is safe or it is not, it can't be both.
>
> Sure, that's why I proposed doing it in arch_cpu_idle_enter/exit.
>
>> I would ask Russell opinion on this, before making any decision.
>
> Sure, that would be very welcome.

Hi Russell,

do you think FIQs should be disabled when the tick is frozen when
going to suspend to idle?

Thanks,

Tomeu
