From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: cpufreq-next opps with cpufreq-bench
Date: Sun, 13 Oct 2013 23:09:15 +0200
Message-ID: <20131013210915.GA24927@lunn.ch>
References: <20131013090159.GB24566@lunn.ch>
 <1495620.7xAc6pX6Cx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:41442 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755192Ab3JMVNg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 13 Oct 2013 17:13:36 -0400
Content-Disposition: inline
In-Reply-To: <1495620.7xAc6pX6Cx@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andrew Lunn <andrew@lunn.ch>, viresh.kumar@linaro.org, linux-pm@vger.kernel.org

> > I did a bisect, and the problem is in the patch:
> > 
> > cpufreq: create per policy rwsem instead of per cpu cpu_policy_rwsem
> > e4762ba2d652dbc4c496c5abdcc80702544ca1fc
> 
> Is this bug present in current linux-next?

The current linux-next seems to be next-20130927, since Stephen
Rothwell is away to the moment. The patch causing the problem is not
in linux-next.

However, i will build and test, tomorrow.

	 Andrew
