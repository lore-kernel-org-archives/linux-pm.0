From: Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH 0/4] Allow cpufreq-dt to defer probe if OPP table is not ready
Date: Tue, 16 Dec 2014 15:09:35 -0800
Message-ID: <1418771379-24369-1-git-send-email-dtor@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:49717 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbaLPXJw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Dec 2014 18:09:52 -0500
Received: by mail-ig0-f177.google.com with SMTP id z20so7943272igj.10
        for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2014 15:09:51 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Stefan Wahren <stefan.wahren@i2se.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

[ Resending as my previous attempt appears to be messed up... ]

This series change cpufreq-dt driver to return -EPROBE_DEFER in case OPP table
is not ready by the time it gets to initialize. The use case is for platforms
that use platform code (or maybe a different driver altogether) to provide OPP
tables.

In addition to changes to cpufreq-dt there are assorted changes to OPP code to
make it work a bit better.

Note that I am not happy with OPP code: dev_pm_opp_init_cpufreq_table() is
wrong in it's assumption that taking RCU lock will guarantee that number of
OPPs will not change - we can remove OPP from list just fine, and then
initialization will fail. I also think that we shoudl change API so users should
get a reference to their OPP table and then pass opaque dev_opp pointer to
accessor APIs instead of re-scanning the global list over and over and over.

Thanks,
Dmitry

Dmitry Torokhov (4):
  PM / OPP: add some lockdep annotations
  PM / OPP: fix warning in of_free_opp_table
  PM / OPP: take RCU lock in dev_pm_opp_get_opp_count
  cpufreq-dt: defer probing if OPP table is not ready

 drivers/base/power/opp.c     | 39 +++++++++++++++++++++++++++++++--------
 drivers/cpufreq/cpufreq-dt.c | 11 +++++++++++
 2 files changed, 42 insertions(+), 8 deletions(-)

