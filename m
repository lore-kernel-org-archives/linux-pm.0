From: "dbasehore ." <dbasehore@chromium.org>
Subject: Re: [PATCH v5 2/5] tick: Add freeze timer events
Date: Thu, 13 Jul 2017 15:58:53 -0700
Message-ID: <CAGAzgsoFugSw=UQsJmep0woGg70J3nie0-EtvtQ4Ec1NG1usOg@mail.gmail.com>
References: <20170708000303.21863-1-dbasehore@chromium.org>
 <20170708000303.21863-2-dbasehore@chromium.org> <20170713073200.uh3oxqowei6vxvwy@hirez.programming.kicks-ass.net>
 <CAJZ5v0horA+vgR3bAbEu+AiqEFJ7JyZ49nTv6FBPHRvmXOUFpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0horA+vgR3bAbEu+AiqEFJ7JyZ49nTv6FBPHRvmXOUFpQ@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, the arch/x86 maintainers <x86@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 13, 2017 at 8:09 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Jul 13, 2017 at 9:32 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> On Fri, Jul 07, 2017 at 05:03:00PM -0700, Derek Basehore wrote:
>>> Adds a new feature to tick to schedule wakeups on a CPU during freeze.
>>> This won't fully wake up the system (devices are not resumed), but
>>> allow simple platform functionality to be run during freeze with
>>> little power impact.
>>>
>>> This implementation allows an idle driver to setup a timer event with
>>> the clock event device when entering freeze by calling
>>> tick_set_freeze_event. Only one caller should exist for the function.
>>>
>>> tick_freeze_event_expired is used to check if the timer went off when
>>> the CPU wakes.
>>>
>>> The event is cleared by tick_clear_freeze_event.
>>
>> Why? What's wrong with using the RTC stuff? RTC should be able to wake
>> suspended systems, see RTCWAKE(8).
>
> The RTC interrupt is an SCI (on ACPI systems) and we don't handle it
> at this point, so we don't know what woke us up until we re-enable
> interrupt handlers and run the one for the SCI.

To add to that point, RTC wake ups are valid for fully waking up the
system. The clock event wake up wasn't used for waking up the system
before, so we know that we don't have to check if it should wake up
the system entirely. The way rtc timers work right now, I think that
we'd have to go all the way through resume devices to figure out if we
should resume to user space or freeze again.
