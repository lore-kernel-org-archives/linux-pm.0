From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI/PCI: PM: Add missing wakeup.flags.valid checks
Date: Fri, 17 May 2019 10:32:14 +0300
Message-ID: <20190517073214.GA2781@lahna.fi.intel.com>
References: <2091978.9z20bSIm3T@kreacher>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2091978.9z20bSIm3T@kreacher>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, May 16, 2019 at 12:42:20PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Both acpi_pci_need_resume() and acpi_dev_needs_resume() check if the
> current ACPI wakeup configuration of the device matches what is
> expected as far as system wakeup from sleep states is concerned, as
> reflected by the device_may_wakeup() return value for the device.
> 
> However, they only should do that if wakeup.flags.valid is set for
> the device's ACPI companion, because otherwise the wakeup.prepare_count
> value for it is meaningless.
> 
> Add the missing wakeup.flags.valid checks to these functions.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
