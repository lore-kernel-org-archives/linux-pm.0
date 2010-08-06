From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [PATCH 7/8] ACPI / PCI: Do not preserve _OSC control
 bits returned by a query (v2)
Date: Fri, 06 Aug 2010 10:28:47 +0900
Message-ID: <4C5B654F.2090105__18797.5835091949$1281058878$gmane$org@jp.fujitsu.com>
References: <201008022351.31406.rjw@sisk.pl> <201008050151.27501.rjw@sisk.pl>
	<4C5A32A9.6010008@jp.fujitsu.com> <201008051625.07190.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008051625.07190.rjw@sisk.pl>
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
Cc: linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

(2010/08/05 23:25), Rafael J. Wysocki wrote:
> On Thursday, August 05, 2010, Hidetoshi Seto wrote:
>> (2010/08/05 8:51), Rafael J. Wysocki wrote:
<snip>
>>> Actually, having reconsidered that, I don't think this approach is valid.
>>>
>>> First, it has the problem that if acpi_pci_osc_control_set() returns error
>>> code, the caller doesn't really know whether the query failed, or the final
>>> request failed.  Arguably, it won't matter for the majority of callers, but
>>> some of them might be interested in knowing that in principle.
>>
>> Ugh... there are only 2 callers now and both of them are in the majority.
>> I don't think it is a time to take care of an invisible minority who might
>> require acpi_pci_osc_raw() to complete its work.
>>
>>>
>>> Second, the callers that call acpi_pci_osc_control_query() before
>>> acpi_pci_osc_control_set() don't need the additional query inside
>>> of acpi_pci_osc_control_set().
>>
>> So we can recommend all of callers not to call acpi_pci_osc_control_query()
>> before acpi_pci_osc_control_set().
> 
> Please consider pcie_port_acpi_setup() in [4/8].
> 
> It has to do the query by itself, because it may not request the controls
> _even_ _if_ _the_ _query_ _is_ _successful_.  Namely, if the result of the
> query is that the BIOS won't let us control the PCIe Capability Structure,
> pcie_port_acpi_setup() should return error code instead of requesting control
> of the other features.  Now, if you put the query into
> acpi_pci_osc_control_set(), it won't be able to recognize this corner case and
> handle it correctly.

Then please rewrite your pcie_port_acpi_setup() to clarify that it cannot live
without separated "query" and "set".

I already stated that current pcie_port_acpi_setup() can do its work using a
modified acpi_pci_osc_control_set().
https://patchwork.kernel.org/patch/116976/

Or you might invent new function like:
 acpi_pci_osc_control_set2(*dev, required_bits, optional_bits)

Anyway I'm going to cancel my plan to test your patches today.

>> I suppose that almost all of "the majority" just want to set fixed set of
>> controls and they will just return error when fails anyway.
>>
>>>
>>> Therefore I'd prefer to have two separate functions, one for querying and the
>>> other for requesting control.  Then, we can provide a helper that calls the
>>> both of them for the callers of acpi_pci_osc_control_set() that don't need
>>> to call acpi_pci_osc_control_query() directly by themselves.
>>
>> I'm afraid the "two" is not enough for the minority.
>>
>> Therefore I don't think it is a time to prepare for such an inexistent
>> minor usage.
> 
> As explained above, I think there is a reason to do that, because
> pcie_port_acpi_setup() has to run a query anyway.

I believe I already reviewed your patch enough, but I couldn't find out
the reason that you are claiming now.

If that helps, one of the reasons why I can accept Kaneshige-san's suggestion
to have a smart acpi_pci_osc_control_set() instead of separated functions is
because I remember a function pci_enable_msix() that returns '0' on success,
'< 0' on failure, and '> 0' when retry might be possible with the returned
value. 


Thanks,
H.Seto
