From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: cpufreq regression due to dceff5c "cpufreq: fix serialization issues with freq change notifiers"
Date: Thu, 12 Sep 2013 00:51:26 +0200
Message-ID: <13389782.ui3WXEBqQV@vostro.rjw.lan>
References: <5230ECB4.2090306@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:46820 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792Ab3IKWkY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 11 Sep 2013 18:40:24 -0400
In-Reply-To: <5230ECB4.2090306@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wednesday, September 11, 2013 04:20:36 PM Stephen Warren wrote:
> One of the test cases I run (not often enough, hence I just noticed this
> late) is the following, to make sure our cpufreq driver is present, and
> adjusting the CPU clock as expected:
> 
> # echo 1000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq ;
> sleep 1 ; cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq ;
> echo 216000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq  ;
> sleep 1 ; cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
> 
> which prints the following when it works:
> 
> 1000000
> 216000
> 
> In next-20130909, that doesn't work, but instead prints:
> 
> 216000
> 216000
> 
> I've also seen the following during git bisect:
> 
> 608000
> 608000
> 
> ... and perhaps other unexpected sets of values.

Can you please test the current linux-next?  I've reverted the commit that
dceff5c attempted to fix, so the output should be correct now.

> This is a regression. I found that if I revert dceff5c "cpufreq: fix
> serialization issues with freq change notifiers", then the test case
> works as expected.
> 
> Any idea what's up?

Commit dceff5c overlooked some places in which transition_ongoing should have
been taken care of.

Thanks,
Rafael



-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
