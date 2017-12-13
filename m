From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] cpufreq: schedutil: Initialize sg_cpu->flags to 0
Date: Wed, 13 Dec 2017 16:52:10 +0530
Message-ID: <20171213112210.GF3322@vireshk-i7>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
 <763feda6424ced8486b25a0c52979634e6104478.1513158452.git.viresh.kumar@linaro.org>
 <20171213111346.GC30887@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40384 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbdLMLWO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 06:22:14 -0500
Received: by mail-pl0-f68.google.com with SMTP id 1so810336pla.7
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2017 03:22:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171213111346.GC30887@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org

On 13-12-17, 12:13, Juri Lelli wrote:
> Hi Viresh,
> 
> On 13/12/17 15:23, Viresh Kumar wrote:
> > Initializing sg_cpu->flags to SCHED_CPUFREQ_RT has no obvious benefit.
> > The flags field wouldn't be used until the utilization update handler is
> > called for the first time, and once that is called we will overwrite
> > flags anyway.
> > 
> > Initialize it to 0.
> > 
> > Change-Id: I028dbb40c5c242cff52fe1b14aeaff37f29a2f8d
> 
> Without ^

Wow. I have a script in place to make sure this doesn't get added. Not sure how
this got added here, while its not present in any of the other patches.

> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
> 
> Best,
> 
> - Juri

-- 
viresh
