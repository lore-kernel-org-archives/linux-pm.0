From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v4 2/3] PM / clock_ops: make __pm_clk_enable more generic
Date: Fri, 07 Nov 2014 11:25:14 -0800
Message-ID: <7h1tpestid.fsf@deeprootsystems.com>
References: <1415281862-23764-1-git-send-email-grygorii.strashko@ti.com>
	<1415281862-23764-3-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33612 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbaKGTZS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 14:25:18 -0500
Received: by mail-pa0-f46.google.com with SMTP id lf10so4074328pab.5
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2014 11:25:17 -0800 (PST)
In-Reply-To: <1415281862-23764-3-git-send-email-grygorii.strashko@ti.com>
	(Grygorii Strashko's message of "Thu, 6 Nov 2014 15:51:01 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: ssantosh@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Grygorii Strashko <grygorii.strashko@ti.com> writes:

> Now there are two places in code which do the same things,
> so allow __pm_clk_enable() to accept pointer on pm_clock_entry
> structure as second parameter instead of pointer on clock and
> remove duplicated code.
>
> Also, updated function intended to be used by following patch.
>
> CC: Santosh Shilimkar <ssantosh@kernel.org>
> CC: Kevin Hilman <khilman@linaro.org>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: Geert Uytterhoeven <geert@linux-m68k.org>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Reviewed-by: Kevin Hilman <khilman@linaro.org>
