From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/4] PM / Domains: Remove redundant call to pm_request_idle() in genpd
Date: Mon, 23 May 2016 14:25:43 -0700
Message-ID: <m2h9domppk.fsf@baylibre.com>
References: <1463485296-22742-1-git-send-email-ulf.hansson@linaro.org>
	<1463485296-22742-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33669 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbcEWVZq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 May 2016 17:25:46 -0400
Received: by mail-pa0-f46.google.com with SMTP id xk12so65906414pac.0
        for <linux-pm@vger.kernel.org>; Mon, 23 May 2016 14:25:45 -0700 (PDT)
In-Reply-To: <1463485296-22742-2-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Tue, 17 May 2016 13:41:33 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> The PM core increases the runtime PM usage count at the system PM prepare
> phase. Later when the system has resumed and the ->complete() callback has
> been invoked, it drops the usage count. In this way, it intentionally
> prevents runtime PM suspend for the device throughout this period.
>
> For this reason, let's remove the call to pm_request_idle() from within
> genpd's ->complete() calllback as it's redundant.

It's not obvious from this description why the pm_request_idle() is
redundant based just on usage count.

IIUC, I think what you mean is that it's redundant because
device_complete() does a pm_runtime_put(), which, in addition to
decrementing the usage count, will do the equivalent of
pm_request_idle()?

Kevin
