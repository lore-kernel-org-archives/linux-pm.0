From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/6] ACPI/PCI: cleanup acpi_pci_run_osc
Date: Fri, 30 Jul 2010 14:15:50 +0200
Message-ID: <201007301415.50398.rjw__3109.13464422828$1280492365$gmane$org@sisk.pl>
References: <201007282323.56351.rjw@sisk.pl> <4C526E3E.3000600@jp.fujitsu.com>
	<4C526F1F.6060701@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C526F1F.6060701@jp.fujitsu.com>
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
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, July 30, 2010, Kenji Kaneshige wrote:
> Make capabilitis buffer in acpi_pci_run_osc() instead of caller of
> this function. This makes the code a little cleaner. This has no
> functional changes.
> 
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

Well, I'm not sure if that really is an improvement.  With the patch
acpi_pci_run_osc() simply has more arguments that doesn't really
make it more readable IMHO.

> ---
>  drivers/acpi/pci_root.c |   34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> Index: linux-2.6.35-rc6/drivers/acpi/pci_root.c
> ===================================================================
> --- linux-2.6.35-rc6.orig/drivers/acpi/pci_root.c
> +++ linux-2.6.35-rc6/drivers/acpi/pci_root.c
> @@ -206,9 +206,10 @@ static void acpi_pci_bridge_scan(struct 
>  
>  static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
>  
> -static acpi_status acpi_pci_run_osc(acpi_handle handle,
> -				    const u32 *capbuf, u32 *retval)
> +static acpi_status acpi_pci_run_osc(acpi_handle handle, u32 support,
> +				    u32 control, bool query, u32 *retval)
>  {
> +	u32 capbuf[3];
>  	struct acpi_osc_context context = {
>  		.uuid_str = pci_osc_uuid_str,
>  		.rev = 1,
> @@ -217,6 +218,10 @@ static acpi_status acpi_pci_run_osc(acpi
>  	};
>  	acpi_status status;
>  
> +	capbuf[OSC_QUERY_TYPE] = (query == true) ? OSC_QUERY_ENABLE : 0;
> +	capbuf[OSC_SUPPORT_TYPE] = support;
> +	capbuf[OSC_CONTROL_TYPE] = control;
> +
>  	status = acpi_run_osc(handle, &context);
>  	if (ACPI_SUCCESS(status)) {
>  		*retval = *((u32 *)(context.ret.pointer + 8));
> @@ -228,17 +233,16 @@ static acpi_status acpi_pci_run_osc(acpi
>  static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root, u32 flags)
>  {
>  	acpi_status status;
> -	u32 support_set, result, capbuf[3];
> +	u32 result;
>  
>  	/* do _OSC query for all possible controls */
> -	support_set = root->osc_support_set | (flags & OSC_PCI_SUPPORT_MASKS);
> -	capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
> -	capbuf[OSC_SUPPORT_TYPE] = support_set;
> -	capbuf[OSC_CONTROL_TYPE] = OSC_PCI_CONTROL_MASKS;
> -
> -	status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
> +	flags &= OSC_PCI_SUPPORT_MASKS;
> +	status = acpi_pci_run_osc(root->device->handle,
> +				  root->osc_support_set | flags,
> +				  OSC_PCI_CONTROL_MASKS,
> +				  true, &result);
>  	if (ACPI_SUCCESS(status)) {
> -		root->osc_support_set = support_set;
> +		root->osc_support_set |= flags;

To me, the old code is cleaner.  I would do

+	flags &= OSC_PCI_SUPPORT_MASKS;
+	flags |= root->osc_support_set;
+	status = acpi_pci_run_osc(root->device->handle,
+				  flags,
+				  OSC_PCI_CONTROL_MASKS,
+				  true, &result);
 	if (ACPI_SUCCESS(status)) {
-		root->osc_support_set = support_set;
+		root->osc_support_set = flags;

but that's almost the same as the old code.

>  		root->osc_control_qry = result;
>  		root->osc_queried = 1;
>  	}
> @@ -373,7 +377,7 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
>  acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags)
>  {
>  	acpi_status status;
> -	u32 control_req, result, capbuf[3];
> +	u32 control_req, result;
>  	acpi_handle tmp;
>  	struct acpi_pci_root *root;
>  
> @@ -407,10 +411,10 @@ acpi_status acpi_pci_osc_control_set(acp
>  		goto out;
>  	}
>  
> -	capbuf[OSC_QUERY_TYPE] = 0;
> -	capbuf[OSC_SUPPORT_TYPE] = root->osc_support_set;
> -	capbuf[OSC_CONTROL_TYPE] = root->osc_control_set | control_req;
> -	status = acpi_pci_run_osc(handle, capbuf, &result);
> +	status = acpi_pci_run_osc(handle,
> +				  root->osc_support_set,
> +				  root->osc_control_set | control_req,
> +				  false, &result);
>  	if (ACPI_SUCCESS(status))
>  		root->osc_control_set = result;
>  out:

Overall, I don't like this change, sorry.

Rafael
