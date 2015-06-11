From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpufreq, Fix overflow in busy_scaled due to long delay
Date: Thu, 11 Jun 2015 07:51:00 -0700
Message-ID: <000301d0a456$09333d00$1b99b700$@net>
References: <1433942325-6610-1-git-send-email-prarit@redhat.com> <2049134.oxrPdGJl10@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta3.telus.net ([209.171.16.76]:45249 "EHLO cmta3.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752482AbbFKOvG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Jun 2015 10:51:06 -0400
In-Reply-To: <2049134.oxrPdGJl10@vostro.rjw.lan>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Prarit Bhargava' <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, 'Kristen Carlson Accardi' <kristen@linux.intel.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Doug Smythies <dsmythies@telus.net>


On 2015.06.10 16:46 Rafael J. Wysocki wrote:
> On Wednesday, June 10, 2015 09:18:45 AM Prarit Bhargava wrote:
>> I looked into switching to div64_s64() instead of the 32-bit version in
>> div_fp(), however, this would result in sample_ratio and core_busy returning
>> 0 which is something we don't want.

???
Due to a great many overflow related issues, div_fp() was changed to div64_s64()
a long time ago.

I have not found the actual commit to reference, but it was about a year ago.
And the math in general was all changed to 64 bit, over a few commits.

> 
> P.
> 
> ---8<---
> 
> The kernel may delay interrupts for a long time which can result in timers
> being delayed.  If this occurs the intel_pstate driver will crash with
> a divide by zero error:

More recent versions will not crash.
Long timer delays are extremely common, and this is a fundamental flaw
in the duration method. Patch sets have been submitting dealing with this,
and other, issues.

>> 
>> which results in the time between samples = last_sample_time - sample.time
>> = 4063149215234118 - 4063132438017305 = 16777216813 which is 16.777 seconds.

I have never seen anything over 4 seconds before, and I study this stuff
(with respect to the intel_pstate driver operation) a lot. Due to help
from others, I have data from a variety of processors.
4 seconds not unusual, even under load.

>> 
>> The duration between reads of the APERF and MPERF registers overflowed a s32
>> sized integer in intel_pstate_get_scaled_busy()'s call to div_fp().  The result
>> is that int_tofp(duration_us) == 0, and the kernel attempts to divide by 0.
>> 
>> While the kernel shouldn't be delaying for a long time, it can and does
>> happen, and the intel_pstate driver should not panic in this situation.  This
>> patch checks for an overflow and ignores the current calculation cycle by
>> returning -EINVAL.  Since intel_pstate_sample() has been called, subsequent
>> timer function calls will then again pick up the correct calculations and the
>> system will continue functioning properly.

That would run the risk that the correct calculation would never be done.
It is fairly easy (I do it all the time) to create a scenario where
there is high load on a CPU, but also a very very high duration value,
for each and every duration. (and O.K., in that scenario the calculation is always
wrong anyhow, due to the long duration check engaging.)


