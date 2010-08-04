From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 7/8] ACPI / PCI: Do not preserve _OSC control
 bits returned by a query (v2)
Date: Wed, 04 Aug 2010 14:46:02 +0900
Message-ID: <4C58FE9A.1040607__18469.1522423693$1280900829$gmane$org@jp.fujitsu.com>
References: <201008022351.31406.rjw@sisk.pl> <4C57C182.7060407@jp.fujitsu.com>
	<201008031133.37471.rjw@sisk.pl> <201008032302.33778.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008032302.33778.rjw@sisk.pl>
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
Cc: linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

(2010/08/04 6:02), Rafael J. Wysocki wrote:
> On Tuesday, August 03, 2010, Rafael J. Wysocki wrote:
>> On Tuesday, August 03, 2010, Hidetoshi Seto wrote:
>>> (2010/08/03 13:52), Kenji Kaneshige wrote:
>>>> (2010/08/03 6:59), Rafael J. Wysocki wrote:
>>>>> @@ -434,19 +432,6 @@ acpi_status acpi_pci_osc_control_set(acp
>>>>>        if ((root->osc_control_set&   control_req) == control_req)
>>>>>            goto out;
>>>>>
>>>>> -    /* Need to query controls first before requesting them */
>>>>> -    if (!root->osc_queried) {
>>>>> -        status = acpi_pci_query_osc(root, root->osc_support_set, NULL);
>>>>> -        if (ACPI_FAILURE(status))
>>>>> -            goto out;
>>>>> -    }
>>>>> -    if ((root->osc_control_qry&   control_req) != control_req) {
>>>>> -        printk(KERN_DEBUG
>>>>> -               "Firmware did not grant requested _OSC control\n");
>>>>> -        status = AE_SUPPORT;
>>>>> -        goto out;
>>>>> -    }
>>>>
>>>> I think acpi_pci_osc_control_set() still need to query before commit
>>>> to ensure all the requested controls are granted to OS.
>>>>
>>>> So the code needs to be
>>>>
>>>>      status = acpi_pci_query_osc(root, root->osc_support_set,&control_req);
>>>>      if (ACPI_FAILURE(status))
>>>>          goto out;
>>>

Sorry, that should have been

	query = control_req;
	status = acpi_pci_query_osc(root, root->osc_support_set, &query);
	if (ACPI_FAILURE(status))
		goto out;
	if ((query & control_req) != control_req) {
		printk_(KERN_DEBUG
			"Firmware did not grant requested _OSC control\n");
		status = AE_SUPPORT;
		goto out;
	}

I know current pcie_port_acpi_setup() queries the requesting controls
before acpi_pci_osc_control_set() and only one control is requested
in the other code. However, I think acpi_pci_osc_control_set() still
need to query the requested controls to ensure all the requested
controls, in case someone calls this function without querying the
requesting controls. In other words, I think it must be ensured that
any controls are never granted to OS when acpi_pci_osc_control_set()
returns error.

>>>>      status = acpi_pci_query_osc(root, root->osc_support_set,&control_req);
>>>>      if (ACPI_FAILURE(status))
>>>>          goto out;

By the way, I think it is getting confusing regarding who query the
controls. IMO, querying controls to ensure all the requested controls
are granted to OS should be done in acpi_pci_osc_control_set(), as
I said above. On the other hand, PCIe port driver need to query
controls for other reason... Now I think it might be better to change
acpi_pci_osc_control_set() like below instead of introducing
acpi_pci_osc_control_query().

acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *flags)
{
	...
	query = control_req;
	status = acpi_pci_query_osc(root, root->osc_support_set, &query);
	if (ACPI_FAILURE(status))
		goto out;
	if ((query & control_req) != control_req) {
		printk_(KERN_DEBUG
			"Firmware did not grant requested _OSC control\n");
		status = AE_SUPPORT;
		*flags = (query & control_req);
		goto out;
	}
	...
}

And do as follows in pcie_port_acpi_setup()

	status = acpi_pci_osc_control_set(handle, &flags);
	if (status == AE_SUPPORT)  {
		/* 2nd try */
		status = acpi_pci_osc_control_set(handle, &flags);
	}
	if (ACPI_FAILURE(status)) {
	...

What do you think about this?


Thanks,
Kenji Kaneshige
