From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC][PATCH 6/7] cpufreq: schedutil: Add iowait boosting
Date: Mon, 1 Aug 2016 18:35:31 -0700
Message-ID: <20160802013531.GC9332@graphite.smuckle.net>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
 <1572483.euTsoFDNE9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34772 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755571AbcHBBgv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2016 21:36:51 -0400
Received: by mail-pf0-f172.google.com with SMTP id p64so60702026pfb.1
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2016 18:35:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1572483.euTsoFDNE9@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

On Mon, Aug 01, 2016 at 01:37:59AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify the schedutil cpufreq governor to boost the CPU frequency
> if the UUF_IO flag is passed to it via cpufreq_update_util().
> 
> If that happens, the frequency is set to the maximum during
> the first update after receiving the UUF_IO flag and then the
> boost is reduced by half during each following update.

Were these changes to schedutil part of the positive test results
mentioned in patch 5? Or are those just from intel pstate?

I was nervous about the effect of this on power and tested a couple low
power usecases. The platform is the Hikey 96board (8 core ARM A53,
single CPUfreq domain) running AOSP Android and schedutil backported to
kernel 4.4. These tests run mp3 and mpeg4 playback for a little while,
recording total energy consumption during the test along with frequency
residency.

As the results below show I did not measure an appreciable effect - if
anything things may be slightly better with the patches.

The hardcoding of a non-tunable boosting scheme makes me nervous but
perhaps it could be revisited if some platform or configuration shows
a noticeable regression?

Testcase	Energy	/----- CPU frequency residency -----\
		(J)	208000	432000	729000	960000	1200000
mp3-before-1	26.822	47.27%	24.79%	16.23%	5.20%	6.52%
mp3-before-2	26.817	41.70%	28.75%	17.62%	5.17%	6.75%
mp3-before-3	26.65	42.48%	28.65%	17.25%	5.07%	6.55%
mp3-after-1	26.667	42.51%	27.38%	18.00%	5.40%	6.71%
mp3-after-2	26.777	48.37%	24.15%	15.68%	4.55%	7.25%
mp3-after-3	26.806	41.93%	27.71%	18.35%	4.78%	7.35%

mpeg4-before-1	26.024	18.41%	60.09%	13.16%	0.49%	7.85%
mpeg4-before-2	25.147	20.47%	64.80%	8.44%	1.37%	4.91%
mpeg4-before-3	25.007	19.18%	66.08%	10.01%	0.59%	4.22%
mpeg4-after-1	25.598	19.77%	61.33%	11.63%	0.79%	6.48%
mpeg4-after-2	25.18	22.31%	62.78%	8.83%	1.18%	4.90%
mpeg4-after-3	25.162	21.59%	64.88%	8.29%	0.49%	4.71%

thanks,
Steve
