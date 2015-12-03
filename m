From: Robert =?ISO-8859-1?Q?Sch=F6ne?= <robert.schoene@tu-dresden.de>
Subject: Re: [PATCH V2 06/10] cpufreq: governor: Keep single copy of
 information common to policy->cpus
Date: Thu, 03 Dec 2015 07:53:43 +0100
Message-ID: <1449125623.17314.13.camel@tu-dresden.de>
References: <cover.1434713657.git.viresh.kumar@linaro.org>
	 <efd892126475600e751c0e1206553270ebba5c00.1434713657.git.viresh.kumar@linaro.org>
	 <1448625400.3689.103.camel@pengutronix.de> <20151130051915.GH3373@ubuntu>
	 <1448879672.8275.15.camel@pengutronix.de> <20151130110327.GC4899@ubuntu>
	 <565F661F.1020204@codeaurora.org> <20151203045425.GA4302@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.zih.tu-dresden.de ([141.30.67.73]:45154 "EHLO
	mailout2.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751745AbbLCHJr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2015 02:09:47 -0500
In-Reply-To: <20151203045425.GA4302@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com


> There is another idea that I have.
> 
> Lets sacrifice idleness of CPU0 (which is already considered as
> housekeeping CPU in scheduler) to save us from all the complexity we
> have today.
> 
> Suppose we have 16 CPUs, with 4 CPUs per policy and hence 4 policies.
> - Keep a single delayed-work (non-deferrable) per policy and queue
> them as:
>   queue_work_on(CPU0).
> - This will work because any CPU can calculate the load of other
> CPUs,
>   and there is no dependency on the local CPU.
> - CPU0 will hence get interrupted, check if the policy->cpus are idle
>   or not, and if not, update their frequency (perhaps with an IPI).
> 
> Not sure if this will be better performance wise though.
> 

No it is not. In your example, everything could be okay with many ifs.
I'm from the HPC field and would expect load imbalances because this
approach does not scale with the number of frequency domains.

In 2011, AMD released Bulldozer servers with 4 sockets and each of
these sockets had 2 dies with 4 modules. Each module has its own
frequency domain, which sums up to 32 different domains.
Putting all the load to CPU0 will be unfavorable for a balanced
performance over all CPUS. This is worsened by the cache coherence
protocol which might delay accesses to shared and foreign memory
significantly.

And this had been in 2011. Today we have Haswell-EP quad socket servers
with up to 72 frequency domains for all CPUs of all sockets put
together. If you have an SGI Altix UV, you even have 256 sockets with
18 domains each, which sums up to 4608 domains.

I would expect architectures with more frequency domains in the future.

Robert

-- 

Dipl.-Inf. Robert Schoene
Computer Scientist - R&D Energy Efficient Computing

Technische Universitaet Dresden
Center for Information Services and High Performance Computing
Distributed and Data Intensive Computing
01062 Dresden
Tel.: +49 (351) 463-42483
Fax : +49 (351) 463-37773
E-Mail: Robert.Schoene@tu-dresden.de


