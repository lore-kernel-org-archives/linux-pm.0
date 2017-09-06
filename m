From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFT][PATCH v3 0/3] i2c: designware: Runtime PM aware system sleep handling
Date: Wed, 06 Sep 2017 11:55:01 +0200
Message-ID: <4508230.n88h0dPXoy@aspire.rjw.lan>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan> <3958866.l2qnKDbinI@aspire.rjw.lan> <20170906091646.oqkcul7oxddf3yr6@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50982 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752241AbdIFKDw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Sep 2017 06:03:52 -0400
In-Reply-To: <20170906091646.oqkcul7oxddf3yr6@sig21.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee@kernel.org>

On Wednesday, September 6, 2017 11:16:46 AM CEST Johannes Stezenbach wrote:
> On Wed, Sep 06, 2017 at 01:41:37AM +0200, Rafael J. Wysocki wrote:
> > On Monday, September 4, 2017 1:05:57 AM CEST Rafael J. Wysocki wrote:
> > > Please test if you can and let me know if anything breaks.
> > 
> > That still applies. :-)
> 
> Done, works for me on Asus E200HA.

Thanks!

> In case it matters, what I tested was v4.13 + sound/topic/dollar-cove-ti-4.13-v5
> (PMIC etc) + sound/topic/soc-cx2072x-4.13 (sound codec driver)
> + "S0ix blocker debug patch v3" from https://bugzilla.kernel.org/show_bug.cgi?id=193891
> + your 3 patches.
> 
> I suspend + resume a few times, no problems.  (Of course S0ix
> still doesn't work according to /sys/kernel/debug/pmc_atom/sleep_state.)
> 

Well, we'll need to address the S0ix thing, but that will require some
investigation.

Can you please open a bug entry for that at bugzilla.kernel.org
(against Power Management -> Hibernation/Suspend) and CC it to me
so that it doesn't fall of the radar?

Thanks,
Rafael
