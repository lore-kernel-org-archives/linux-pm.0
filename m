From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2 2/8] USB / PCI / PM: Allow the PCI core to do the
 resume cleanup
Date: Tue, 13 Jun 2017 10:52:52 +0200
Message-ID: <20170613085252.GA21068@kroah.com>
References: <8918199.uo13RZ8hZk@aspire.rjw.lan>
 <1615075.mBkoKApGGc@aspire.rjw.lan>
 <38416217.53MZsF26VB@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:52620 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbdFMIxB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2017 04:53:01 -0400
Content-Disposition: inline
In-Reply-To: <38416217.53MZsF26VB@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux USB <linux-usb@vger.kernel.org>, Mathias Nyman <mathias.nyman@linux.intel.com>, Felipe Balbi <balbi@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Hans De Goede <hdegoede@redhat.com>, Alan Stern <stern@rowland.harvard.edu>

On Mon, Jun 12, 2017 at 10:49:40PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> hcd_pci_resume_noirq() used as a universal _resume_noirq handler for
> PCI USB controllers calls pci_back_from_sleep() which is unnecessary
> and may become problematic.
> 
> It is unnecessary, because the PCI bus type carries out post-suspend
> cleanup of all PCI devices during resume and that covers all things
> done by the pci_back_from_sleep().  There is no reason why USB cannot
> follow all of the other PCI devices in that respect.
> 
> It will become problematic after subsequent changes that make it
> possible to go back to sleep again after executing dpm_resume_noirq()
> if no valid system wakeup events have been detected at that point.
> Namely, calling pci_back_from_sleep() at the _resume_noirq stage
> will cause the wakeup status of the devices in question to be cleared
> and if any of them has triggered system wakeup, that event may be
> missed then.
> 
> For the above reasons, drop the pci_back_from_sleep() invocation
> from hcd_pci_resume_noirq().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
