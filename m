From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC/RFT][PATCH 0/4] cpufreq / sched: iowait boost in
 intel_pstate and schedutil
Date: Thu, 8 Sep 2016 12:26:15 -0700
Message-ID: <20160908192615.GD15431@graphite.smuckle.net>
References: <2730042.XLMy9dAKI1@vostro.rjw.lan>
 <20160908002226.GC15431@graphite.smuckle.net>
 <1473294950.154359.38.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33166 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964859AbcIHT0T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Sep 2016 15:26:19 -0400
Received: by mail-pa0-f50.google.com with SMTP id cm16so20227638pac.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Sep 2016 12:26:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1473294950.154359.38.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Doug Smythies <doug.smythies@gmail.com>

On Wed, Sep 07, 2016 at 05:35:50PM -0700, Srinivas Pandruvada wrote:
> Did you see any performance regression on Android workloads?

I did a few AnTuTU runs and did not observe a regression.

thanks,
Steve
