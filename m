From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] Increase in idle power with schedutil
Date: Sun, 22 May 2016 12:39:12 +0200
Message-ID: <20160522103912.GN3193@twins.programming.kicks-ass.net>
References: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAJZ5v0jv+fD-ZKjLBepL9Fkn1JFROO3nGHX_3-=PuzGSAALB5g@mail.gmail.com>
 <20160519114029.GW3193@twins.programming.kicks-ass.net>
 <201605201223.u4KCNWn9028105@mx0a-001b2d01.pphosted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40711 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbcEVKjT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 May 2016 06:39:19 -0400
Content-Disposition: inline
In-Reply-To: <201605201223.u4KCNWn9028105@mx0a-001b2d01.pphosted.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, Steve Muckle <steve.muckle@linaro.org>

On Fri, May 20, 2016 at 05:53:41PM +0530, Shilpasri G Bhat wrote:
> 
> Below are the comparisons by disabling watchdog.
> Both schedutil and ondemand have a similar ramp-down trend. And in both the
> cases I can see that frequency of the cpu is not reduced in deterministic
> fashion. In a observation window of 30 seconds after running a workload I can
> see that the frequency is not ramped down on some cpus in the system and are
> idling at max frequency.

So does it actually matter what the frequency is when you idle? Isn't
the whole thing clock gated anyway?

Because this seems to generate contradictory requirements, on the one
hand we want to stay idle as long as possible while on the other hand
you seem to want to clock down while idle, which requires not being
idle.

If it matters; should not your idle state muck explicitly set/restore
frequency?
