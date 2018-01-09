From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v4 0/2] PM / core: Extend behaviour for wakeup paths
Date: Tue,  9 Jan 2018 10:03:38 +0100
Message-ID: <1515488620-10575-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:42395 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbeAIJDr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jan 2018 04:03:47 -0500
Received: by mail-lf0-f52.google.com with SMTP id e27so15068937lfb.9
        for <linux-pm@vger.kernel.org>; Tue, 09 Jan 2018 01:03:46 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Changes in v4:
	- Dropped the changes that already been applied.
	- Patch 1 is new, should not introduce any functional changes, but only
	  structural code changes, as requested by Rafael.
	- Patch 2, re-based on top of new patch.

Ulf Hansson (2):
  PM / core: Re-structure code for clearing the direct_complete flag
  PM / core: Propagate wakeup_path status flag in
    __device_suspend_late()

 drivers/base/power/main.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

-- 
2.7.4
