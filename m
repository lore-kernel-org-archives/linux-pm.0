From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC/RFT][PATCH v4 1/2] cpufreq: New governor using utilization
 data from the scheduler
Date: Wed, 2 Mar 2016 19:35:36 -0800
Message-ID: <56D7B108.80101@linaro.org>
References: <5059413.77KZsd2lep@vostro.rjw.lan>
 <1825489.pc33SqXSIB@vostro.rjw.lan> <56D1270F.4010106@linaro.org>
 <2754630.1sRldKdOu8@vostro.rjw.lan> <56D5161F.1030701@linaro.org>
 <CAJZ5v0hi+RZUkWFGDPpftWxcCP-1v6675FY14j19AoRM=e=13Q@mail.gmail.com>
 <56D7AD86.8080702@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34861 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755074AbcCCDfj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 22:35:39 -0500
Received: by mail-pa0-f53.google.com with SMTP id bj10so6389855pad.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Mar 2016 19:35:39 -0800 (PST)
In-Reply-To: <56D7AD86.8080702@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>

On 03/02/2016 07:20 PM, Steve Muckle wrote:
> Why does the frequency value not help? It is true there may be issues of
> a workload being memory bound and not responding quite linearly to
> increasing frequency, but that would pose a problem for the current
> algorithm also. Surely it's better to attempt a consistent policy which
> doesn't vary based on a platform's fmin value?

FWIW I'm not trying to hold up this series - rather just discuss
possibilities and differences with the now deprecated solution that may
be able to be integrated here sometime in the near future.
