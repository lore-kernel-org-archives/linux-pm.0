From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: [PATCH 0/2] clocksource: nomadik-mtu: support timer-based delay
Date: Tue,  4 Dec 2012 11:10:43 +0100
Message-ID: <1354615845-2758-1-git-send-email-fabio.baltieri@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: John Stultz <johnstul@us.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Fabio Baltieri <fabio.baltieri@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi all,

this implements timer-based delay support for nomadik and ux500
platforms, using the MTU as time source, and marks the u8500 cpufreq
driver as CPUFREQ_CONST_LOOPS accordingly.

The patches are based on Arnd's arm-soc/ux500/mtu-clk branch, as that
contains latest MTU driver developments, including a driver move/rename,
but I can rebase if necessary.

Thanks,
Fabio


Fabio Baltieri (2):
  clocksource: nomadik-mtu: support timer-based delay
  cpufreq: db8500: set CPUFREQ_CONST_LOOPS

 drivers/clocksource/nomadik-mtu.c | 11 +++++++++++
 drivers/cpufreq/db8500-cpufreq.c  |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
1.7.12.1
