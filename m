From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH] power: Add legacy pm ops usage warning
Date: Tue, 05 Nov 2013 11:41:10 -0700
Message-ID: <52793BC6.1080208@samsung.com>
References: <1383318424-4072-1-git-send-email-shuah.kh@samsung.com>
 <7710681.pPuGuuagq2@vostro.rjw.lan>
Reply-To: shuah.kh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w2.samsung.com ([211.189.100.14]:58309 "EHLO
	usmailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596Ab3KESlO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2013 13:41:14 -0500
In-reply-to: <7710681.pPuGuuagq2@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com, Shuah Khan <shuah.kh@samsung.com>

On 11/01/2013 05:04 PM, Rafael J. Wysocki wrote:
> On Friday, November 01, 2013 09:07:04 AM Shuah Khan wrote:
>> Add legacy pm_ops usage checks to device_pm_add() when a device gets added
>> to PM core's list of active devices. If legacy pm_ops usage is found at its
>> class, bus, driver level, print warning message to indicate the driver code
>> needs updating to use dev pm ops interfaces. This will help serve as a way
>> to track drivers that still use legacy pm ops and fix them.
>
> I think it would be much better to do these checks during bus type, class or
> driver registration, because if you register a bus type with legacy PM, for
> example, the check in device_pm_add() will trigger for all devices with that
> bus type.
>
> Thanks!

Rafael,

Correct. device_pm_add() triggers for all devices that use the driver. 
On the other hand, the check is done only when the device gets added to 
the pm core. I do like that part.

I am testing with adding checks driver_register() to look for suspend at 
bus level. I am not seeing the same set of drivers I saw with the check 
in device_pm_add(), which is puzzling. I am working on testing still. 
Keep you posted.

-- Shuah

-- 
Shuah Khan
Senior Linux Kernel Developer - Open Source Group
Samsung Research America(Silicon Valley)
shuah.kh@samsung.com | (970) 672-0658
