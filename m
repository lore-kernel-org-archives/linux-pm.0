From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 9/10] cpufreq: governor: Rearrange governor data
 structures
Date: Sun, 7 Feb 2016 14:59:11 +0530
Message-ID: <20160207092911.GA19059@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <13133705.tMsel709A1@vostro.rjw.lan>
 <20160205091357.GL21792@vireshk>
 <2480267.pVUasc5mK9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2480267.pVUasc5mK9@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 05-02-16, 23:47, Rafael J. Wysocki wrote:
> On Friday, February 05, 2016 02:43:57 PM Viresh Kumar wrote:
> > Value of policy_dbs->policy was used to verify the state machine of
> > the governor and so was updated only in start/stop.
> > 
> > You have moved it to INIT first (which shouldn't have been part of
> > this patch at the least),
> 
> Why?

Because it doesn't match $SUBJECT at all..

> > and then there is no reasoning given on why
> > that isn't required as part of the state machine now, which I believe
> > is still required the way it was.
> 
> No, it isn't required.  The whole "state machine" isn't required IMO.

The state machine wasn't required if the core wasn't buggy. Its buggy because we
drop policy->rwsem during set-policy, before calling EXIT. And other
__cpufreq_governor() calls can shoot up at that point of time.

We have seen lots of crashes earlier and so the state machine was introduced to
get them fixed.

It might not be required (after making sure things are working fine now), after
applying my patch series of 7 patches. As that fixes the lock-drop issue ..

> The only user of this is the cpufreq core, so why does the code here have to
> double check what the core is doing?

Because, core doesn't guarantee the order today.

-- 
viresh
