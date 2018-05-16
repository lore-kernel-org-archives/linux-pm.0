From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] ACPICA: Introduce acpi_dispatch_gpe()
Date: Wed, 16 May 2018 23:03:09 +0200
Message-ID: <CAJZ5v0hAzkyMA4Kku9p6_TcmOXDniVSqGRKmkDvsJsW26SOKFQ@mail.gmail.com>
References: <2406722.gU2bUHd7bl@aspire.rjw.lan> <1877957.ohNgiH8Sko@aspire.rjw.lan>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B776DF31@ORSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B776DF31@ORSMSX108.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Schmauss, Erik" <erik.schmauss@intel.com>, "Wang, Wendy" <wendy.wang@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, May 16, 2018 at 9:18 PM, Moore, Robert <robert.moore@intel.com> wrote:
> I'm not sure why this is necessary, please explain.
>
> Is the implication here that some driver is going to poll on acpi_dispatch_gpe?

Not a driver, but the core part of resume from suspend-to-idle and it
needs to call it for the EC GPE specifically to avoid missing events
that will be discarded on some platforms if the EC is not poked at
within specific time since when the GPE status changed.

IOW, the use case is in patch [2/2]. :-)

I do realize, however, that you may not want this upstream as it is
strictly Linux-specific and will probably stay this way forever
(suspend-to-idle is a Linux concept and I'm not aware of any OSes
doing it).

>> -----Original Message-----
>> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
>> Sent: Wednesday, May 16, 2018 5:12 AM
>> To: Linux ACPI <linux-acpi@vger.kernel.org>
>> Cc: Zhang, Rui <rui.zhang@intel.com>; Linux PM <linux-
>> pm@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>; Schmauss, Erik
>> <erik.schmauss@intel.com>; Moore, Robert <robert.moore@intel.com>; Wang,
>> Wendy <wendy.wang@intel.com>
>> Subject: [PATCH 1/2] ACPICA: Introduce acpi_dispatch_gpe()
>>
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Introduce acpi_dispatch_gpe() as a wrapper around acpi_ev_detect_gpe()
>> for checking if the given GPE (as represented by a GPE device handle and
>> a GPE number) is currently active and dispatching it (if that's the
>> case) outside of interrupt context.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/acpi/acpica/evgpe.c   |    6 ++++++
>>  drivers/acpi/acpica/evxfgpe.c |   22 ++++++++++++++++++++++
>>  include/acpi/acpixf.h         |    1 +
>>  3 files changed, 29 insertions(+)
>>
>> Index: linux-pm/drivers/acpi/acpica/evgpe.c
>> ===================================================================
>> --- linux-pm.orig/drivers/acpi/acpica/evgpe.c
>> +++ linux-pm/drivers/acpi/acpica/evgpe.c
>> @@ -634,6 +634,12 @@ acpi_ev_detect_gpe(struct acpi_namespace
>>
>>       flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
>>
>> +     if (!gpe_event_info) {
>> +             gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device,
>> gpe_number);
>> +             if (!gpe_event_info)
>> +                     goto error_exit;
>> +     }
>> +
>>       /* Get the info block for the entire GPE register */
>>
>>       gpe_register_info = gpe_event_info->register_info;
>> Index: linux-pm/drivers/acpi/acpica/evxfgpe.c
>> ===================================================================
>> --- linux-pm.orig/drivers/acpi/acpica/evxfgpe.c
>> +++ linux-pm/drivers/acpi/acpica/evxfgpe.c
>> @@ -639,6 +639,28 @@ ACPI_EXPORT_SYMBOL(acpi_get_gpe_status)
>>
>>
>> /***********************************************************************
>> ********
>>   *
>> + * FUNCTION:    acpi_gispatch_gpe
>> + *
>> + * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for
>> GPE0/GPE1
>> + *              gpe_number          - GPE level within the GPE block
>> + *
>> + * RETURN:      None
>> + *
>> + * DESCRIPTION: Detect and dispatch a General Purpose Event to either a
>> function
>> + *              (e.g. EC) or method (e.g. _Lxx/_Exx) handler.
>> + *
>> +
>> +***********************************************************************
>> +*******/ void acpi_dispatch_gpe(acpi_handle gpe_device, u32 gpe_number)
>> +{
>> +     ACPI_FUNCTION_TRACE(acpi_dispatch_gpe);
>> +
>> +     acpi_ev_detect_gpe(gpe_device, NULL, gpe_number); }
>> +
>> +ACPI_EXPORT_SYMBOL(acpi_dispatch_gpe)
>> +
>> +/**********************************************************************
>> +*********
>> + *
>>   * FUNCTION:    acpi_finish_gpe
>>   *
>>   * PARAMETERS:  gpe_device          - Namespace node for the GPE Block
>> Index: linux-pm/include/acpi/acpixf.h
>> ===================================================================
>> --- linux-pm.orig/include/acpi/acpixf.h
>> +++ linux-pm/include/acpi/acpixf.h
>> @@ -753,6 +753,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_sta
>>                                                    u32 gpe_number,
>>                                                    acpi_event_status
>>                                                    *event_status))
>> +void acpi_dispatch_gpe(acpi_handle gpe_device, u32 gpe_number);
>>  ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
>> acpi_disable_all_gpes(void))
>> ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
>> acpi_enable_all_runtime_gpes(void))
>>  ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
>> acpi_enable_all_wakeup_gpes(void))
>
