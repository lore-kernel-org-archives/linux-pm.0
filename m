From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/11] cpufreq: governor: Use common mutex for dbs_data
 protection
Date: Thu, 4 Feb 2016 10:39:54 +0530
Message-ID: <20160204050954.GU3469@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <1529283.0IedZktI9q@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35193 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbcBDFJ6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 00:09:58 -0500
Received: by mail-pf0-f180.google.com with SMTP id 65so31748946pfd.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Feb 2016 21:09:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1529283.0IedZktI9q@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On 04-02-16, 00:16, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Every governor relying on the common code in cpufreq_governor.c
> has to provide its own mutex in struct common_dbs_data.  However,
> those mutexes are never used at the same time

Why do you think so? I thought they can always be used in parallel.

Consider 2 or more policies, one can have ondemand as the governor,
whereas other one can have conservative.

If CPUs go online/offline or if governors are switching in parallel,
then cpufreq_governor_dbs() can very much run in parallel for ondemand
and conservative.

Or am I missing something here ?

-- 
viresh
