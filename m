From: Mark Salyzyn <salyzyn@android.com>
Subject: Re: PM / Suspend: Print wall time at suspend entry and exit
Date: Mon, 5 Jun 2017 15:10:52 -0700
Message-ID: <ca5fb419-386f-9e27-43c4-677be6f0ae4b@android.com>
References: <20170605193157.59875-1-salyzyn@android.com>
 <CAJZ5v0iLFw68RxzkgyFF_WhxO-nzr0nWoZjq-uEEU6+UzMB7cQ@mail.gmail.com>
 <20170605211835.GB9035@amd>
 <5931f9cb-016f-4163-4908-6825cf84b9d3@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33473 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbdFEWKy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2017 18:10:54 -0400
Received: by mail-pg0-f49.google.com with SMTP id f185so26077963pgc.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Jun 2017 15:10:54 -0700 (PDT)
In-Reply-To: <5931f9cb-016f-4163-4908-6825cf84b9d3@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Todd Poynor <toddpoynor@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>

On 06/05/2017 02:47 PM, Mark Salyzyn wrote:
> On 06/05/2017 02:18 PM, Pavel Machek wrote:
>> Hi!
>>
>>> On Mon, Jun 5, 2017 at 9:31 PM, Mark Salyzyn <salyzyn@android.com> 
>>> wrote:
>>>> Permits power state and battery life diagnosis.
>>> Which is possible even without this patch and we have tools for that
>>> (analyze_suspend.py, anyone?).
>>>
>>> Honestly, I don't see why this change is necessary or even useful.
>> I ran dmesg after resume and now I...
>>
>> [1019729.486249] ACPI : EC: EC stopped
>> [1019729.486255] PM: Saving platform NVS memory
>> [1019729.486276] Disabling non-boot CPUs ...
>> [1019729.490423] smpboot: CPU 1 is now offline
>> [1019729.531015] smpboot: CPU 2 is now offline
>> [1019729.577742] Broke affinity for irq 16
>> [1019729.577747] Broke affinity for irq 17
>> [1019729.577751] Broke affinity for irq 19
>> [1019729.577756] Broke affinity for irq 23
>> [1019729.578771] smpboot: CPU 3 is now offline
>> [1019729.604987] ACPI: Low-level resume complete
>> [1019729.605052] ACPI : EC: EC started
>> [1019729.605054] PM: Restoring platform NVS memory
>> [1019729.605352] Suspended for 3196.166 seconds
>> [1019729.605376] Enabling non-boot CPUs ...
>> [1019729.631246] x86: Booting SMP configuration:
>> [1019729.631249] smpboot: Booting Node 0 Processor 1 APIC 0x1
>> [1019729.631496] Initializing CPU#1
>> [1019729.631514] Disabled fast string operations
>> [1019729.636643]  cache: parent cpu1 should not be sleeping
>> [1019729.637286] CPU1 is up
>>
>> Aha. I missed the "suspended for 3196" message before. So I believe
>> you are right; there's already enough information in the kernel logs.
>>
>>                                     Pavel
>
> We do not get the Suspended for messages on failure to suspend 
> (interrupt wakeup), but that is a weak argument ;-/ since it is 
> discoverable from context and we can count the aborted suspends 
> switching the tools. The Suspended for messages are in ms which is not 
> accurate enough for Android user space logs (in ns) long term 
> continuous tracking of monotonic vs realtime and makes no accounting 
> for ntp adjustments. Currently, post mortem data only on Android, we 
> have no other way to align monotonic kernel logs with user space logs 
> without this.
>
> Sincerely -- Mark Salyzyn
>
Also, not all devices have a persistent time that can be collected at 
Suspend at that level, so they have to turn off CONFIG_SUSPEND_TIME 
because 'Suspended for' is meaningless on those platforms, but alas 
these prints turn into a backup mechanism for those platforms as they 
are printed befopre and after the hardware is up and running.

-- Mark
