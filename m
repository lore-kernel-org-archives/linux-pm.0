From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V3] PM / Domains: Remove intermediate states from the
 power off sequence
Date: Thu, 25 Jun 2015 14:24:04 +0200
Message-ID: <CAMuHMdU7jGd2O_StrVgZPL3-WZRJkzSJ1d-Xe-utb2=4L2gqEQ@mail.gmail.com>
References: <1434020737-13354-1-git-send-email-ulf.hansson@linaro.org>
	<7ha8w01qir.fsf@deeprootsystems.com>
	<CAMuHMdWCo+U26x9Z5vUu+5ZVSpSOFF1LDO7jkezuXzVR2mC6qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33446 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbbFYMYE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2015 08:24:04 -0400
Received: by oiyy130 with SMTP id y130so51014955oiy.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2015 05:24:04 -0700 (PDT)
In-Reply-To: <CAMuHMdWCo+U26x9Z5vUu+5ZVSpSOFF1LDO7jkezuXzVR2mC6qA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Axel Haslam <ahaslam+renesas@baylibre.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Ulf,

On Tue, Jun 23, 2015 at 12:57 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>> I know Lina has been testing this (or an earlier version) on qcom
>> hardware so would be nice to get a tested-by from her, and would also be
>> nice to see if Geert has a chance to take this for a spin on his Renesas
>> hardware and anyone can take this for a spin on Exynos.
>
> I needed some athletics to make this apply to my current tree, but I did
> manage to test it on:
>   - sh73a0/kzm9g (SYSC PM Domain/pm-rmobile),
>   - r8a7740/armadillo (SYSC PM Domain/pm-rmobile),
>   - r8a73a4/ape6evm (SYSC PM Domain/pm-rmobile),
>   - r8a7791/koelsch (CPG Clock Domain + SYSC PM Domain/pm-rcar).
> I didn't notice any regressions or other oddities.
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

I accidentally tested v2 instead of v4. Retested with v4, everything still fine.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
