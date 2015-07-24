From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] cpufreq: Separate CPU device removal from CPU online
Date: Fri, 24 Jul 2015 21:54:30 +0200
Message-ID: <4877095.RtPZqi4Ng3@vostro.rjw.lan>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan> <1532128.uWbA5iRc7E@vostro.rjw.lan> <20150724021916.GA11315@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50669 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752134AbbGXT1k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2015 15:27:40 -0400
In-Reply-To: <20150724021916.GA11315@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Friday, July 24, 2015 07:49:16 AM Viresh Kumar wrote:
> On 23-07-15, 22:56, Rafael J. Wysocki wrote:
> > > > +	if (policy && policy->kobj_cpu != cpu) {
> > > 
> > > Why are you comparing cpu against kobj_cpu ? I don't think it can ever
> > > be false.
> 
> So what I meant was that the expression 'policy->kobj_cpu != cpu' will
> never return 'false'. Because policy->kobj_cpu is going to get set to
> the cpu for which we allocated the policy. And so it wouldn't match
> for any other CPU.

Unless kobj_cpu is removed before another one is registered (not a very
realistic scenario, but there's no guarantee that it will never happen).

But in that case we won't do the right thing anyway ...

> > It can.  When we're adding a CPU that has a policy already, because it is
> > "related" to a previously registered CPU.
> 
> In this case also the expression will return true.
> 
> > > > +		ret = sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
> > > > +		if (ret) {
> > > > +			dev_dbg(dev, "%s: Failed to create link (%d)\n",
> > > 
> > > dev_err
> > 
> > Well, I'm wondering about this.  Why does this have to be dev_err()?
> 
> Isn't this an error? We need to create a symlink, we failed and
> atleast the user should know about it. Why hide such failures ?

dev_err() doesn't mean "device error message".  It means "high priority device
message".

The user will know that the link is not there anyway and the question here is
whether or not the associated kernel message has to be high-priority.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
