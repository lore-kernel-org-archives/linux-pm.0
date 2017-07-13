From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 2/5] tick: Add freeze timer events
Date: Thu, 13 Jul 2017 09:32:00 +0200
Message-ID: <20170713073200.uh3oxqowei6vxvwy@hirez.programming.kicks-ass.net>
References: <20170708000303.21863-1-dbasehore@chromium.org>
 <20170708000303.21863-2-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170708000303.21863-2-dbasehore@chromium.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Derek Basehore <dbasehore@chromium.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, x86@kernel.org, platform-driver-x86@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 07, 2017 at 05:03:00PM -0700, Derek Basehore wrote:
> Adds a new feature to tick to schedule wakeups on a CPU during freeze.
> This won't fully wake up the system (devices are not resumed), but
> allow simple platform functionality to be run during freeze with
> little power impact.
> 
> This implementation allows an idle driver to setup a timer event with
> the clock event device when entering freeze by calling
> tick_set_freeze_event. Only one caller should exist for the function.
> 
> tick_freeze_event_expired is used to check if the timer went off when
> the CPU wakes.
> 
> The event is cleared by tick_clear_freeze_event.

Why? What's wrong with using the RTC stuff? RTC should be able to wake
suspended systems, see RTCWAKE(8).
