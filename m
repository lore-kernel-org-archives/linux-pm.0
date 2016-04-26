From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 0/2] PM / Domains: Initial improvements of system PM code in genpd
Date: Tue, 26 Apr 2016 08:47:16 +0200
Message-ID: <1461653238-3891-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34801 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbcDZGr3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2016 02:47:29 -0400
Received: by mail-lf0-f46.google.com with SMTP id j11so6203662lfb.1
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2016 23:47:28 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The system PM code in genpd needs a round of modernization and clean-up. This is
only the first initial part.

I intend to in step by step improve the code, so in a later point enable to do
optimizations. Such as, avoid waking up devices unless it's really needed.

Ulf Hansson (2):
  PM / Domains: Remove redundant pm_runtime_get|put*() in
    pm_genpd_prepare()
  PM / Domains: Drop unnecessary wakeup code from pm_genpd_prepare()

 drivers/base/power/domain.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

-- 
1.9.1

