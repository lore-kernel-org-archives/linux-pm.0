From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [vireshk:cpufreq/stats/cleanups 12/14] drivers/cpufreq/cpufreq_stats.c:19:1:
 sparse: symbol 'cpufreq_stats_lock' was not declared. Should it be static?
Date: Fri, 19 Dec 2014 13:51:47 +0530
Message-ID: <CAKohpo=2xJXWG0jGZP=o_FGhcdp0HAj_O7T_pM96g9RzDMkYDQ@mail.gmail.com>
References: <201412191646.uhe36Ci6%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:36443 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbaLSIVs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Dec 2014 03:21:48 -0500
Received: by mail-ob0-f171.google.com with SMTP id uz6so11471956obc.2
        for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2014 00:21:47 -0800 (PST)
In-Reply-To: <201412191646.uhe36Ci6%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 19 December 2014 at 13:47, kbuild test robot <fengguang.wu@intel.com> wrote:
> tree:   https://git.linaro.org/people/vireshk/linux cpufreq/stats/cleanups
> head:   f6439741b76da59257758838e8b24472831e850c
> commit: 2194c3c381af6cbfe8ab4fda481e07a004446e30 [12/14] cpufreq: stats: replace spinlock with mutex
> reproduce:
>   # apt-get install sparse
>   git checkout 2194c3c381af6cbfe8ab4fda481e07a004446e30
>   make ARCH=x86_64 allmodconfig
>   make C=1 CF=-D__CHECK_ENDIAN__
>
>
> sparse warnings: (new ones prefixed by >>)
>
>>> drivers/cpufreq/cpufreq_stats.c:19:1: sparse: symbol 'cpufreq_stats_lock' was not declared. Should it be static?
>
> Please review and possibly fold the followup patch.

Thanks fixed.
