From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCHv v3] power: Include additional information in pm_print_times
Date: Mon, 17 Jun 2013 16:24:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1306171618430.1684-100000@iolanthe.rowland.org>
References: <1371497795-20084-1-git-send-email-shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36873 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751923Ab3FQUYB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2013 16:24:01 -0400
In-Reply-To: <1371497795-20084-1-git-send-email-shuah.kh@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com, gregkh@linuxfoundation.org, joe@perches.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com

On Mon, 17 Jun 2013, Shuah Khan wrote:

> Change __device_suspend() path to include driver name and the ops that
> get run for a device. This additional information helps associate the
> driver and the type of pm_ops the device uses in the suspend path very
> quickly, which will aid in debugging problems in suspend and resume paths.
> Changed both start and end debug messages to include pm_ops information
> and use dev_info() instead of pr_info(). Changed the end message to include
> parent device information and have the same format as the start message.
> 
> dmesg output before the change:
> 
> [  164.390032] calling  1-1+ @ 69, parent: usb1
> [  164.390035] call 1-1+ returned 0 after 0 usecs
> 
> [  164.390352] calling  00:0a+ @ 2457, parent: pnp0
> [  164.390357] call 00:0a+ returned 0 after 3 usecs
> 
> [  164.390361] calling  00:09+ @ 2457, parent: pnp0
> [  164.496458] call 00:09+ returned 0 after 103500 usecs
> 
> [  164.496494] calling  00:05+ @ 2457, parent: pnp0
> [  164.496511] call 00:05+ returned 0 after 14 usecs
> 
> dmesg output after the change:
> 
> [  545.985394] usb 1-1: Start: type pm ops @ 68, parent: usb1
> [  545.987650] usb 1-1: End  : type pm ops @ 68, parent: usb1 time(2184 usecs) err(0)
> 
> [  545.982544] system 00:0a: Start: legacy bus pm ops @ 2391, parent: pnp0
> [  545.982554] system 00:0a: End  : legacy bus pm ops @ 2391, parent: pnp0 time(4 usecs) err(0)
> 
> [  545.982569] tpm_tis 00:09: Start: legacy bus pm ops @ 2391, parent: pnp0
> [  546.087017] tpm_tis 00:09: End  : legacy bus pm ops @ 2391, parent: pnp0 time(101936 usecs) err(0)
> 
> [  546.087069] rtc_cmos 00:05: Start: legacy bus pm ops @ 2391, parent: pnp0
> [  546.087084] rtc_cmos 00:05: End  : legacy bus pm ops @ 2391, parent: pnp0 time(11 usecs) err(0)

If you don't mind a little more bike-shedding, I suggest formatting the 
return value and time in a shorter format, like this:

[  545.987650] usb 1-1: End  : type pm ops @ 68, parent: usb1 -> 0, 2184 us

Alan Stern

