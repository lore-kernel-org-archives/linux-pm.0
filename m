From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 2/10] cpufreq: governor: Use common mutex for dbs_data protection
Date: Fri, 05 Feb 2016 23:59:11 +0100
Message-ID: <4787292.dQnn9ZTm9B@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan> <76588769.1gWBaNHTiQ@vostro.rjw.lan> <20160205065341.GE21792@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51249 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751733AbcBEW6F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2016 17:58:05 -0500
In-Reply-To: <20160205065341.GE21792@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On Friday, February 05, 2016 12:23:41 PM Viresh Kumar wrote:
> On 05-02-16, 03:14, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Every governor relying on the common code in cpufreq_governor.c
> > has to provide its own mutex in struct common_dbs_data.  However,
> > there actually is no need to have a separate mutex per governor
> > for this purpose, they may be using the same global mutex just
> > fine.  Accordingly, introduce a single common mutex for that and
> > drop the mutex field from struct common_dbs_data.
> > 
> > That at least will ensure that the mutex is always present and
> > initialized regardless of what the particular governors do.
> > 
> > Another benefit is that the common code does not need a pointer to
> > a governor-related structure to get to the mutex which sometimes
> > helps.
> > 
> > Finally, it makes the code generally easier to follow.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Acked-by: Saravana Kannan <skannan@codeaurora.org>
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!

One more observation here.

If we are able to eliminate dbs_data_mutex from update_sampling_rate(),
then cpufreq_governor_dbs() becomes the only user of that lock.  Further,
if we can guarantee that the governor's ->governor callback will always
be invoked under policy->rwsem, dbs_data_mutex becomes unnecessary and
may be dropped.

Thanks,
Rafael

