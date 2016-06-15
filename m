From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 4/5] PM / Domains: Stop/start devices during system PM suspend/resume in genpd
Date: Wed, 15 Jun 2016 14:40:37 -0700
Message-ID: <m2oa72nnai.fsf@baylibre.com>
References: <1464600795-26307-1-git-send-email-ulf.hansson@linaro.org>
	<1464600795-26307-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35006 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbcFOVkj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 17:40:39 -0400
Received: by mail-pa0-f44.google.com with SMTP id hl6so11025882pac.2
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2016 14:40:38 -0700 (PDT)
In-Reply-To: <1464600795-26307-5-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Mon, 30 May 2016 11:33:14 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> Not all subsystems/drivers that manages devices attached to a genpd, makes
> use of the pm_runtime_force_suspend|resume() helper functions to deal with
> system PM suspend/resume.
>
> In cases like these and when genpd's ->stop|start() callbacks are being
> used for the device, invoke the pm_runtime_force_suspend|resume() helper
> functions from genpd's "noirq" system PM callbacks. In this way we make
> sure to "stop" the device on suspend and to "start" it on resume.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
