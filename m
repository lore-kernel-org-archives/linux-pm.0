From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [RESEND PATCH v3 2/2] PM / Domains: Remove redundant wrapper functions for system PM
Date: Wed, 15 Jun 2016 14:01:43 -0700
Message-ID: <m2bn32p3ns.fsf@baylibre.com>
References: <1464601388-26693-1-git-send-email-ulf.hansson@linaro.org>
	<1464601388-26693-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36690 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbcFOVBp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 17:01:45 -0400
Received: by mail-pf0-f173.google.com with SMTP id t190so12283025pfb.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2016 14:01:45 -0700 (PDT)
In-Reply-To: <1464601388-26693-3-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Mon, 30 May 2016 11:43:08 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Alex Deucher <alexander.deucher@amd.com>, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, dri-devel@lists.freedesktop.org, Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> Due to the previous changes to genpd, which removed the suspend_power_off
> flag, several of the system PM callbacks is no longer doing any additional
> checks but only invoking a corresponding pm_generic_* helper function.
>
> To clean up the code let's remove these wrapper functions as they have
> become redundant. Instead assign the system PM callbacks directly to
> the pm_generic_*() helper function.
>
> While changing this, it became clear that some of the current system PM
> callbacks in genpd, invokes the wrong callback at the driver level. For
> example, genpd's ->restore() callback invokes pm_generic_resume(), while
> it should be pm_generic_restore(). Let's fix this as well.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>

Kevin
