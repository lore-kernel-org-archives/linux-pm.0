From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] cpufreq: pmac64: speed up frequency switch
Date: Fri, 16 Aug 2013 08:14:32 +1000
Message-ID: <1376604872.4255.115.camel@pasglop>
References: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
	 <9298823.WUCyZreP9q@vostro.rjw.lan> <1374614043.3916.84.camel@pasglop>
	 <1376269668.32100.148.camel@pasglop>
	 <20130815201000.GB3067@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:46463 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901Ab3HOWPF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 Aug 2013 18:15:05 -0400
In-Reply-To: <20130815201000.GB3067@blackmetal.musicnaut.iki.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Nick Piggin <npiggin@suse.de>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Thu, 2013-08-15 at 23:10 +0300, Aaro Koskinen wrote:

> I guess we should keep the current 12us latency in g5_neo2_cpufreq_init()
> (although I doubt it's correct...), and only add the new 10ms latency
> value to g5_pm72_cpufreq_init() - that way we can enable the older systems
> to use ondemand (despite long latencies), while not risking regressing
> any of the current functionality.
> 
> I'll resend the series with the changes.

Well, mine is a 11,2, it's not a neo2.

I suppose we could try to measure the latency :-)

Cheers,
Ben.


