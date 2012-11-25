From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] platform / ACPI: Attach/detach ACPI PM during
 probe/remove/shutdown
Date: Sun, 25 Nov 2012 10:42:25 -0800
Message-ID: <20121125184225.GA1423@kroah.com>
References: <1672179.qgDUs0YdYu@vostro.rjw.lan>
 <6227446.8xPtqi6yHi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54930 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280Ab2KYSlE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 25 Nov 2012 13:41:04 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so7489863pbc.19
        for <linux-pm@vger.kernel.org>; Sun, 25 Nov 2012 10:41:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <6227446.8xPtqi6yHi@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, "Svahn, Kai" <kai.svahn@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Huang Ying <ying.huang@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, Aaron Lu <aaron.lu@intel.com>, Grant Likely <grant.likely@secretlab.ca>

On Sun, Nov 25, 2012 at 03:58:14PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Drivers usually expect that the devices they are supposed to handle
> will be operational when their .probe() routines are called, but that
> need not be the case on some ACPI-based systems with ACPI-based
> device enumeration where the BIOSes don't put devices into D0 by
> default.  To work around this problem it is sufficient to change
> bus type .probe() routines to ensure that devices will be powered
> on before the drivers' .probe() routines run (and their .remove()
> and .shutdown() routines accordingly).
> 
> Modify platform_drv_probe() to run acpi_dev_pm_attach() for devices
> whose ACPI handles are present, so that ACPI power management is used
> to change their power states and change their power states to D0
> before driver probing.  Analogously, modify platform_drv_remove() and
> platform_drv_shutdown() to call acpi_dev_pm_detach() for those
> devices, so that they are not subject to ACPI PM any more.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
