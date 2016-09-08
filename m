From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC/RFT][PATCH 0/4] cpufreq / sched: iowait boost in
 intel_pstate and schedutil
Date: Wed, 7 Sep 2016 17:22:26 -0700
Message-ID: <20160908002226.GC15431@graphite.smuckle.net>
References: <2730042.XLMy9dAKI1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33345 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752661AbcIHAWa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Sep 2016 20:22:30 -0400
Received: by mail-pf0-f170.google.com with SMTP id g202so11703854pfb.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Sep 2016 17:22:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2730042.XLMy9dAKI1@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Doug Smythies <doug.smythies@gmail.com>

On Sat, Sep 03, 2016 at 02:56:48AM +0200, Rafael J. Wysocki wrote:
> Please let me know what you think and if you can run some benchmarks you
> care about and see if the changes make any difference (this way or another),
> please do that and let me know what you've found.

LGTM (I just reviewed the first and last patch, skipping the
intel_pstate ones).

I was unable to see a conclusive power regression in Android audio, video or
idle usecases on my hikey 96board.

thanks,
Steve
