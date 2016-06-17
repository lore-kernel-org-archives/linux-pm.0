From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / Domains: Convert pm_genpd_init() to return an error code
Date: Fri, 17 Jun 2016 12:59:30 +0200
Message-ID: <CAMuHMdVofBY-kNULQHWmoAuovLfK4HG4Ce1VORrKekOG9vAbWg@mail.gmail.com>
References: <1466159272-9726-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34444 "EHLO
	mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbcFQK7c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2016 06:59:32 -0400
Received: by mail-it0-f65.google.com with SMTP id f6so1590554ith.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2016 03:59:32 -0700 (PDT)
In-Reply-To: <1466159272-9726-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Ulf,

On Fri, Jun 17, 2016 at 12:27 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
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

What can we do in case of error? It's not like anything is going to work
if PM domains are failing...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
