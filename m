From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] cpufreq: ondemand: Eliminate the deadband effect
Date: Wed, 23 Jul 2014 01:50:28 +0200
Message-ID: <1513010.lqhBUJhHsL@vostro.rjw.lan>
References: <1404147574-17422-1-git-send-email-stratosk@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64918 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752380AbaGVXcE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jul 2014 19:32:04 -0400
In-Reply-To: <1404147574-17422-1-git-send-email-stratosk@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, June 30, 2014 07:59:32 PM Stratos Karafotis wrote:
> Hi all,
> 
> This patchset changes slightly the calculation of target frequency to
> eliminate the deadband effect (explained in patch 2 changelog) that it
> seems to slow down the CPU in low and medium loads.
> 
> Patch 1 introduces a new relation (RELATION_C) for the next frequency
> selection, which chooses the closest frequency to target.
> 
> Patch 2 is the actual change to ondemand governor.
> 
> You may find graphs with the 'deadband' effect and benchmark results:
> https://docs.google.com/spreadsheets/d/16kDBh5lyc6YvBnoS1hUa1t2O38z0xrWvaEj5XtJ8auw/edit#gid=2072493052
> 
> Thanks
> 
> 
> Stratos Karafotis (2):
>   cpufreq: Introduce new relation for freq selection
>   cpufreq: ondemand: Eliminate the deadband effect in low loads
> 
>  drivers/cpufreq/cpufreq_ondemand.c | 11 +++++++----
>  drivers/cpufreq/freq_table.c       | 12 +++++++++++-
>  include/linux/cpufreq.h            |  1 +
>  3 files changed, 19 insertions(+), 5 deletions(-)

OK, I've queued up these two patches for 3.17.  We'll see if anyone sees
any problems related to them.  Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
