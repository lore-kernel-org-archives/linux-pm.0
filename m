From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 9/10] cpufreq: governor: Rearrange governor data structures
Date: Sun, 07 Feb 2016 15:34:29 +0100
Message-ID: <2128774.ZZqv5COSxS@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan> <2480267.pVUasc5mK9@vostro.rjw.lan> <20160207092911.GA19059@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54631 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753670AbcBGOdU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Feb 2016 09:33:20 -0500
In-Reply-To: <20160207092911.GA19059@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On Sunday, February 07, 2016 02:59:11 PM Viresh Kumar wrote:
> On 05-02-16, 23:47, Rafael J. Wysocki wrote:
> > On Friday, February 05, 2016 02:43:57 PM Viresh Kumar wrote:
> > > Value of policy_dbs->policy was used to verify the state machine of
> > > the governor and so was updated only in start/stop.
> > > 
> > > You have moved it to INIT first (which shouldn't have been part of
> > > this patch at the least),
> > 
> > Why?
> 
> Because it doesn't match $SUBJECT at all..
> 
> > > and then there is no reasoning given on why
> > > that isn't required as part of the state machine now, which I believe
> > > is still required the way it was.
> > 
> > No, it isn't required.  The whole "state machine" isn't required IMO.
> 
> The state machine wasn't required if the core wasn't buggy. Its buggy because we
> drop policy->rwsem during set-policy, before calling EXIT. And other
> __cpufreq_governor() calls can shoot up at that point of time.
> 
> We have seen lots of crashes earlier and so the state machine was introduced to
> get them fixed.
> 
> It might not be required (after making sure things are working fine now), after
> applying my patch series of 7 patches. As that fixes the lock-drop issue ..
> 
> > The only user of this is the cpufreq core, so why does the code here have to
> > double check what the core is doing?
> 
> Because, core doesn't guarantee the order today.

OK, so I have reworked this.  I have a series of 3 patches now instead of it
that I'm going to post shortly.

Thanks,
Rafael

