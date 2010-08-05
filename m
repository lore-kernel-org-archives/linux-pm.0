From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [PATCH 7/8] ACPI / PCI: Do not preserve _OSC control
 bits returned by a query (v2)
Date: Thu, 05 Aug 2010 12:38:55 +0900
Message-ID: <4C5A324F.8060206__16861.6759045564$1280979621$gmane$org@jp.fujitsu.com>
References: <201008022351.31406.rjw@sisk.pl> <4C59284F.9080808@jp.fujitsu.com>
	<4C593547.2040700@jp.fujitsu.com> <201008041415.23248.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008041415.23248.rjw@sisk.pl>
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
Cc: linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

(2010/08/04 21:15), Rafael J. Wysocki wrote:
> On Wednesday, August 04, 2010, Kenji Kaneshige wrote:
>> (2010/08/04 17:43), Hidetoshi Seto wrote:
>>>   /**
>>>    * acpi_pci_osc_control_set - commit requested control to Firmware
>>>    * @handle: acpi_handle for the target ACPI object
>>> @@ -411,14 +379,17 @@ acpi_status acpi_pci_osc_control_query(acpi_handle handle, u32 *mask)
>>>    *
>>>    * Attempt to take control from Firmware on requested control bits.
>>>    **/
>>
>> Updating description of this function would be appreciated.

OK, I will do it.

>>> @@ -452,7 +427,10 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags)
>>>   	capbuf[OSC_CONTROL_TYPE] = root->osc_control_set | control_req;
>>>   	status = acpi_pci_run_osc(handle, capbuf,&result);
>>>   	if (ACPI_SUCCESS(status))
>>> -		root->osc_control_set = result;
>>> +		root->osc_control_set = *flags = result;
>>
>> I don't think we need to update *flags here, though it depends on the design
>> of this function interface.
>> IMHO, updating *flags only when AE_SUPPORT is returned is easy to understand.
> 
> I think the patch is correct.  We should update *flags in any case so that the
> caller can check what's the full mask of granted controls even if it asked for
> fewer control bits.

My idea (that will be what I'll add to the description of function) is:

  On success, OS takes all of requested control(s) and *flags is updated with
  set of controls now OS have.
  If AE_SUPPORT returns, none of control settings are changed since Firmware
  rejects granting some of requested controls. *flags is updated with set of
  controls with rejected bits cleared.
  All other cases mean failure, none of control settings are changed, and
  *flags is unchanged.

Thanks,
H.Seto
