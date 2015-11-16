From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/3] PM / OPP: Parse opp-supported-hw/opp-<prop>-<name> bindings
Date: Mon, 16 Nov 2015 16:07:25 +0530
Message-ID: <cover.1447669859.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33859 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbbKPKh5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 05:37:57 -0500
Received: by padhx2 with SMTP id hx2so171673136pad.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2015 02:37:57 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

The bindings are reviewed now and here is the code to parse them. The
first patch is a minor cleanup and other two contain the real stuff.

Rebased over: v4.4-rc1 + OPP debugfs support patch.
Tested-on: Exynos 5250, dual core A15.

Viresh Kumar (3):
  PM / OPP: Add missing doc comments
  PM / OPP: Parse 'opp-supported-hw' binding
  PM / OPP: Parse 'opp-<prop>-<name>' bindings

 drivers/base/power/opp/core.c | 301 ++++++++++++++++++++++++++++++++++++++++--
 drivers/base/power/opp/opp.h  |  11 +-
 include/linux/pm_opp.h        |  21 +++
 3 files changed, 319 insertions(+), 14 deletions(-)

-- 
2.6.2.198.g614a2ac

