From: Mason <slash.tmp@free.fr>
Subject: Weird interaction between thermal and cpufreq drivers
Date: Thu, 28 Apr 2016 17:24:54 +0200
Message-ID: <57222B46.4070502@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:42341 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752622AbcD1PZK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 Apr 2016 11:25:10 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Sebastian Frias <sf84@laposte.net>

Hello linux-pm,

I'm seeing a weird bug, where the thermal driver(*) returns bogus
temperatures once I lower the CPU frequency.

(*) drivers/thermal/tango_thermal.c

The setup: I'm using next-20160428
(Is it a good idea to test on linux-next?
Are there bugs lurking there that get sorted out later?)

I have a script which prints /sys/class/thermal/thermal_zone0/temp
every second.

When the CPU is running at nominal speed, these values seem correct.
("seem" because I don't have the HW to calibrate the thermometer.)

But once I lower the frequency of the CPU(*), the script starts
printing bogus values like 29000 (my driver's minimum) and very
high temps like 100000 or even 137000!

(*) echo 135000 > /sys/devices/system/cpu/cpufreq/scaling_max_freq
I'm using the performance governor, so everything should be manual,
if I understand correctly.

I looked at timing issues in my driver. I do have an obvious
usleep_range(10, 20); in my code. IIUC, this primitive will use
the underlying Cortex A9 twd block, which does introduce errors
on frequency changes, so I switched it to udelay(100); This one
should only use the platform tick counter, which ticks at a
constant speed. But I still have the issues.

Any idea what could be going wrong?

I guess I can test on v4.6-rc5

Regards.
