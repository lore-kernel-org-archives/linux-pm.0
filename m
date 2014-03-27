From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
Date: Thu, 27 Mar 2014 23:56:17 +1100
Message-ID: <1395924977.5569.109.camel@pasglop>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
	 <1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
	 <CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
	 <20140327093050.GA27777@in.ibm.com>
	 <CAKohponOe9Au+pe5u9FpddW3+f5pegZB953+5fmYBDusE9j0HA@mail.gmail.com>
	 <20140327112031.GC27777@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:55775 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756694AbaC0M4r (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Mar 2014 08:56:47 -0400
In-Reply-To: <20140327112031.GC27777@in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ego@linux.vnet.ibm.com
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Linux PM list <linux-pm@vger.kernel.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>

On Thu, 2014-03-27 at 16:50 +0530, Gautham R Shenoy wrote:
> 
> Well, in the scenarios that we're interested in, it is highly unlikely
> that CONFIG_PREMPT is set. Hence we'll default to
> raw_smp_processor_id() anyway. So, I think we can retain
> smp_processor_id(). 

We don't know that. Some people are interested in running preempt
on these things. If raw is ok to call here, please use it.

Cheers,
Ben.


