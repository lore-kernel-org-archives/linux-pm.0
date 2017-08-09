From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 0/4] PM: Replace "freeze" with "s2idle" in item names related to suspend-to-idle
Date: Thu, 10 Aug 2017 00:11:54 +0200
Message-ID: <4362123.MquenKSW7f@aspire.rjw.lan>
References: <1912685.WjJGzNPQ5e@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1912685.WjJGzNPQ5e@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, August 5, 2017 2:55:34 PM CEST Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> The term "suspend-to-idle" (and its short form "s2idle") was invented after
> introducing support for the system state it refers to.  At that time, the
> feature was called "freeze", kind of for the lack of a better idea how to
> call it.
> 
> It would not be a problem if it wasn't confusing, but alas it is.  The word
> "freeze" is quite heavily loaded in the PM terminology.  It is related to
> the freezing of tasks, the freezing of filesystems (which isn't only used
> for PM for that matter), and one of the phases of handling devices during
> hibernation (and during resume from it) is called "freeze", which is reflected
> in the names of PM callbacks used by it.
> 
> To avoid that confusion, the following patches change the names of various
> items related to suspend-to-idle by replacing the word "freeze" in them
> with "s2idle".
> 
> The series is on top of current linux-next.

The v2 addresses the comment from Peter that PM_SUSPEND_S2IDLE had too many
"suspends" in it, so it is now replaced with PM_SUSPEND_TO_IDLE.  No other
changes.

Thanks,
Rafael
