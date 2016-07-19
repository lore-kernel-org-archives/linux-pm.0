From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][v2] timekeeping: Fix memory overwrite of sleep_time_bin
 array
Date: Tue, 19 Jul 2016 17:07:07 +0800
Message-ID: <578DEDBB.9030602@intel.com>
References: <1468903861-12487-1-git-send-email-yu.c.chen@intel.com>
 <alpine.DEB.2.11.1607191031260.3596@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:25644 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953AbcGSI70 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 Jul 2016 04:59:26 -0400
In-Reply-To: <alpine.DEB.2.11.1607191031260.3596@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>, "Rafael J. Wysock" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, "Stable # 3 . 17+" <stable@vger.kernel.org>

Hi Thomas,

On 2016=E5=B9=B407=E6=9C=8819=E6=97=A5 16:36, Thomas Gleixner wrote:
> On Tue, 19 Jul 2016, Chen Yu wrote:
>
>> It is reported the hibernation fails at 2nd attempt, which
>> hangs at hibernate() -> syscore_resume() -> i8237A_resume()
>> -> claim_dma_lock(), because the lock has already been taken.
>> However there is actually no other process would like to grab
>> this lock on that problematic platform.
>>
>> Further investigation shows that, the problem is caused by setting
>> /sys/power/pm_trace to 1 before the 1st hibernation, since once
>> pm_trace is enabled, the rtc becomes an unmeaningful value after res=
umed,
> So why is the RTC value useless if pm_trace is enabled? I really have=
 a hard
> time to understand why pm_trace would affect the sleep time readout f=
rom RTC.
>
> Thanks,
>
> 	tglx
After pm_trace is enabled, during system suspend/hibernate, the hash na=
me of
each devices will be written to rtc, so  the rtc value depends on what=20
we write in last suspend
round, thus pm_trace can be  used for diagnose which device failed to=20
suspend(eg, the suspending
on this device hang the system, we reboot the system , and check rtc=20
hash value).

  In our case, after first hibernate/resume round,  we found our curren=
t=20
system time
is  at  2117, so syscore_resume -> timekeeping_resume :
__timekeeping_inject_sleeptime(tk, &ts_delta)
would inject a quite large delta :  2117 - 2017 year, thus the=20
sleep_time_bin is overflow.

thanks,
Yu
