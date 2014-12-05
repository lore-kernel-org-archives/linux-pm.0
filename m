From: Arto Merilainen <amerilainen@nvidia.com>
Subject: [RFC RESEND 0/3] Add watermark support to devfreq
Date: Fri, 5 Dec 2014 15:41:29 +0200
Message-ID: <1417786892-477-1-git-send-email-amerilainen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11887 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbaLENl6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Dec 2014 08:41:58 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, tomeu.vizoso@collabora.com, gnurou@gmail.com
Cc: javier.martinez@collabora.co.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, swarren@wwwdotorg.org, thierry.reding@gmail.com, grant.likely@linaro.org, srasal@nvidia.com, amerilainen@nvidia.com

(Sorry for the spam. I am resending the series because I noted that
some of the email addresses were mistyped)

Currently main mechanism to implement scaling using devfreq is
polling and the device profile is free to set polling interval.
However, in many cases this approach is not optimal; We may
unnecessarily use CPU time to determine load on engine that
is idle most of time - or we may simply read load when we
already know that the device is busy.

In some cases a device itself has counters to track its activity
and possibility to raise interrupts when load goes above or below
certain threshold.

This series adds support for watermark events to devfreq and
introduces two example governors. The first patch adds two
callbacks to the device profile (for setting watermark) and
adds a new function call to devfreq that informs of crossed
watermark.

The added governors demonstrate usage of the new API. The first
governor (watermark simple) sets device to trigger low watermark
event when load goes below 10% and high watermark interrupt when
the load goes above 60%. Watermark active tries to keep load at
certain level and it actively sets thresholds based on the
frequency table in order get interrupts only when the load value
would affect to the current frequency in re-estimation.

Arto Merilainen (1):
  PM / devfreq: Add watermark active governor

Shridhar Rasal (2):
  PM / devfreq: Add watermark events
  PM / devfreq: Add watermark simple governor

 drivers/devfreq/Kconfig                 |  18 +++
 drivers/devfreq/Makefile                |   2 +
 drivers/devfreq/devfreq.c               |  19 +++
 drivers/devfreq/governor.h              |   1 +
 drivers/devfreq/governor_wmark_active.c | 276 ++++++++++++++++++++++++++++++++
 drivers/devfreq/governor_wmark_simple.c | 245 ++++++++++++++++++++++++++++
 include/linux/devfreq.h                 |  26 +++
 7 files changed, 587 insertions(+)
 create mode 100644 drivers/devfreq/governor_wmark_active.c
 create mode 100644 drivers/devfreq/governor_wmark_simple.c

-- 
1.8.1.5

