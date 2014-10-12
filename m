From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 1/2] acpi: Use syscore instead of pm_power_off_prepare
 to prepare for poweroff
Date: Sun, 12 Oct 2014 12:59:05 -0700
Message-ID: <543ADD89.1050702@roeck-us.net>
References: <1413062057-11657-1-git-send-email-linux@roeck-us.net> <3090667.ydmQKSGePB@vostro.rjw.lan> <543AD7FA.5060706@roeck-us.net> <2189351.ETD7m2XsWr@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2189351.ETD7m2XsWr@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 10/12/2014 01:16 PM, Rafael J. Wysocki wrote:
> On Sunday, October 12, 2014 12:35:22 PM Guenter Roeck wrote:
>> On 10/12/2014 12:45 PM, Rafael J. Wysocki wrote:
>>> On Saturday, October 11, 2014 02:14:16 PM Guenter Roeck wrote:
>>>> The syscore shutdown callback seems to be perfectly suited to prepare for system
>>>> poweroff. Use it instead of pm_power_off_prepare.
>>>
>>> How much testing did that receive?
>>>
>>
>> As I mentioned in patch 0/2, compile tested so far only. Before I start playing
>> with my servers, I wanted to get some feedback if the idea is worth pursuing
>> further or if I am missing something essential.
>
> Well, it makes sense in principle, but the ordering with respect to the other
> syscore shutdown things and the migrate_to_reboot_cpu() may be a problem.
>
> I always get nervous when the ordering of ACPI-related code changes like
> that and the reason is quite weak this time to be honest.
>

Ok, no problem; I'll drop it.

Guenter
