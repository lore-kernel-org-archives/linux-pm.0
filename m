From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: cpufreq-next opps with cpufreq-bench
Date: Sun, 13 Oct 2013 23:29:54 +0200
Message-ID: <3119345.O6JJGb18ys@vostro.rjw.lan>
References: <20131013090159.GB24566@lunn.ch> <1495620.7xAc6pX6Cx@vostro.rjw.lan> <20131013210915.GA24927@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61704 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755230Ab3JMVSI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 13 Oct 2013 17:18:08 -0400
In-Reply-To: <20131013210915.GA24927@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org

On Sunday, October 13, 2013 11:09:15 PM Andrew Lunn wrote:
> > > I did a bisect, and the problem is in the patch:
> > > 
> > > cpufreq: create per policy rwsem instead of per cpu cpu_policy_rwsem
> > > e4762ba2d652dbc4c496c5abdcc80702544ca1fc
> > 
> > Is this bug present in current linux-next?
> 
> The current linux-next seems to be next-20130927, since Stephen
> Rothwell is away to the moment. The patch causing the problem is not
> in linux-next.
> 
> However, i will build and test, tomorrow.

Well, I was talking about the current linux-next branch of the tree at:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
