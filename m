From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/2, v2] PM / Runtime: Rework the "runtime idle" helper
 routine
Date: Mon, 3 Jun 2013 10:33:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1306031032130.1304-100000@iolanthe.rowland.org>
References: <29156715.ksdUTA6va9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36580 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758509Ab3FCOdV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2013 10:33:21 -0400
In-Reply-To: <29156715.ksdUTA6va9@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On Sun, 2 Jun 2013, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The "runtime idle" helper routine, rpm_idle(), currently ignores
> return values from .runtime_idle() callbacks executed by it.
> However, it turns out that many subsystems use
> pm_generic_runtime_idle() which checks the return value of the
> driver's callback and executes pm_runtime_suspend() for the device
> unless that value is not 0.  If that logic is moved to rpm_idle()
> instead, pm_generic_runtime_idle() can be dropped and its users
> will not need any .runtime_idle() callbacks any more.
> 
> Moreover, the PCI, SCSI, and SATA subsystems' .runtime_idle()
> routines, pci_pm_runtime_idle(), scsi_runtime_idle(), and
> ata_port_runtime_idle(), respectively, as well as a few drivers'
> ones may be simplified if rpm_idle() calls rpm_suspend() after 0 has
> been returned by the .runtime_idle() callback executed by it.
> 
> To reduce overall code bloat, make the changes described above.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

