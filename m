From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V3 3/3] ARM: shmobile: Convert to genpd flags for PM
 clocks for R-mobile
Date: Mon, 1 Dec 2014 10:36:24 +0100
Message-ID: <CAMuHMdVntNxw+zciOQfayfJbMMV+AqOyZMqeB2FY=Q5eA=r0rw@mail.gmail.com>
References: <1417163403-7070-1-git-send-email-ulf.hansson@linaro.org>
	<1417163403-7070-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:48610 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715AbaLAJg0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 04:36:26 -0500
In-Reply-To: <1417163403-7070-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Simon Horman <horms@verge.net.au>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Arnd Bergmann <arnd@arndb.de>, Linux-sh list <linux-sh@vger.kernel.org>

On Fri, Nov 28, 2014 at 9:30 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Instead of using the dev_ops ->stop|start() callbacks for genpd, let's
> convert to use genpd's flag field and set it to GENPD_PM_CLK.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

(tested on r8a7740/armadillo-multiplatform and sh73a0/kzm9g-multiplatform).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
