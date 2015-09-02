From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 Resend 3/5] PM / OPP: Move opp core to its own
 directory
Date: Wed, 2 Sep 2015 12:43:06 +0530
Message-ID: <20150902071306.GB22673@linux>
References: <cover.1441083292.git.viresh.kumar@linaro.org>
 <54ff6f4e8fe495d9a859a7a7aa61ac2e79f08551.1441083292.git.viresh.kumar@linaro.org>
 <20150901225115.GB21112@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35404 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbbIBHNM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2015 03:13:12 -0400
Received: by pacfv12 with SMTP id fv12so1896684pac.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2015 00:13:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150901225115.GB21112@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, khilman@linaro.org, Anand Moon <moon.linux@yahoo.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 01-09-15, 15:51, Stephen Boyd wrote:
> It's odd that we use CONFIG_DEBUG_DRIVER here when that's talking
> about debugging the driver core. I wonder why this wouldn't be
> some OPP specific debug config option instead. But that was
> already there before so this topic is for another patch.

I agree.. Maybe a separate patch to add Kconfig for both
drivers/base/power and drivers/base/power/opp directories.

-- 
viresh
