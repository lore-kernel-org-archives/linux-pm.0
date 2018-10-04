From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] cpuidle/drivers/menu: Remove get_loadavg in the performance multiplier
Date: Thu, 04 Oct 2018 11:39:14 +0200
Message-ID: <2531993.xoN9vA4MB0@aspire.rjw.lan>
References: <1538638927-26846-1-git-send-email-daniel.lezcano@linaro.org> <CAJZ5v0i+TMAeaMp8D8qGph1VZKg0L23RsqdPMEQ0xHhpTCHgQA@mail.gmail.com> <20181004093644.GL19272@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004093644.GL19272@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Colin Cross <ccross@android.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, October 4, 2018 11:36:44 AM CEST Peter Zijlstra wrote:
> On Thu, Oct 04, 2018 at 10:47:04AM +0200, Rafael J. Wysocki wrote:
> 
> > > The comment is irrelevant as the remaining function is used for
> > > statistics in addition to the perf multiplier. It does exactly what the
> > > function name is.
> > 
> > Which is my point.  It shouldn't be dropped entirely, but updated IMO.
> 
> But the function name isn't the problem.. the problem that any use of
> the number is fundamentally broken.
> 

We're in violent agreement here. :-)

I just wanted to say that the comment was still relevant at least with
respect to this function, but the patch was removing the comment
entirely.
