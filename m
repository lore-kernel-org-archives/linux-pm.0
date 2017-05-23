From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/4] PM / OPP: Minor cleanups
Date: Tue, 23 May 2017 09:31:41 +0530
Message-ID: <cover.1495511998.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35987 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750712AbdEWEBv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 00:01:51 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so101250751pfg.3
        for <linux-pm@vger.kernel.org>; Mon, 22 May 2017 21:01:51 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

Hi,

Here are few cleanup patches for the OPP core. The first two simplify
the code that was written specifically due to the limitations that we
had because of RCUs. We don't RCUs anymore and this can be simplified.

The last two take care of specific corner cases.

Rebased over pm/linux-next and tested on Exynos dual core board.

V1->V2:
- Some RBY from Stephen
- s/while/for/ for one of the loops
- Dropped a comment and fixed an error message
- opp-table marked as const in one of the place.

Viresh Kumar (4):
  PM / OPP: Reorganize _generic_set_opp_regulator()
  PM / OPP: Don't create copy of regulators unnecessarily
  PM / OPP: opp-microvolt is not optional if regulators are set
  PM / OPP: Don't create debugfs "supply-0" directory unnecessarily

 drivers/base/power/opp/core.c    | 87 +++++++++++++++++-----------------------
 drivers/base/power/opp/debugfs.c |  7 ++--
 drivers/base/power/opp/of.c      | 10 ++++-
 3 files changed, 48 insertions(+), 56 deletions(-)

-- 
2.13.0.70.g6367777092d9
