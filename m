From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC/PATCH] dt: bindings: Define bindings for device idle states
Date: Sun, 28 Aug 2016 10:15:53 +0200
Message-ID: <CAMuHMdUopKey_HujyeK+GnTx6JpjmcQ7-zL+8=4hqhdxG4UFNQ@mail.gmail.com>
References: <1472207073-4901-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35157 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbcH1Icg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Aug 2016 04:32:36 -0400
In-Reply-To: <1472207073-4901-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robh+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Brendan Jackman <Brendan.Jackman@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Axel Haslam <ahaslam@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>

On Fri, Aug 26, 2016 at 12:24 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/device-idle-states.txt
> @@ -0,0 +1,102 @@

> +Required properties:
> +- compatible:          Must contain "simple-dev, idle-state".

Bogus space after the comma.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
