From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [PATCH 2/7] ACPI / PCI: Introduce
	acpi_pci_root_osc_query()
Date: Mon, 02 Aug 2010 18:18:55 +0900
Message-ID: <4C568D7F.5080105__36741.9016235091$1280740805$gmane$org@jp.fujitsu.com>
References: <201007310020.56546.rjw@sisk.pl> <201007310026.22124.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201007310026.22124.rjw@sisk.pl>
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

(2010/07/31 7:26), Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Introduce a function allowing the caller to obtain a mask of _OSC
> control bits the BIOS will allow the kernel to control for a given
> PCI root bridge.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/pci_root.c |   56 +++++++++++++++++++++++++++++++++++++++++-------
>  include/linux/acpi.h    |    1 
>  2 files changed, 49 insertions(+), 8 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/pci_root.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/pci_root.c
> +++ linux-2.6/drivers/acpi/pci_root.c
> @@ -224,21 +224,32 @@ static acpi_status acpi_pci_run_osc(acpi
>  	return status;
>  }
>  
> -static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root, u32 flags)
> +static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
> +					u32 support,
> +					u32 *control)
>  {
>  	acpi_status status;
> -	u32 support_set, capbuf[3];
> +	u32 capbuf[3];
> +
> +	support &= OSC_PCI_SUPPORT_MASKS;
> +	support |= root->osc_support_set;
>  
>  	/* do _OSC query for all possible controls */
> -	support_set = root->osc_support_set | (flags & OSC_PCI_SUPPORT_MASKS);
>  	capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
> -	capbuf[OSC_SUPPORT_TYPE] = support_set;
> -	capbuf[OSC_CONTROL_TYPE] = OSC_PCI_CONTROL_MASKS;
> +	capbuf[OSC_SUPPORT_TYPE] = support;
> +	if (control) {
> +		*control &= OSC_PCI_CONTROL_MASKS;
> +		capbuf[OSC_CONTROL_TYPE] = *control;
> +	} else {
> +		capbuf[OSC_CONTROL_TYPE] = OSC_PCI_CONTROL_MASKS;
> +	}
>  
>  	status = acpi_pci_run_osc(root->device->handle, capbuf);
>  	if (ACPI_SUCCESS(status)) {
> -		root->osc_support_set = support_set;
> +		root->osc_support_set = support;
>  		root->osc_control_qry = capbuf[OSC_CONTROL_TYPE];
> +		if (control)
> +			*control = capbuf[OSC_CONTROL_TYPE];
>  		root->osc_queried = 1;
>  	}
>  	return status;
> @@ -253,7 +264,7 @@ static acpi_status acpi_pci_osc_support(
>  	if (ACPI_FAILURE(status))
>  		return status;
>  	mutex_lock(&osc_lock);
> -	status = acpi_pci_query_osc(root, flags);
> +	status = acpi_pci_query_osc(root, flags, NULL);
>  	mutex_unlock(&osc_lock);
>  	return status;
>  }
> @@ -362,6 +373,35 @@ out:
>  }
>  EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
>  
> + /**
> + * acpi_pci_root_osc_query - Get the _OSC bits the kernel can control.
> + * @handle: ACPI handle of a PCI root bridge (or PCIe Root Complex).
> + * @ctrl_mask: Mask of _OSC bits to query and the place to put the result into.
> + **/
> +acpi_status acpi_pci_root_osc_query(acpi_handle handle, u32 *ctrl_mask)
> +{
> +	acpi_status status;
> +	acpi_handle tmp;
> +	struct acpi_pci_root *root;
> +
> +	if (!ctrl_mask || !(*ctrl_mask & OSC_PCI_CONTROL_MASKS))
> +		return AE_BAD_PARAMETER;
> +
> +	root = acpi_pci_find_root(handle);
> +	if (!root)
> +		return AE_NOT_EXIST;
> +
> +	status = acpi_get_handle(handle, "_OSC", &tmp);
> +	if (ACPI_FAILURE(status))
> +		return status;
> +
> +	mutex_lock(&osc_lock);
> +	status = acpi_pci_query_osc(root, root->osc_support_set, ctrl_mask);
> +	mutex_unlock(&osc_lock);
> +
> +	return status;
> +}
> +
>  /**
>   * acpi_pci_osc_control_set - commit requested control to Firmware
>   * @handle: acpi_handle for the target ACPI object
> @@ -395,7 +435,7 @@ acpi_status acpi_pci_osc_control_set(acp
>  
>  	/* Need to query controls first before requesting them */
>  	if (!root->osc_queried) {
> -		status = acpi_pci_query_osc(root, root->osc_support_set);
> +		status = acpi_pci_query_osc(root, root->osc_support_set, NULL);
>  		if (ACPI_FAILURE(status))
>  			goto out;
>  	}
> Index: linux-2.6/include/linux/acpi.h
> ===================================================================
> --- linux-2.6.orig/include/linux/acpi.h
> +++ linux-2.6/include/linux/acpi.h
> @@ -305,6 +305,7 @@ acpi_status acpi_run_osc(acpi_handle han
>  				OSC_PCI_EXPRESS_AER_CONTROL |		\
>  				OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL)
>  
> +extern acpi_status acpi_pci_root_osc_query(acpi_handle handle, u32 *ctrl_mask);
>  extern acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags);
>  extern void acpi_early_init(void);

IMHO acpi_pci_osc_control_query() is better name for new function here,
to make it be paired with acpi_pci_osc_control_set(), and to avoid mistakable
"*_get" that sounds like it takes controls via _OSC.

Thanks,
H.Seto
