From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [REGRESSION 4.17] Spurious wakeup / reboot with power button
Date: Sun, 8 Jul 2018 10:18:22 +0200
Message-ID: <CAJZ5v0ipP8JP01L7E4FwL1K6woda4oBKMxgLRfOiNYujzoY37w@mail.gmail.com>
References: <s5hk1qaf9hv.wl-tiwai@suse.de> <7049b672-859c-e049-a391-f66e4336d4a9@cosifan.de>
 <CAJZ5v0ikijT8MRHRsTAZ=FGPbkTu4QeJENBCeaa7BDP_E964UQ@mail.gmail.com>
 <1704080.gFTvVrrZA1@aspire.rjw.lan> <s5hbmbksg6f.wl-tiwai@suse.de> <c04bb990-8921-90c5-e298-bf68e3c9cd33@cosifan.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c04bb990-8921-90c5-e298-bf68e3c9cd33@cosifan.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Thomas_H=C3=A4nig?= <haenig@cosifan.de>
Cc: Takashi Iwai <tiwai@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Erik Schmauss <erik.schmauss@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 6, 2018 at 7:57 PM, Thomas H=C3=A4nig <haenig@cosifan.de> wrote=
:
>
>
> Am 06.07.2018 um 14:27 schrieb Takashi Iwai:
>> On Fri, 06 Jul 2018 14:13:04 +0200,
>> Rafael J. Wysocki wrote:
>>>
>>> On Friday, July 6, 2018 1:21:50 PM CEST Rafael J. Wysocki wrote:
>>>> On Fri, Jul 6, 2018 at 1:12 PM, Thomas H=C3=A4nig <haenig@cosifan.de> =
wrote:
>>>
>>> [cut]
>>>
>>>> So the latest patch:
>>>>
>>>> https://patchwork.kernel.org/patch/10511211/
>>>>
>>>> should work for you (please verify) and the change in
>>>> drivers/acpi/sleep.c in it most likely is not necessary.
>>>>
>>>> If you can confirm that this one works for you, I'll send a smaller
>>>> one with the acpi_hw_legacy_sleep() part alone.
>>>
>>> Well, scratch this, sorry.
>>>
>>> The power button probably is a fixed event and it won't be effected by
>>> that patch.
>>>
>>> Instead, please test the patch below.
>>
>> FWIW, the test kernel on OBS home:tiwai:bsc1099930-3 was refreshed
>> with this one.  The release number will be *.g2351e2d.
>>
>>
>> Takashi
>>
>>>
>>> ---
>>>  drivers/acpi/acpica/hwsleep.c |   15 +++++++++++----
>>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>>
>>> Index: linux-pm/drivers/acpi/acpica/hwsleep.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- linux-pm.orig/drivers/acpi/acpica/hwsleep.c
>>> +++ linux-pm/drivers/acpi/acpica/hwsleep.c
>>> @@ -51,16 +51,23 @@ acpi_status acpi_hw_legacy_sleep(u8 slee
>>>              return_ACPI_STATUS(status);
>>>      }
>>>
>>> -    /*
>>> -     * 1) Disable all GPEs
>>> -     * 2) Enable all wakeup GPEs
>>> -     */
>>> +    /* Disable all GPEs */
>>>      status =3D acpi_hw_disable_all_gpes();
>>>      if (ACPI_FAILURE(status)) {
>>>              return_ACPI_STATUS(status);
>>>      }
>>> +    /*
>>> +     * If the target sleep state is S5, clear all GPEs and fixed event=
s too
>>> +     */
>>> +    if (sleep_state =3D=3D ACPI_STATE_S5) {
>>> +            status =3D acpi_hw_clear_acpi_status();
>>> +            if (ACPI_FAILURE(status)) {
>>> +                    return_ACPI_STATUS(status);
>>> +            }
>>> +    }
>>>      acpi_gbl_system_awake_and_running =3D FALSE;
>>>
>>> +     /* Enable all wakeup GPEs */
>>>      status =3D acpi_hw_enable_all_wakeup_gpes();
>>>      if (ACPI_FAILURE(status)) {
>>>              return_ACPI_STATUS(status);
>>>
> Hello Takashi,
> with the kernel built by you the system shuts down when pressing the
> power button and stays off too!  :-)
>
> So the above mentioned patch to hwsleep.c seems to do the trick.

OK, thanks for verifying!

> Regards and thanks a lot @all!

Cheers,
Rafael
