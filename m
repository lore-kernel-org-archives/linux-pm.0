From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 7/7][Resend] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Thu, 31 Mar 2016 14:24:45 +0200
Message-ID: <20160331122445.GJ3408@twins.programming.kicks-ass.net>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <6666532.7ULg06hQ7e@vostro.rjw.lan>
 <56F5E1F2.5090100@linaro.org>
 <CAJZ5v0j=LwOT=sjSOwwzY=sYLqiV1tuvVazzgU+yMwMWXmpR8A@mail.gmail.com>
 <CAJZ5v0i1=P45wWHYHVp9mW=h7w_MywFz7x2qmEs2iiEhJSq-5g@mail.gmail.com>
 <56F97548.1030903@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:46958 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbcCaMYt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 08:24:49 -0400
Content-Disposition: inline
In-Reply-To: <56F97548.1030903@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Mon, Mar 28, 2016 at 11:17:44AM -0700, Steve Muckle wrote:
> The scenario I'm contemplating is that while a CPU-intensive task is
> running a thermal interrupt goes off. The driver for this thermal
> interrupt responds by capping fmax. If this happens just after the tick,
> it seems possible that we could wait a full tick before changing the
> frequency. Given a 10ms tick it could be rather annoying for thermal
> management algorithms on some platforms (I'm familiar with a few).

So I'm blissfully unaware of all the thermal stuffs we have; but it
looks like its somehow bolten onto cpufreq without feedback.

The thing I worry about is thermal scaling the CPU back past where RT/DL
tasks can still complete in time. It should not be able to do that, or
rather, missing deadlines because thermal is about as useful as
rebooting the device.

I guess I'm saying is, the whole cpufreq/thermal 'interface' needs work
anyhow.
