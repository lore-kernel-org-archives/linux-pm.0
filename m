From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/11] cpufreq: governor: Use common mutex for dbs_data protection
Date: Thu, 4 Feb 2016 17:46:07 +0100
Message-ID: <CAJZ5v0hWj4JgCh76Fg48ex3Svv7BUHR=9+RoA728R9aYU+12Pw@mail.gmail.com>
References: <3705929.bslqXH980s@vostro.rjw.lan>
	<1529283.0IedZktI9q@vostro.rjw.lan>
	<20160204050954.GU3469@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:32894 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140AbcBDQqJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 11:46:09 -0500
In-Reply-To: <20160204050954.GU3469@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On Thu, Feb 4, 2016 at 6:09 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 04-02-16, 00:16, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Every governor relying on the common code in cpufreq_governor.c
>> has to provide its own mutex in struct common_dbs_data.  However,
>> those mutexes are never used at the same time
>
> Why do you think so? I thought they can always be used in parallel.
>
> Consider 2 or more policies, one can have ondemand as the governor,
> whereas other one can have conservative.
>
> If CPUs go online/offline or if governors are switching in parallel,
> then cpufreq_governor_dbs() can very much run in parallel for ondemand
> and conservative.
>
> Or am I missing something here ?

Well, so perhaps the changelog is inaccurate.

However, what's wrong with using a single mutex then?

Thanks,
Rafael
