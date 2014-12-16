From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/2] cpuidle: acpi: Remove TIME_INVALID flag from acpi
Date: Tue, 16 Dec 2014 00:28:11 -0500
Message-ID: <CAJvTdKkzNUc4Q59DSeo3MPVhR=eWLE3iEmagrYSVb69Stt-Exg@mail.gmail.com>
References: <1416562192-14114-1-git-send-email-daniel.lezcano@linaro.org>
	<2283319.n13QkHWkNs@vostro.rjw.lan>
	<546F53CF.8070004@linaro.org>
	<54802121.2030407@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <54802121.2030407@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, linaro-kernel@lists.linaro.org, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

>>>> The commit 8e92b6605d introduced the TIME_VALID flag for the C1 state
>>>> if this one is a mwait state assuming the interrupt will be enabled
>>>> before reading the end time of the idle state.
...
>>>> I have been digging through the code and I didn't find any place
>>>> where the interrupts are enabled before reading the time.

Linux is correct as it stands, and the patch proposed here is not correct.

Note that on x86, the "STI" instruction enables interrupts:

static inline void native_safe_halt(void)
{
        asm volatile("sti; hlt": : :"memory");
}

We get here via acpi_safe_halt(), which is invoked with interrupts
disabled via the cpuidle enter path.
As it needs to return with interrupts disabled, it hacks them off
again, but not before the actual
interrupt is serviced -- which is what throws off the time-stamps in
this path, and why
the CPUIDLE_FLAG_TIME_INVALID exists.

/*
 * Callers should disable interrupts before the call and enable
 * interrupts after return.
 */
static void acpi_safe_halt(void)
{
        if (!tif_need_resched()) {
                safe_halt();
                local_irq_disable();
        }
}

That said...
I think if ladder and menu were more clever, we could delete
CPUIDLE_FLAG_TIME_INVALID...
Today, we use this flag to set our last_residency to the amount of
time until the predicted
next timer expires.  There are only two cases:

First, we could have taken and serviced an interrupt -- all before the timer
would have expired.
In this case, we are rounding up last_residency to the max, the
duration till the next timer
would have expired.

Second, we could take the timer, and we could service it for a long
time, and we'd
return a time that is longer than the expected time.  So here we are truncating
down to the expected duration till the next timer.

But in case #1, our "invalid" measurement is actually more accurate than what
we are rounding up to.  And in case #2, we don't need a flag to detect it --
indeed menu already checks for that case:

                /* Make sure our coefficients do not exceed unity */
                if (measured_us > data->next_timer_us)
                        measured_us = data->next_timer_us;

cheers,
Len Brown, Intel Open Source Technology Center
