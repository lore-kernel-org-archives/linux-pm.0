From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 0/4] cpufreq-dt, platform_data based proposal
Date: Wed, 10 Sep 2014 11:41:48 +0200
Message-ID: <1410342112-13264-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:35891 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751260AbaIJJmk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 05:42:40 -0400
In-Reply-To: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hello,

Here is a proposal to solve the cpufreq-dt issue.

We don't seem to be anywhere near reaching an agreement on a DT
binding to represent the topology of CPU clocks in a system, because
it's a complicated matter. Mike doesn't want to add a clock API that
would allow the generic cpufreq driver to find out which CPUs share
clocks, as he believes this is part of the hardware description and
should therefore be described in the DT rather than "guessed"
dynamically at boot time by looking at the clocks referenced by each
CPU. And with Viresh not accepting any machine specific driver, it
results in platforms like Armada XP having no solution to support
cpufreq...

So this proposal consists in adding a platform_data flag for the
cpufreq-dt driver, which allows platform code to tell whether CPU
clocks are shared or are independent.

If you don't like platform_data, we can also register two different
platform_driver for the two different cases, simply with different
names.

Another approach would be to lift the ban on machine-specific cpufreq
drivers, since the generic driver is not capable of handling all
situations.

Thomas

Thomas Petazzoni (4):
  cpufreq: allow driver-specific flags
  cpufreq: cpufreq-dt: extend with platform_data
  ARM: mvebu: use the cpufreq-dt platform_data for independent clocks
  cpufreq: cpufreq-dt: remove warning about regulators

 arch/arm/mach-mvebu/pmsu.c   |  8 +++++++-
 drivers/cpufreq/cpufreq-dt.c | 23 ++++++++++++++++++-----
 drivers/cpufreq/cpufreq.c    | 15 +++++++++++++++
 include/linux/cpufreq-dt.h   | 22 ++++++++++++++++++++++
 include/linux/cpufreq.h      |  5 ++++-
 5 files changed, 66 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/cpufreq-dt.h

-- 
2.0.0

