From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] cpuidle/drivers/menu: Remove get_loadavg in the
 performance multiplier
Date: Thu, 4 Oct 2018 11:36:44 +0200
Message-ID: <20181004093644.GL19272@hirez.programming.kicks-ass.net>
References: <1538638927-26846-1-git-send-email-daniel.lezcano@linaro.org>
 <1538638927-26846-2-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0iLAtfo0w=BE-G+YW1WAxXsAdveiRvNhBSkpVPsd+TC9A@mail.gmail.com>
 <4541426c-8c73-7fe6-b3b6-9707861564ce@linaro.org>
 <CAJZ5v0i+TMAeaMp8D8qGph1VZKg0L23RsqdPMEQ0xHhpTCHgQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i+TMAeaMp8D8qGph1VZKg0L23RsqdPMEQ0xHhpTCHgQA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Colin Cross <ccross@android.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Alex Shi <alex.shi@linaro.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 04, 2018 at 10:47:04AM +0200, Rafael J. Wysocki wrote:

> > The comment is irrelevant as the remaining function is used for
> > statistics in addition to the perf multiplier. It does exactly what the
> > function name is.
> 
> Which is my point.  It shouldn't be dropped entirely, but updated IMO.

But the function name isn't the problem.. the problem that any use of
the number is fundamentally broken.
