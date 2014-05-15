From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 2/3] PM / sleep: Mechanism to avoid resuming runtime-suspended devices unnecessarily
Date: Thu, 15 May 2014 14:55:49 +0200
Message-ID: <1798774.vz7tFfDHW5@vostro.rjw.lan>
References: <16671603.abrivY8Odm@vostro.rjw.lan> <Pine.LNX.4.44L0.1405141041360.1432-100000@iolanthe.rowland.org> <CAPDyKFry+O=HvtFtvZh=sYqq9aaFJ78C=8x2euh6MbGExLyuWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64627 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751764AbaEOMjB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 May 2014 08:39:01 -0400
In-Reply-To: <CAPDyKFry+O=HvtFtvZh=sYqq9aaFJ78C=8x2euh6MbGExLyuWw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>

On Thursday, May 15, 2014 02:06:59 PM Ulf Hansson wrote:
> > Do we want to allow ->prepare() to return > 0 if the device isn't
> > runtime suspended?  If we do then non-suspended devices may be a common
> > case.  We should then avoid the extra overhead of disable + enable.
> > So I would write:
> >
> >         if (dev->power.direct_complete) {
> >                 if (pm_runtime_status_suspended(dev)) {
> >                         pm_runtime_disable(dev);
> >                         if (dev->power.disable_depth == 1
> >                             && pm_runtime_status_suspended(dev))
> >                                 goto Complete;
> >                         pm_runtime_enable(dev);
> >                 }
> >                 dev->power.direct_complete = false;
> >         }
> >
> 
> I am wondering whether the above pm_runtime_disable|enable actually
> belongs better in driver/subsystem in favour of the PM core?

No, it doesn't.

> Doesn't the driver/subsystem anyway needs to be on top of what goes
> on? Typically, while runtime PM has been disabled, that might affect
> it's wakeup handling? Or this case are already handled due to other
> circumstances?

Yes, that's the case.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
