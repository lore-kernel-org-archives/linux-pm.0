From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [PATCH 4/6] ACPI/PCI: ask bios for control of all
 native services at once
Date: Fri, 30 Jul 2010 17:42:46 +0900
Message-ID: <4C529086.9090600__17153.0412779704$1280479606$gmane$org@jp.fujitsu.com>
References: <201007282323.56351.rjw@sisk.pl>
	<20100728144358.5e2c12ce@virtuousgeek.org>
	<4C510B90.9070302@jp.fujitsu.com> <201007291745.39285.rjw@sisk.pl>
	<4C526A85.3070902@jp.fujitsu.com> <4C526E3E.3000600@jp.fujitsu.com>
	<4C526FDC.6050800@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C526FDC.6050800@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

I have a concern.

(2010/07/30 15:23), Kenji Kaneshige wrote:
(snip)
> +/**
> + * pcie_port_acpi_setup - Request the BIOS to release control of PCIe services.
> + * @port: PCIe Port service for a root port or event collector.
> + * @srv_mask: Bit mask of services that can be enabled for @port.
> + *
> + * Invoked when @port is identified as a PCIe port device.  To avoid conflicts
> + * with the BIOS PCIe port native services support requires the BIOS to yield
> + * control of these services to the kernel.  The mask of services that the BIOS
> + * allows to be enabled for @port is written to @srv_mask.
> + *
> + * NOTE: It turns out that we cannot do that for individual port services
> + * separately, because that would make some systems work incorrectly.
> + */
> +int pcie_port_acpi_setup(struct pci_dev *port, int *srv_mask)
> +{
> +	acpi_status status;
> +	acpi_handle handle;
> +	u32 flags, request;
> +
> +	if (acpi_pci_disabled)
> +		return 0;
> +
> +	handle = acpi_find_root_bridge_handle(port);
> +	if (!handle)
> +		return -EINVAL;
> +
> +	request = (OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL |
> +		   OSC_PCI_EXPRESS_NATIVE_HP_CONTROL |
> +		   OSC_PCI_EXPRESS_PME_CONTROL |
> +		   OSC_PCI_EXPRESS_AER_CONTROL);
> +
> +	if (pcie_aer_get_firmware_first(port)) {
> +		dev_dbg(&port->dev, "PCIe errors handled by BIOS.\n");
> +		request &= ~OSC_PCI_EXPRESS_AER_CONTROL;
> +	}

We should drop OSC_PCI_EXPRESS_AER_CONTROL from request when AER is not
configured, and also when AER is disabled for some reason (e.g. pci=noaer).
Otherwise no one own AER errors, it will mean that unhandled error might
cause unexpected system behavior.

> +
> +	status = acpi_pci_osc_control_query(handle, request, &flags);
> +	if (ACPI_FAILURE(status)) {
> +		dev_dbg(&port->dev, "ACPI _OSC query failed (code %d)\n",
> +			status);
> +		return -ENODEV;
> +	}
> +
> +	if (!(flags & OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL)) {
> +		dev_dbg(&port->dev, "BIOS refuses to grant control of PCIe "
> +			"Capability Structure\n");
> +		return -EACCES;
> +	}
> +
> +	request &= flags;
> +	*srv_mask = PCIE_PORT_SERVICE_VC;
> +	if (request & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL)
> +		*srv_mask |= PCIE_PORT_SERVICE_HP;
> +	if (request & OSC_PCI_EXPRESS_PME_CONTROL)
> +		*srv_mask |= PCIE_PORT_SERVICE_PME;
> +	if (request & OSC_PCI_EXPRESS_AER_CONTROL)
> +		*srv_mask |= PCIE_PORT_SERVICE_AER;
> +
> +	status = acpi_pci_osc_control_set(handle, request);
> +	if (ACPI_FAILURE(status)) {
> +		dev_dbg(&port->dev, "ACPI _OSC request failed (code %d)\n",
> +			status);
> +		return -ENODEV;
> +	}
> +
> +	dev_info(&port->dev, "ACPI _OSC control granted for 0x%02x\n", request);
> +
> +	return 0;
> +}

I'll post a fix for this soon.


Thanks,
H.Seto
