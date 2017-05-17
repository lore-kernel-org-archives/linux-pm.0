From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/4] PM / OPP: Minor cleanups
Date: Wed, 17 May 2017 10:10:31 +0530
Message-ID: <cover.1494995911.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36103 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbdEQEkx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 May 2017 00:40:53 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so1007507pfg.3
        for <linux-pm@vger.kernel.org>; Tue, 16 May 2017 21:40:52 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>

Hi,

Here are few cleanup patches for the OPP core. The first two simplify
the code that was written specifically due to the limitations that we
had because of RCUs. We don't RCUs anymore and this can be simplified.

The last two take care of specific corner cases.

Rebased over pm/linux-next and tested on Exynos dual core board.

Viresh Kumar (4):
  PM / OPP: Reorganize _generic_set_opp_regulator()
  PM / OPP: Don't create copy of regulators unnecessarily
  PM / OPP: opp-microvolt is not optional if regulators are set
  PM / OPP: Don't create debugfs "supply-0" directory unnecessarily

 drivers/base/power/opp/core.c    | 87 +++++++++++++++++-----------------------
 drivers/base/power/opp/debugfs.c |  6 +--
 drivers/base/power/opp/of.c      | 11 ++++-
 3 files changed, 49 insertions(+), 55 deletions(-)

-- 
2.13.0.303.g4ebf3021692d
