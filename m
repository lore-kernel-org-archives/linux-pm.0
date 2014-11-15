From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Possible bug: Duplicate OPPs warning after reloading cpufreq-dt
Date: Sat, 15 Nov 2014 12:54:50 +0100 (CET)
Message-ID: <1973548224.143005.1416052490232.JavaMail.open-xchange@oxbaltgw05.schlund.de>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:59577 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbaKOLyw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 15 Nov 2014 06:54:52 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org

Hi,
 
in the case cpufreq-dt is compiled as module, reloading cpufreq-dt gives a poor
warning about duplicate OPPs:
 
root@duckbill:~# modprobe cpufreq-dt
root@duckbill:~# modprobe -r cpufreq-dt
root@duckbill:~# modprobe cpufreq-dt
[   53.824262] cpu cpu0: dev_pm_opp_add: duplicate OPPs detected. Existing:
freq: 261819000, volt: 1350000, enabled: 1. New: freq: 261819000, volt: 1350000,
enabled: 1
[   53.881680] cpu cpu0: dev_pm_opp_add: duplicate OPPs detected. Existing:
freq: 360000000, volt: 1350000, enabled: 1. New: freq: 360000000, volt: 1350000,
enabled: 1
[   53.921576] cpu cpu0: dev_pm_opp_add: duplicate OPPs detected. Existing:
freq: 392728000, volt: 1450000, enabled: 1. New: freq: 392728000, volt: 1450000,
enabled: 1
[   53.964054] cpu cpu0: dev_pm_opp_add: duplicate OPPs detected. Existing:
freq: 454737000, volt: 1550000, enabled: 1. New: freq: 454737000, volt: 1550000,
enabled: 1

I think these warnings are misleading and should be avoided. Unfortunately i
don't have a idea to fix it the right way.

Test platform: Freescale i.MX28 (ARM9)
Kernel: 3.18.0-rc3

Best regards
Stefan
