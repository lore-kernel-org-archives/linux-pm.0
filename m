From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Auto suspend not working on usb hid devices
Date: Sun, 11 Jan 2015 10:53:07 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1501111049520.31181-100000@netrider.rowland.org>
References: <CAOVJa8Hu5j04UKAPiQwhBYOuxvUdjbz_BASzcuPxJX63kE+Q2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:53335 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751699AbbAKPxI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 11 Jan 2015 10:53:08 -0500
In-Reply-To: <CAOVJa8Hu5j04UKAPiQwhBYOuxvUdjbz_BASzcuPxJX63kE+Q2A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: vichy <vichy.kuo@gmail.com>
Cc: linux-pm@vger.kernel.org

On Sun, 11 Jan 2015, vichy wrote:

> hi all:
> I list below environment I have that autosuspend seems doesn't work on
> my platform.
> 1. kernel version 3.10.30
> 2. compile kernel with CONFIG_PM_RUNTIME=y
> 3. "echo 'rpm:rpm_suspend' > set_event"
> 4. insert hid devices and "echo auto > /sys/bus/usb/devices/6-1/power/control"
> 5. there is no any usb related runtime suspend output in trace.
> 
> Did I miss any kernel configuration to let it work?
> Or where is the proper debug entry I can check why rpm_suspend isn't
> been called on my system?

There are lots of reasons why a device might not be runtime suspended.  
There is no single debug entry that presents them.  Some information 
can be seen in the files in the device's /sys/.../power directory.

Alan Stern

