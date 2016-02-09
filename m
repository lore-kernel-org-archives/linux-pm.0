From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 03/13] cpufreq: governor: New sysfs show/store callbacks for governor tunables
Date: Tue, 09 Feb 2016 21:20:31 +0100
Message-ID: <1574334.EZHJkPPKZd@vostro.rjw.lan>
References: <cover.1454931188.git.viresh.kumar@linaro.org> <CAJZ5v0jZs1=sxq2Fz38dZFj3-4SK7HvLEWoFQe4eJaPPSeFkXQ@mail.gmail.com> <20160209032126.GA23393@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62952 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755077AbcBIUTU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 15:19:20 -0500
In-Reply-To: <20160209032126.GA23393@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tuesday, February 09, 2016 08:51:26 AM Viresh Kumar wrote:
> On 08-02-16, 22:36, Rafael J. Wysocki wrote:
> > On Mon, Feb 8, 2016 at 12:39 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > +       ret = kobject_init_and_add(&dbs_data->kobj, &gov->kobj_type,
> > > +                                  get_governor_parent_kobj(policy),
> > > +                                  gov->kobj_name);
> > 
> > Besides, you forgot about the format argument for kobject_init_and_add().
> 
> What about that? Why is it required here ? We don't have to modify the
> gov->gov.name string at all, and that string can be used here without adding any
> more format arguments.

But that's because the governor name is a static string and we can safely pass
it as a format (because we know that it doesn't contain any output field specifiers
in particular).

So either there should be a comment to that effect in the code, or the format
argument should be present.

Thanks,
Rafael

