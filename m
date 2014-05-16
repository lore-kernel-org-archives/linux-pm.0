From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/3] (was: Re: PM / sleep: Mechanism to avoid resuming runtime-suspended devices unnecessarily)
Date: Fri, 16 May 2014 02:45:35 +0200
Message-ID: <1596386.YnYCCm2UQG@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1405141041360.1432-100000@iolanthe.rowland.org> <1495375.YeObBhD5SE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495375.YeObBhD5SE@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, May 15, 2014 01:13:02 PM Rafael J. Wysocki wrote:
> On Wednesday, May 14, 2014 10:53:16 AM Alan Stern wrote:
> > On Tue, 13 May 2014, Rafael J. Wysocki wrote:

[cut]

> > 
> > 	if (dev->power.direct_complete) {
> > 		if (pm_runtime_status_suspended(dev)) {
> > 			pm_runtime_disable(dev);
> > 			if (dev->power.disable_depth == 1
> > 			    && pm_runtime_status_suspended(dev))
> > 				goto Complete;
> > 			pm_runtime_enable(dev);
> > 		}
> > 		dev->power.direct_complete = false;
> > 	}
> 
> That is a good idea, thanks!

New patches follow.

[1/3] is the core change with the above added.

> > Also, now that we have finally settled on the appropriate API, there
> > needs to ba a patch updating the PM documentation.
> 
> Absolutely.  I thought about updating the documentation in the same patch
> (at least the comments in pm.h), but I guess a separate patch for files
> under Documentation/ may be better.

[2/3] is the corresponding documentation update (I hope I haven't overlooked
anything important).

[3/3] is a resend of the ACPI PM patch on top of the core change.

Rafael
