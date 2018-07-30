From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RESEND 1/1] x86: tsc: avoid system instability in
 hibernation
Date: Mon, 30 Jul 2018 10:53:54 +0200
Message-ID: <20180730085354.GA2494@hirez.programming.kicks-ass.net>
References: <20180726155656.14873-1-eduval@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180726155656.14873-1-eduval@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduval@amazon.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "mike.travis@hpe.com" <mike.travis@hpe.com>, Rajvi Jingar <rajvi.jingar@intel.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 26, 2018 at 08:56:56AM -0700, Eduardo Valentin wrote:
> System instability are seen during resume from hibernation when system
> is under heavy CPU load. This is due to the lack of update of sched
> clock data

Which would suggest you're already running with unstable sched clock.
Otherwise nobody would care about the scd stuff.

What kind of machine are you running? What does:

  dmesg | grep -i tsc

say?

> The fix for this situation is to mark the sched clock as unstable
> as early as possible in the resume path, leaving it unstable
> for the duration of the resume process. This will force the
> scheduler to attempt to align the sched clock across CPUs using
> the delta with time of day, updating sched clock data. In a post
> hibernation event, we can then mark the sched clock as stable
> again, avoiding unnecessary syncs with time of day on systems
> in which TSC is reliable.

None of this makes any sense. Either you were already unstable and it
should already have worked and them marking it stable is an outright
bug, or your sched clock was stable but then your initial diagnosis of
lack of scd updates is complete garbage.
