From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 1/4] cpufreq: schedutil: Initialize sg_cpu->flags to 0
Date: Wed, 13 Dec 2017 12:13:46 +0100
Message-ID: <20171213111346.GC30887@localhost.localdomain>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
 <763feda6424ced8486b25a0c52979634e6104478.1513158452.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38325 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752103AbdLMLNv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 06:13:51 -0500
Received: by mail-wm0-f65.google.com with SMTP id 64so4282290wme.3
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2017 03:13:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <763feda6424ced8486b25a0c52979634e6104478.1513158452.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org

Hi Viresh,

On 13/12/17 15:23, Viresh Kumar wrote:
> Initializing sg_cpu->flags to SCHED_CPUFREQ_RT has no obvious benefit.
> The flags field wouldn't be used until the utilization update handler is
> called for the first time, and once that is called we will overwrite
> flags anyway.
> 
> Initialize it to 0.
> 
> Change-Id: I028dbb40c5c242cff52fe1b14aeaff37f29a2f8d

Without ^

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Best,

- Juri
