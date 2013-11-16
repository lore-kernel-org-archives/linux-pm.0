From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH] power: Change device_wakeup_enable() to check for null
 dev_name(dev)
Date: Sat, 16 Nov 2013 08:28:23 -0700
Message-ID: <52878F17.6020104@samsung.com>
References: <1384560238-10708-1-git-send-email-shuah.kh@samsung.com>
 <4035469.UfR6Rto3I2@vostro.rjw.lan> <5286B95F.4040306@samsung.com>
 <20131116002501.GA20625@kroah.com>
Reply-To: shuah.kh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w2.samsung.com ([211.189.100.11]:51729 "EHLO
	usmailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab3KPP2p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 16 Nov 2013 10:28:45 -0500
In-reply-to: <20131116002501.GA20625@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, anton@enomsg.org, dwmw2@infradead.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com, stable@vger.kernel.org, Shuah Khan <shuah.kh@samsung.com>

On 11/15/2013 05:25 PM, Greg KH wrote:
> On Fri, Nov 15, 2013 at 05:16:31PM -0700, Shuah Khan wrote:
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
> Why is a driver calling kobject_set_name() instead of device_set_name()?
>
> Yes, it's really the same thing deep down, but drivers should never care
> about a kobject, just 'struct device'.  Well, even then it usually
> should care about it's type of 'struct device' but that's a different
> issue...
>
> Anyway, not saying your patch is wrong at all, just for the future if
> people are looking for code cleanups...
>

Use of kobject_set_name() did look odd to me. I will fix that for this 
driver by re-doing the patch while I am it. About the power_supply 
patch, stable needs fixing as well, and I will have to backport once he 
fix goes into the mainline.

http://www.kernelhub.org/?msg=362354&p=2 as is doesn't apply to 3.10 and 
3.11

-- Shuah

-- 
Shuah Khan
Senior Linux Kernel Developer - Open Source Group
Samsung Research America(Silicon Valley)
shuah.kh@samsung.com | (970) 672-0658
