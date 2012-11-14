From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH v2 3/6] usb: add runtime pm support for usb port
 device
Date: Wed, 14 Nov 2012 12:07:08 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211141201580.1620-100000@iolanthe.rowland.org>
References: <50A3B50D.3000408@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35804 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932872Ab2KNRHJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Nov 2012 12:07:09 -0500
In-Reply-To: <50A3B50D.3000408@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <lantianyu1986@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lan Tianyu <tianyu.lan@intel.com>, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, oneukum@suse.de, linux-usb@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On Wed, 14 Nov 2012, Lan Tianyu wrote:

> >>> Hi Rafael and Alan:
> >>>     This patch has a collaboration problem with pm qos. Since pm core would
> >>> pm_runtime_get_sync/put(port_dev) if pm qos flags was changed and port's
> >>> suspend call_back() clear PORT_POWER feature without any check. This
> >>> will cause PORT_POWER feather being cleared every time after pm qos
> >>> flags being changed.
> >>>
> >>>     I have an idea that add check in the port's runtime idle callback.
> >>> Check NO_POWER_OFF flag firstly. If set return. Second, for port without
> >>> device, suspend port directly and for port with device, increase child
> >>> device's runtime usage without resume and do barrier to ensure all
> >>> suspend process finish, at last check the child runtime status. If it
> >>> was suspended, suspend port and if do nothing.

> >> Hmm.  If child->dev is not suspended, then our usage_count should be
> >> at least 1, so pm_runtime_suspend(&port_dev->dev) shouldn't actually
> >> suspend us.  Isn't that the case?
> > No, because the child device is not under port device and so even if
> > child->dev is not suspended, port device's usage still can be 0 and
> > power off the port.
> >>
> Please ignore this reply. I may not understand your reply correctly.
> You are right if the child->dev is not suspended, the usage count should be at
> last 1. But how about if the child->dev is suspended.
> 
> Assume that usb device was suspended and power off, so port's usage count must be 0
> since it has been suspended. If pm qos NO_POWER_OFF was set at this time, pm core
> would get port resume and suspend it again. the usage change 0 - 1 - 0. So port is
> power off with NO_POWER_OFF flag setting, Does this make sense?

Suppose, as you say, the USB device is suspended and the port is
powered off.  Now the user wants to set the PM QOS NO_POWER_OFF flag.  
When this happens, the PM core will first do a runtime resume of the
port, then it will set the flag, and then it will do a runtime suspend
of the port.  The port's runtime_suspend callback should see that the
flag is set and return -EAGAIN, leaving the port powered on.

Alan Stern

