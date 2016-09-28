From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH 2/2] mfd: intel-lpss: Avoid resuming runtime-suspended
 lpss unnecessarily
Date: Wed, 28 Sep 2016 16:09:07 +0800
Message-ID: <20160928080907.GA4567@sharon>
References: <cover.1475032126.git.yu.c.chen@intel.com>
 <6e14fa9659f23da041bc5e65edcd53c3e4845c74.1475032126.git.yu.c.chen@intel.com>
 <1475048574.4635.1.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32962 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750977AbcI1IBA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Sep 2016 04:01:00 -0400
Content-Disposition: inline
In-Reply-To: <1475048574.4635.1.camel@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

Hi Oliver,
On Wed, Sep 28, 2016 at 09:42:54AM +0200, Oliver Neukum wrote:
> On Wed, 2016-09-28 at 11:28 +0800, Chen Yu wrote:
> > So first try is to use pm_request_resume() instead, to make the
> > runtime
> > resume process asynchronously. Unfortunately the asynchronous runtime
> > resume relies on pm_wq, which is freezed at early stage. So we choose
> > another method, that is to avoid resuming runtime-suspended devices,
> > if they are already runtime suspended. This is safe because for LPSS
> > driver, the runtime suspend and system suspend are of the same
> > hook - i.e., intel_lpss_suspend(). And moreover, this device is
> > neither runtime wakeup source nor system wakeup source.
> 
> I agree with the reasoning but I don't see the specificity to LPSS.
> Shouldn't this go into the core?
>
Thanks for your reply. Do you mean we should add the logic to pm core?
There is already one if the driver's
.prepare() returns a positive number(aka, RPM_SUSPENDED), then pm core will keep
this device in runtime-suspended during sleep.
Documentation/power/runtime_pm.txt:
"the PM core provides a mechanism allowing some coordination between
different levels of device hierarchy.  Namely, if a system suspend .prepare()
callback returns RPM_SUSPENDED for a device, that indicates to the PM core
that the device appears to be runtime-suspended and its state is fine, so it
may be left in runtime suspend provided that all of its descendants are also
left in runtime suspend.  If that happens, the PM core will not execute any
system suspend and resume callbacks for all of those devices, except for the
complete callback, which is then entirely responsible for handling the device
as appropriate. "

Thanks,
Yu


