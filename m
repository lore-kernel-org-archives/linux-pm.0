From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: pm: System date and time set incorrectly after suspend/resume to
 disk
Date: Tue, 18 Jun 2013 18:14:02 +0000
Message-ID: <B8EFE96D1287C24090BAD9D858E15E6172A4C4@sisaex02sj>
References: <B8EFE96D1287C24090BAD9D858E15E6172A070@sisaex02sj>
 <CANcMJZCuYmim8q5ZPg2ppwA8T0jXMmpGowikeca5EzaoeVxr-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w2.samsung.com ([211.189.100.12]:24350 "EHLO
	usmailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932812Ab3FRSOG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2013 14:14:06 -0400
Content-language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>, Shuah Khan <shuah.kh@samsung.com>

On 06/17/2013 08:14 PM, John Stultz wrote:
> On Mon, Jun 17, 2013 at 6:30 PM, Shuah Khan <shuah.kh@samsung.com> wrote:
>> I am seeing a problem on my system after a suspend to disk in reboot or
>> shutdown mode. When pm_trace is 0 (which is the default), I can't
>> reproduce the problem easily. I have to run a few more suspend tests
>> before I see the problem. When pm_trace is disabled, the problem showed
>> up when I ran suspend in platform mode in a row. However when pm_ptrace
>> is enabled, problem happens on the very first spend to disk in reboot mode.
>>
>> Steps to run into the issue:
>>
>> echo 1 > pm_print_times
>> echo 1 > pm_trace
>> echo reboot > disk
>> echo disk > state
>>
>> or
>>
>> echo 1 > pm_print_times
>> echo 1 > pm_trace
>> echo shutdown > disk
>> echo disk > state
>>
>> When system comes back up, system time set to incorrect time.
>
> So I this is by design. Please see Documentation/power/s2ram.txt for details:
>
> "pm_trace uses the system's Real Time Clock (RTC) to save the magic number.
> Reason for this is that the RTC is the only reliably available piece of
> hardware during resume operations where a value can be set that will
> survive a reboot.
>
> Consequence is that after a resume (even if it is successful) your system
> clock will have a value corresponding to the magic number instead of the
> correct date/time! It is therefore advisable to use a program like ntp-date
> or rdate to reset the correct date/time from an external time source when
> using this trace option."
>
> thanks
> -john
>

Thanks. It definitely is working as designed and documented. :) Is there 
a reason why pm_trace_store() couldn't/shouldn't  print a warning 
message (pr_warn) along the lines of:

"CAUTION: this option will cause your machine's real-time clock to be 
set to an invalid time after a resume. Remember to set correct time 
after resume!!"

It will serve as a reminder to correct the time after resume. I could 
send a patch in to add a warning message.

thanks,
-- Shuah

Shuah Khan, Linux Kernel Developer - Open Source Group Samsung Research 
America (Silicon Valley) shuah.kh@samsung.com | (970) 672-0658
