From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] drivers: base: add support to skip power management in
 device/driver model
Date: Thu, 7 Feb 2019 16:18:57 +0100
Message-ID: <CAPDyKFoenSDhYk_xNLFn6kB+rqvQQ+p71F27Mvevu-H9Nhxhuw@mail.gmail.com>
References: <20190206150935.12140-1-sudeep.holla@arm.com> <CAPDyKFr2qwXoOL3SRy7Crf-pg4FMn_qecPrw__BE+YpVAjAFZA@mail.gmail.com>
 <20190207103600.GA14464@e107155-lin> <CAPDyKFpkiaP0J_LJxP6tRUOyz3QKtDgA+PuhL-9vew7-RfKyNA@mail.gmail.com>
 <20190207150638.GB14464@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207150638.GB14464@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Jisheng Zhang <jszhang@marvell.com>, Steve Longerbeam <slongerbeam@gmail.com>, Eugeniu Rosca <erosca@de.adit-jv.com>, Joshua Frkuska <joshua_frkuska@mentor.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 7 Feb 2019 at 16:06, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Feb 07, 2019 at 03:29:07PM +0100, Ulf Hansson wrote:
> > On Thu, 7 Feb 2019 at 11:36, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> [..]
>
> > >
> > > May be, but as mentioned above we can't really. Also this change will
> > > help to avoid creating unnecessary power sysfs which is mainly runtime
> > > pm related for some of the devices created. CPU/caches was just one
> > > example which triggered this, but this can be more useful. We can avoid
> > > adding them to dpm list.
> >
> > Well, to me the approach you suggest sounds prone to errors and I am
> > afraid people may abuse it. Moreover, I don't know if there is other
> > problems with it, let's see what Rafael thinks about it.
> >
>
> Sorry, I should have put reference to earlier discussion that led to this
> patch. For your reference: [1]

Yeah, that would have been nice. :-)

>
> > Instead I think we should make the PM core to deal with this scenario,
> > as all it boils down to, is to allow a device to be unregistered and
> > registered during system suspend/resume, with a parent device that is
> > "persistent" during the sequence.
> >
>
> OK
>
> > Perhaps we could even just drop the corresponding printed warning,
> > "cache: parent cpu1 should not be sleeping", in device_pm_add() as I
> > wonder if it's really a necessary print.
> >
> Indeed, I was ignoring knowing that it's harmless. But more people
> started to complain, and Rafael suggested this which I agree as we
> have several pseudo devices created in the kernel that we can bypass
> some of these pm handling knowing we won't need it.

Okay, I see.

Anyway, I will likely need to restore part of this change, via my
cluster idling series then. As from that point, the cpu device that
you call device_set_pm_not_required() for, starts to be used from both
PM core and runtime PM point of view. But I guess that's okay then.

Kind regards
Uffe
