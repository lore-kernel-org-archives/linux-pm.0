From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Auto suspend not working on usb hid devices
Date: Fri, 16 Jan 2015 10:23:04 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1501161021260.1469-100000@iolanthe.rowland.org>
References: <CAOVJa8E28LTMMUa7tjNSitYb33VZNiWH9Nob=Zt_J81fmV8TUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:60255 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752893AbbAPPXF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jan 2015 10:23:05 -0500
In-Reply-To: <CAOVJa8E28LTMMUa7tjNSitYb33VZNiWH9Nob=Zt_J81fmV8TUw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: vichy <vichy.kuo@gmail.com>
Cc: linux-pm@vger.kernel.org

On Fri, 16 Jan 2015, vichy wrote:

> I found the usb storage interface driver also set supports_autosuspend
> =1 and I found the runtime_usage =1 .
> But the device doesn't go into runtime suspend, even I put control as auto.
> is there any condition purposely abandon usb storage device to do so?

In order to suspend a USB storage device, you have to enable suspend 
not just for that device but also for all its children.  In particular, 
if the device is a disk or flash drive then you have to enable suspend 
for the corresponding SCSI device.

Alan Stern

