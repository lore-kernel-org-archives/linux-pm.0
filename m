From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/3] PCI / PM: Skip bridges in pci_enable_wake()
Date: Tue, 25 Jul 2017 15:44:10 +0300
Message-ID: <20170725124410.GQ2369@lahna.fi.intel.com>
References: <3116391.JNS1F4DjTg@aspire.rjw.lan>
 <1895122.yvmCHzQO3z@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7733 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751155AbdGYMoP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jul 2017 08:44:15 -0400
Content-Disposition: inline
In-Reply-To: <1895122.yvmCHzQO3z@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>

On Fri, Jul 21, 2017 at 02:38:08PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> PCI bridges only have a reason to generate wakeup signals on behalf
> of devices below them, so avoid preparing bridges for wakeup directly
> in pci_enable_wake().
> 
> Also drop the pci_has_subordinate() check from pci_pm_default_resume()
> as this will be done by pci_enable_wake() itself now.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
