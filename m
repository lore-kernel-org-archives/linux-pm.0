From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering
 utilization update callbacks
Date: Fri, 19 Feb 2016 09:28:23 -0800
Message-ID: <56C750B7.6090701@linaro.org>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <2044559.7ypXocW9OZ@vostro.rjw.lan> <3499355.2JlaSruvOa@vostro.rjw.lan>
 <16016177.YFqb4gVNBo@vostro.rjw.lan>
 <CAJZ5v0jthTo8rXMp_ad=k5EcFBcwLgKRMnwPsznqDhois84uYA@mail.gmail.com>
 <20160219080917.GE22643@pablo> <1455900129.7375.231.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38609 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424899AbcBSR22 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2016 12:28:28 -0500
Received: by mail-wm0-f41.google.com with SMTP id a4so80667251wme.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Feb 2016 09:28:27 -0800 (PST)
In-Reply-To: <1455900129.7375.231.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 02/19/2016 08:42 AM, Srinivas Pandruvada wrote:
> We did experiments using util/max in intel_pstate. For some benchmarks
> there were regression of 4 to 5%, for some benchmarks it performed at
> par with getting utilization from the processor. Further optimization
> in the algorithm is possible and still in progress. Idea is that we can
> change P-State fast enough and be more reactive. Once I have good data,
> I will send to this list. The algorithm can be part of the cpufreq
> governor too.

There has been a lot of work in the area of scheduler-driven CPU
frequency selection by Linaro and ARM as well. It was posted most
recently a couple months ago:

http://thread.gmane.org/gmane.linux.power-management.general/69176

It was also posted as part of the energy-aware scheduling series last
July. There's a new RFC series forthcoming which I had hoped (and
failed) to post prior to my business travel this week; it should be out
next week. It will address the feedback received thus far along with
locking and other things.

The scheduler hooks for utilization-based cpufreq operation deserve a
lot more debate I think. They could quite possibly have different
requirements than hooks which are chosen just to guarantee periodic
callbacks into sampling-based governors.

For my part I think it would be best if the util/max parameters are
omitted until it's clear whether these same hooks can be effectively
used for architecture agnostic scheduler-guided (capacity driven) CPU
frequency support. My upcoming RFC will provide another opportunity to
debate the hooks as well as how scheduler-guided CPU frequency should be
structured.

thanks,
Steve
