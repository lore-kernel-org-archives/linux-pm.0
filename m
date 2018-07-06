From: =?UTF-8?Q?Thomas_H=c3=a4nig?= <haenig@cosifan.de>
Subject: Re: [REGRESSION 4.17] Spurious wakeup / reboot with power button
Date: Fri, 6 Jul 2018 19:57:06 +0200
Message-ID: <c04bb990-8921-90c5-e298-bf68e3c9cd33@cosifan.de>
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
> 
>>
>> ---
>>  drivers/acpi/acpica/hwsleep.c |   15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> Index: linux-pm/drivers/acpi/acpica/hwsleep.c
>> ===================================================================
>> --- linux-pm.orig/drivers/acpi/acpica/hwsleep.c
>> +++ linux-pm/drivers/acpi/acpica/hwsleep.c
>> @@ -51,16 +51,23 @@ acpi_status acpi_hw_legacy_sleep(u8 slee
>>  		return_ACPI_STATUS(status);
>>  	}
>>  
>> -	/*
>> -	 * 1) Disable all GPEs
>> -	 * 2) Enable all wakeup GPEs
>> -	 */
>> +	/* Disable all GPEs */
>>  	status = acpi_hw_disable_all_gpes();
>>  	if (ACPI_FAILURE(status)) {
>>  		return_ACPI_STATUS(status);
>>  	}
>> +	/*
>> +	 * If the target sleep state is S5, clear all GPEs and fixed events too
>> +	 */
>> +	if (sleep_state == ACPI_STATE_S5) {
>> +		status = acpi_hw_clear_acpi_status();
>> +		if (ACPI_FAILURE(status)) {
>> +			return_ACPI_STATUS(status);
>> +		}
>> +	}
>>  	acpi_gbl_system_awake_and_running = FALSE;
>>  
>> +	 /* Enable all wakeup GPEs */
>>  	status = acpi_hw_enable_all_wakeup_gpes();
>>  	if (ACPI_FAILURE(status)) {
>>  		return_ACPI_STATUS(status);
>>
Hello Takashi,
with the kernel built by you the system shuts down when pressing the
power button and stays off too!  :-)

So the above mentioned patch to hwsleep.c seems to do the trick.

Regards and thanks a lot @all!
Thomas

thomas@tslb:~> uname -a
Linux tslb 4.17.4-2.g2351e2d-default #1 SMP PREEMPT Fri Jul 6 12:24:35
UTC 2018 (2351e2d) x86_64 x86_64 x86_64 GNU/Linux


thomas@tslb:~> rpm -qi kernel-default-4.17.4-2.1.g2351e2d.x86_64
Name        : kernel-default
Version     : 4.17.4
Release     : 2.1.g2351e2d
Architecture: x86_64
Install Date: Fr 06 Jul 2018 19:43:38 CEST
Group       : System/Kernel
Size        : 360100489
License     : GPL-2.0
Signature   : RSA/SHA256, Fr 06 Jul 2018 16:47:25 CEST, Key ID
4bf05f46f6e74bf5
Source RPM  : kernel-default-4.17.4-2.1.g2351e2d.nosrc.rpm
Build Date  : Fr 06 Jul 2018 16:42:04 CEST
Build Host  : lamb63
Relocations : (not relocatable)
Vendor      : obs://build.opensuse.org/home:tiwai
URL         : http://www.kernel.org/
Summary     : The Standard Kernel
Description :
The standard kernel for both uniprocessor and multiprocessor systems.

Source Timestamp: 2018-07-06 14:24:35 +0200
GIT Revision: 2351e2d70cbcb963c461d55abeee967ea9a940ea
GIT Branch: users/tiwai/stable/bsc1099930
Distribution: home:tiwai:bsc1099930-3
