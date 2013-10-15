From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: cpufreq-next opps with cpufreq-bench
Date: Wed, 16 Oct 2013 01:23:37 +0200
Message-ID: <2502389.2uE805jDh9@vostro.rjw.lan>
References: <20131013090159.GB24566@lunn.ch> <20131013211436.GB24927@lunn.ch> <20131013214547.GC24927@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63622 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933729Ab3JOXLr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2013 19:11:47 -0400
In-Reply-To: <20131013214547.GC24927@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org

On Sunday, October 13, 2013 11:45:47 PM Andrew Lunn wrote:
> On Sun, Oct 13, 2013 at 11:14:36PM +0200, Andrew Lunn wrote:
> > On Sun, Oct 13, 2013 at 11:09:15PM +0200, Andrew Lunn wrote:
> > > > > I did a bisect, and the problem is in the patch:
> > > > > 
> > > > > cpufreq: create per policy rwsem instead of per cpu cpu_policy_rwsem
> > > > > e4762ba2d652dbc4c496c5abdcc80702544ca1fc
> > > > 
> > > > Is this bug present in current linux-next?
> > > 
> > > The current linux-next seems to be next-20130927, since Stephen
> > > Rothwell is away to the moment. The patch causing the problem is not
> > > in linux-next.
> > 
> > Hi Rafael
> > 
> > It is however in your linux-next branch:
> > 
> > http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/drivers/cpufreq/cpufreq.c?h=linux-next&id=e4762ba2d652dbc4c496c5abdcc80702544ca1fc
> > 
> > I will build your tree and test...
> 
> Done.
> 
> It also has the bug.

Well, I've dropped the offending commit from my queue.  Hopefully, it still
builds on all targets it used to build on.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
