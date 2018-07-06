From: =?UTF-8?Q?Thomas_H=c3=a4nig?= <haenig@cosifan.de>
Subject: Re: [REGRESSION 4.17] Spurious wakeup / reboot with power button
Date: Fri, 6 Jul 2018 14:53:20 +0200
Message-ID: <f1cfb12a-f099-059c-5c8d-e42a9fa3f851@cosifan.de>
References: <s5hk1qaf9hv.wl-tiwai@suse.de>
 <7049b672-859c-e049-a391-f66e4336d4a9@cosifan.de>
 <CAJZ5v0ikijT8MRHRsTAZ=FGPbkTu4QeJENBCeaa7BDP_E964UQ@mail.gmail.com>
 <1704080.gFTvVrrZA1@aspire.rjw.lan> <s5hbmbksg6f.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hbmbksg6f.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Erik Schmauss <erik.schmauss@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Am 06.07.2018 um 14:27 schrieb Takashi Iwai:
> On Fri, 06 Jul 2018 14:13:04 +0200,
> Rafael J. Wysocki wrote:
>>
>> On Friday, July 6, 2018 1:21:50 PM CEST Rafael J. Wysocki wrote:
>>> On Fri, Jul 6, 2018 at 1:12 PM, Thomas Hänig <haenig@cosifan.de> wrote:
>>
>> [cut]
>>  
>>> So the latest patch:
>>>
>>> https://patchwork.kernel.org/patch/10511211/
>>>
>>> should work for you (please verify) and the change in
>>> drivers/acpi/sleep.c in it most likely is not necessary.
>>>
>>> If you can confirm that this one works for you, I'll send a smaller
>>> one with the acpi_hw_legacy_sleep() part alone.
>>
>> Well, scratch this, sorry.
>>
>> The power button probably is a fixed event and it won't be effected by
>> that patch.
>>
>> Instead, please test the patch below.
> 
> FWIW, the test kernel on OBS home:tiwai:bsc1099930-3 was refreshed
> with this one.  The release number will be *.g2351e2d.
> 
> 
> Takashi

to make shure I have made no mistake while building my own, I will try
out your kernel as well.

Thomas
