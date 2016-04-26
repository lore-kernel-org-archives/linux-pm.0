From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/2] PM / Domains: Second step in improving system PM code in genpd
Date: Tue, 26 Apr 2016 14:23:29 +0200
Message-ID: <1461673411-14245-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33970 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbcDZMXo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2016 08:23:44 -0400
Received: by mail-lf0-f54.google.com with SMTP id j11so15703782lfb.1
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2016 05:23:44 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

This is the second step in improving the system PM code in genpd. The first
patch is actually fixing a bug while it also enables for further clean-ups,
which is done in the second patch.

The next step of improving system PM code in genpd will move it to the part of
trying to optimize the behaviour, such as avoid waking up devices unless it's
really needed.

Note, these two patches is based upon "[PATCH v2 0/2] PM / Domains: Initial
improvements of system PM code in genpd", which was recently posted. Probably
it's a good idea to combine these series into one, if/when new re-spins are
needed.

Ulf Hansson (2):
  PM / Domains: Allow genpd to power on during the system PM phase
  PM / Domains: Remove redundant wrapper functions for system PM

 drivers/base/power/domain.c | 271 ++++++--------------------------------------
 include/linux/pm_domain.h   |   1 -
 2 files changed, 35 insertions(+), 237 deletions(-)

-- 
1.9.1

