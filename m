From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] PM / wakeirq: fix wakeirq setting after wakup re-configuration from sysfs
Date: Thu, 07 Apr 2016 23:25:50 +0200
Message-ID: <1664339.h6rI5IB9Xd@vostro.rjw.lan>
References: <1459943153-2553-1-git-send-email-grygorii.strashko@ti.com> <20160407175600.GN16484@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54312 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751673AbcDGVXT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 17:23:19 -0400
In-Reply-To: <20160407175600.GN16484@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, nsekhar@ti.com, nm@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, linux-omap@vger.kernel.org

On Thursday, April 07, 2016 10:56:01 AM Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [160406 04:47]:
> > Now wakeirq stops working for device if wakeup option for
> > this device will be reconfigured through sysfs, like:
> > 
> > echo disabled > /sys/devices/platform/extcon_usb1/power/wakeup
> > echo enabled > /sys/devices/platform/extcon_usb1/power/wakeup
> > 
> > Once above set of commands is executed the device's wakeup_source
> > opject will be recreated and dev->power.wakeup->wakeirq field will
> > contain NULL. As result, device_wakeup_arm_wake_irqs() will not arm
> > wakeirq for the affected device.
> > 
> > Hece, lets try to fix it in the following way:
> >   check for dev->wakeirq field when device_wakeup_attach() is called
> >   and if !NULL re-attach wakeirq to the device
> 
> Yeah I think that's all there is to it, thanks for fixing it:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Applied, thanks!

