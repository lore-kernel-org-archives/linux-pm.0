From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / Domains: Fix typo in description of genpd_dev_pm_detach()
Date: Thu, 27 Aug 2015 13:35:40 +0200
Message-ID: <CAMuHMdUCj7NFooWS8dtj4LB55hQLdMjOOEPoAxS+upR7PvwyXQ@mail.gmail.com>
References: <1440667020-8833-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33288 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbbH0Lfl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2015 07:35:41 -0400
Received: by obbhe7 with SMTP id he7so17805300obb.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2015 04:35:40 -0700 (PDT)
In-Reply-To: <1440667020-8833-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>

On Thu, Aug 27, 2015 at 11:17 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
> The function genpd_dev_pm_detach() detaches a device from a PM domain,
> however, in the description, the "dev" argument for the function is
> described as the device to "attach" instead of "detach". Correct this.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
