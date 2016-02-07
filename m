From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 2/10] cpufreq: governor: Use common mutex for dbs_data protection
Date: Sun, 07 Feb 2016 15:33:07 +0100
Message-ID: <2182507.NaCeYsVQeB@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan> <4787292.dQnn9ZTm9B@vostro.rjw.lan> <20160207093112.GB19059@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62892 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750749AbcBGOb7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Feb 2016 09:31:59 -0500
In-Reply-To: <20160207093112.GB19059@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On Sunday, February 07, 2016 03:01:12 PM Viresh Kumar wrote:
> On 05-02-16, 23:59, Rafael J. Wysocki wrote:
> > One more observation here.
> > 
> > If we are able to eliminate dbs_data_mutex from update_sampling_rate(),
> > then cpufreq_governor_dbs() becomes the only user of that lock.  Further,
> > if we can guarantee that the governor's ->governor callback will always
> > be invoked under policy->rwsem, dbs_data_mutex becomes unnecessary and
> > may be dropped.
> 
> That will be guaranteed with my 7 patches, which I will rebase and send again.
> 
> But there are cases where a single dbs_data is going to be used for multiple
> policies and so relying on policy->rwsem isn't going to be sufficient.
> 
> But, yeah, we should be able to narrow down the locked area I believe.

That should only be a matter of protecting the gov->gdbs_data object and its
refcount then.

Thanks,
Rafael

