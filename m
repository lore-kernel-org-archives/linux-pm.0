From: =?UTF-8?Q?Thomas_H=c3=a4nig?= <haenig@cosifan.de>
Subject: Re: [REGRESSION 4.17] Spurious wakeup / reboot with power button
Date: Thu, 5 Jul 2018 20:18:29 +0200
Message-ID: <69b98b03-4dbf-3a8d-6ae3-b9a6ffc92f0a@cosifan.de>
References: <s5hk1qaf9hv.wl-tiwai@suse.de> <s5hk1q9u3cf.wl-tiwai@suse.de>
 <CAJZ5v0jgYmxu5S8JBJdtDn3MFDAroig=ZhK=V4Ec9iELZSfP6w@mail.gmail.com>
 <3165315.C5RQ1k0pt5@aspire.rjw.lan> <s5hd0w1fwoq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hd0w1fwoq.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Erik Schmauss <erik.schmauss@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Am 05.07.2018 um 18:56 schrieb Takashi Iwai:
> On Thu, 05 Jul 2018 18:02:11 +0200,
> Rafael J. Wysocki wrote:
>>
>> [The Lv's address is not valid any more, so drop it from the CC]
>>
>> On Thursday, July 5, 2018 5:10:20 PM CEST Rafael J. Wysocki wrote:
>>> On Thu, Jul 5, 2018 at 5:09 PM, Takashi Iwai <tiwai@suse.de> wrote:
>>>> On Thu, 05 Jul 2018 16:00:14 +0200,
>>>> Thomas H4nig wrote:
>>>>>
>>>>> Am 05.07.2018 um 14:12 schrieb Takashi Iwai:
>>>>>> On Thu, 05 Jul 2018 12:41:03 +0200,
>>>>>> Rafael J. Wysocki wrote:
>>>>>>>
>>>>>>> On Thursday, July 5, 2018 11:50:11 AM CEST Takashi Iwai wrote:
>>>>>>>> On Thu, 05 Jul 2018 11:34:59 +0200,
>>>>>>>> Rafael J. Wysocki wrote:
>>>>>>>>>
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> On Thu, Jul 5, 2018 at 9:05 AM, Takashi Iwai <tiwai@suse.de> wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> we've got a regression report since 4.17 about the behavior of
>>>>>>>>>> power-off with the power button.  When a machine is powered off with
>>>>>>>>>> the power button on desktop, it reboots after a few seconds instead of
>>>>>>>>>> power down.
>>>>>>>>>>
>>>>>>>>>> The manual power down via "systemctl poweroff" works fine, so it's
>>>>>>>>>> possibly some spurious wakeup by the power button action, and some
>>>>>>>>>> ACPI-related change is suspected.
>>>>>>>>>> The regression still remains in 4.18-rc3.
>>>>>>>>>
>>>>>>>>> There are only a few ACPI commits directly related to power management
>>>>>>>>> between 4.16 and 4.17 and none of them looks particularly suspicious.
>>>>>>>>
>>>>>>>> OK, interesting.
>>>>>>>>
>>>>>>>>> It looks like the power button state may not be cleared sufficiently
>>>>>>>>> after it's been pressed which is now visible for some reason.
>>>>>>>>
>>>>>>>> Hmm, where can such a state remain?  Since it happens after the
>>>>>>>> machine turned off, some (ACPI) wakeup bits?
>>>>>>>
>>>>>>> Basically, yes.
>>>>>>>
>>>>>>> It looks like a GPE may remain active which then triggers wakeup after
>>>>>>> shutdown.
>>>>>>>
>>>>>>> On a hunch, I'm wondering if reverting commit
>>>>>>>
>>>>>>> 18996f2db918 ACPICA: Events: Stop unconditionally clearing ACPI IRQs during suspend/resume
>>>>>>>
>>>>>>> (may not revert clearly, though) makes any difference.
>>>>>>
>>>>>> OK, I'm building a 4.17.x test kernel with that revert, in OBS
>>>>>> home:tiwai:bsc1099930 repo.
>>>>>>
>>>>>> Thomas, could you try later the kernel in
>>>>>>    http://download.opensuse.org/repositories/home:/tiwai:/bsc1099930/standard/
>>>>>> ?  It'll take an hour or so until the build finishes.
>>>>>
>>>>> With your new built kernel
>>>>> 4.17.4-1.g6f23755-default
>>>>>
>>>>> the power button works again, so the revert solved the problem
>>>>
>>>> Thanks, that clarifies the cause.
>>>> Adding Erik and Lv to Cc.
>>>>
>>>> I guess it's the side-effect by removing
>>>>          acpi_ev_walk_gpe_list(acpi_hw_clear_gpe_block, NULL);
>>>> in acpi_hw_disable_all_gpes().
>>>>
>>>> This function is called from acpi_power_off_prepare(), and the machine
>>>> goes to power off without clearing the GPEs, hence it's woken up later
>>>> unexpectedly.
>>>
>>> That's correct.
>>>
>>> We need to fix up that commit.  I'll try to prepare something.
>>>
>>
>> Below is a patch to test that theory and maybe fix things if it is correct.
>>
>> What it does is to clear all GPEs after disabling them in
>> acpi_power_off_prepare() which should address the issue if our theory
>> about the underlying reason is correct.
>>
>> Please test.
> 
> OK, building a new test kernel package in OBS home:tiwai:bsc1099930-2
> repo.  It'll appear at
>    http://download.opensuse.org/repositories/home:/tiwai:/bsc1099930-2/standard/
> 
> Thomas, please give it a try later.
> 
> 
> thanks,
> 
> Takashi

Later will have to be tomorrow morning (07:00 UTC+2) as until then I 
have no access to the machine in question.


Thanks
Thomas
