From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v2 0/2] cpufreq: exynos: Fixes for v3.12
Date: Wed, 09 Oct 2013 14:08:41 +0200
Message-ID: <1381320523-28183-1-git-send-email-l.majewski@samsung.com>
References: <1380108138-30402-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:20190 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab3JIMIz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Oct 2013 08:08:55 -0400
In-reply-to: <1380108138-30402-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Yadwinder Singh Brar <yadi.brar01@gmail.com>, Tomasz Figa <t.figa@samsung.com>

Attached commits provide cpufreq regression fixes for Trats and Trats2
Exynos4 boards.
Since v3.12 Exynos4 uses common clock framework for clock manipulation.
Those patches restore correct output for cpuinfo_cur_freq [1] sysfs
attribute.
Without them, the [1] provides default frequency (800 MHz) set at driver
initialization.


Lukasz Majewski (2):
  cpufreq: exynos4x12: Use the common clock framework to set APLL clock
    rate
  cpufreq: exynos4210: Use the common clock framework to set APLL clock
    rate

 drivers/cpufreq/exynos4210-cpufreq.c |   67 ++++-----------------------------
 drivers/cpufreq/exynos4x12-cpufreq.c |   69 ++++------------------------------
 2 files changed, 16 insertions(+), 120 deletions(-)

-- 
1.7.10.4

