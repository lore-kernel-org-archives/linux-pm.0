From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [PATCH 1/7] ACPI / PCI: Make acpi_pci_run_osc() use
 capbuf to return the result
Date: Mon, 02 Aug 2010 18:16:05 +0900
Message-ID: <4C568CD5.6000801__13517.4638395712$1280740704$gmane$org@jp.fujitsu.com>
References: <201007310020.56546.rjw@sisk.pl> <201007310024.10174.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201007310024.10174.rjw@sisk.pl>
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

(2010/07/31 7:24), Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> There is no reason why acpi_pci_run_osc() should use a separate
> argument to return the _OSC result, since there is a place for it
> in the buffer passed via capbuf, as none of the callers needs to
> preserve the original contents of that buffer, so drop the third
> argument of acpi_pci_run_osc() and modify the callers accordingly.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

I think this change is not significant for later patches.
Can we skip?

Thanks,
H.Seto

>  drivers/acpi/pci_root.c |   17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/pci_root.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/pci_root.c
> +++ linux-2.6/drivers/acpi/pci_root.c
> @@ -206,8 +206,7 @@ static void acpi_pci_bridge_scan(struct 
>  
>  static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
>  
> -static acpi_status acpi_pci_run_osc(acpi_handle handle,
> -				    const u32 *capbuf, u32 *retval)
> +static acpi_status acpi_pci_run_osc(acpi_handle handle, u32 *capbuf)
>  {
>  	struct acpi_osc_context context = {
>  		.uuid_str = pci_osc_uuid_str,
> @@ -219,7 +218,7 @@ static acpi_status acpi_pci_run_osc(acpi
>  
>  	status = acpi_run_osc(handle, &context);
>  	if (ACPI_SUCCESS(status)) {
> -		*retval = *((u32 *)(context.ret.pointer + 8));
> +		capbuf[OSC_CONTROL_TYPE] = ((u32 *)context.ret.pointer)[2];
>  		kfree(context.ret.pointer);
>  	}
>  	return status;
> @@ -228,7 +227,7 @@ static acpi_status acpi_pci_run_osc(acpi
>  static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root, u32 flags)
>  {
>  	acpi_status status;
> -	u32 support_set, result, capbuf[3];
> +	u32 support_set, capbuf[3];
>  
>  	/* do _OSC query for all possible controls */
>  	support_set = root->osc_support_set | (flags & OSC_PCI_SUPPORT_MASKS);
> @@ -236,10 +235,10 @@ static acpi_status acpi_pci_query_osc(st
>  	capbuf[OSC_SUPPORT_TYPE] = support_set;
>  	capbuf[OSC_CONTROL_TYPE] = OSC_PCI_CONTROL_MASKS;
>  
> -	status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
> +	status = acpi_pci_run_osc(root->device->handle, capbuf);
>  	if (ACPI_SUCCESS(status)) {
>  		root->osc_support_set = support_set;
> -		root->osc_control_qry = result;
> +		root->osc_control_qry = capbuf[OSC_CONTROL_TYPE];
>  		root->osc_queried = 1;
>  	}
>  	return status;
> @@ -373,7 +372,7 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
>  acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags)
>  {
>  	acpi_status status;
> -	u32 control_req, result, capbuf[3];
> +	u32 control_req, capbuf[3];
>  	acpi_handle tmp;
>  	struct acpi_pci_root *root;
>  
> @@ -410,9 +409,9 @@ acpi_status acpi_pci_osc_control_set(acp
>  	capbuf[OSC_QUERY_TYPE] = 0;
>  	capbuf[OSC_SUPPORT_TYPE] = root->osc_support_set;
>  	capbuf[OSC_CONTROL_TYPE] = root->osc_control_set | control_req;
> -	status = acpi_pci_run_osc(handle, capbuf, &result);
> +	status = acpi_pci_run_osc(handle, capbuf);
>  	if (ACPI_SUCCESS(status))
> -		root->osc_control_set = result;
> +		root->osc_control_set = capbuf[OSC_CONTROL_TYPE];
>  out:
>  	mutex_unlock(&osc_lock);
>  	return status;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
