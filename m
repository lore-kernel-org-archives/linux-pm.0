From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 7/10] PCI / Hot-plug: Query _OSC before
	requesting controls
Date: Mon, 09 Aug 2010 10:22:18 +0900
Message-ID: <4C5F584A.3050009__33762.4679356397$1281317137$gmane$org@jp.fujitsu.com>
References: <201008060303.51224.rjw@sisk.pl> <201008060311.33359.rjw@sisk.pl>
	<4C5B7181.3010602@jp.fujitsu.com> <201008061234.46493.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008061234.46493.rjw@sisk.pl>
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
Cc: linux-pci@vger.kernel.org, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

(2010/08/06 19:34), Rafael J. Wysocki wrote:
> On Friday, August 06, 2010, Hidetoshi Seto wrote:
>> (2010/08/06 10:11), Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki<rjw@sisk.pl>
>>>
>>> It generally is unsafe to call acpi_pci_osc_control_set() without
>>> checking what _OSC bits the BIOS is willing to grant control of,
>>> because control of some _OSC bits may be granted even if
>>> acpi_pci_osc_control_set() returns AE_SUPPORT.  Therefore make
>>> acpi_get_hp_hw_control_from_firmware() use
>>> acpi_pci_osc_control_query() to check if the BIOS will grant
>>> OSC_SHPC_NATIVE_HP_CONTROL before calling acpi_pci_osc_control_set().
>>>
>>> Signed-off-by: Rafael J. Wysocki<rjw@sisk.pl>
>>> ---
>>>   drivers/pci/hotplug/acpi_pcihp.c |    6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> Index: linux-2.6/drivers/pci/hotplug/acpi_pcihp.c
>>> ===================================================================
>>> --- linux-2.6.orig/drivers/pci/hotplug/acpi_pcihp.c
>>> +++ linux-2.6/drivers/pci/hotplug/acpi_pcihp.c
>>> @@ -358,11 +358,13 @@ int acpi_get_hp_hw_control_from_firmware
>>>   		acpi_get_name(handle, ACPI_FULL_PATHNAME,&string);
>>>   		dbg("Trying to get hotplug control for %s\n",
>>>   				(char *)string.pointer);
>>> +		status = acpi_pci_osc_control_query(handle,&flags);
>>> +		if (ACPI_FAILURE(status)
>>> +		    || !(flags&  OSC_SHPC_NATIVE_HP_CONTROL))
>>> +			goto no_control;
>>>   		status = acpi_pci_osc_control_set(handle, flags);
>>>   		if (ACPI_SUCCESS(status))
>>>   			goto got_one;
>>> -		if (status == AE_SUPPORT)
>>> -			goto no_control;
>>>   		kfree(string.pointer);
>>>   		string = (struct acpi_buffer){ ACPI_ALLOCATE_BUFFER, NULL };
>>>   	}
>>
>> This breaks fallback mechanism for OSHP, doesn't it?
>
> Hmm, well.  Can you please elaborate a bit?
>
> I guess you mean that the last two statements should be executed if
> acpi_pci_osc_control_query() returns error code, is that correct?
>

On legacy platform, firmware provides OSHP method instead of _OSC method
to grant native hot-plug control to OS. For this reason, current code
evaluates OSHP method if _OSC evaluation failed with error code other
than AE_SUPPORT (ex. "AE_NOT_FOUND" would be returned on the legacy
platform that provides OSHP instead of _OSC).

So I think Hidetoshi meant that

>>> +		status = acpi_pci_osc_control_query(handle,&flags);
>>> +		if (ACPI_FAILURE(status)
>>> +		    || !(flags&  OSC_SHPC_NATIVE_HP_CONTROL))
>>> +			goto no_control;

should be

	status = acpi_pci_osc_control_query(handle,&flags);
	if (status == AE_SUPPORT)
		goto no_control;

Thanks,
Kenji Kaneshige
