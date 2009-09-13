From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC][PATCH 3/4] PCI / ACPI PM: Platform support for
	PCI PME	wake-up
Date: Sun, 13 Sep 2009 23:25:05 +0100
Message-ID: <20090913222505.GC31175__42691.843774128$1252880783$gmane$org@srcf.ucam.org>
References: <200909132320.05077.rjw@sisk.pl> <200909132324.03340.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200909132324.03340.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Sep 13, 2009 at 11:24:03PM +0200, Rafael J. Wysocki wrote:
> +	} else if (!dev->wakeup.flags.run_wake) {
> +		acpi_set_gpe_type(dev->wakeup.gpe_device,
> +					dev->wakeup.gpe_number,
> +					ACPI_GPE_TYPE_WAKE);

Is this going to work for cases where we have multiple devices attached 
to the same GPE? The common one is EHCI, where both EHCI HCDs will be 
one a single GPE. If we wake one, that'll then disable the GPE for the 
other. Further wakeup events will then be lost.

> +	if (device->wakeup.flags.valid)
> +		acpi_install_notify_handler(device->handle, ACPI_SYSTEM_NOTIFY,
> +						pci_acpi_device_wakeup,
> +						&dev->dev);
> +

I think this will fail for the root bridge if acpiphp has already 
grabbed it to check for hotplug events.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
