From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] drivers: base: add support to skip power management in
 device/driver model
Date: Tue, 12 Feb 2019 19:07:31 +0100
Message-ID: <CAJZ5v0hQ=M1mtoMTSHnO3E2XSP4eC8SH+_WWXafk7ZVCG__MJg@mail.gmail.com>
References: <20190206150935.12140-1-sudeep.holla@arm.com> <CAPDyKFr2qwXoOL3SRy7Crf-pg4FMn_qecPrw__BE+YpVAjAFZA@mail.gmail.com>
 <20190207103600.GA14464@e107155-lin> <CAPDyKFpkiaP0J_LJxP6tRUOyz3QKtDgA+PuhL-9vew7-RfKyNA@mail.gmail.com>
 <20190207150638.GB14464@e107155-lin> <CAPDyKFoenSDhYk_xNLFn6kB+rqvQQ+p71F27Mvevu-H9Nhxhuw@mail.gmail.com>
 <20190207152908.GC14464@e107155-lin> <CAPDyKFrV7XpKK-Pds=BNgJm9EC50C0wB_f99DK-6N7+K8aZXZw@mail.gmail.com>
 <20190212174937.GA19095@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212174937.GA19095@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Jisheng Zhang <jszhang@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, Steve Longerbeam <slongerbeam@gmail.com>, Eugeniu Rosca <erosca@de.adit-jv.com>, Joshua Frkuska <joshua_frkuska@mentor.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 12, 2019 at 6:49 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, Feb 11, 2019 at 05:20:20PM +0100, Ulf Hansson wrote:
> > On Thu, 7 Feb 2019 at 16:29, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Thu, Feb 07, 2019 at 04:18:57PM +0100, Ulf Hansson wrote:
> > > > On Thu, 7 Feb 2019 at 16:06, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > [...]
> > >
> > > > > Indeed, I was ignoring knowing that it's harmless. But more people
> > > > > started to complain, and Rafael suggested this which I agree as we
> > > > > have several pseudo devices created in the kernel that we can bypass
> > > > > some of these pm handling knowing we won't need it.
> > > >
> > > > Okay, I see.
> > > >
> > > > Anyway, I will likely need to restore part of this change, via my
> > > > cluster idling series then. As from that point, the cpu device that
> > > > you call device_set_pm_not_required() for, starts to be used from both
> > > > PM core and runtime PM point of view. But I guess that's okay then.
> > > >
> > >
> > > Ah I see. I can drop for CPU devices then. Since I didn't see any use for
> > > them, I set the flag, but I can drop it now or you can do that as part
> > > of that series.
> >
> > Well, I prefer if you drop it for CPU devices, as least for now.
> >
> > > There are quite a few devices(especially the ones
> > > registered under system subsys can set this but I would take it separate
> > > once we settle on this). Also Rafael may have seen use for few more
> > > devices when he suggested this.
> >
> > Yep, let's find another first user of this.
> >
> > Additionally, it seems like we should drop the print in device_pm_add().
> >
>
> Hi Rafael,
>
> Do you prefer to drop the error message or retain it as is ?

Do you mean the one in device_pm_add()?

> With this patch, we don't have to. I will repost v2 dropping this flags for cpus
> and just retaining the cache nodes for now.

OK
