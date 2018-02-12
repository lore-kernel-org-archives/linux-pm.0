From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [GIT PULL] OPP updates for 4.16-rc2
Date: Mon, 12 Feb 2018 15:16:51 +0530
Message-ID: <20180212094651.GS28462@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:33588 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932720AbeBLJqy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Feb 2018 04:46:54 -0500
Received: by mail-io0-f182.google.com with SMTP id n7so16643432iob.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Feb 2018 01:46:54 -0800 (PST)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org

Hi Rafael,

Please pull the OPP changes for 4.16-rc2. It contains a single trivial
commit.

--
viresh

-------------------------8<-------------------------

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to 4a823c0be80fa996234ebb41c80d40458b1bec1e:

  opp: cpu: Replace GFP_ATOMIC with GFP_KERNEL in dev_pm_opp_init_cpufreq_table (2018-02-12 15:07:46 +0530)

----------------------------------------------------------------
Jia-Ju Bai (1):
      opp: cpu: Replace GFP_ATOMIC with GFP_KERNEL in dev_pm_opp_init_cpufreq_table

 drivers/opp/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
viresh
