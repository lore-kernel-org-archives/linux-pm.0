From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: cpufreq-next opps with cpufreq-bench
Date: Sun, 13 Oct 2013 23:45:47 +0200
Message-ID: <20131013214547.GC24927@lunn.ch>
References: <20131013090159.GB24566@lunn.ch>
 <1495620.7xAc6pX6Cx@vostro.rjw.lan>
 <20131013210915.GA24927@lunn.ch>
 <20131013211436.GB24927@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:41458 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755356Ab3JMVtz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 13 Oct 2013 17:49:55 -0400
Content-Disposition: inline
In-Reply-To: <20131013211436.GB24927@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, viresh.kumar@linaro.org, linux-pm@vger.kernel.org

On Sun, Oct 13, 2013 at 11:14:36PM +0200, Andrew Lunn wrote:
> On Sun, Oct 13, 2013 at 11:09:15PM +0200, Andrew Lunn wrote:
> > > > I did a bisect, and the problem is in the patch:
> > > > 
> > > > cpufreq: create per policy rwsem instead of per cpu cpu_policy_rwsem
> > > > e4762ba2d652dbc4c496c5abdcc80702544ca1fc
> > > 
> > > Is this bug present in current linux-next?
> > 
> > The current linux-next seems to be next-20130927, since Stephen
> > Rothwell is away to the moment. The patch causing the problem is not
> > in linux-next.
> 
> Hi Rafael
> 
> It is however in your linux-next branch:
> 
> http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/drivers/cpufreq/cpufreq.c?h=linux-next&id=e4762ba2d652dbc4c496c5abdcc80702544ca1fc
> 
> I will build your tree and test...

Done.

It also has the bug.

   Andrew
