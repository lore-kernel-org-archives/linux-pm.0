From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Thu, 3 Mar 2016 17:47:51 +0100
Message-ID: <20160303164751.GD6375@twins.programming.kicks-ass.net>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <1842158.0Xhak3Uaac@vostro.rjw.lan>
 <CAKfTPtANvYp5ar8UkKyN9R25Ntrfp+bEEFw5M0=MA8q7zscSMw@mail.gmail.com>
 <CAJZ5v0jvStPbhKSJUHTwySkEXa0rKp3zE7YLWeCmGHeQt8xcrw@mail.gmail.com>
 <CAJZ5v0gC_S+a43FvgpB25WnpAANkDQk7agwSx4gRJvdmnPFkeQ@mail.gmail.com>
 <20160303122030.GN6356@twins.programming.kicks-ass.net>
 <CAJZ5v0ifY7V48Vh8PdErobxiB0_NAweQ3XiSaMgby54varMLkQ@mail.gmail.com>
 <20160303163735.GS6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160303163735.GS6356@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 03, 2016 at 05:37:35PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 03, 2016 at 05:24:32PM +0100, Rafael J. Wysocki wrote:
> > >> f = a * x + b

> > If not, then I think it's reasonable to map the middle of the
> > available frequency range to x = 0.5 and then we have b = 0 and a =
> > (max_freq + min_freq) / 2.
> 
> So I really think that approach falls apart on the low util bits, you
> effectively always run above min speed, even if min is already vstly
> over provisioned.

Ah nevermind, I cannot read. Yes that is worth trying I suppose. But the
b=0,a=1 thing seems more natural still.
