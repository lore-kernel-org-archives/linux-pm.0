From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 03/13] cpufreq: governor: New sysfs show/store
 callbacks for governor tunables
Date: Tue, 9 Feb 2016 08:51:26 +0530
Message-ID: <20160209032126.GA23393@vireshk>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
 <89c003851ca3be77cf3656805303bf4f36d585ea.1454931188.git.viresh.kumar@linaro.org>
 <CAJZ5v0jZs1=sxq2Fz38dZFj3-4SK7HvLEWoFQe4eJaPPSeFkXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35420 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbcBIDVa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 22:21:30 -0500
Received: by mail-pf0-f178.google.com with SMTP id c10so53381484pfc.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 19:21:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jZs1=sxq2Fz38dZFj3-4SK7HvLEWoFQe4eJaPPSeFkXQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 08-02-16, 22:36, Rafael J. Wysocki wrote:
> On Mon, Feb 8, 2016 at 12:39 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +       ret = kobject_init_and_add(&dbs_data->kobj, &gov->kobj_type,
> > +                                  get_governor_parent_kobj(policy),
> > +                                  gov->kobj_name);
> 
> Besides, you forgot about the format argument for kobject_init_and_add().

What about that? Why is it required here ? We don't have to modify the
gov->gov.name string at all, and that string can be used here without adding any
more format arguments.

-- 
viresh
