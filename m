From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 2/5] PM / Runtime: Prevent re-resuming devices in pm_runtime_force_resume()
Date: Wed, 15 Jun 2016 14:33:22 -0700
Message-ID: <m237oep271.fsf@baylibre.com>
References: <1464600795-26307-1-git-send-email-ulf.hansson@linaro.org>
	<1464600795-26307-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35112 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbcFOVdY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 17:33:24 -0400
Received: by mail-pa0-f50.google.com with SMTP id hl6so10976658pac.2
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2016 14:33:24 -0700 (PDT)
In-Reply-To: <1464600795-26307-3-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Mon, 30 May 2016 11:33:12 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> If the runtime PM status of the device isn't RPM_SUSPENDED, prevent the
> pm_runtime_force_resume() to call the ->runtime_resume() callback for the
> device, as it's not the expected behaviour from the subsystem/driver.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
