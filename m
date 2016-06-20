From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] PM / Domains: Convert pm_genpd_init() to return an error code
Date: Mon, 20 Jun 2016 11:00:24 -0700
Message-ID: <m2ziqfagg7.fsf@baylibre.com>
References: <1466159272-9726-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34125 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbcFTS6Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2016 14:58:24 -0400
Received: by mail-pa0-f48.google.com with SMTP id bz2so53374630pad.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2016 11:57:44 -0700 (PDT)
In-Reply-To: <1466159272-9726-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Fri, 17 Jun 2016 12:27:52 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> The are already cases when pm_genpd_init() can fail. Currently we hide the
> failures instead of propagating an error code, which is a better method.
>
> Moreover, to prepare for future changes like moving away from using a
> fixed array-size of the struct genpd_power_state, to instead dynamically
> allocate data for it, the pm_genpd_init() API needs to be able to return
> an error code, as allocation can fail.
>
> Current users of the pm_genpd_init() is thus requested to start dealing
> with error codes. In the transition phase, users will have to live with
> only error messages being printed to log.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Kevin Hilman <khilman@baylibre.com>
