From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCHv v3] power: Include additional information in pm_print_times
Date: Sat, 22 Jun 2013 00:58:28 +0000
Message-ID: <B8EFE96D1287C24090BAD9D858E15E6172EFEE@sisaex02sj>
References: <1371497795-20084-1-git-send-email-shuah.kh@samsung.com>
 <2534796.mOHH0DCD2A@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "pavel@ucw.cz" <pavel@ucw.cz>, "len.brown@intel.com" <len.brown@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "joe@perches.com" <joe@perches.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>, Shuah Khan <shuah.kh@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 06/21/2013 06:15 PM, Rafael J. Wysocki wrote:
> On Monday, June 17, 2013 01:36:35 PM Shuah Khan wrote:
>> Change __device_suspend() path to include driver name and the ops that
>> get run for a device. This additional information helps associate the
>> driver and the type of pm_ops the device uses in the suspend path very
>> quickly, which will aid in debugging problems in suspend and resume paths.
>> Changed both start and end debug messages to include pm_ops information
>> and use dev_info() instead of pr_info(). Changed the end message to include
>> parent device information and have the same format as the start message.
>>
>> dmesg output before the change:
>>
>> [  164.390032] calling  1-1+ @ 69, parent: usb1
>> [  164.390035] call 1-1+ returned 0 after 0 usecs
>>
>> [  164.390352] calling  00:0a+ @ 2457, parent: pnp0
>> [  164.390357] call 00:0a+ returned 0 after 3 usecs
>>
>> [  164.390361] calling  00:09+ @ 2457, parent: pnp0
>> [  164.496458] call 00:09+ returned 0 after 103500 usecs
>>
>> [  164.496494] calling  00:05+ @ 2457, parent: pnp0
>> [  164.496511] call 00:05+ returned 0 after 14 usecs
>>
>> dmesg output after the change:
>>
>> [  545.985394] usb 1-1: Start: type pm ops @ 68, parent: usb1
>> [  545.987650] usb 1-1: End  : type pm ops @ 68, parent: usb1 time(2184 usecs) err(0)
>>
>> [  545.982544] system 00:0a: Start: legacy bus pm ops @ 2391, parent: pnp0
>> [  545.982554] system 00:0a: End  : legacy bus pm ops @ 2391, parent: pnp0 time(4 usecs) err(0)
>>
>> [  545.982569] tpm_tis 00:09: Start: legacy bus pm ops @ 2391, parent: pnp0
>> [  546.087017] tpm_tis 00:09: End  : legacy bus pm ops @ 2391, parent: pnp0 time(101936 usecs) err(0)
>>
>> [  546.087069] rtc_cmos 00:05: Start: legacy bus pm ops @ 2391, parent: pnp0
>> [  546.087084] rtc_cmos 00:05: End  : legacy bus pm ops @ 2391, parent: pnp0 time(11 usecs) err(0)
>>
>
> I was about to apply your patch, but then I noticed something that might cause
> problems to happen.
>
> Namely, there are tools that use these messages to create suspend/resume time
> charts and they will stop working after the proposed changes.
>
> Please keep the existing formatting the way it is and only append the additional
> information at the end of each line.
>
> Thanks,
> Rafael
>

Hi Rafael,

Yes changing the format would cause problems for scripts that rely on 
the exact format. Would you like to pick the v2 version of the patch 
that appends the additional information at the end, instead of changing 
the format? Here is the link. If you would like me to resend it, I can 
do that.

https://lkml.org/lkml/2013/6/14/448

-- Shuah

Shuah Khan, Linux Kernel Developer - Open Source Group Samsung Research 
America (Silicon Valley) shuah.kh@samsung.com | (970) 672-0658
