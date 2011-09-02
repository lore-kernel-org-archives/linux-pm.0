From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v9 2/4] PM: Introduce devfreq: generic DVFS
 framework with device-specific OPPs
Date: Thu, 1 Sep 2011 23:55:34 -0700
Message-ID: <CAJOA=zPcjwgV_gtNOiHC1sc_kX62mpiwL30zduK_HNDgvdLD3Q@mail.gmail.com>
References: <1314775779-21399-1-git-send-email-myungjoo.ham@samsung.com>
	<1314775779-21399-3-git-send-email-myungjoo.ham@samsung.com>
	<CAJOA=zM+MOAd9cCo04EzsegvkbOHRykZpiyappPptpC95b18=w@mail.gmail.com>
	<CAJ0PZbQiv0eKcTu4gzdtvXGAm9MbETeHQ7AgOcXA4gYCF8H9-g@mail.gmail.com>
	<CAJOA=zMnkNmDrCpO4Y+1TJOAPUcNwsJn0Cp+zY_NNYeFxGdzkw@mail.gmail.com>
	<CAJ0PZbQb4T1TeCLb4ZD1tLQYcVaq4z4FbG9dMCeNSXX6TiQt4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJ0PZbQb4T1TeCLb4ZD1tLQYcVaq4z4FbG9dMCeNSXX6TiQt4Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@gmail.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 1, 2011 at 9:38 PM, MyungJoo Ham <myungjoo.ham@gmail.com> wrote:
> I'm considering to allow a governor to declare that it will run its own l=
oop
> .
> Because we have .init/.exit callbacks and an update in OPP triggers to
> call devfreq->profile->target anyway, we only need to add one bit in
> struct devfreq_governor, "bool own_loop". Then, we just need to modify
> devfreq_add_device to omit from the list or mark them not to be looped
> if the "own_loop" bit is true for the given governor.
>
> That way, we can keep most governors simple as cpufreq's drivers and
> as not complex as cpufreq's governors. For those governors that really
> need to run their own loop, we can give the option. I want most
> devfreq governors to be general enough for devfreq devices so that the
> device drivers may use any of them without altering the parameters
> much and easy and short enough for subsystems to have their own
> governors. Thus, common things such as looping and getting usage
> statistics are moved from governors to devfreq framework.

I can understand wanting to keep the governors simpler than their
CPUfreq counterparts.  However I also disagree with polling boolean
and the use of devfreq for non-polling purposes (with the exception of
powersave & performance, which are mostly for testing, and for
userspace which is a special case).

Also my version of the patch removes the dependency on the opp library
and abstracts those details away in a frequency table, which might use
OPPs as a backing store, or might accept arbitrary rates given min/max
limitations (such as for a device connected to a clock with a very
wide divider).  There are probably devices out there than can simply
change rates with clk_set_rate that would benefit from devfreq, but do
not have OPPs.

> You are welcome to post an RFC patch to allow governors to have their
> own loop implemented in governors; however, I think that should be
> optional, not mandatory for governors. And, that degree of
> synchronization issue in devfreq ain't that badly complex, isn't it?

Thanks for being open to the idea.  I don't think that the list walk
is wildly complex but some of the differences run deeper than that.
I'm at LPC next week so I'm not sure when my RFC will hit the list.
Hopefully the week after LPC.  Until then I'll continue to review your
devfreq patches as usual.

>
> Thank you.
>
>
> Cheers! It's Friday.
> MyungJoo
>
> ps. Ah.. and for the kobject thing that you've mentioned in the other
> thread, I'm experimenting it (a kobject class "devfreq"). However, it
> will relocate devfreq sysfs entries from /sys/devices/.../power/* to
> /sys/devices/.../devfreq/*.

Just my $0.02, but my patch does the same thing and I think it's a
good thing.  The code lives drivers/devfreq/ so placing it under
/sys/device/.../power/ wasn't a perfect fit anyways.

Regards,
Mike

> To Rafael:
> =A0Would it be fine for the devfreq sys entries to move to such a
> location by creating "devfreq" class? I remember you've objected to an
> independent per-device sysfs directory for devfreq entries. However,
> it is sort of "sideeffect" in reducing overhead of searching struct
> devfreq again and again for sysfs callbacks.
>
> --
> MyungJoo Ham, Ph.D.
> Mobile Software Platform Lab, DMC Business, Samsung Electronics
>
