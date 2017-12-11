From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/4] PM / core: Add helpers for subsystem callback selection
Date: Mon, 11 Dec 2017 11:08:44 +0100
Message-ID: <CAMuHMdXPA+k=cbBj-_2b0Su7DGj5+MLMOFWxphTBBxCNqC4j-w@mail.gmail.com>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan> <75666632.ssxbU8s7ES@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38581 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdLKKIq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Dec 2017 05:08:46 -0500
In-Reply-To: <75666632.ssxbU8s7ES@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

On Sun, Dec 10, 2017 at 12:58 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Add helper routines to find and return a suitable subsystem callback
> during the "noirq" phases of system suspend/resume (or analogous)
> transitions as well as during the "late" phase of system suspend and
> the "early" phase of system resume (or analogous) transitions.
>
> The helpers will be called from additional sites going forward.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
