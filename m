From: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] PCI: PM: Avoid possible suspend-to-idle issue
Date: Fri, 17 May 2019 09:57:43 -0600
Message-ID: <20190517155743.GB25006@localhost.localdomain>
References: <2315917.ZGeXE6pBFC@kreacher>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2315917.ZGeXE6pBFC@kreacher>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, May 17, 2019 at 11:08:50AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If a PCI driver leaves the device handled by it in D0 and calls
> pci_save_state() on the device in its ->suspend() or ->suspend_late()
> callback, it can expect the device to stay in D0 over the whole
> s2idle cycle.  However, that may not be the case if there is a
> spurious wakeup while the system is suspended, because in that case
> pci_pm_suspend_noirq() will run again after pci_pm_resume_noirq()
> which calls pci_restore_state(), via pci_pm_default_resume_early(),
> so state_saved is cleared and the second iteration of
> pci_pm_suspend_noirq() will invoke pci_prepare_to_sleep() which
> may change the power state of the device.
> 
> To avoid that, add a new internal flag, skip_bus_pm, that will be set
> by pci_pm_suspend_noirq() when it runs for the first time during the
> given system suspend-resume cycle if the state of the device has
> been saved already and the device is still in D0.  Setting that flag
> will cause the next iterations of pci_pm_suspend_noirq() to set
> state_saved for pci_pm_resume_noirq(), so that it always restores the
> device state from the originally saved data, and avoid calling
> pci_prepare_to_sleep() for the device.
> 
> Fixes: 33e4f80ee69b ("ACPI / PM: Ignore spurious SCI wakeups from suspend-to-idle")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

LGTM

Reviewed-by: Keith Busch <keith.busch@intel.com>
