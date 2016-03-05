From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 6/10] cpufreq: Support for fast frequency switching
Date: Sat, 5 Mar 2016 12:58:42 +0100
Message-ID: <20160305115842.GB11846@gmail.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <2409306.qzzMXcm4dm@vostro.rjw.lan>
 <15684081.T4iOMUSHCY@vostro.rjw.lan>
 <56DA09B1.4010005@linaro.org>
 <CAJZ5v0jENyu8j0fq1-BhU64QwRHAjvcjQktYc2sa9QmhktoEnQ@mail.gmail.com>
 <CAJZ5v0jd6sXQnvZ87=_L1MQgu2QsBJtYb8jwn=0=m7eRdKVvhA@mail.gmail.com>
 <CAJZ5v0jh7qcmYjDXCdO3Pid4XyuuxQfsKAmWDLXYcrkx0t-phw@mail.gmail.com>
 <56DA20C0.1070803@linaro.org>
 <CAJZ5v0gqnDR8BJ6JUKBB7-T8MAhNge9TPngZ9Crc45TRzm04vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32897 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbcCEL6s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 5 Mar 2016 06:58:48 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gqnDR8BJ6JUKBB7-T8MAhNge9TPngZ9Crc45TRzm04vQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>


* Rafael J. Wysocki <rafael@kernel.org> wrote:

> > Honestly I wonder if it's better to just try the "no notifiers with fast 
> > drivers" approach to start. The notifiers could always be added if platform 
> > owners complain that they absolutely require them.
> 
> Well, I'm not sure what happens if we start to fail notifier registrations.  It 
> may not be a well tested error code path. :-)

Yeah, so as a general principle 'struct notifier_block' as a really bad interface 
with poor and fragile semantics, and we are trying to get rid of them everywhere 
from core kernel code. For example Thomas Gleixner et al is working on eliminating 
them from the CPU hotplug code - which will get rid of most remaining notifier 
uses from the scheduler as well.

So please add explicit cpufreq driver callback functions instead, which can be 
filled in by a platform if needed. No notifiers!

Thanks,

	Ingo
