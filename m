From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 5/9] PM / ACPI: Provide option to disable direct_complete for ACPI devices
Date: Fri, 25 Aug 2017 14:23:59 +0200
Message-ID: <2514819.i36HWVUm2E@aspire.rjw.lan>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org> <12333551.k204JYSgao@aspire.rjw.lan> <CAPDyKFrFUgE0FJE==ht4Z5utj+Pht=9UGn-LYBR9hP4ncofreg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrFUgE0FJE==ht4Z5utj+Pht=9UGn-LYBR9hP4ncofreg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, August 25, 2017 11:28:25 AM CEST Ulf Hansson wrote:
> [...]
> 
> >>
> >> The above change would offer an improvement, however there are more
> >> benefits from the runtime PM centric path that it doesn't cover.
> >
> > The idea, though, is not to make it instead of, but in addition to the
> > runtime PM centric path.
> >
> > So a driver using the runtime PM centric (or rather runtime PM aware)
> > callbacks can set power.force_suspend and benefit from having direct_complete
> > set conditional on whether or not the device is runtime resumed before the
> > late suspend.
> >
> > If device_complete remains set in __device_suspend_late(), no system
> > suspend/resume callbacks will be invoked from that point on.  If it isn't
> > set, pm_runtime_force_suspend() should work just fine and then
> > pm_runtime_force_resume() should do the right thing on the way back.
> >
> > All boils down to (a) setting a flag and (b) using the right callbacks
> > for system suspend which is the case with your patches either.
> 
> You make it sound simple. :-)
> 
> I try to get inspired of your ideas and see what I can come up with.
> However, I really want us to avoid making it more difficult to
> understand the behavior of the core, so I probably look start changing
> the ACPI PM domain first, then trying to adopt the behavior of the
> core on top of those changes. Does that sound reasonable to you?

Well, I don't think we need to change the ACPI PM domain at all. :-)

However, let me contiune in a reply to

https://marc.info/?l=linux-arm-kernel&m=150361200030186&w=2

for more complete context.

Thanks,
Rafael

