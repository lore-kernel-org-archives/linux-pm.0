From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] PM / core: Add SAFE_SUSPEND driver flag
Date: Tue, 29 Aug 2017 17:02:53 +0200
Message-ID: <2539179.02z2N9fVNH@aspire.rjw.lan>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org> <35841101.LqGbCjJMGH@aspire.rjw.lan> <CAPDyKFrYd4ViFfouM8wd7xkg2L9B0neHt7kTOxLqcGtqBFun5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrYd4ViFfouM8wd7xkg2L9B0neHt7kTOxLqcGtqBFun5A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 29, 2017 4:57:28 PM CEST Ulf Hansson wrote:
> On 29 August 2017 at 02:20, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Add a driver_flags field to struct dev_pm_info for flags that can be
> > set by device drivers at the probe time to inform the PM core and/or
> > bus types, PM domains and so on on the capabilities and/or
> > preferences of device drivers.  It is anticipated that more than one
> > flag of this kind will be necessary going forward.
> >
> > Define and document a SAFE_SUSPEND flag to instruct bus types and PM
> > domains that the system suspend callbacks provided by the driver can
> > cope with runtime suspended devices, so from the driver's perspective
> > it should be safe to leave devices in runtime suspend during system
> > suspend.
> 
> This changelog is a bit too vague to me. Wouldn't it be more clear if
> also adding something along the lines that this also means that
> runtime resuming a device isn't needed by the subsystem/PM domain
> during system sleep?

No.

> Because ideally that is what you want to avoid, right?

Not really.  The driver doesn't know what the needs of the higher level
are.  It may only say what it can do and the bus type can use this
information to make a decision.

> Moreover I am also not convinced that this solution really is the
> right path. It seems like we might end up adding more bits for the
> "driver_flag" field and it gets complicated. Do we really need to
> distinguish between all different cases in such detail?

Yes, we do.

Every time we try to address two different problems with one mechanism,
it backfires later.

> I will continue to review this tomorrow, however in the meantime I
> have finalized a re-spin of my v3 series so I decided to post it
> anyway. I am adding only one new flag to the PM core, perhaps I am
> over-simplifying things, but please have look once more. I think I
> have addressed all your concerns you have raised so far.

I'll have a look, but I really don't want to conflate the "I'm fine
with not resuming the device" case with the "I don't want to use
direct_complete with it" one.  To me, they are fundamentally different
and I'm not going to apply any patches conflating them.

Thanks,
Rafael

