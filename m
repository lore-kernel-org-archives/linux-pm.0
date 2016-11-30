From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/3] dev_pm_qos improvements
Date: Tue, 29 Nov 2016 17:11:49 -0800
Message-ID: <cover.1480468027.git.luto@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756541AbcK3BM3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Nov 2016 20:12:29 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Andy Lutomirski <luto@kernel.org>

Hi Rafael-

Here are three minor dev_pm_qos improvements that make my upcoming
nvme power management code work much better.  Any chance you could
take them for 4.10?

Thanks,
Andy

Andy Lutomirski (3):
  dev_pm_qos: Improve sysfs pm_qos_latency_tolerance validation
  dev_pm_qos: Fix writing 'auto' to pm_qos_latency_tolerance_us
  dev_pm_qos: Export dev_pm_qos_update_user_latency_tolerance

 drivers/base/power/qos.c   | 6 +++++-
 drivers/base/power/sysfs.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.9.3

