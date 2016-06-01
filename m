From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Implement light weight
 cpufreq_get_policy_table() routine
Date: Wed, 1 Jun 2016 07:24:05 +0530
Message-ID: <20160601015405.GB3725@vireshk-i7>
References: <57ec51642c05c8a859ba4bf90fdc80b23d75e239.1464241360.git.viresh.kumar@linaro.org>
 <CAJZ5v0h95G7ngB7tMpV_vbERZivuLBxXNROqMMQyPaShyr_Raw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35096 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbcFAByJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 21:54:09 -0400
Received: by mail-pf0-f180.google.com with SMTP id g64so4070578pfb.2
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2016 18:54:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h95G7ngB7tMpV_vbERZivuLBxXNROqMMQyPaShyr_Raw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>

On 01-06-16, 00:40, Rafael J. Wysocki wrote:
> On Thu, May 26, 2016 at 7:42 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Most of the callers of cpufreq_frequency_get_table() already have the
> > pointer to a valid policy structure and they don't really need to go
> > through the per-cpu variable first and then a check to validate the
> > frequency, in order to find the freq-table for the policy.
> >
> > Implement a light weight call for this and update users.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c             | 4 ++--
> >  drivers/cpufreq/cpufreq_ondemand.c    | 2 +-
> >  drivers/cpufreq/cpufreq_stats.c       | 3 +--
> >  drivers/cpufreq/freq_table.c          | 4 ++--
> >  drivers/cpufreq/ppc_cbe_cpufreq_pmi.c | 2 +-
> >  include/linux/cpufreq.h               | 7 +++++++
> >  6 files changed, 14 insertions(+), 8 deletions(-)

Submitted another version which accesses policy->freq_table directly
instead.

-- 
viresh
