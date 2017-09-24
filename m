From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v4 0/3] i2c: designware: Runtime PM aware system sleep handling
Date: Mon, 25 Sep 2017 01:13:29 +0200
Message-ID: <65494652.vEfz4tCBDb@aspire.rjw.lan>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan> <3958866.l2qnKDbinI@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <3958866.l2qnKDbinI@aspire.rjw.lan>
Sender: linux-i2c-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee.jones@linaro.org>, Rajat Jain <rajatja@google.com>
List-Id: linux-pm@vger.kernel.org

Hi,

The original purpose of this set was as stated below:

On Wednesday, September 6, 2017 1:41:37 AM CEST Rafael J. Wysocki wrote:
> On Monday, September 4, 2017 1:05:57 AM CEST Rafael J. Wysocki wrote:
> > Hi,
> 
> An update related to the dependency on intel-lpss.
> 
> > The point here is to avoid runtime resuming i2c designware devices during
> > system suspend in the driver's ->suspend callback in the case when the
> > ACPI PM domain is not present.  That will allow us to deal with the
> > ACPI PM domain case going forward, among other things.
> > 
> > The first patch cleans up the runtime PM handling in the i2c-designware-platdrv
> > _probe() routine so as to make it enable runtime PM in all cases, but prevent
> > the device from being runtime suspended via pm_runtime_forbid() if
> > pm_disabled is set.
> 
> The second one pushed the intel-lpss system suspend/resume callbacks to the
> late/early stages of suspend/resume, respectively, so that the i2c-designware-platdrv
> ones can be pushed too.
> 
> > The second one get rids of some ugly code and makes the PM callbacks of the
> > driver handle runtime-suspended devices during system suspend/resume.
> 
> This is the third one and it does less than it did before now.
> 

In the meantime, though, Rajat reported that there actually were problems with
i2c-designware being suspended too early (as in some cases dependent device
drivers attempted to use i2c during the late suspend phase of system suspend),
so here it goes again as a fix.

Patches [1-2/3] have not changed since v3 (other than by acquiring tags) and
patch [3/3] has only been rebased on top of 4.14-rc1 (and has acquired some
tags too).

Thanks,
Rafael
