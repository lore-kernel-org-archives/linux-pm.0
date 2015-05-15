From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH] ARM: tegra: cpuidle: implement cpuidle_state.enter_freeze()
Date: Fri, 15 May 2015 11:03:35 +0200
Message-ID: <CAAObsKBLHqf1+KUE89Orr7ZwzY3-WEW1CHokSOxSD9pEOmTkhg@mail.gmail.com>
References: <1428490480-10144-1-git-send-email-tomeu.vizoso@collabora.com>
 <20150408115546.GA24271@red-moon> <552643E1.3060200@collabora.com>
 <285738930.THBQOWvsah@vostro.rjw.lan> <20150410100844.GC23730@red-moon>
 <CAAObsKAihF1k1yzZxQEs_jpPnCdV3HQbLaYHWu1QNsNd5zqiOg@mail.gmail.com> <20150417140819.GB2347@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150417140819.GB2347@red-moon>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 17 April 2015 at 16:08, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org> wrote:
> On Thu, Apr 16, 2015 at 03:37:19PM +0100, Tomeu Vizoso wrote:
>
> [...]
>
>> >> I don't know what FIQs are. :-)
>> >
>> > In short, fast IRQs, it is a separate IRQ line handled as a separate
>> > exception source with some private (banked) registers that minimize registers
>> > saving/restoring. They are not identical to NMI on x86, since
>> > their behaviour (handling) may be overriden by platforms and they
>> > can be masked.
>> >
>> >> ->enter_freeze is entered with interrupts disabled on the local CPU.  It is
>> >> not supposed to re-enable them.  That is, while in the ->enter_freeze callback
>> >> routine, the CPU must not be interrupted aby anything other than NMI.
>> >
>> > It boils down to what FIQs handlers are allowed to do with tick frozen
>> > and what they are (may be) currently used for.
>> >
>> > Russell has more insights on this than I do, in particular what FIQs are
>> > currently used for on ARM and if we can leave them enabled safely with tick
>> > frozen.
>>
>> But even if it's currently safe to leave them enabled, is there any
>> reason for not disabling them?
>
> Ok, the point here is: either it is safe, and you leave them enabled,
> or it is not and we must disable them *before* enter_freeze() is entered.
>
> Disabling them in the platform enter_freeze() hook does not make sense,
> because this means we run with FIQs enabled with tick frozen, either
> it is safe or it is not, it can't be both.

I have been looking and asking around, and seems like we should
actually leave FIQs enabled when the tick is frozen and only disable
them within enter_freeze.

My understanding is that FIQ handlers are extremely limited in what
they can do, with the main use being NMI-like functionality. There are
a handful of other FIQ handlers in mainline, but they don't call into
any other kernel code and limit themselves to doing some basic I/O.

The only reason why they should be disabled in enter_freeze is that
the context of the CPU that is going to a lower power state could
become corrupted if a FIQ gets fired during a save or restore
operation.

Regards,

Tomeu

> I would ask Russell opinion on this, before making any decision.
>
> Lorenzo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
