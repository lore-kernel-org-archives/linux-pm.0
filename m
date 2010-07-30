From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] PCI / PCIe: Ask BIOS for control of all
 native services at once (v4)
Date: Fri, 30 Jul 2010 15:16:30 +0900
Message-ID: <4C526E3E.3000600__28860.1803513759$1280470813$gmane$org@jp.fujitsu.com>
References: <201007282323.56351.rjw@sisk.pl>
	<20100728144358.5e2c12ce@virtuousgeek.org>
	<4C510B90.9070302@jp.fujitsu.com> <201007291745.39285.rjw@sisk.pl>
	<4C526A85.3070902@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C526A85.3070902@jp.fujitsu.com>
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
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

(2010/07/30 15:00), Kenji Kaneshige wrote:
> (2010/07/30 0:45), Rafael J. Wysocki wrote:
>> On Thursday, July 29, 2010, Kenji Kaneshige wrote:
>>> (2010/07/29 6:43), Jesse Barnes wrote:
>>>> On Wed, 28 Jul 2010 23:23:56 +0200
>>>> "Rafael J. Wysocki"<rjw@sisk.pl> wrote:
>>>>
>>>>> From: Rafael J. Wysocki<rjw@sisk.pl>
>>>>>
>>>>> PCIe port service drivers ask the BIOS, through _OSC, for control of
>>>>> the services they handle. Unfortunately, each of them individually
>>>>> asks for control of the PCIe capability structure and if that is
>>>>> granted, some BIOSes expect that the other PCIe port services will be
>>>>> configured and handled by the kernel as well. If that is not the
>>>>> case (eg. one of the PCIe port service drivers is not loaded), the
>>>>> BIOS may be confused and may cause the system as a whole to misbehave
>>>>> (eg. on one of such systems enabling the native PCIe PME service
>>>>> without loading the native PCIe hot-plug service driver causes a
>>>>> storm of ACPI notify requests to appear).
>>>>>
>>>>> For this reason rework the PCIe port driver so that (1) it checks
>>>>> which native PCIe port services can be enabled, according to the
>>>>> BIOS, and (2) it requests control of all these services
>>>>> simultaneously. In particular, this causes pcie_portdrv_probe() to
>>>>> fail if the BIOS refuses to grant control of the PCIe capability
>>>>> structure, which means that no native PCIe port services can be
>>>>> enabled for the PCIe root complex the given port belongs to.
>>>>>
>>>>> Make it possible to override this behavior using a new command line
>>>>> switch pcie_ports= that can be set to 'auto' (ask the BIOS, the
>>>>> default), 'native' (use the PCIe native services regardless of the
>>>>> BIOS response to the control request), or 'compat' (do not use the
>>>>> PCIe native services at all).
>>>>>
>>>>> Accordingly, rework the existing PCIe port service drivers so that
>>>>> they don't request control of the services directly.
>>>>>
>>>>> Signed-off-by: Rafael J. Wysocki<rjw@sisk.pl>
>>>>> ---
>>>>
>>>> Kenji-san, are you ok with this version? I would like to get your ack
>>>> (and ideally your tested-by) for this one since it affects
>>>> functionality you need.
>>>>
>>>
>>> Hi Jesse, Rafael,
>>>
>>> I've just started reviewing the latest version of the patch. I have good
>>> impression about this version so far. Please give me a few days for
>>> deeper
>>> review. And I've booked the test machine for this patch in next week.
>>> I'll
>>> try to test the patch and send you the result as soon as I can.
>>>
>>> Here are two comments I have so far.
>>>
>>> Though it is not directly related to Rafael's patch, I found one problem
>>> in _OSC query handling while reviewing this patch. Currently, all the
>>> _OSC controls are queried at the same time in acpi_pci_osc_support() and
>>> the result is preserved for later acpi_pci_osc_control_set() call. But
>>> query result can vary depending on the combination of requested
>>> controls.
>>
>> In principle it can, but acpi_pci_query_osc() asks for all aplicable
>> control
>> bits, in which case the formware can only clear those bits in the
>> response if
>> the corresponding features are unsupported. Doing otherwise would be in
>> violation of Section 6.2.9.1. of ACPI spec 3.0b, the following in
>> particular:
>>
>> "If any bits in the Control Field are returned cleared (masked to
>> zero) by the _OSC control method,
>> the respective feature is designated unsupported by the platform and
>> must not be enabled by the OS."
>>
>
> My concern is as follows.
>
> For easy, assume as follows:
> - all the _OSC controls are A, B, C
> -B depends on C.
> - When requesting A, B and C, all A, B and C are granted to OS.
> - When requesting A, B, only A is granted to OS.
>
> Current linux queries all A, B and C at the boot time and preserve the
> result (all A, B and C can be granted to OS). Here, if a service driver
> requests A and B using acpi_pci_osc_control_set(),
> acpi_pci_osc_control_set()
> checks if both of those controls can be granted to OS. The expected result
> here is only A can be granted to OS, but current linux judges both of them
> can be granted because linux does this check by seeing preserved result.
> As a result, acpi_pci_osc_control_set() evaluates _OSC with query flag
> cleared to request A and B. Since the control B returned cleared,
> acpi_pci_osc_control() returns error to the service driver. As a result,
> control A is granted to OS even though there is no driver to handle the
> control A.
>
>
>>> So I think query result must not be preserved. Since Rafael's patch uses
>>> query result, this problem should be fixed at the same time. I'll try to
>>> make a patch for this and update Rafael's patch if needed.
>>
>> It would be sufficient to change acpi_pci_osc_control_get(), introduced
>> by my patch, to call acpi_pci_query_osc() unconditionally, but as I
>> said above,
>> I don't think it's necessary.
>
> I made a patch for this and updated your patch slightly. I'll send them
> soon.
>
>>
>>> I think the following changes should be done in the separated patch. I
>>> guess this change is for the BIOS which enables hotplug interrupt at
>>> when
>>> _OSC is evaluated with native hot-plug control. Right?
>>
>> Yes, it is.
>>
>>> Anyway, it should be separated patch with appropriate description.
>>
>> But the $subject patch does analogous things for AER and PCIe PME. Do you
>> think they also should be introduced by separate patches?
>
> I think the following changes in your patch should be introduced by
> separate patches.
>
> - optimizing the checks in acpi_pci_osc_control_set()
> - Disabling hot-plug interrupt
> - Removing module_exit()
>
> Thanks,
> Kenji Kaneshige

Hi Rafael,

Here is an updated version of your patch. The set of patches consists
of six patches. The [PATCH 1/6] and [PATCH 2/6] is to change _OSC
query handling as I explained in the previous e-mail. Remaining
patches are based on your change (I split the original one into some
pieces). Please see below about the summary of changes.

NOTE: I have not tested it at all yet (compile only). This is request
       for comment.

- [PATCH 1/5] ACPI/PCI: cleanup acpi_pci_run_osc
   Cleanup acpi_pci_run_osc() to make the following patch cleaner.

- [PATCH 2/5] ACPI/PCI: do not preserve query result
   Fix the possible problem that some of the requested _OSC controls
   are granted to OS even though acpi_pci_osc_control_set() fails. That
   is, some of the requested controls for this service is granted to OS
   even though OS doesn't handle the service.

- [PATCH 3/5] ACPI/PCI: optimize checks in acpi_pci_osc_control_set()
   Make the following optimization in Rafael's v.4 patch as a separated
   patch here.
   ================================================================
   -       status = acpi_get_handle(handle, "_OSC", &tmp);
   -       if (ACPI_FAILURE(status))
   -               return status;
   -
           control_req = (flags & OSC_PCI_CONTROL_MASKS);
           if (!control_req)
               return AE_TYPE;
   @@ -389,6 +419,10 @@ acpi_status acpi_pci_osc_control_set(acp
           if (!root)
                   return AE_NOT_EXIST;

   +       status = acpi_get_handle(handle, "_OSC", &tmp);
   +       if (ACPI_FAILURE(status))
   +               return status;
   +
     ================================================================

- [PATCH 4/5] ACPI/PCI: ask bios for control of all native services at once
   ChangeLog from Rafael's v.4:
   ============================
   * Rewrote acpi_pci_osc_control_get() becasuse _OSC query handling is
     changed by [PATCH 2/5]. And renamed acpi_pci_osc_control_get() to
     acpi_pci_osc_control_query() because latter one is more
     straightforward.
   * Moved the optimization for acpi_pci_osc_control_set() into the
     separated patch ([PATCH 3/6]).
   * Moved the change to disable native hot-plug interrupt into the
     separated patch ([PATCH 5/6]).
   * Moved the change to remove module_exit() into the separated patch
     ([PATCH 6/6]).

- [PATCH 5/6] PCI: portdrv: disable native hot-plug interrupt
   Make the change to disable native hot-plug interrupt as a separated
   patch here.

- [PATCH 6/6] PCI: portdrv: remove module_exit
   Make the change to remove module_exit() as a separated patch here.

Regards,
Kenji Kaneshige
