From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v7 1/5] PM / Domains: prepare for multiple states
Date: Fri, 1 May 2015 20:58:37 +0200
Message-ID: <CAMuHMdW+B53fftE9i_CKcf6wO+MpYhGXU_5J7TbhuO4tfXNHcg@mail.gmail.com>
References: <1430391335-7588-1-git-send-email-ahaslam@baylibre.com>
	<1430391335-7588-2-git-send-email-ahaslam@baylibre.com>
	<20150430152959.GD424@linaro.org>
	<5542530E.80803@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35102 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbbEAS6i (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2015 14:58:38 -0400
Received: by oign205 with SMTP id n205so75759926oig.2
        for <linux-pm@vger.kernel.org>; Fri, 01 May 2015 11:58:37 -0700 (PDT)
In-Reply-To: <5542530E.80803@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>, Axel Haslam <ahaslam+renesas@baylibre.com>

On Thu, Apr 30, 2015 at 6:06 PM, Axel Haslam <ahaslam@baylibre.com> wrote:
> Im not against adding the wrapper if it simplifies things. But, in general,
> i think all latencies should be set, otherwise genpd may violate device
> constraints by turning a power domain off when it should not. So maybe, by
> leaving the arguments, it kind of sends the message to the developer that
> something important is needed.

Note that in the absence of latencies, device constraints may indeed be
violated once. After that the genpd core will have measured the real
latency value, and will start using that.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
