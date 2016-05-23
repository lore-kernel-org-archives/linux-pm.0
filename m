From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] Increase in idle power with schedutil
Date: Mon, 23 May 2016 11:24:51 +0200
Message-ID: <20160523092451.GF15728@worktop.ger.corp.intel.com>
References: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAJZ5v0jv+fD-ZKjLBepL9Fkn1JFROO3nGHX_3-=PuzGSAALB5g@mail.gmail.com>
 <20160519114029.GW3193@twins.programming.kicks-ass.net>
 <201605201223.u4KCNWn9028105@mx0a-001b2d01.pphosted.com>
 <20160522103912.GN3193@twins.programming.kicks-ass.net>
 <20160522204252.GH15383@graphite.smuckle.net>
 <20160523090004.GA21186@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:41717 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbcEWJZG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 May 2016 05:25:06 -0400
Content-Disposition: inline
In-Reply-To: <20160523090004.GA21186@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Steve Muckle <steve.muckle@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org

On Mon, May 23, 2016 at 10:00:04AM +0100, Lorenzo Pieralisi wrote:
> It is also related to static leakage power that depends on the operating
> voltage (ie higher operating frequencies require higher voltage) so in a
> way scaling frequency before going idle may not be effective if voltage
> does not scale too in turn.

Sure, but the platform drivers 'know' all this and can make the right
decision.
