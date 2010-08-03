From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [PATCH 7/8] ACPI / PCI: Do not preserve _OSC control
 bits returned by a query (v2)
Date: Tue, 03 Aug 2010 16:13:06 +0900
Message-ID: <4C57C182.7060407__48548.5114892528$1280819660$gmane$org@jp.fujitsu.com>
References: <201008022351.31406.rjw@sisk.pl> <201008022359.33177.rjw@sisk.pl>
	<4C57A09B.9070206@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C57A09B.9070206@jp.fujitsu.com>
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

(2010/08/03 13:52), Kenji Kaneshige wrote:
> (2010/08/03 6:59), Rafael J. Wysocki wrote:
>> @@ -434,19 +432,6 @@ acpi_status acpi_pci_osc_control_set(acp
>>       if ((root->osc_control_set&  control_req) == control_req)
>>           goto out;
>>
>> -    /* Need to query controls first before requesting them */
>> -    if (!root->osc_queried) {
>> -        status = acpi_pci_query_osc(root, root->osc_support_set, NULL);
>> -        if (ACPI_FAILURE(status))
>> -            goto out;
>> -    }
>> -    if ((root->osc_control_qry&  control_req) != control_req) {
>> -        printk(KERN_DEBUG
>> -               "Firmware did not grant requested _OSC control\n");
>> -        status = AE_SUPPORT;
>> -        goto out;
>> -    }
> 
> I think acpi_pci_osc_control_set() still need to query before commit
> to ensure all the requested controls are granted to OS.
> 
> So the code needs to be
> 
>     status = acpi_pci_query_osc(root, root->osc_support_set, &control_req);
>     if (ACPI_FAILURE(status))
>         goto out;

Hum, since acpi_status acpi_pci_osc_control_set() is an exported
function, we cannot be too careful here. 

OTOH, I think this second query should be done in caller too,
i.e. pcie_port_acpi_setup() in patch [4/8].

Now:
  pcie_port_acpi_setup()
  {
    flags = A|B|C|D;
    acpi_pci_osc_control_query(handle, &flags);
    /* note: flags might be changed after query */
    acpi_pci_osc_control_set(handle, flags);
  }

Strictly, it could be like:

New:
  pcie_port_acpi_setup()
  {
    flags = A|B|C|D;
    do {
      pre_flags = flags;
      acpi_pci_osc_control_query(handle, &flags);
    } while (flags && pre_flags != flags);
    if (flags)
      acpi_pci_osc_control_set(handle, flags);
  }

IMHO these checks are kind of preventive guard for corner cases,
and I suppose it can be implemented by an incremental patch later.


Thanks,
H.Seto
