From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] fix sysfs showing the correct C-states after AC->DC and
 DC->AC transitions
Date: Thu, 02 Apr 2015 14:04:35 +0200
Message-ID: <2713092.F08tekMTF5@amdc1032>
References: <3701793.GEjYLvWeTc@netbook>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <3701793.GEjYLvWeTc@netbook>
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Schlichter <thomas.schlichter@web.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On Wednesday, April 01, 2015 08:04:34 PM Thomas Schlichter wrote:
> Hello,

Hi,

> I do have a Samsung NC20 netbook which provides the C-states C1 and C2 to the 
> OS when connected to AC, and additionally provides the C3 C-state when 
> disconnected from AC. With the current kernels I have these two problems 
> (regressions):
> 
> 1. The number of C-states shown in sysfs is fixed to the number of C-states
>    present at boot.
>    If I boot with AC connected, I always only see the C-states up to C2 even
>    if I disconnect AC.
> 
>    The reason is commit 130a5f692425e6237229598a8624da0a247f33d5
>    "ACPI / cpuidle: remove dev->state_count setting". It removes the update of
>    dev->state_count, but sysfs uses exactly this variable to show the
>    C-states.
> 
>    The fix is to use drv->state_count in sysfs. As this is currently the last
>    user of dev->state_count, this variable can be completely removed. And this
>    is exactly what Bartlomiej Zolnierkiewicz's not yet applied patch "[PATCH
>    v2 9/9] cpuidle: remove state_count field from struct cpuidle_device"
>    http://marc.info/?m=138756533317836 does.
> 
>    Long story short: That patch fixes problem 1 for me.

Rafael, please apply that patch (as Thomas has noticed it is required
to fix issue with dynamic dev/drv->state_count updates, sorry for not
catching it earlier).

[ Originally the whole series was dropped when patch #8 ("[PATCH v2 8/9]
  intel_idle: use the common cpuidle_[un]register() routines") turned out
  to introduce some problems.  Patches #1-7 were later re-merged but not
  patch #9 (which is independent of patch #8). ]

> 2. After a AC->DC or DC->AC transition, the name and description of the
>    POLLING C-state become "<null>".
> 
>    Here, the reason is commit d7c7f103262bc2248548ed0e113e916e843c4eeb
>    "cpuidle: don't call poll_idle_init() for every cpu". It only calls
>    poll_idle_init() during cpuidle_register_driver() instead of
>    cpuidle_enable_device() and thus does not re-initialize the fields of
>    drv->states[0] after acpi_processor_setup_cpuidle_states() cleared them.
> 
>    Here, the fix is to _not_ clear drv->states[0] in
>    acpi_processor_setup_cpuidle_states(). For this purpose I created a small
>    patch.

This patch looks fine to me.  FWIW:

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> For your convenience, both of the fixing patches are attached to this mail.
> The first one is necessary for all kernels since 3.14, the second one for all
> kernels since 3.13. So I'd propose to push both of them also to the necessary
> stable kernels.

Sounds good to me.  Thank you for working on this.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

