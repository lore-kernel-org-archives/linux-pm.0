From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v3] ARM: tegra: cpuidle: implement cpuidle_state.enter_freeze()
Date: Mon, 29 Jun 2015 11:18:49 +0200
Message-ID: <CAAObsKDD8juE3VuM94Z+d0Z8Gs0c2SWTg61uMa-9jQ+X1-FAVQ@mail.gmail.com>
References: <1432046953-12945-1-git-send-email-tomeu.vizoso@collabora.com>
 <1773599.T1QStsTFTH@vostro.rjw.lan> <CAAObsKCURyo-ujcA7r+UYqSw6ie-aBxKiYEdTKwe-HrL14RkBw@mail.gmail.com>
 <20150629090050.GD5431@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150629090050.GD5431@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 29 June 2015 at 11:00, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Jun 18, 2015 at 09:09:29AM +0200, Tomeu Vizoso wrote:
>> On 21 May 2015 at 03:02, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
>> > On Tuesday, May 19, 2015 04:49:12 PM Tomeu Vizoso wrote:
>> >> This callback is expected to do the same as enter() but it has to
>> >> guarantee that interrupts aren't enabled at any point in its execution,
>> >> as the tick is frozen.
>> >>
>> >> It will be called when the system goes to suspend-to-idle and will
>> >> reduce power usage because CPUs won't be awaken for unnecessary IRQs.
>> >>
>> >> By setting the CPUIDLE_FLAG_TIMER_STOP flag, we can reuse the same code
>> >> for both the enter() and enter_freeze() callbacks.
>> >>
>> >> Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>> >> Cc: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> >
>> > Makes sense to me, but I suppose it should go in via arm-soc.
>>
>> Hi Thierry,
>>
>> what's the plan regarding merging of this patch?
>>
>> It needs df8d9ee ("cpuidle: Run tick_broadcast_exit() with disabled
>> interrupts") so it doesn't break boot.
>
> By the looks of it the above patch was merged in 4.1, so I can easily
> take this through the Tegra tree. The commit message doesn't say whether
> or not this fixes a bug. Is this urgent? Should it go into 4.2? It
> sounds more like it's a power-saving feature, so 4.3 is probably more
> appropriate.

Yeah, it doesn't fix any bug and its effect should only be reduced
power consumption when in suspend-to-idle.

Thanks,

Tomeu

> Thierry
