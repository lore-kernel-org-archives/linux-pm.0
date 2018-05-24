From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC] suspend: Prevent might sleep splats
Date: Thu, 24 May 2018 17:57:56 +0200
Message-ID: <CAJZ5v0hKfAuEyf7YQhb0Cs4p=RK6DADCrqvdSz0bcSihjiYBsw@mail.gmail.com>
References: <20180524142426.jeyszeqdrjvb3tob@linutronix.de>
 <CAJZ5v0jyGVP4h6B=wkhHb7UV2yePHZVjkzodj0Djx-gUBxyMkA@mail.gmail.com> <20180524154505.d5r77w7xinpbc36n@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180524154505.d5r77w7xinpbc36n@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, May 24, 2018 at 5:45 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2018-05-24 17:07:16 [+0200], Rafael J. Wysocki wrote:
>> On Thu, May 24, 2018 at 4:24 PM, Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de> wrote:
>> > From: Thomas Gleixner <tglx@linutronix.de>
>> >
>> > timekeeping suspend/resume calls read_persistent_clock() which takes
>> > rtc_lock. That results in might sleep warnings because at that point
>> > we run with interrupts disabled.
>> >
>> > We cannot convert rtc_lock to a raw spinlock as that would trigger
>> > other might sleep warnings.
>> >
>> > As a workaround we disable the might sleep warnings by setting
>> > system_state to SYSTEM_SUSPEND before calling sysdev_suspend() and
>> > restoring it to SYSTEM_RUNNING afer sysdev_resume().
>> >
>> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>
>> Hmm.  Don't we also need to cover suspend-to-idle?
>
> Well, if you agree with the approach then I would look into it.

As long as the SYSTEM_SUSPEND system state is defined unambiguously, I
don't have a problem with doing this.
