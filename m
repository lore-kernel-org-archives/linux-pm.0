From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: avoid adding devices without pm_ops to dpm list
Date: Sun, 4 May 2014 11:52:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1405041146580.1712-100000@netrider.rowland.org>
References: <5365D6C9.10901@codeaurora.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:36649 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754510AbaEDPw2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 4 May 2014 11:52:28 -0400
In-Reply-To: <5365D6C9.10901@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sravan <asravan@codeaurora.org>
Cc: linux-pm@vger.kernel.org

On Sun, 4 May 2014, Sravan wrote:

> Hi Alan,
> If i follow below steps, won't it resolve the issue?
> 
> 1. Add pm_ops check for driver during driver registration
> 2. If driver has pm_ops, i will add device to dpm_list.

Where will you add it?  Devices have to be added in the correct place 
in the list.  You mustn't just add a device to the end of the list.

> 3. error handling to remove device from dpm_list if driver is unregistered
> 
> driver attach to device code flow is as below:
> driver_register->bus_add_driver->driver_attach->__driver_attach->driver_probe_device->really_probe
> 
> Thus dpm_list is becoming dynamic and unnecessary devices are removed 
> from dpm_list.
> 
> I observed few hundreds of devices without pm_ops (no pm_ops for any of 
> pm_domain, type, class, driver)
> on my device. So i am looking for better solution to optimize this 
> Suspend/Resume path and latencies.
> 
> Let me know if you think of any side effects with above approach and 
> better alternative solutions.

A better approach might be for dpm_prepare() to look for devices with
no callbacks.  When it finds one, it can mark the device structure so
that later stages can skip the device quickly.

Alan Stern

