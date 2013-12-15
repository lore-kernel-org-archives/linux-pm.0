From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/PATCH 1/3] pm: make PM macros more smart
Date: Sun, 15 Dec 2013 18:51:12 +0100
Message-ID: <20131215175112.GA23298@Nokia-N900>
References: <1386911905-2366-1-git-send-email-david.a.cohen@linux.intel.com>
 <1386911905-2366-2-git-send-email-david.a.cohen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55989 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab3LORvR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 15 Dec 2013 12:51:17 -0500
Content-Disposition: inline
In-Reply-To: <1386911905-2366-2-git-send-email-david.a.cohen@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: David Cohen <david.a.cohen@linux.intel.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, sarah.a.sharp@linux.intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, santosh.shilimkar@ti.com

On Thu 2013-12-12 21:18:23, David Cohen wrote:
> This patch makes SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() more
> smart.
> 
> Despite those macros check for '#ifdef CONFIG_PM_SLEEP/RUNTIME' to avoid
> setting the callbacks when such #ifdef's aren't defined, they don't
> handle compiler to avoid messages like that:
> 
> drivers/usb/host/xhci-plat.c:200:12: warning: ???xhci_plat_suspend??? defined but not used [-Wunused-function]
> drivers/usb/host/xhci-plat.c:208:12: warning: ???xhci_plat_resume??? defined but not used [-Wunused-function]
> 
> As result, those macros get rid of #ifdef's when setting callbacks but
> not when implementing them.
> 
> With this patch, drivers using SET_*_PM_OPS() macros don't need to #ifdef
> the callbacks implementation as well.

Well... Interesting trickery, but it means that resulting kernel
will be bigge due to the dead functions no?

That may be acceptable tradeoff, but I guess its worth discussing...
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
