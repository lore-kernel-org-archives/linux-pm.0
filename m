From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [REGRESSION 4.17] Spurious wakeup / reboot with power button
Date: Fri, 6 Jul 2018 13:21:50 +0200
Message-ID: <CAJZ5v0ikijT8MRHRsTAZ=FGPbkTu4QeJENBCeaa7BDP_E964UQ@mail.gmail.com>
References: <s5hk1qaf9hv.wl-tiwai@suse.de> <s5hk1q9u3cf.wl-tiwai@suse.de>
 <CAJZ5v0jgYmxu5S8JBJdtDn3MFDAroig=ZhK=V4Ec9iELZSfP6w@mail.gmail.com>
 <3165315.C5RQ1k0pt5@aspire.rjw.lan> <s5hd0w1fwoq.wl-tiwai@suse.de>
 <5cce6fa6-c089-7a6b-aaef-bdd04a3761c6@cosifan.de> <s5hr2kgetux.wl-tiwai@suse.de>
 <7049b672-859c-e049-a391-f66e4336d4a9@cosifan.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7049b672-859c-e049-a391-f66e4336d4a9@cosifan.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Thomas_H=C3=A4nig?= <haenig@cosifan.de>
Cc: Takashi Iwai <tiwai@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Erik Schmauss <erik.schmauss@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 6, 2018 at 1:12 PM, Thomas H=C3=A4nig <haenig@cosifan.de> wrote=
:
> Am 06.07.2018 um 08:55 schrieb Takashi Iwai:
>> On Fri, 06 Jul 2018 07:18:36 +0200,
>> Thomas H4nig wrote:
>>>
>>>
>>>
>>> Am 05.07.2018 um 18:56 schrieb Takashi Iwai:
>>>> On Thu, 05 Jul 2018 18:02:11 +0200,
>>>> Rafael J. Wysocki wrote:
>>>>>
>>>>> [The Lv's address is not valid any more, so drop it from the CC]
>>>>>
>>>>> On Thursday, July 5, 2018 5:10:20 PM CEST Rafael J. Wysocki wrote:
>>>>>> On Thu, Jul 5, 2018 at 5:09 PM, Takashi Iwai <tiwai@suse.de> wrote:
>>>>>>> On Thu, 05 Jul 2018 16:00:14 +0200,
>>>>>>> Thomas H4nig wrote:
>>>>>>>>
>>>>>>>> Am 05.07.2018 um 14:12 schrieb Takashi Iwai:
>>>>>>>>> On Thu, 05 Jul 2018 12:41:03 +0200,
>>>>>>>>> Rafael J. Wysocki wrote:
>>>>>>>>>>
>>>>>>>>>> On Thursday, July 5, 2018 11:50:11 AM CEST Takashi Iwai wrote:
>>>>>>>>>>> On Thu, 05 Jul 2018 11:34:59 +0200,
>>>>>>>>>>> Rafael J. Wysocki wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Hi,
>>>>>>>>>>>>
>>>>>>>>>>>> On Thu, Jul 5, 2018 at 9:05 AM, Takashi Iwai <tiwai@suse.de> w=
rote:
>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>
>>>>>>>>>>>>> we've got a regression report since 4.17 about the behavior o=
f
>>>>>>>>>>>>> power-off with the power button.  When a machine is powered o=
ff with
>>>>>>>>>>>>> the power button on desktop, it reboots after a few seconds i=
nstead of
>>>>>>>>>>>>> power down.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The manual power down via "systemctl poweroff" works fine, so=
 it's
>>>>>>>>>>>>> possibly some spurious wakeup by the power button action, and=
 some
>>>>>>>>>>>>> ACPI-related change is suspected.
>>>>>>>>>>>>> The regression still remains in 4.18-rc3.
>>>>>>>>>>>>
>>>>>>>>>>>> There are only a few ACPI commits directly related to power ma=
nagement
>>>>>>>>>>>> between 4.16 and 4.17 and none of them looks particularly susp=
icious.
>>>>>>>>>>>
>>>>>>>>>>> OK, interesting.
>>>>>>>>>>>
>>>>>>>>>>>> It looks like the power button state may not be cleared suffic=
iently
>>>>>>>>>>>> after it's been pressed which is now visible for some reason.
>>>>>>>>>>>
>>>>>>>>>>> Hmm, where can such a state remain?  Since it happens after the
>>>>>>>>>>> machine turned off, some (ACPI) wakeup bits?
>>>>>>>>>>
>>>>>>>>>> Basically, yes.
>>>>>>>>>>
>>>>>>>>>> It looks like a GPE may remain active which then triggers wakeup=
 after
>>>>>>>>>> shutdown.
>>>>>>>>>>
>>>>>>>>>> On a hunch, I'm wondering if reverting commit
>>>>>>>>>>
>>>>>>>>>> 18996f2db918 ACPICA: Events: Stop unconditionally clearing ACPI =
IRQs during suspend/resume
>>>>>>>>>>
>>>>>>>>>> (may not revert clearly, though) makes any difference.
>>>>>>>>>
>>>>>>>>> OK, I'm building a 4.17.x test kernel with that revert, in OBS
>>>>>>>>> home:tiwai:bsc1099930 repo.
>>>>>>>>>
>>>>>>>>> Thomas, could you try later the kernel in
>>>>>>>>>   http://download.opensuse.org/repositories/home:/tiwai:/bsc10999=
30/standard/
>>>>>>>>> ?  It'll take an hour or so until the build finishes.
>>>>>>>>
>>>>>>>> With your new built kernel
>>>>>>>> 4.17.4-1.g6f23755-default
>>>>>>>>
>>>>>>>> the power button works again, so the revert solved the problem
>>>>>>>
>>>>>>> Thanks, that clarifies the cause.
>>>>>>> Adding Erik and Lv to Cc.
>>>>>>>
>>>>>>> I guess it's the side-effect by removing
>>>>>>>         acpi_ev_walk_gpe_list(acpi_hw_clear_gpe_block, NULL);
>>>>>>> in acpi_hw_disable_all_gpes().
>>>>>>>
>>>>>>> This function is called from acpi_power_off_prepare(), and the mach=
ine
>>>>>>> goes to power off without clearing the GPEs, hence it's woken up la=
ter
>>>>>>> unexpectedly.
>>>>>>
>>>>>> That's correct.
>>>>>>
>>>>>> We need to fix up that commit.  I'll try to prepare something.
>>>>>>
>>>>>
>>>>> Below is a patch to test that theory and maybe fix things if it is co=
rrect.
>>>>>
>>>>> What it does is to clear all GPEs after disabling them in
>>>>> acpi_power_off_prepare() which should address the issue if our theory
>>>>> about the underlying reason is correct.
>>>>>
>>>>> Please test.
>>>>
>>>> OK, building a new test kernel package in OBS home:tiwai:bsc1099930-2
>>>> repo.  It'll appear at
>>>>   http://download.opensuse.org/repositories/home:/tiwai:/bsc1099930-2/=
standard/
>>>>
>>>> Thomas, please give it a try later.
>>>>
>>>>
>>>> thanks,
>>>>
>>>> Takashi
>>>
>>> I am sorry, but with your test kernel 4.17.4-1.g76c6238-default the
>>> notebook again gets not properly powered off but restarts
>>
>> Interesting.  The package version shows that the tested kernel must be
>> the right one.  (Though, it'd be good to double-check -- it's often
>> confusing if you have multiple same kernel versions on the system.)
>>
>> If Rafael's patch doesn't work, we'd need to identify which change in
>> the commit 18996f2db918 has the effect.
>>
>> Thomas, could you try to build & modify the kernel in your side?
>> Package build on OBS and test takes too long.
>>
>> There are three places that remove the GPE-clearing in the patch.
>>
>> One is in acpi_ev_enable_gpe():
>>
>> --- a/drivers/acpi/acpica/evgpe.c
>> +++ b/drivers/acpi/acpica/evgpe.c
>> @@ -115,13 +115,6 @@ acpi_status acpi_ev_enable_gpe(struct acpi_gpe_even=
t_info *gpe_event_info)
>>
>>       ACPI_FUNCTION_TRACE(ev_enable_gpe);
>>
>> -     /* Clear the GPE (of stale events) */
>> -
>> -     status =3D acpi_hw_clear_gpe(gpe_event_info);
>> -     if (ACPI_FAILURE(status)) {
>> -             return_ACPI_STATUS(status);
>> -     }
>> -
>>       /* Enable the requested GPE */
>>
>>       status =3D acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
>>
>>
>> ... the second one is in acpi_hw_disable_all_gpes():
>>
>> --- a/drivers/acpi/acpica/hwgpe.c
>> +++ b/drivers/acpi/acpica/hwgpe.c
>> @@ -497,7 +497,6 @@ acpi_status acpi_hw_disable_all_gpes(void)
>>       ACPI_FUNCTION_TRACE(hw_disable_all_gpes);
>>
>>       status =3D acpi_ev_walk_gpe_list(acpi_hw_disable_gpe_block, NULL);
>> -     status =3D acpi_ev_walk_gpe_list(acpi_hw_clear_gpe_block, NULL);
>>       return_ACPI_STATUS(status);
>>  }
>>
>>
>> ... and the last one is in acpi_hw_legacy_sleep():
>>
>> --- a/drivers/acpi/acpica/hwsleep.c
>> +++ b/drivers/acpi/acpica/hwsleep.c
>> @@ -85,15 +85,8 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
>>               return_ACPI_STATUS(status);
>>       }
>>
>> -     /* Clear all fixed and general purpose status bits */
>> -
>> -     status =3D acpi_hw_clear_acpi_status();
>> -     if (ACPI_FAILURE(status)) {
>> -             return_ACPI_STATUS(status);
>> -     }
>> -
>>       /*
>>        * 1) Disable/Clear all GPEs
>>
>>
>> The rest are only comments changes.
>>
>> Try to revert each hunk manually one-by-one and figure out which one
>> actually causes the regression.  Maybe it'd be safer to test on the
>> 4.17.x kernel, but you can check on 4.18-rc, too.
>>
>
> I am finally through and have results with patch(es) reverted for kernel
> 4.17.3-1-default:
>
> 1 - reboot
> 2 - reboot
> 3 - poweroff
>
> being
> #1 - evgpe.c
> #2 - hwgpe.c
> #3 - hwsleep.c
>
> whereas the revert failed at #3 and I tried it manually, resulting in
>
> whereas the revert failed at #3 and I tried it manually, resulting in
>
> --- drivers/acpi/acpica/hwsleep.c       2018-07-06 12:56:07.881379862 +02=
00
> +++ drivers/acpi/acpica/hwsleep.c.orig  2018-06-26 08:45:20.000000000 +02=
00
> @@ -51,13 +51,6 @@ acpi_status acpi_hw_legacy_sleep(u8 slee
>                 return_ACPI_STATUS(status);
>         }
>
> -       /* Clear all fixed and general purpose status bits */
> -
> -       status =3D acpi_hw_clear_acpi_status();
> -       if (ACPI_FAILURE(status)) {
> -               return_ACPI_STATUS(status);
> -       }
> -
>         /*
>          * 1) Disable all GPEs
>          * 2) Enable all wakeup GPEs
>
> --

OK, thanks!

So the latest patch:

https://patchwork.kernel.org/patch/10511211/

should work for you (please verify) and the change in
drivers/acpi/sleep.c in it most likely is not necessary.

If you can confirm that this one works for you, I'll send a smaller
one with the acpi_hw_legacy_sleep() part alone.

Thanks,
Rafael
