From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 7/8] ACPI / PCI: Do not preserve _OSC control
 bits returned by a query (v2)
Date: Wed, 04 Aug 2010 18:39:19 +0900
Message-ID: <4C593547.2040700__41044.6535483517$1280914936$gmane$org@jp.fujitsu.com>
References: <201008022351.31406.rjw@sisk.pl> <4C57C182.7060407@jp.fujitsu.com>
	<201008031133.37471.rjw@sisk.pl> <201008032302.33778.rjw@sisk.pl>
	<4C58FE9A.1040607@jp.fujitsu.com> <4C59284F.9080808@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C59284F.9080808@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

(2010/08/04 17:43), Hidetoshi Seto wrote:
> (2010/08/04 14:46), Kenji Kaneshige wrote:
>> By the way, I think it is getting confusing regarding who query the
>> controls. IMO, querying controls to ensure all the requested controls
>> are granted to OS should be done in acpi_pci_osc_control_set(), as
>> I said above. On the other hand, PCIe port driver need to query
>> controls for other reason... Now I think it might be better to change
>> acpi_pci_osc_control_set() like below instead of introducing
>> acpi_pci_osc_control_query().
>>
>> acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *flags)
>> {
>>      ...
>>      query = control_req;
>>      status = acpi_pci_query_osc(root, root->osc_support_set,&query);
>>      if (ACPI_FAILURE(status))
>>          goto out;
>>      if ((query&  control_req) != control_req) {
>>          printk_(KERN_DEBUG
>>              "Firmware did not grant requested _OSC control\n");
>>          status = AE_SUPPORT;
>>          *flags = (query&  control_req);
>>          goto out;
>>      }
>>      ...
>> }
>>
>> And do as follows in pcie_port_acpi_setup()
>>
>>      status = acpi_pci_osc_control_set(handle,&flags);
>>      if (status == AE_SUPPORT)  {
>>          /* 2nd try */
>>          status = acpi_pci_osc_control_set(handle,&flags);
>>      }
>>      if (ACPI_FAILURE(status)) {
>>      ...
>>
>> What do you think about this?
> 
> I think it makes sense, though some minor cares are required.
> 
> Does this incremental patch (apply after [8/8]) looks good?
> If it is OK, I'll test these 8+1 patches within the next 2days.
> 
> Thanks,
> H.Seto
> 
> =====
> Subject: ACPI/PCI: Unify acpi_pci_osc_control_*()
> 
> Now AE_SUPPORT of acpi_pci_osc_control_set() tells not only
> that query fails with the requested control bits but also that
> the result of query is stored into the pointed place.
> 
> This allow user to retry acpi_pci_osc_control_set() with the
> result of query.
> 
> Signed-off-by: Hidetoshi Seto<seto.hidetoshi@jp.fujitsu.com>
> ---
>   drivers/acpi/pci_root.c          |   54 +++++++++++--------------------------
>   drivers/pci/hotplug/acpi_pcihp.c |    2 +-
>   drivers/pci/pcie/portdrv_acpi.c  |   23 +++++++---------
>   include/linux/acpi.h             |    3 +-
>   4 files changed, 28 insertions(+), 54 deletions(-)

<snip.>

>   /**
>    * acpi_pci_osc_control_set - commit requested control to Firmware
>    * @handle: acpi_handle for the target ACPI object
> @@ -411,14 +379,17 @@ acpi_status acpi_pci_osc_control_query(acpi_handle handle, u32 *mask)
>    *
>    * Attempt to take control from Firmware on requested control bits.
>    **/

Updating description of this function would be appreciated.

<snip.>

> @@ -452,7 +427,10 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags)
>   	capbuf[OSC_CONTROL_TYPE] = root->osc_control_set | control_req;
>   	status = acpi_pci_run_osc(handle, capbuf,&result);
>   	if (ACPI_SUCCESS(status))
> -		root->osc_control_set = result;
> +		root->osc_control_set = *flags = result;

I don't think we need to update *flags here, though it depends on the design
of this function interface.
IMHO, updating *flags only when AE_SUPPORT is returned is easy to understand.

Others looks good to me.

Thanks,
Kenji Kaneshige
