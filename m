From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH] power: Change device_wakeup_enable() to check for null
 dev_name(dev)
Date: Fri, 15 Nov 2013 17:16:31 -0700
Message-ID: <5286B95F.4040306@samsung.com>
References: <1384560238-10708-1-git-send-email-shuah.kh@samsung.com>
 <4035469.UfR6Rto3I2@vostro.rjw.lan>
Reply-To: shuah.kh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w2.samsung.com ([211.189.100.12]:17602 "EHLO
	usmailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab3KPAQf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2013 19:16:35 -0500
In-reply-to: <4035469.UfR6Rto3I2@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com, anton@enomsg.org, dwmw2@infradead.org, stable@vger.kernel.org, Shuah Khan <shuah.kh@samsung.com>

On 11/15/2013 05:21 PM, Rafael J. Wysocki wrote:
> On Friday, November 15, 2013 05:03:57 PM Shuah Khan wrote:
>> device_wakeup_enable() uses dev_name(dev) as the wakeup source name.
>> When it gets called with a device with its name not yet set, ws structure
>> with ws->name = NULL gets created.
>>
>> When kernel is booted with wakeup_source_activate enabled, it will panic
>> when the trace point code tries to derefernces ws->name.
>>
>> Change device_wakeup_enable() to check for dev_name(dev) null condition
>> and return -EINVAL to avoid panics when device_wakeup_enable() gets called
>> before device is fully initialized with its name.
  		return -EINVAL;
>
> Can you please use WARN_ON(!dev_name(dev)) here?  While I agree that it is a
> bad idea to crash the kernel because dev has no name, that indicates a driver
> bug that shouldn't be too easy to ignore.
>
> Thanks!
>

Right. ok I will re-cut the patch with WARN_ON and send it. fyi I did 
send fix for the driver (power_supply) as well.

http://www.kernelhub.org/?msg=362354&p=2

-- Shuah
-- 
Shuah Khan
Senior Linux Kernel Developer - Open Source Group
Samsung Research America(Silicon Valley)
shuah.kh@samsung.com | (970) 672-0658
