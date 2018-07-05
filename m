From: =?UTF-8?Q?Thomas_H=c3=a4nig?= <haenig@cosifan.de>
Subject: Re: [REGRESSION 4.17] Spurious wakeup / reboot with power button
Date: Thu, 5 Jul 2018 16:00:14 +0200
Message-ID: <da324a44-9520-db81-2106-146d98431a54@cosifan.de>
References: <s5hk1qaf9hv.wl-tiwai@suse.de>
 <CAJZ5v0guCPET3gM-G_NAM-BjER2D3yW2i_CwR-5sHyNzCQ6R+Q@mail.gmail.com>
 <s5hk1qaui3w.wl-tiwai@suse.de> <1999215.6UrMtQZ5Bj@aspire.rjw.lan>
 <s5ha7r5vq2r.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5ha7r5vq2r.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Am 05.07.2018 um 14:12 schrieb Takashi Iwai:
> On Thu, 05 Jul 2018 12:41:03 +0200,
> Rafael J. Wysocki wrote:
>>
>> On Thursday, July 5, 2018 11:50:11 AM CEST Takashi Iwai wrote:
>>> On Thu, 05 Jul 2018 11:34:59 +0200,
>>> Rafael J. Wysocki wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Thu, Jul 5, 2018 at 9:05 AM, Takashi Iwai <tiwai@suse.de> wrote:
>>>>> Hi,
>>>>>
>>>>> we've got a regression report since 4.17 about the behavior of
>>>>> power-off with the power button.  When a machine is powered off with
>>>>> the power button on desktop, it reboots after a few seconds instead of
>>>>> power down.
>>>>>
>>>>> The manual power down via "systemctl poweroff" works fine, so it's
>>>>> possibly some spurious wakeup by the power button action, and some
>>>>> ACPI-related change is suspected.
>>>>> The regression still remains in 4.18-rc3.
>>>>
>>>> There are only a few ACPI commits directly related to power management
>>>> between 4.16 and 4.17 and none of them looks particularly suspicious.
>>>
>>> OK, interesting.
>>>
>>>> It looks like the power button state may not be cleared sufficiently
>>>> after it's been pressed which is now visible for some reason.
>>>
>>> Hmm, where can such a state remain?  Since it happens after the
>>> machine turned off, some (ACPI) wakeup bits?
>>
>> Basically, yes.
>>
>> It looks like a GPE may remain active which then triggers wakeup after
>> shutdown.
>>
>> On a hunch, I'm wondering if reverting commit
>>
>> 18996f2db918 ACPICA: Events: Stop unconditionally clearing ACPI IRQs during suspend/resume
>>
>> (may not revert clearly, though) makes any difference.
> 
> OK, I'm building a 4.17.x test kernel with that revert, in OBS
> home:tiwai:bsc1099930 repo.
> 
> Thomas, could you try later the kernel in
>   http://download.opensuse.org/repositories/home:/tiwai:/bsc1099930/standard/
> ?  It'll take an hour or so until the build finishes.

With your new built kernel
4.17.4-1.g6f23755-default

the power button works again, so the revert solved the problem

Thanks
Thomas
