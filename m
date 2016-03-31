From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 7/7][Resend] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Thu, 31 Mar 2016 14:28:09 +0200
Message-ID: <20160331122809.GK3408@twins.programming.kicks-ass.net>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <6666532.7ULg06hQ7e@vostro.rjw.lan>
 <20160328090333.GK32495@vireshk-i7>
 <2253696.9jRPsKRmxz@vostro.rjw.lan>
 <CAJZ5v0jEueokR+bZJVRjQtmUe6BeKqUgnjWy9BZm4nGnKjT9mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:47019 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbcCaM2M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 08:28:12 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jEueokR+bZJVRjQtmUe6BeKqUgnjWy9BZm4nGnKjT9mg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Wed, Mar 30, 2016 at 03:12:40AM +0200, Rafael J. Wysocki wrote:
> Except that for_each_cpu_and_not is not defined as of today.
> 
> I guess I can play with cpumasks, but then I'm not sure that will end
> up actually more efficient.

It will not indeed.
