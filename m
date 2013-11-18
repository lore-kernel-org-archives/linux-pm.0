From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH] power: Change device_wakeup_enable() to check for null
 dev_name(dev)
Date: Mon, 18 Nov 2013 10:45:23 -0700
Message-ID: <528A5233.4040306@samsung.com>
References: <1384560238-10708-1-git-send-email-shuah.kh@samsung.com>
 <4035469.UfR6Rto3I2@vostro.rjw.lan> <5286B95F.4040306@samsung.com>
 <3366600.jMpqPVojcG@vostro.rjw.lan>
Reply-To: shuah.kh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w2.samsung.com ([211.189.100.13]:32582 "EHLO
	usmailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab3KRRpd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2013 12:45:33 -0500
In-reply-to: <3366600.jMpqPVojcG@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, anton@enomsg.org, dwmw2@infradead.org
Cc: len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com, stable@vger.kernel.org, Shuah Khan <shuah.kh@samsung.com>

On 11/15/2013 05:32 PM, Rafael J. Wysocki wrote:
> On Friday, November 15, 2013 05:16:31 PM Shuah Khan wrote:
>> On 11/15/2013 05:21 PM, Rafael J. Wysocki wrote:
>>> On Friday, November 15, 2013 05:03:57 PM Shuah Khan wrote:
>>>> device_wakeup_enable() uses dev_name(dev) as the wakeup source name.
>>>> When it gets called with a device with its name not yet set, ws structure
>>>> with ws->name = NULL gets created.
>>>>
>>>> When kernel is booted with wakeup_source_activate enabled, it will panic
>>>> when the trace point code tries to derefernces ws->name.
>>>>
>>>> Change device_wakeup_enable() to check for dev_name(dev) null condition
>>>> and return -EINVAL to avoid panics when device_wakeup_enable() gets called
>>>> before device is fully initialized with its name.
>>    		return -EINVAL;
>>>
>>> Can you please use WARN_ON(!dev_name(dev)) here?  While I agree that it is a
>>> bad idea to crash the kernel because dev has no name, that indicates a driver
>>> bug that shouldn't be too easy to ignore.
>>>
>>> Thanks!
>>>
>>
>> Right. ok I will re-cut the patch with WARN_ON and send it. fyi I did
>> send fix for the driver (power_supply) as well.
>>
>> http://www.kernelhub.org/?msg=362354&p=2
>
> That's OK (thanks for taking care of this), but there may be more brilliant
> stuff like that in the future and people should see right away that something's
> wrong in those cases.
>

Rafael/Anton/David,

I added WARN_ON and testing the patch. We have two instance of 
device_wakeup_enable() calls with null dev_name during boot. Both are 
from power_supply_register(). One when AC Adapter [ADP1] is added and 
the second when device: 'BAT1' gets added.

[    4.412959] device_wakeup_enable() called with null device nme
[    4.412967] device: 'ADP1': device_add

[    4.460190] device_wakeup_enable() called with null device nme
[    4.460197] device: 'BAT1': device_add


I think adding WARN_ON to device_wakeup_enable() and fix to 
power_supply_register() should go in as a dependent patch series, to 
avoid panics during boot. As soon as the device_wakeup_enable() WARN_ON 
goes in, I suspect most laptops will panic during boot, similar to what 
  I am seeing in my testing. Thoughts?

I will send these fixes, maybe these two can be funneled through PM tree 
with power_supply maintainers ACK for the power_supply_register() fix.

thanks,
-- Shuah

-- 
Shuah Khan
Senior Linux Kernel Developer - Open Source Group
Samsung Research America(Silicon Valley)
shuah.kh@samsung.com | (970) 672-0658
