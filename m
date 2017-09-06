From: Johannes Stezenbach <js@sig21.net>
Subject: Re: [RFT][PATCH v3 0/3] i2c: designware: Runtime PM aware system
 sleep handling
Date: Wed, 6 Sep 2017 21:59:16 +0200
Message-ID: <20170906195916.mo3mccgzcn7csbrc@sig21.net>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan>
 <3958866.l2qnKDbinI@aspire.rjw.lan>
 <20170906091646.oqkcul7oxddf3yr6@sig21.net>
 <4508230.n88h0dPXoy@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4508230.n88h0dPXoy@aspire.rjw.lan>
Sender: linux-i2c-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 06, 2017 at 11:55:01AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, September 6, 2017 11:16:46 AM CEST Johannes Stezenbach wrote:
> 
> > In case it matters, what I tested was v4.13 + sound/topic/dollar-cove-ti-4.13-v5
> > (PMIC etc) + sound/topic/soc-cx2072x-4.13 (sound codec driver)
> > + "S0ix blocker debug patch v3" from https://bugzilla.kernel.org/show_bug.cgi?id=193891
> > + your 3 patches.
> > 
> > I suspend + resume a few times, no problems.  (Of course S0ix
> > still doesn't work according to /sys/kernel/debug/pmc_atom/sleep_state.)
> > 
> 
> Well, we'll need to address the S0ix thing, but that will require some
> investigation.
> 
> Can you please open a bug entry for that at bugzilla.kernel.org
> (against Power Management -> Hibernation/Suspend) and CC it to me
> so that it doesn't fall of the radar?

I'll do that tomorrow, TIA for your interest in the issue.

Today I spent several hours to bisect the S0ix "regression"
on Asus E200HA, I put regression in quotes because S0ix
only ever worked with gross hacks like poking registers
using busybox devmem.  Anyway, the gross hack worked
on v4.12 and stopped working in v4.13-rc and the
culprit is d31fd43c0f9a4 "clk: x86: Do not gate clocks
enabled by the firmware" (I'll report this properly in a seperate mail).

But I guess that's not the part you're interested in,
the bug entry should cover interaction of dw i2c, acpi pm,
acpi-lpss and ACPI OpRegion, right?


Thanks,
Johannes
