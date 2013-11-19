From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH 0/2] power_supply: Fix Oops from NULL pointer dereference
 from wakeup_source_activate
Date: Tue, 19 Nov 2013 13:11:21 -0800
Message-ID: <20131119211121.GA20193@teo>
References: <cover.1384875691.git.shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:57964 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab3KSVLZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2013 16:11:25 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so3421732pdj.25
        for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2013 13:11:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <cover.1384875691.git.shuah.kh@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: len.brown@intel.com, pavel@ucw.cz, rjw@rjwysocki.net, gregkh@linuxfoundation.org, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com

On Tue, Nov 19, 2013 at 08:59:34AM -0700, Shuah Khan wrote:
> power_supply_register() calls device_init_wakeup() to register a wakeup
> source before initializing dev_name. As a result, device_wakeup_enable()
> end up registering wakeup source with a null name when wakeup_source_register()
> gets called with dev_name(dev) which is null at the time.
> 
> device_wakeup_enable() uses dev_name(dev) as the wakeup source name.
> When it gets called with a device with its name not yet set, ws structure
> with ws->name = NULL gets created.
> 
> When kernel is booted with wakeup_source_activate enabled, it will panic
> when the trace point code tries to dereferences ws->name.
> 
> This patch series fixes power_supply_register() to initialize the device name
> prior to calling device_init_wakeup() and adds WARN_ON on null device name to
> device_wakeup_enable() to detect driver bugs that result in calling
> device_wakeup_enable() before device is fully initialized with its name in
> device_wakeup_enable().
> 
> It is important that these two fixes to be pulled in together as a series. The
> change to add WARN_ON on null device name without the power_supply_register()
> fix will result in early boot panics when AC Adapter and Battery device drivers
> try to register wakeup source.

I am all for it, so for the power_supply part:

Acked-by: Anton Vorontsov <anton@enomsg.org>
