From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/8] cpufreq: cleanups and reorganization
Date: Wed, 01 Jun 2016 18:47:54 +0200
Message-ID: <2443928.vz0jCToKqk@vostro.rjw.lan>
References: <cover.1464776797.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42131 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932830AbcFAQoD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2016 12:44:03 -0400
In-Reply-To: <cover.1464776797.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On Wednesday, June 01, 2016 04:04:14 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> This cleans up cpufreq core and few platform drivers a bit. Its mostly
> around cleaning up the usage of cpufreq_frequency_table_target(), which
> will be optimized in a later series.
> 
> This is just preparatory cleanup for that.
> 
> Also note that the 4th patch was sent earlier as well in a different
> form and this is V3 of that.
> 
> Viresh Kumar (8):
>   ARM: s3c24xx: Sort cpufreq tables
>   cpufreq: s3c24xx: Remove useless checks
>   cpufreq: powerenv: Fix memory leak
>   cpufreq: Remove cpufreq_frequency_get_table()
>   cpufreq: ondemand: Don't keep a copy of freq_table pointer
>   cpufreq: Drop freq-table param to cpufreq_frequency_table_target()
>   cpufreq: Drop 'freq_table' argument of __target_index()
>   cpufreq: Return index from cpufreq_frequency_table_target()

All of this makes sense to me, so I'm going to apply it.

BTW, if you CC the Linaro list, please also CC the LKML.

Thanks,
Rafael

