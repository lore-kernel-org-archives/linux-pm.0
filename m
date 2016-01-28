From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH] cpufreq: Fix NULL reference crash while accessing
 policy->governor_data
Date: Thu, 28 Jan 2016 10:44:34 +0000
Message-ID: <20160128104434.GT10898@e106622-lin>
References: <1297c8fc8135f8b5359f9c49d220a939c0ee640e.1453741314.git.viresh.kumar@linaro.org>
 <3004241.yqvZmcL5vE@vostro.rjw.lan>
 <20160128021553.GC3935@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59032 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964914AbcA1Kn6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 Jan 2016 05:43:58 -0500
Content-Disposition: inline
In-Reply-To: <20160128021553.GC3935@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, "# v4 . 2+" <stable@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 28/01/16 07:45, Viresh Kumar wrote:
> On 27-01-16, 23:54, Rafael J. Wysocki wrote:
> > So I've applied this, but I'm not sure it is sufficient yet.
> 
> At least, this solves the crash Juri was hitting on a multi cluster
> box.
> 
> > Have you double checked whether or not stuff cannot be reordered by
> > the CPU and/or the compiler and no additional memory barriers are needed?
> 
> I don't think CPU will reorder things before a function call. It can
> reorder lines, which CPU thinks aren't related but it can't assume the
> same in this case. We have tons of code like this.
> 
> @Juri: What do you say? 
> 

Yeah, it looks good on my boxes (even though I'll run some more tests
later today). I'm not entirely sure either about the reordering, but
reordering across a function call (of a different compilation unit)
seems quite unlikely to me as well.

Best,

- Juri
