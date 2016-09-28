From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 2/2] mfd: intel-lpss: Avoid resuming runtime-suspended
 lpss unnecessarily
Date: Wed, 28 Sep 2016 09:42:54 +0200
Message-ID: <1475048574.4635.1.camel@suse.com>
References: <cover.1475032126.git.yu.c.chen@intel.com>
         <6e14fa9659f23da041bc5e65edcd53c3e4845c74.1475032126.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751021AbcI1Hm7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Sep 2016 03:42:59 -0400
In-Reply-To: <6e14fa9659f23da041bc5e65edcd53c3e4845c74.1475032126.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On Wed, 2016-09-28 at 11:28 +0800, Chen Yu wrote:
> So first try is to use pm_request_resume() instead, to make the
> runtime
> resume process asynchronously. Unfortunately the asynchronous runtime
> resume relies on pm_wq, which is freezed at early stage. So we choose
> another method, that is to avoid resuming runtime-suspended devices,
> if they are already runtime suspended. This is safe because for LPSS
> driver, the runtime suspend and system suspend are of the same
> hook - i.e., intel_lpss_suspend(). And moreover, this device is
> neither runtime wakeup source nor system wakeup source.

I agree with the reasoning but I don't see the specificity to LPSS.
Shouldn't this go into the core?

	Regards
		Oliver


