From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [PATCH 4/8] PCI / PCIe: Ask BIOS for control of all
 native services at once (v6)
Date: Tue, 03 Aug 2010 10:14:08 +0900
Message-ID: <4C576D60.1070404__46505.6342458867$1280798269$gmane$org@jp.fujitsu.com>
References: <201008022351.31406.rjw@sisk.pl> <201008022356.31166.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008022356.31166.rjw@sisk.pl>
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
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

(2010/08/03 6:56), Rafael J. Wysocki wrote:
> +int pcie_port_acpi_setup(struct pci_dev *port, int *srv_mask)
> +{
> +	acpi_status status;
> +	acpi_handle handle;
> +	u32 flags;
> +
> +	if (acpi_pci_disabled)
> +		return 0;
> +
> +	handle = acpi_find_root_bridge_handle(port);
> +	if (!handle)
> +		return -EINVAL;
> +
> +	flags = OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL
> +		| OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
> +		| OSC_PCI_EXPRESS_PME_CONTROL;
> +
> +	if (pcie_aer_get_firmware_first(port))
> +		dev_dbg(&port->dev, "PCIe errors handled by BIOS.\n");
> +	else if (pci_aer_available())
> +		flags |= OSC_PCI_EXPRESS_AER_CONTROL;

Is the debug message necessary even when AER is not available?
At least current code doesn't output such strings when pci=noaer,
since AER service driver is not loaded.

if (pci_aer_available()) {
	if (pcie_aer_get_firmware_first(port))
		dev_dbg(&port->dev, "PCIe errors handled by BIOS.\n");
	else
		flags |= OSC_PCI_EXPRESS_AER_CONTROL;
}

Thanks,
H.Seto
