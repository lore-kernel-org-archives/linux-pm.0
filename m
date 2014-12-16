From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v14 03/10] qcom: spm: Add Subsystem Power Manager driver
Date: Tue, 16 Dec 2014 15:38:30 +0100
Message-ID: <2663853.2Q3kHisMT7@wuerfel>
References: <1417541958-56907-1-git-send-email-lina.iyer@linaro.org> <2519415.GklIQeMgWR@wuerfel> <54903DC6.8010308@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:55393 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbaLPOjT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Dec 2014 09:39:19 -0500
In-Reply-To: <54903DC6.8010308@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lina Iyer <lina.iyer@linaro.org>, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On Tuesday 16 December 2014 15:12:22 Daniel Lezcano wrote:
> At the beginning, all that become from not including mach files from the 
> drivers directory which make sense.
> 
> Perhaps it is time to write a similar mechanism for the cpuidle drivers 
> where we can still separate the low level PM code from the generic 
> cpuidle code.

That way you basically duplicate the same thing we already have, which
isn't much better.

In the example of drivers/soc/qcom/spm.c, just call cpuidle_register
from the spm_dev_probe() function and be done with it. You already
have a device that is responsible for handling this, don't try to
construct more than you already need.

I would assume that the same can be done for most other platforms.

There are probably cases where the same piece of hardware is responsible
for both cpuidle and cpufreq, but what that means is really that you
should have a single driver for it that does both things. Same for
SMP support: if you have one register block that does both the SMP
bringup and the cpuidle stuff, then have *one* driver for this block
that does it all. There are currently a few dependencies that require
doing SMP bringup early during boot, but we decided years ago that those
are all artificial dependencies and we should be able to boot secondary
CPUs much later than we currently do.

	Arnd
