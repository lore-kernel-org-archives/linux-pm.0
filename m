From: Paul Menzel <pmenzel+linux-pm@molgen.mpg.de>
Subject: Re: int3403_driver_init needs over 330 ms to finish
Date: Wed, 14 Mar 2018 09:19:38 +0100
Message-ID: <6ce0b246-b2ba-c251-3506-df3e3b71da84@molgen.mpg.de>
References: <b6cf267e-3042-1226-cb06-1b7fc26ed122@molgen.mpg.de>
 <1521012744.2087.13.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521012744.2087.13.camel@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Dear Rui,


On 03/14/2018 08:32 AM, Zhang Rui wrote:
> On 二, 2018-03-13 at 20:39 +0100, Paul Menzel wrote:

>> Booting the Dell XPS 13 9370 with Linux 4.16-rc4+ and
>> `initcall_debug`,
>> shows it is shown that int3403_driver_init needs over 330 ms to run.
>>
>>       [    2.524839] initcall int3403_driver_init+0x0/0x1000
>> [int3403_thermal] returned 0 after 333972 usecs
>>
> I guess most of the time are spent in evaluating ACPI ASL code.
> But anyway, please create a bugzilla report and attach both dmesg and
> acpidump there.

I created bug report #199113 [1], and attached the requested files.


Kind regards,

Paul


[1] https://bugzilla.kernel.org/show_bug.cgi?id=199113
