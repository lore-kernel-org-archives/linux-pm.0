From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH v2 1/4] time: rtc-lib: Add rtc_show_time(const char
 *prefix_msg)
Date: Wed, 19 Jul 2017 10:28:04 -0400
Message-ID: <abb4ef30-06c2-18db-6c8d-c29be1b1fa3d@redhat.com>
References: <20170718211930.123077-1-salyzyn@android.com>
 <alpine.DEB.2.20.1707182338470.2425@nanos>
 <8afb372a-3951-6fb9-c0be-82756623061f@android.com>
 <alpine.DEB.2.20.1707190023010.2425@nanos>
 <5016ccc4-7faa-b61e-c0a1-b851620849c7@android.com>
 <alpine.DEB.2.20.1707190913500.2286@nanos>
 <f50dbf47-d1dc-5e51-fdcd-0318c2ab93cd@redhat.com>
 <alpine.DEB.2.20.1707191426060.2286@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751448AbdGSO2I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Jul 2017 10:28:08 -0400
In-Reply-To: <alpine.DEB.2.20.1707191426060.2286@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Salyzyn <salyzyn@android.com>, LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org, andy.shevchenko@gmail.com, Mark Salyzyn <salyzyn@google.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thierry Strudel <tstrudel@google.com>, John Stultz <john.stultz@linaro.org>, Richard Cochran <richardcochran@gmail.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>



On 07/19/2017 08:28 AM, Thomas Gleixner wrote:
> On Wed, 19 Jul 2017, Prarit Bhargava wrote:
>> On 07/19/2017 03:23 AM, Thomas Gleixner wrote:
>>> There is another option to remedy this and the dmesg tooling issues:
>>>
>>> Instead of switching the time stamps in dmesg to a different clock we might
>>> as well have an optional secondary timestamp. So instead of:
>>>
>>>  [  341.590930] wlan0: associated
>>>
>>> you would get:
>>>
>>>  [  341.590930] [ sec.usec] wlan0: associated
>>>
>>> where the second time stamp would be CLOCK_REALTIME/BOOTTIME.
>>>
>>> That should also solve Prarits problem, hmm?
>>
>> It would but I would prefer a single time stamp be printed than two.  I think
>> two timestamps is adding confusion to the output from a end-users point of view.
> 
> Fair enough. I came up with that idea when I looked at the old thread. The
> discussion about tools (e.g. dmesg) dried out at some point and looked
> unresolved.

tglx,

There were two outstanding issues with my patchset.  The first, as you mention
above, is the issue with tooling.  I will handle the chicken-and-egg issue with
the kernel modification and tooling.  I will post patches for dmesg & systemd
once the kernel patchset lands in a "next" tree; other tools will have to be
patched as we find them.

The second issue is a sysfs stability and output issue that I have a question
on.  Since I'm changing the value of print.time from a bool to an int, the
output of /sys/modules/printk/parameters/time would change from Y/N to 0-3.  The
file is not listed in Documentation/ABI/stable so I think I can change it.  Can
you confirm that this is the case?  I wary of changing anything under sysfs and
I'm not sure who else would know if I can change the output of that file.

If it is the case that the output can be changed, then I'm going to suggest that
we allow, for example, human-readable format "printk.time=monotonic" along with
"printk.time=2" as kernel parameters.  I would also like your thoughts on that idea.

If the file cannot be changed I will have to add an additional module parameter
to printk.  Does "timestamp" sound okay to you?  I will go with whatever you
suggest.

Thanks,

P.
