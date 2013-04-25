From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 0/2] thermal: avoid using IS_ERR_OR_NULL()
Date: Thu, 25 Apr 2013 10:13:32 -0400
Message-ID: <1366899214-22639-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39989 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932256Ab3DYON6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Apr 2013 10:13:58 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

Hello Rui,

Here are two important patches I cooked while reading
linux-arm archives. IS_ERR_OR_NULL() can cause serious
problems and some ppl is even considering removing it [1].

For this reason, I am proposing the following cleanup under
drivers/thermal/

Please consider them.

BR,

Eduardo Valentin (2):
  thermal: thermal_core: remove usage of IS_ERR_OR_NULL
  thermal: db8500_cpufreq_cooling: remove usage of IS_ERR_OR_NULL()

 drivers/thermal/db8500_cpufreq_cooling.c | 2 +-
 drivers/thermal/thermal_core.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

[1] - http://www.mail-archive.com/linux-omap@vger.kernel.org/msg78030.html

-- 
1.8.2.1.342.gfa7285d

