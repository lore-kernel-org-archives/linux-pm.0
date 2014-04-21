From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: avoid adding devices without pm_ops to dpm list
Date: Mon, 21 Apr 2014 10:09:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1404211005230.1201-100000@iolanthe.rowland.org>
References: <535509EA.2090006@codeaurora.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:42503 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751032AbaDUOJA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Apr 2014 10:09:00 -0400
In-Reply-To: <535509EA.2090006@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sravan <asravan@codeaurora.org>
Cc: linux-pm@vger.kernel.org

On Mon, 21 Apr 2014, Sravan wrote:

> Hello,
> 
> I have come across below code which looks can be optimized to reduce 
> suspend/resume latencies.
> 
> During device registration at boot up, device_add() is called.
> In this device_add() function, device_pm_add() is called without 
> checking if the device has pm_ops or not.
> Thus dpm_list is generated with all devices even if some devices don't 
> have pm_ops.
> 
> device_add() -> device_pm_add()-> generate dpm_list
> 
> During suspend/resume process, suspend/resume APIs are called for 
> devices present in dpm_list.
> due to this, suspend/resume APIs for devices without pm_ops also called 
> and just return with NULL.

What are you talking about?  _No_ device has a pm_ops structure; there
is no such member inside struct device.

> Can we optimize this code by adding *ONLY* devices with pm_ops to 
> dpm_list and ignore remaining?
> It will help reduce suspend/resume latencies. I observed 10mS savings 
> with my debug code. It may change based on number of devices without pm_ops.
> 
> Let me know your opinion/suggestions on this.

The suspend and resume routines look at pm_ops structures in the 
device's power domain, device type, bus type, class, and driver.  Even 
though most of those remain constant throughout the device's lifetime, 
the driver can change at any time.  Therefore it is not possible to 
leave devices off the dpm_list.

Alan Stern

