From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/4] cpufreq-dt, platform_data based proposal
Date: Wed, 10 Sep 2014 11:53:27 +0200
Message-ID: <2947757.7VG6XCG6t9@wuerfel>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com> <1410342112-13264-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:64945 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbaIJJxf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 05:53:35 -0400
In-Reply-To: <1410342112-13264-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Viresh Kumar <viresh.kumar@linaro.org>, Lior Amsalem <alior@marvell.com>, Rob Herring <rob.herring@linaro.org>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Tawfik Bayouk <tawfik@marvell.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Tomasz Figa <t.figa@samsung.com>, Rafael Wysocki <rjw@rjwysocki.net>, Nadav Haklai <nadavh@marvell.com>, Thomas Abraham <thomas.ab@samsung.com>, Mike Turquette <mike.turquette@linaro.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sachin Kamat <spk.linux@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>

On Wednesday 10 September 2014 11:41:48 Thomas Petazzoni wrote:
> We don't seem to be anywhere near reaching an agreement on a DT
> binding to represent the topology of CPU clocks in a system, because
> it's a complicated matter. Mike doesn't want to add a clock API that
> would allow the generic cpufreq driver to find out which CPUs share
> clocks, as he believes this is part of the hardware description and
> should therefore be described in the DT rather than "guessed"
> dynamically at boot time by looking at the clocks referenced by each
> CPU. And with Viresh not accepting any machine specific driver, it
> results in platforms like Armada XP having no solution to support
> cpufreq...
> 
> So this proposal consists in adding a platform_data flag for the
> cpufreq-dt driver, which allows platform code to tell whether CPU
> clocks are shared or are independent.
> 
> If you don't like platform_data, we can also register two different
> platform_driver for the two different cases, simply with different
> names.
> 
> Another approach would be to lift the ban on machine-specific cpufreq
> drivers, since the generic driver is not capable of handling all
> situations.

Using platform_data works nicely if you register the cpufreq device
from the platform code, but that is a particular thing that has
been bugging me for a long time and that I really want to get rid
of: We don't want to introduce platform-specific files for ARM64,
so we have to solve this anyway by just looking at DT, and whatever
solution we end up with should work for both ARM32 and ARM64.

Most of us will be at LCU next week, so I'd suggest we solve this
problem using the 'lock everyone into one room without beer until
we come up with a working approach' method.

	Arnd
