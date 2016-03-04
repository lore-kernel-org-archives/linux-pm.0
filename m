From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Fri, 4 Mar 2016 02:14:06 +0100
Message-ID: <CAJZ5v0i6A8EDWXjU5+ANW_n1Rpv1xaWwWV7Q9-1NgO5P8HnhUw@mail.gmail.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
	<1842158.0Xhak3Uaac@vostro.rjw.lan>
	<CAKfTPtANvYp5ar8UkKyN9R25Ntrfp+bEEFw5M0=MA8q7zscSMw@mail.gmail.com>
	<CAJZ5v0jvStPbhKSJUHTwySkEXa0rKp3zE7YLWeCmGHeQt8xcrw@mail.gmail.com>
	<CAJZ5v0gC_S+a43FvgpB25WnpAANkDQk7agwSx4gRJvdmnPFkeQ@mail.gmail.com>
	<20160303122030.GN6356@twins.programming.kicks-ass.net>
	<CAJZ5v0ifY7V48Vh8PdErobxiB0_NAweQ3XiSaMgby54varMLkQ@mail.gmail.com>
	<20160303163735.GS6356@twins.programming.kicks-ass.net>
	<20160303164751.GD6375@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:34082 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756879AbcCDBOJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 20:14:09 -0500
In-Reply-To: <20160303164751.GD6375@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>

On Thu, Mar 3, 2016 at 5:47 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Mar 03, 2016 at 05:37:35PM +0100, Peter Zijlstra wrote:
>> On Thu, Mar 03, 2016 at 05:24:32PM +0100, Rafael J. Wysocki wrote:
>> > >> f = a * x + b
>
>> > If not, then I think it's reasonable to map the middle of the
>> > available frequency range to x = 0.5 and then we have b = 0 and a =
>> > (max_freq + min_freq) / 2.

That actually should be a = max_freq + min_freq, because I want
(max_freq + min_freq) / 2 = a / 2.

>> So I really think that approach falls apart on the low util bits, you
>> effectively always run above min speed, even if min is already vstly
>> over provisioned.
>
> Ah nevermind, I cannot read. Yes that is worth trying I suppose. But the
> b=0,a=1 thing seems more natural still.

It is somewhat imbalanced, though.  If all of the values of x are
equally probable (or equally frequent), the probability of running
above the middle frequency is lower than the probability of running
below it.
