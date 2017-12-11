From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/4] PM / core: Use dev_pm_skip_next_resume_phases() internally
Date: Mon, 11 Dec 2017 11:03:39 +0100
Message-ID: <CAMuHMdXimJpnp84oUmGYTWHrBr7yQES48dhTA2fEWrDErbLYbQ@mail.gmail.com>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan> <2984032.oZIAi2Obeo@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46918 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752259AbdLKKDk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Dec 2017 05:03:40 -0500
In-Reply-To: <2984032.oZIAi2Obeo@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

On Sun, Dec 10, 2017 at 12:56 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Make the PM core call dev_pm_skip_next_resume_phases() to skip the
> "early resume" and "resume" phases of system-wide transitions to the
> working state for a given device instead of clearing the relevant
> status bits for it directly.
>
> No intentional changes in functionality.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
