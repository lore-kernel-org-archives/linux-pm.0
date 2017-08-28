From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 5/9] PM / ACPI: Provide option to disable direct_complete for ACPI devices
Date: Mon, 28 Aug 2017 23:14:43 +0200
Message-ID: <3394725.Atsz4N1K4M@aspire.rjw.lan>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org> <1644235.K1erQvOgW9@aspire.rjw.lan> <CAPDyKFq_AN+jEfgDoE0iv=QS5ydDCgPGxW5ivBwp0BAgHDyrGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFq_AN+jEfgDoE0iv=QS5ydDCgPGxW5ivBwp0BAgHDyrGw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, August 28, 2017 4:24:51 PM CEST Ulf Hansson wrote:
> On 28 August 2017 at 15:40, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Monday, August 28, 2017 2:54:40 PM CEST Ulf Hansson wrote:
> >> On 28 August 2017 at 14:39, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > On Monday, August 28, 2017 10:31:44 AM CEST Ulf Hansson wrote:
> >> >> On 28 August 2017 at 03:30, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> >> > On Friday, August 25, 2017 3:42:35 PM CEST Rafael J. Wysocki wrote:
> >> >> >> On Thursday, August 24, 2017 11:50:40 PM CEST Rafael J. Wysocki wrote:
> >> >> >> > On Thursday, August 24, 2017 6:35:49 PM CEST Rafael J. Wysocki wrote:
> >> >> >> > > On Thursday, August 24, 2017 11:15:26 AM CEST Ulf Hansson wrote:
> >
> > [cut]
> >
> >> >> >
> >> >> > Well, not really, because if the device remains runtime suspended,
> >> >> > ->runtime_suspend() will not be called by pm_runtime_force_suspend() and
> >> >> > acpi_dev_suspend_late() should not be called then.
> >> >> >
> >> >> > So more changes in the ACPI PM domain are needed after all.
> >> >>
> >> >> Yes, that's what I thought as well.
> >> >>
> >> >> Anyway, let me cook a new version of the series - trying to address
> >> >> the first bits you have pointed out. Then we can continue with
> >> >> fine-tuning on top, addressing further optimizations of the ACPI PM
> >> >> domain.
> >> >
> >> > Actually, please hold on and let me show you what I would like to do
> >> > first.
> >>
> >> Hmm.
> >>
> >> I think I have almost done the work for the ACPI PM domain already.
> >> It's just a matter of minor tweaks to the changes in patch 6 and 7
> >> (and of course to get them into a shape that you prefer) and then
> >> dropping patch 5 altogether.
> >>
> >> Wouldn't it be better if you build upon my changes?
> >>
> >> Anyway, if you have strong opinion of driving this, I am fine stepping aside.
> >
> > OK, so see below. :-)
> >
> > If what you want is to make the i2c designware driver use _force_suspend() and
> > _force_resume(), then to me this is only tangentially related to direct_complete
> > and can be done without messing up with that one.
> >
> > So the problem is not when direct_complete is set (becasue the driver's and
> > PM domain's callbacks will not be invoked then even), but when it is not set.
> 
> For i2c designware driver case - then you are right! Although, that's
> because the i2c designware driver has nothing else to do than to call
> pm_runtime_force_suspend|resume() from the late suspend and early
> resume callbacks.
> 
> However, for other drivers this isn't the case. A driver may have some
> additional things to cope with during system sleep, besides making
> sure to call pm_runtime_force_suspend|resume().

Sure enough, but I'm seeing that as a separate issue.

> Then as I stated earlier, it would be of great value if we could
> remain having runtime PM enabled during the entire device_suspend()
> phase. I am not sure how you intend to address that, or perhaps you
> did in some of those earlier patches you posted.

I did, but I'd prefer to get back to that later.

If the issues occurring when direct_complete is not set are addressed first,
disabling direct_complete for the devices that cannot use it should be
straightforward.

> In my re-spinned series (not posted yet), I am still addressing both
> issues above, but also not preventing the direct_complete path for
> parent/suppliers when the runtime PM centric path is used.
> 
> > If direct_complete is not set, the ACPI PM domain resumes the device in
> > acpi_subsys_suspend(), because it doesn't know two things: (a) why direct_complete
> > is not set and (b) whether or not the drivers PM callbacks can cope with a
> > runtime suspended device.  These two things are separate, so they need to
> > be addressed separately.
> 
> Yes.
> 
> >
> > For (b) I'd like to use the SAFE_SUSPEND flag from my previous patch.
> 
> Seems like a reasonable approach.
> 
> >
> > As far as (a) is concerned, there are two possible reasons for not setting
> > direct_complete.  First, it may be necessary to change the power state of the
> > device and in that case the device *should* be resumed in acpi_subsys_suspend().
> > Second, direct_complete may not be set for the device's children and in that
> > case acpi_subsys_suspend() may not care as long as SAFE_SUSPEND is set.
> 
> Okay!

Good. :-)

Let me split the patch into a more manageable series, then, clean it up a bit
and add the LPSS coverage to the ACPI part.

Thanks,
Rafael

