From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 4/7] cpufreq / sched: Add flags argument to cpufreq_update_util()
Date: Mon, 01 Aug 2016 16:57:18 +0200
Message-ID: <1874381.hHx7HlTjB3@vostro.rjw.lan>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan> <1797214.I7CKAT8Nb2@vostro.rjw.lan> <20160801073312.GB4220@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64124 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752366AbcHAOyX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2016 10:54:23 -0400
In-Reply-To: <20160801073312.GB4220@light.dominikbrodowski.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

On Monday, August 01, 2016 09:33:12 AM Dominik Brodowski wrote:
> On Mon, Aug 01, 2016 at 01:36:46AM +0200, Rafael J. Wysocki wrote:
> > +#define UUF_RT	0x01
> 
> What does UUF stand for?

"Utilization upadte flag".

Thanks,
Rafael

