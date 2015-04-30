From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC v6 5/5] PM / Domains: remove old power on/off callbacks.
Date: Thu, 30 Apr 2015 09:21:53 +0200
Message-ID: <CAMuHMdX2ThcBd1rfpbLEdfjYZJG7zKQ8F7xJfBDCo=gR6SQ9bg@mail.gmail.com>
References: <1430334615-1161-1-git-send-email-ahaslam@baylibre.com>
	<1430334615-1161-6-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36581 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbbD3HVy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2015 03:21:54 -0400
Received: by oift201 with SMTP id t201so41288658oif.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2015 00:21:53 -0700 (PDT)
In-Reply-To: <1430334615-1161-6-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>, Axel Haslam <ahaslam+renesas@baylibre.com>

On Wed, Apr 29, 2015 at 9:10 PM,  <ahaslam@baylibre.com> wrote:
> Now that all known users have been converted to use the state
> version of the callbacks, we can remove the default callbacks
> without breaking compilation.

You forgot to update the one-line summary and the full description:
the callbacks are no longer removed, only the latencies.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
