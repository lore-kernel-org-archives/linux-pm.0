From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 2/3] PM / mfd: intel-lpss: Push system sleep callbacks to late/early stages
Date: Mon, 25 Sep 2017 14:50:56 +0200
Message-ID: <3654965.TWMXy0zEsZ@aspire.rjw.lan>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan> <4332008.kXBLY0K23i@aspire.rjw.lan> <20170925072847.nl2a6feqzrzdcxwz@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50581 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934840AbdIYNAH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2017 09:00:07 -0400
In-Reply-To: <20170925072847.nl2a6feqzrzdcxwz@ninjato>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>, Rajat Jain <rajatja@google.com>

On Monday, September 25, 2017 9:28:47 AM CEST Wolfram Sang wrote:
> On Mon, Sep 25, 2017 at 01:20:35AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Push the system suspend/resume callbacks of intel-lpss to the late
> > suspend/early resume stages to allow child device callbacks to be
> > pushed to the late/early stages of suspend/resume too, so as to
> > make it possible to avoid resuming the children if they are runtime-
> > suspended during system suspend going forward.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Tested-by: Johannes Stezenbach <js@sig21.net>
> > Tested-by: Rajat Jain <rajatja@google.com>
> 
> If this series shall go in via I2C, I'd need an ack from Lee for this
> one.

Sure.

> Also, I'd assume this should go in for v4.14 already?

Well, it may be slightly late for that.  Realistically, the earliest -rc it
can get into seems to be -rc4 and I'd prefer it to get a bit more exposure
before it gets into a release.  It's up to you, though. :-)

Thanks,
Rafael
