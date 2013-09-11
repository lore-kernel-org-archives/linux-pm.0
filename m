From: Stephen Warren <swarren@wwwdotorg.org>
Subject: cpufreq regression due to dceff5c "cpufreq: fix serialization issues
 with freq change notifiers"
Date: Wed, 11 Sep 2013 16:20:36 -0600
Message-ID: <5230ECB4.2090306@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:57837 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029Ab3IKWUk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2013 18:20:40 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

One of the test cases I run (not often enough, hence I just noticed this
late) is the following, to make sure our cpufreq driver is present, and
adjusting the CPU clock as expected:

# echo 1000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq ;
sleep 1 ; cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq ;
echo 216000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq  ;
sleep 1 ; cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq

which prints the following when it works:

1000000
216000

In next-20130909, that doesn't work, but instead prints:

216000
216000

I've also seen the following during git bisect:

608000
608000

... and perhaps other unexpected sets of values.

This is a regression. I found that if I revert dceff5c "cpufreq: fix
serialization issues with freq change notifiers", then the test case
works as expected.

Any idea what's up?
