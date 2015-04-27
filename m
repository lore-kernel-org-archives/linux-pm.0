From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC v5 1/8] PM / Domains: structure changes for multiple states
Date: Mon, 27 Apr 2015 10:30:20 +0200
Message-ID: <CAMuHMdW-HFbnFyhn2h+NdbzRMtXZmr2guRNo6QwgL+WvrND=cA@mail.gmail.com>
References: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>
	<1429896924-21540-2-git-send-email-ahaslam@baylibre.com>
	<CAMuHMdWx=g+NLOcJyCAzhFjM-woMEzZQq1Tn4d+ctpGmzyzDxA@mail.gmail.com>
	<553DF2CB.3070306@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:35462 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110AbbD0IaV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2015 04:30:21 -0400
Received: by obcux3 with SMTP id ux3so77901298obc.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2015 01:30:21 -0700 (PDT)
In-Reply-To: <553DF2CB.3070306@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>

On Mon, Apr 27, 2015 at 10:26 AM, Axel Haslam <ahaslam@baylibre.com> wrote:
> BTW, im thinking i should add a default OFF state in case the state_count is
> 0, that way, platforms could not worry about states
> at all in case they dont define latencies.

Ideally, the latencies should come from DT, not from C platform code.

Now v4.1-rc1 is out, I'll resurrect my patches for that, as Kevin asked back
in March.
They'll be RFC again, as they're gonna need changes to support multiple
states.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
