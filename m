From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFT][PATCH 0/2] i2c: designware: Runtime PM aware system sleep handling
Date: Mon, 04 Sep 2017 01:05:57 +0200
Message-ID: <3023226.l5IfJK6GIc@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The point here is to avoid runtime resuming i2c designware devices during
system suspend in the driver's ->suspend callback in the case when the
ACPI PM domain is not present.  That will allow us to deal with the
ACPI PM domain case going forward, among other things.

The first patch cleans up the runtime PM handling in the i2c-designware-platdrv
_probe() routine so as to make it enable runtime PM in all cases, but prevent
the device from being runtime suspended via pm_runtime_forbid() if
pm_disabled is set.

The second one get rids of some ugly code and makes the PM callbacks of the
driver handle runtime-suspended devices during system suspend/resume.

Please test if you can and let me know if anything breaks.

Thanks,
Rafael

