From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 2/2] PM / Domains: Remove redundant wrapper functions for system PM
Date: Thu, 05 May 2016 12:42:02 +0200
Message-ID: <m2lh3odbwl.fsf@baylibre.com>
References: <1461673411-14245-1-git-send-email-ulf.hansson@linaro.org>
	<1461673411-14245-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36120 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756563AbcEEKmF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2016 06:42:05 -0400
Received: by mail-wm0-f45.google.com with SMTP id n129so15181274wmn.1
        for <linux-pm@vger.kernel.org>; Thu, 05 May 2016 03:42:04 -0700 (PDT)
In-Reply-To: <1461673411-14245-3-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Tue, 26 Apr 2016 14:23:31 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> Previous changes to genpd enables us to assign several of the system PM
> callbacks to the pm_generic* helper functions, instead of invoking them
> via wrapper functions.

Seems the primary function of the existing wrappers here is checking if
there is in fact a genpd present (or error).  The changelog should
probably explain why that is no longer needed.

Kevin
