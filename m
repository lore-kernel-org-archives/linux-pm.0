From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 08:40:59 -0700
Message-ID: <87hbm6cz90.fsf__236.143222037022$1274111095$gmane$org@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1005151716180.24645-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005151716180.24645-100000@netrider.rowland.org>
	(Alan Stern's message of "Sat\,
	15 May 2010 17\:19\:55 -0400 \(EDT\)")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-omap@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Fri, 14 May 2010, Brian Swetland wrote:
>
>> In tickless mode, the time until next timer is a signed int, so the
>> longest the kernel will ever sleep is ~2 seconds at a go.  In
>> practice, userspace entities often have polling behavior that can
>> trigger more often than that, and I've observed some kernel periodic
>> timers (haven't cataloged them recently) that happen more often than
>> once a second.
>
> Paul and Kevin, how does the OMAP implementation handle these 
> difficulties?

just a minor clarification... these aren't OMAP-specific issues, but
generic issues to all power-sensitive kernel users.

The ~2 second limit was fixed by Jon Hunter (TI) and is in mainline
since 2.6.32[1].

For other timers, there has been active work (mostly by Intel folks)
on deferrable timers, coalescing timers, timer slack etc. that has
greatly reduced the kernel timer impact on wakeups.

> Also, how does it handle the issue of ill-behaved apps?

For userspace, apps that have polling behavior or are ill-behaved must
be found and fixed.  Thanks to tools like powertop, this is a farily
easy task.

But really, I don't consider the "ill-behaved app" problem to be a
real-world problem.  Both in maemo/meego and Android, if someone
writes an app that kills battery life, it will get reported as a bug,
or get bad ratings etc.  On these kinds of devices, there is a *stong*
developer incentive to not write battery sucking apps.

Kevin


[1]
commit 97813f2fe77804a4464564c75ba8d8826377feea
Author: Jon Hunter <jon-hunter@ti.com>
Date:   Tue Aug 18 12:45:11 2009 -0500

    nohz: Allow 32-bit machines to sleep for more than 2.15 seconds
    
    In the dynamic tick code, "max_delta_ns" (member of the
    "clock_event_device" structure) represents the maximum sleep time
    that can occur between timer events in nanoseconds.
    
    The variable, "max_delta_ns", is defined as an unsigned long
    which is a 32-bit integer for 32-bit machines and a 64-bit
    integer for 64-bit machines (if -m64 option is used for gcc).
    The value of max_delta_ns is set by calling the function
    "clockevent_delta2ns()" which returns a maximum value of LONG_MAX.
    For a 32-bit machine LONG_MAX is equal to 0x7fffffff and in
    nanoseconds this equates to ~2.15 seconds. Hence, the maximum
    sleep time for a 32-bit machine is ~2.15 seconds, where as for
    a 64-bit machine it will be many years.
    
    This patch changes the type of max_delta_ns to be "u64" instead of
    "unsigned long" so that this variable is a 64-bit type for both 32-bit
    and 64-bit machines. It also changes the maximum value returned by
    clockevent_delta2ns() to KTIME_MAX.  Hence this allows a 32-bit
    machine to sleep for longer than ~2.15 seconds. Please note that this
    patch also changes "min_delta_ns" to be "u64" too and although this is
    unnecessary, it makes the patch simpler as it avoids to fixup all
    callers of clockevent_delta2ns().
    
    [ tglx: changed "unsigned long long" to u64 as we use this data type
        through out the time code ]
    
    Signed-off-by: Jon Hunter <jon-hunter@ti.com>
    Cc: John Stultz <johnstul@us.ibm.com>
    LKML-Reference: <1250617512-23567-3-git-send-email-jon-hunter@ti.com>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
