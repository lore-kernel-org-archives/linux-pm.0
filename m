From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH] platform: x86: intel-hid: Add missing ->thaw callback
Date: Tue, 18 Apr 2017 09:07:35 -0700
Message-ID: <20170418160735.GB25405@fury>
References: <3369188.n8HfSBcO3V@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:50213 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757454AbdDRQHj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2017 12:07:39 -0400
Content-Disposition: inline
In-Reply-To: <3369188.n8HfSBcO3V@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alex Hung <alex.hung@canonical.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Tue, Apr 18, 2017 at 03:49:06PM +0200, Rafael Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The intel-hid driver is missing a PM ->thaw callback allowing the
> device to go back to the operational state after creating a
> hibernation image or when there is an image restoration error during
> resume.
> 
> The lack of the ->thaw callback basically means that all events
> signaled by the device are discarded after a hibernation image has
> been created which may be problematic, for example, if the image
> cannot be saved (eg. due to an I/O issue with storage).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

+ Alex Hung <alex.hung@canonical.com>

Queued to testing, thank you Rafael.

> ---
>  drivers/platform/x86/intel-hid.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-pm/drivers/platform/x86/intel-hid.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/x86/intel-hid.c
> +++ linux-pm/drivers/platform/x86/intel-hid.c
> @@ -136,6 +136,7 @@ static int intel_hid_pl_resume_handler(s
>  
>  static const struct dev_pm_ops intel_hid_pl_pm_ops = {
>  	.freeze  = intel_hid_pl_suspend_handler,
> +	.thaw  = intel_hid_pl_resume_handler,
>  	.restore  = intel_hid_pl_resume_handler,
>  	.suspend  = intel_hid_pl_suspend_handler,
>  	.resume  = intel_hid_pl_resume_handler,
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
