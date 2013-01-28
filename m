From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] PM / OPP : export symbol consolidation
Date: Mon, 28 Jan 2013 12:26:14 -0600
Message-ID: <1359397576-26131-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm <linux-pm@vger.kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Rafael <rjw@sisk.pl>, Mark Langsdorf <mark.langsdorf@calxeda.com>, Shawn Guo <shawn.guo@linaro.org>, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi,
This is a consolidation of Rafael's request for usage of EXPORT_SYMBOL_GPL
and requirement for cpufreq helpers to be exported to be used by cpufreq
drivers which may be modules.

https://patchwork.kernel.org/patch/1847261/ is patch #2 in this series.

Mark Langsdorf (1):
  PM / OPP: Export more symbols for module usage

Nishanth Menon (1):
  PM / OPP: switch exported symbols to GPL variant

 drivers/base/power/opp.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

-- 
1.7.9.5

Regards,
Nishanth Menon
