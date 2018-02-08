From: "dbasehore ." <dbasehore@chromium.org>
Subject: Re: [PATCH v5 4/4] irqchip/gic-v3-its: add ability to resend MAPC on resume
Date: Wed, 7 Feb 2018 16:00:53 -0800
Message-ID: <CAGAzgsprocoZRtccPrbArUqyBTYiQm=vr6qjrK-5rAMSeusZ-Q@mail.gmail.com>
References: <20180207014117.62611-1-dbasehore@chromium.org>
 <20180207014117.62611-5-dbasehore@chromium.org> <8276f426-e4a0-c400-9f87-31be3d6b1733@arm.com>
 <20180207232201.GB106856@ban.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40509 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbeBHAAz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Feb 2018 19:00:55 -0500
Received: by mail-wr0-f196.google.com with SMTP id i56so2916056wra.7
        for <linux-pm@vger.kernel.org>; Wed, 07 Feb 2018 16:00:55 -0800 (PST)
In-Reply-To: <20180207232201.GB106856@ban.mtv.corp.google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Soby Mathew <Soby.Mathew@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org, robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Feb 7, 2018 at 3:22 PM, Brian Norris <briannorris@chromium.org> wrote:
> Hi Marc,
>
> I'm really not an expert on this, so take my observations with a large
> grain of salt:
>
> On Wed, Feb 07, 2018 at 08:46:42AM +0000, Marc Zyngier wrote:
>> On 07/02/18 01:41, Derek Basehore wrote:
>> > This adds functionality to resend the MAPC command to an ITS node on
>> > resume. If the ITS is powered down during suspend and the collections
>> > are not backed by memory, the ITS will lose that state. This just sets
>> > up the known state for the collections after the ITS is restored.
>> >
>> > This is enabled via the reset-on-suspend flag in the DTS for an ITS
>> > that has a non-zero number of collections stored in it.
>> >
>> > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
>> > ---
>> >  drivers/irqchip/irq-gic-v3-its.c   | 80 ++++++++++++++++++++------------------
>> >  include/linux/irqchip/arm-gic-v3.h |  1 +
>> >  2 files changed, 43 insertions(+), 38 deletions(-)
>> >
>> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> > index 5e63635e2a7b..dd6cd6e68ed0 100644
>> > --- a/drivers/irqchip/irq-gic-v3-its.c
>> > +++ b/drivers/irqchip/irq-gic-v3-its.c
>> > @@ -1942,52 +1942,53 @@ static void its_cpu_init_lpis(void)
>> >     dsb(sy);
>> >  }
>> >
>> > -static void its_cpu_init_collection(void)
>> > +static void its_cpu_init_collection(struct its_node *its)
>
> ...
>
>> > @@ -3127,6 +3128,9 @@ static void its_restore_enable(void)
>> >                     its_write_baser(its, baser, baser->val);
>> >             }
>> >             writel_relaxed(its->ctlr_save, base + GITS_CTLR);
>> > +
>> > +           if (GITS_TYPER_HWCOLLCNT(gic_read_typer(base + GITS_TYPER)) > 0)
>> > +                   its_cpu_init_collection(its);
>>
>> This isn't correct. Think of a system where half the collections are in
>> HW, and the other half memory based (nothing in the spec forbids this).
>> You must evaluate the CID of each collection and replay the MAPC *only*
>> if it falls into the range [0..HCC-1]. The memory-based collections are
>> already mapped, and remapping an already mapped collection requires
>> extra care (see MAPC and the UNPREDICTABLE behaviour when V=1), so don't
>> go there.
>
> IIUC, this is only run on CPU0 (it's in syscore resume), so implicitly,
> CID is 0. Thus, the current condition is already doing what you ask:
>
>         HCC > 0 == CID
>
> which is equivalent to:
>
>         HCC - 1 >= CID
>
> Or should we really double check what CPU we're running on?

There seems to be the edge case where you hotplug CPU 0 before
suspending. In that case, I believe you're on the lowest number CPU
left?

It seems that all of the CPUs that are disabled have the ITS
reinitialized from scratch via enable_nonboot_cpus(). This code runs
on only the CPU that firmware resumes with. If that CPU isn't CPU 0
for whatever reason, we need to make sure that it's processor ID is
less than HCC.

>
> Brian
