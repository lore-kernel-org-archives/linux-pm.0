From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/4] OPP: Some cleanups
Date: Thu, 15 Oct 2015 21:42:42 +0530
Message-ID: <cover.1444925400.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35089 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752AbbJOQMy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 12:12:54 -0400
Received: by pabur7 with SMTP id ur7so9446927pab.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 09:12:54 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>

Rafael,

These are some random cleanups, which were part of the multi-regulator
series earlier. Sending them separately to make that series a bit light
weight.

V1->V2:
- Just sending them separately.

Viresh Kumar (4):
  PM / OPP: Improve debug print messages with pr_fmt
  PM / OPP: Rename routines specific to old bindings with _v1
  PM / OPP: Parse all power-supply related bindings together
  PM / OPP: Create separate structure for regulator/supplies

 drivers/base/power/opp/core.c | 78 +++++++++++++++++++++++++++----------------
 drivers/base/power/opp/cpu.c  |  3 ++
 drivers/base/power/opp/opp.h  | 29 +++++++++++-----
 3 files changed, 73 insertions(+), 37 deletions(-)

-- 
2.4.0

