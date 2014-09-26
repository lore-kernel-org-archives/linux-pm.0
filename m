From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 05/13] PM / Domains: Add helper variable np = dev->of_node
Date: Fri, 26 Sep 2014 10:47:18 +0200
Message-ID: <CAMuHMdUEA07weFje47u4sJ6uc0FCvoq+FEe27DSmKOVB0dTatA@mail.gmail.com>
References: <1411662520-22795-1-git-send-email-geert+renesas@glider.be>
	<1411662520-22795-6-git-send-email-geert+renesas@glider.be>
	<CAPDyKFpiTBKEJHTF9cK20GTqEgx=4UNt52sKi0dQ7NsZNhfFOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpiTBKEJHTF9cK20GTqEgx=4UNt52sKi0dQ7NsZNhfFOA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Kevin Hilman <khilman@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 26, 2014 at 10:43 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 25 September 2014 18:28, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> Why?

Because else the next patch would add a few more users of dev->of_node.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
