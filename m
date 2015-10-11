From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 0/5] cpufreq: sysfs cleanup
Date: Sun, 11 Oct 2015 12:57:30 -0700
Message-ID: <003001d1045f$10bed0c0$323c7240$@net>
References: <cover.1444583718.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta13.telus.net ([209.171.16.86]:42800 "EHLO cmta13.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094AbbJKT5e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 11 Oct 2015 15:57:34 -0400
In-Reply-To: <cover.1444583718.git.viresh.kumar@linaro.org>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, 'Rafael Wysocki' <rjw@rjwysocki.net>


On 2105.10.11 10:21 Viresh Kumar wrote:

>Rafael,
>
> This is in response to the other thread where you and Saravana were
>discussing this. It doesn't allow updating policy for offline CPUs yet,
> but does cleanup the sysfs stuff.
>
> This is untested by me as I didn't had access to the hardware to test
> this week. But this is tested by Fengguang's build bot for some time
> now.
>
> Will be good if one of you can test this out.
>
> Viresh Kumar (5):
>  cpufreq: Use cpumask_copy instead of cpumask_or to copy a mask
>  cpufreq: create cpu/cpufreq at boot time
>  cpufreq: remove cpufreq_sysfs_{create|remove}_file()
>  cpufreq: create cpu/cpufreq/policyX directories
>  cpufreq: Drop redundant check for inactive policies
>
> drivers/cpufreq/cpufreq.c          | 95 +++++---------------------------------
> drivers/cpufreq/cpufreq_governor.c | 20 ++------
> include/linux/cpufreq.h            |  5 --
> 3 files changed, 16 insertions(+), 104 deletions(-)
>
> -- 
> 2.4.0

For my part of it, this patch set fixes the user space regression
that was introduced into the pm-utils with kernel 4.2.
If it ends up merged, I'll go back and cancel the bug reports
I submitted.

References (mainly for myself):
https://bugs.launchpad.net/ubuntu/+source/pm-utils/+bug/1493156
https://bugs.freedesktop.org/show_bug.cgi?id=91914


