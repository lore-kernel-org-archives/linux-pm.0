From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 0/3] PM / sleep: Avoid resuming runtime-suspended
 devices during system suspend
Date: Tue, 13 May 2014 11:25:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1405131115050.1098-100000@iolanthe.rowland.org>
References: <1881168.eI1v8ceYmq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:42651 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751145AbaEMPZI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 May 2014 11:25:08 -0400
In-Reply-To: <1881168.eI1v8ceYmq@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

Crossing emails again...

On Tue, 13 May 2014, Rafael J. Wysocki wrote:

> > There's nothing to prevent a runtime-suspended device from being 
> > resumed in between the ->prepare() and ->suspend() callbacks.
> 
> I'm moving the barrier from __device_suspend() to device_prepare(), so there
> shouldn't be surprise resumes in that time frame.

A wakeup request from the hardware can cause a runtime resume, even 
if most threads are in the freezer:

	Not all kernel threads get frozen.  One of the unfrozen threads 
	could respond to the wakeup request by calling 
	pm_runtime_resume().

	Some runtime PM callbacks are marked as IRQ-safe and can run
	directly within an interrupt handler.

> > Therefore it makes little sense to check the device's runtime status in 
> > device_prepare().  The check should be done in __device_suspend().
> 
> If we do the barrier in device_prepare(), then I'm not sure what mechanism
> would cause the device to resume.

See above.  A wakeup request can arrive after the barrier has finished.

> If there is one, the whole approach is in danger, because ->prepare() has to
> check if devices are runtime-suspended and has to be sure that their status
> won't change after it has returned 1.

->prepare() cannot guarantee in all cases that a device will remain in 
runtime suspend.  Fortunately, it doesn't need to.  In fact (as I 
mentioned sometime before), it doesn't even need to check whether the 
device currently is runtime suspended -- it suffices to know that _if_ 
the device is runtime suspended _then_ it has the proper settings for 
system suspend.

Regardless, status changes cannot cause a problem.  If the device does
get runtime-resumed after ->prepare(), it will remain that way when
__device_suspend() runs.  The device can't be runtime-suspended again,
because device_prepare() does pm_get_noresume().

Therefore, if the device is still runtime-suspended when
__device_suspend() runs, we can be sure that its status and state are
still the same as when ->prepare() ran.

Alan Stern

