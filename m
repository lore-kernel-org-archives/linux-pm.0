From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / runtime: Rework pm_runtime_force_suspend/resume()
Date: Wed, 03 Jan 2018 12:01:47 +0100
Message-ID: <1871035.vYgTsgebaR@aspire.rjw.lan>
References: <20180102130404.GA23434@wunner.de> <2760744.Zsn8Ys48yq@aspire.rjw.lan> <CAJZ5v0gp_CJJZk7MwLtErqmM=iXxsxK5-mMA-w_4DYmtBBih0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gp_CJJZk7MwLtErqmM=iXxsxK5-mMA-w_4DYmtBBih0w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, January 3, 2018 12:21:36 AM CET Rafael J. Wysocki wrote:
> On Tue, Jan 2, 2018 at 8:07 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, January 2, 2018 2:04:04 PM CET Lukas Wunner wrote:
> >> On Tue, Jan 02, 2018 at 12:02:18PM +0100, Rafael J. Wysocki wrote:
> >> > On Tue, Jan 2, 2018 at 11:51 AM, Lukas Wunner <lukas@wunner.de> wrote:
> >> > > On Tue, Jan 02, 2018 at 01:56:28AM +0100, Rafael J. Wysocki wrote:
> >> > >> +     if (atomic_read(&dev->power.usage_count) <= 1 &&
> >> > >> +         atomic_read(&dev->power.child_count) == 0)
> >> > >> +             pm_runtime_set_suspended(dev);
> >> > >>
> >> > >> -     pm_runtime_set_suspended(dev);
> >> > >
> >> > > The ->runtime_suspend callback *has* been executed at this point.
> >> > > If the status is only updated conditionally, it may not reflect
> >> > > the device's actual power state correctly.  That doesn't seem to
> >> > > be a good idea.
> >> >
> >> > It doesn't matter, because this is done with runtime PM disabled, isn't it?
> >>
> >> It might not make a difference for the use case I have in mind, but
> >> pm_runtime_status_suspended() will return an incorrect result and is
> >> called from 47 files in 4.15-rc6 according to lxr.free-electrons.com.
> >
> > Generally, the runtime PM status is only meaningful for devices with runtime PM
> > enabled.
> >
> > There is an exception, which is during system suspend/resume, when runtime PM
> > is automatically disabled by the core, but that only under certain assumptions.
> >
> > Basically, you have to assume that no one else will mess up with the device
> > between the times you call pm_runtime_status_suspended() to check its runtime
> > PM status (or between the first time you do that and the last time runtime PM
> > has been enabled for the device).
> >
> > This patch doesn't change the situation in that respect.
> 
> BTW, I'm not sure why you are worrying about the "status" field alone
> and not about the usage counter that can be greater than 0 after
> pm_runtime_force_suspend() which is inconsistent with the device's
> physical state (and with the "status" field too for that matter -
> always without the patch and in some cases with it) then.  As a matter
> of fact, the information left by the runtime PM framework is messed up
> with here this way or another and so anyway the only party that can
> make sense of it after pm_runtime_force_suspend() is the subsequent
> pm_runtime_force_resume().

All of that said, I have overlooked the fact that pm_runtime_force_suspend()
itself can be called twice in a row for the same device during the same
system-wide PM transition (genpd can do that, confusingly enough).

I'll send a v2 in a moment.

Thanks,
Rafael
