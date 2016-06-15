From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 1/5] PM / Domains: Remove redundant call to pm_request_idle() in genpd
Date: Wed, 15 Jun 2016 14:33:07 -0700
Message-ID: <m27fdqp27g.fsf@baylibre.com>
References: <1464600795-26307-1-git-send-email-ulf.hansson@linaro.org>
	<1464600795-26307-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35087 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbcFOVdK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 17:33:10 -0400
Received: by mail-pa0-f53.google.com with SMTP id hl6so10975360pac.2
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2016 14:33:10 -0700 (PDT)
In-Reply-To: <1464600795-26307-2-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Mon, 30 May 2016 11:33:11 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> The PM core increases the runtime PM usage count at the system PM prepare
> phase. Later when the system resumes, it does a pm_runtime_put() in the
> complete phase, which in addition to decrementing the usage count, does
> the equivalent of a pm_request_idle().
>
> Therefore the call to pm_request_idle() from within genpd's ->complete()
> callback is redundant, so let's remove it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
