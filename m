From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 5/5] PM / Runtime: Defer resuming of the device in pm_runtime_force_resume()
Date: Wed, 15 Jun 2016 14:41:48 -0700
Message-ID: <m2k2hqnn8j.fsf@baylibre.com>
References: <1464600795-26307-1-git-send-email-ulf.hansson@linaro.org>
	<1464600795-26307-6-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34897 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbcFOVlu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 17:41:50 -0400
Received: by mail-pf0-f171.google.com with SMTP id c2so12579347pfa.2
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2016 14:41:50 -0700 (PDT)
In-Reply-To: <1464600795-26307-6-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Mon, 30 May 2016 11:33:15 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> When the pm_runtime_force_suspend|resume() helpers were invented, we still
> had CONFIG_PM_RUNTIME and CONFIG_PM_SLEEP as separate Kconfig options.
>
> To make sure these helpers worked for all combinations and without
> introducing too much of complexity, the device was always resumed in
> pm_runtime_force_resume().
>
> More precisely, when CONFIG_PM_SLEEP was set and CONFIG_PM_RUNTIME was
> unset, we needed to resume the device as the subsystem/driver couldn't
> rely on using runtime PM to do it.
>
> As the CONFIG_PM_RUNTIME option was merged into CONFIG_PM a while ago, it
> removed this combination, of using CONFIG_PM_SLEEP without the earlier
> CONFIG_PM_RUNTIME.
>
> For this reason we can now rely on the subsystem/driver to use runtime PM
> to resume the device, instead of forcing that to be done in all cases. In
> other words, let's defer the runtime resume to a later point when it's
> actually needed.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
