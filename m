From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 0/4] PM / Domains: Add support for always on PM domains in genpd
Date: Sun, 23 Apr 2017 15:12:53 -0700
Message-ID: <m2mvb64vtm.fsf@baylibre.com>
References: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34528 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S972960AbdDXTII (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Apr 2017 15:08:08 -0400
Received: by mail-wr0-f172.google.com with SMTP id z109so97188294wrb.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Apr 2017 12:08:07 -0700 (PDT)
In-Reply-To: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org> (Ulf
        Hansson's message of "Mon, 20 Mar 2017 11:19:19 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> The current method to implement an always on PM domain by users of genpd,
> consists of returning -EBUSY from their ->power_off() callback. This approach is
> suboptimal as genpd is required to follow the regular execution path of its
> power off sequence, which ends by invoking the ->power_off() callback.
>
> To enable genpd to early abort the power off sequence for always on PM domains,
> it needs static information about these configurations. Therefore this series
> invents add new genpd configuration flag, GENPD_FLAG_ALWAYS_ON, which allow
> users to explicity tell genpd about these kind of PM domains.
>
> Some additonal changes, which are related this context, are also folded in as a
> part of the series.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
