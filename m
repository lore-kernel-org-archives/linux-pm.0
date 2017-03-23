From: Sai Gurrappadi <sgurrappadi@nvidia.com>
Subject: Re: [RFC][PATCH v3 2/2] cpufreq: schedutil: Avoid reducing frequency
 of busy CPUs prematurely
Date: Thu, 23 Mar 2017 13:48:16 -0700
Message-ID: <58D43490.3080807@nvidia.com>
References: <4366682.tsferJN35u@aspire.rjw.lan> <2185243.flNrap3qq1@aspire.rjw.lan> <3300960.HE4b3sK4dn@aspire.rjw.lan> <2997922.DidfPadJuT@aspire.rjw.lan> <58D42173.2080205@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1859 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932359AbdCWUue (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 16:50:34 -0400
In-Reply-To: <58D42173.2080205@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Boonstoppel <pboonstoppel@nvidia.com>



On 03/23/2017 12:26 PM, Sai Gurrappadi wrote:

> 
> Hm, sorry I am a bit confused perhaps you could help me understand the problem/solution better :)
> 
> Say we have the this simple case of only a single periodic task running on one CPU, wouldn't the PELT update on wakeup cause a frequency update which updates the sg_cpu->saved_idle_calls value here? That would then cause the frequency update on idle entry to always skip dropping frequency right?
 
Apologies, this example here is flawed because on task dequeue, its utilization isn't removed. There is no problem in this case...


-Sai
