From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH v2 1/4] time: rtc-lib: Add rtc_show_time(const char
 *prefix_msg)
Date: Wed, 19 Jul 2017 08:03:27 -0400
Message-ID: <f50dbf47-d1dc-5e51-fdcd-0318c2ab93cd@redhat.com>
References: <20170718211930.123077-1-salyzyn@android.com>
 <alpine.DEB.2.20.1707182338470.2425@nanos>
 <8afb372a-3951-6fb9-c0be-82756623061f@android.com>
 <alpine.DEB.2.20.1707190023010.2425@nanos>
 <5016ccc4-7faa-b61e-c0a1-b851620849c7@android.com>
 <alpine.DEB.2.20.1707190913500.2286@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751452AbdGSMDb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Jul 2017 08:03:31 -0400
In-Reply-To: <alpine.DEB.2.20.1707190913500.2286@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>
Cc: LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org, andy.shevchenko@gmail.com, Mark Salyzyn <salyzyn@google.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thierry Strudel <tstrudel@google.com>, John Stultz <john.stultz@linaro.org>, Richard Cochran <richardcochran@gmail.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>



On 07/19/2017 03:23 AM, Thomas Gleixner wrote:
> On Tue, 18 Jul 2017, Mark Salyzyn wrote:
>> On 07/18/2017 03:35 PM, Thomas Gleixner wrote:
>>> There was some discussion about making the clock source for dmesg time
>>> stamps selectable, so you can use MONOTONIC, REALTIME, BOOTTIME. The
>>> patches looked sensible, but there was some showstopper vs. the user space
>>> dmesg utility. See:
>>
>> The timestamps are useful for the 'second' purpose of these patches when
>> dmesg time is BOOTTIME or MONOTONIC, and can be turned off if REALTIME
>> is selected. Having rtc_show_time a single point for switching this no doubt
>> helps,
>> not hinders, that dmesg issue.
>>
>> The inflection points would still serve a purpose, still need
>> suspend/resume/hibernate/restore. The reboot messages are _only_ useful to
>> us with their timestamps, as I checked and the only tools that use those are
>> for log synchronization. We may be able to do away with them on REALTIME
>> dmesg'ing; but the standardization of the message as a marker would have a
>> legacy purpose (!)
>>
>> NB: We have a similar configuration for the user space logger, which can be
>> configured to report in MONOTONIC time. We have yet to have a vendor
>> use the feature, opting for REALTIME logging for user space activities.
>> Our klogd (which runs at background priority and is batched) manages a
>> histogram relationship between MONOTONIC and REALTIME helped by these
>> prints and incorporates the REALTIME dmesg logs merged into our user
>> space logging database.
> 
> There is another option to remedy this and the dmesg tooling issues:
> 
> Instead of switching the time stamps in dmesg to a different clock we might
> as well have an optional secondary timestamp. So instead of:
> 
>  [  341.590930] wlan0: associated
> 
> you would get:
> 
>  [  341.590930] [ sec.usec] wlan0: associated
> 
> where the second time stamp would be CLOCK_REALTIME/BOOTTIME.
> 
> That should also solve Prarits problem, hmm?

It would but I would prefer a single time stamp be printed than two.  I think
two timestamps is adding confusion to the output from a end-users point of view.

Mark, why don't we get together and fixup my original patchset to make sure it
meets your needs?  It will fix both of our issues albeit not necessarily in the
text format you want it.

P.

> 
> Thanks,
> 
> 	tglx
> 
> 
