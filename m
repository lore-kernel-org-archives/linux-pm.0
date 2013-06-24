From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH 1/2] power: add new interface to return pm_transition state
Date: Mon, 24 Jun 2013 16:20:06 +0000
Message-ID: <B8EFE96D1287C24090BAD9D858E15E6172F2C0@sisaex02sj>
References: <1371931874-3220-1-git-send-email-shuah.kh@samsung.com>
 <4133846.I1XZFprb5V@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w2.samsung.com ([211.189.100.12]:58814 "EHLO
	usmailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab3FXQUK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2013 12:20:10 -0400
Content-language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "pavel@ucw.cz" <pavel@ucw.cz>, "len.brown@intel.com" <len.brown@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "airlied@linux.ie" <airlied@linux.ie>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>, Shuah Khan <shuah.kh@samsung.com>

On 06/22/2013 03:17 PM, Rafael J. Wysocki wrote:
> On Saturday, June 22, 2013 02:11:14 PM Shuah Khan wrote:
>> Add a new interface get_pm_transition() to return pm_transition state.
>> This interface is intended to be used from dev_pm_ops class and type
>> suspend interfaces that call legacy pm ops driver suspend interfaces.
>> Legacy suspend pm_ops take pm_message_t as a parameter.
>>
>> e.g: drm_class_suspend() calls into driver suspend routines
>> via drm_dev->driver->suspend(drm_dev, state).
>>
>> Once drm_class_suspend() is converted to dev_pm_ops, it will no longer
>> have access to pm_transition which it has to pass into driver legacy
>> suspend calls. get_pm_transition() interface addresses this need.
>
> That shouldn't be necessary because each transition has its own callback
> in strict dev_pm_ops.
>
> Thanks,
> Rafael
>

Yes that is correct that there is no need pass in or know pm_transition 
with dev_pm_ops. The issue I am running into is the legacy pm_ops class 
suspend/resume routines call. In the example, I mentioned in my 
changelog, drm_class_suspend() calls legacy pm_ops and passes in state. 
It passes in the state to the driver legacy suspend routine. I have seen 
code paths in drivers that differentiate between PM_EVENT_FREEZE, 
PM_EVENT_SUSPEND, PM_EVENT_SLEEP etc.

I considered passing PM_EVENT_SUSPEND to 
drm_dev->driver->suspend(drm_dev, state) from drm_class_suspend() which 
would eliminate the need for this new interface. However, I am concerned 
about breaking driver legacy suspend routines that key of off the state 
to execute different code paths for PM_EVENT_FREEZE vs. 
PM_EVENT_SUSPEND. Suspend routines get called when state is is 
PM_EVENT_FREEZE based on my testing.

I would rather not add a new interface. Hoping you will have another 
idea on how to pass in the state to legacy suspend/resume without adding 
this new interface. My thinking is that this new interface is temporary 
measure until all of the legacy suspend routines get converted to 
dev_pm_ops and at the tile legacy interface gets removed, this new 
interface can go away as well.

thanks,
-- Shuah

Shuah Khan, Linux Kernel Developer - Open Source Group Samsung Research 
America (Silicon Valley) shuah.kh@samsung.com | (970) 672-0658
