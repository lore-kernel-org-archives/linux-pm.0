From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 2/6] timekeeping: Pass readout base to update_fast_timekeeper()
Date: Fri, 13 Feb 2015 08:29:13 +0800
Message-ID: <CALAqxLV1fKx+8oMT__pb2sTds+cMv+DmdXHFHd-voTiiVgar4Q@mail.gmail.com>
References: <8292243.ibkmfVtXac@vostro.rjw.lan>
	<1973562.AfpZ97hsgV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1973562.AfpZ97hsgV@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Alan Cox <alan@linux.intel.com>, "Li, Aubrey" <aubrey.li@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 11, 2015 at 12:01 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Modify update_fast_timekeeper() to take a struct tk_read_base
> pointer as its argument (instead of a struct timekeeper pointer)
> and update its kerneldoc comment to reflect that.
>
> That will allow a struct tk_read_base that is not part of a
> struct timekeeper to be passed to it in the next patch.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thomas was really behind the update_fast_timekeeper design so I'm not
sure I can critique if this fits in the larger vision here, but I
don't see anything wrong and its not breaking in any of my tests,
so...

Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
