From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] Increase in idle power with schedutil
Date: Thu, 19 May 2016 13:40:29 +0200
Message-ID: <20160519114029.GW3193@twins.programming.kicks-ass.net>
References: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAJZ5v0jv+fD-ZKjLBepL9Fkn1JFROO3nGHX_3-=PuzGSAALB5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49510 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbcESLkh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 07:40:37 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jv+fD-ZKjLBepL9Fkn1JFROO3nGHX_3-=PuzGSAALB5g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, Steve Muckle <steve.muckle@linaro.org>

On Wed, May 18, 2016 at 11:11:51PM +0200, Rafael J. Wysocki wrote:
> On Wed, May 18, 2016 at 2:53 PM, Shilpasri G Bhat
> <shilpa.bhat@linux.vnet.ibm.com> wrote:
> > This patch adds driver callback for fast_switch and below observations
> > on schedutil governor are done with this patch.
> >
> > In POWER8 there is a regression observed with schedutil compared to
> > ondemand. With schedutil the frequency is not ramping down and is
> > mostly stuck at max frequency during idle . This is because of the
> > watchdog timer, an RT task which is fired every 4 seconds which
> > results in requesting max frequency.
> 
> Well, yes, that would be problematic.
> 

Right; we need to come up with something for RT tasks; but what happens
if you disable the watchdog? This should be entirely doable and might
give a better comparison.
