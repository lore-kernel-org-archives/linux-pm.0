From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: Separate CPU device removal from CPU online
Date: Fri, 24 Jul 2015 07:49:16 +0530
Message-ID: <20150724021916.GA11315@linux>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
 <15986005.VczafT3nkj@vostro.rjw.lan>
 <20150723063942.GF5322@linux>
 <1532128.uWbA5iRc7E@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36231 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbbGXCTV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 22:19:21 -0400
Received: by pdjr16 with SMTP id r16so5602310pdj.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2015 19:19:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1532128.uWbA5iRc7E@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 23-07-15, 22:56, Rafael J. Wysocki wrote:
> > > +	if (policy && policy->kobj_cpu != cpu) {
> > 
> > Why are you comparing cpu against kobj_cpu ? I don't think it can ever
> > be false.

So what I meant was that the expression 'policy->kobj_cpu != cpu' will
never return 'false'. Because policy->kobj_cpu is going to get set to
the cpu for which we allocated the policy. And so it wouldn't match
for any other CPU.

> It can.  When we're adding a CPU that has a policy already, because it is
> "related" to a previously registered CPU.

In this case also the expression will return true.

> > > +		ret = sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
> > > +		if (ret) {
> > > +			dev_dbg(dev, "%s: Failed to create link (%d)\n",
> > 
> > dev_err
> 
> Well, I'm wondering about this.  Why does this have to be dev_err()?

Isn't this an error? We need to create a symlink, we failed and
atleast the user should know about it. Why hide such failures ?

-- 
viresh
