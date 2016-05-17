From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/4] PM / Domains / Runtime: Optimize device system PM when using genpd
Date: Tue, 17 May 2016 13:41:32 +0200
Message-ID: <1463485296-22742-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35902 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbcEQLlr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2016 07:41:47 -0400
Received: by mail-lb0-f177.google.com with SMTP id h1so4825497lbj.3
        for <linux-pm@vger.kernel.org>; Tue, 17 May 2016 04:41:46 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The main goal of this series is to avoid unnecessary operations of devices
during the system PM suspend/resume path, especially when using genpd.

For example, we want to avoid to have genpd to unconditionally runtime resume
devices in the system PM prepare phase. That also means that in most cases a
runtime suspended device can remain in such state, during the system PM suspend
sequence.

Moreover, we don't want to unconditionally wake up all devices during the system
PM resume sequence, but instead defer that to be done when devices are actually
going to be used.

Note, this series is based upon another posted series (not queued) for genpd:
[PATCH v3 0/2] PM / Domains: Second step in improving system PM code in genpd
http://www.spinics.net/lists/dri-devel/msg107207.html

Ulf Hansson (4):
  PM / Domains: Remove redundant call to pm_request_idle() in genpd
  PM / Runtime: Prevent re-resuming devices in pm_runtime_force_resume()
  PM / Domains: Allow runtime PM during system PM phases
  PM / Runtime: Defer resuming of the device in
    pm_runtime_force_resume()

 drivers/base/power/domain.c  | 56 ++++++++++++++++++++++++--------------------
 drivers/base/power/runtime.c | 14 +++++++++++
 2 files changed, 44 insertions(+), 26 deletions(-)

-- 
1.9.1

