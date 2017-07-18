From: Mark Salyzyn <salyzyn@android.com>
Subject: Re: [PATCH v2 1/4] time: rtc-lib: Add rtc_show_time(const char
 *prefix_msg)
Date: Tue, 18 Jul 2017 16:25:11 -0700
Message-ID: <5016ccc4-7faa-b61e-c0a1-b851620849c7@android.com>
References: <20170718211930.123077-1-salyzyn@android.com>
 <alpine.DEB.2.20.1707182338470.2425@nanos>
 <8afb372a-3951-6fb9-c0be-82756623061f@android.com>
 <alpine.DEB.2.20.1707190023010.2425@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33250 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbdGRXZO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2017 19:25:14 -0400
Received: by mail-pf0-f169.google.com with SMTP id s70so9198314pfs.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2017 16:25:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1707190023010.2425@nanos>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org, andy.shevchenko@gmail.com, Mark Salyzyn <salyzyn@google.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thierry Strudel <tstrudel@google.com>, John Stultz <john.stultz@linaro.org>, Richard Cochran <richardcochran@gmail.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Prarit Bhargava <prarit@redhat.com>

[TL;DR]

On 07/18/2017 03:35 PM, Thomas Gleixner wrote:
> Can we please fix the tools and not introduce that horror in the kernel?
IMHO, we can switch this patch to epoch.ns time; but the momentum on the
tools will end up with us internally patching it back to RTC format at 
least until
we can get our act together ... I have accepted that risk, we always like to
see all changes upstream though. Would an additional config parameter
appease the situation?
> Just for the record: You cannot use that stuff deep in the suspend/resume
> code because timekeeping is suspended there as well and that call to
> getnstimeofday() is going to trigger a WARNON() when called after
> timekeeping was suspended. So please be more precise about the limitations
> of this.

Yes, I should have been clearer about that, in fact my comments in 0/4 
were _backwards_
when I reread them ;-/. One of the issues is the somewhat helpful suspend
millisecond duration requires a persistent clock, which is _not_ 
available on all
hardware. Printing the time on entry and exit from suspend and resume is 
always
possible because we are staying away from that lower level issue.

I should probably roll the details of 0/4 comments into 1/4, the intro 
has not served
its purpose.

It should also be made clearer that these single messages serve _two_ 
purposes,
the primary one is power analysis; the secondary one is log synchronization.

> There was some discussion about making the clock source for dmesg time
> stamps selectable, so you can use MONOTONIC, REALTIME, BOOTTIME. The
> patches looked sensible, but there was some showstopper vs. the user space
> dmesg utility. See:

The timestamps are useful for the 'second' purpose of these patches when
dmesg time is BOOTTIME or MONOTONIC, and can be turned off if REALTIME
is selected. Having rtc_show_time a single point for switching this no 
doubt helps,
not hinders, that dmesg issue.

The inflection points would still serve a purpose, still need
suspend/resume/hibernate/restore. The reboot messages are _only_ useful to
us with their timestamps, as I checked and the only tools that use those are
for log synchronization. We may be able to do away with them on REALTIME
dmesg'ing; but the standardization of the message as a marker would have a
legacy purpose (!)

NB: We have a similar configuration for the user space logger, which can be
configured to report in MONOTONIC time. We have yet to have a vendor
use the feature, opting for REALTIME logging for user space activities.
Our klogd (which runs at background priority and is batched) manages a
histogram relationship between MONOTONIC and REALTIME helped by these
prints and incorporates the REALTIME dmesg logs merged into our user
space logging database.

-- Mark
