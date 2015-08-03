From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 00/16] ARM: shmobile: Add CPG/MSTP Clock Domain
Date: Mon, 3 Aug 2015 19:20:47 +0200
Message-ID: <CAMuHMdUxCgXnF6AM=LefR7ZHX0d8XNcn-O=eA7o4C18O4kJbAg@mail.gmail.com>
References: <1435766290-3005-1-git-send-email-geert+renesas@glider.be>
	<CAPDyKFp=zoo1OY9K-dYh9e2OV-OFVp36MbXX83vT19uFWB+0Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36722 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971AbbHCRUr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2015 13:20:47 -0400
In-Reply-To: <CAPDyKFp=zoo1OY9K-dYh9e2OV-OFVp36MbXX83vT19uFWB+0Yg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-clk@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jul 22, 2015 at 3:00 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 1 July 2015 at 17:57, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>> This patch series adds Clock Domain support to the Clock Pulse Generator
>> (CPG) Module Stop (MSTP) Clocks driver using the generic PM Domain, to
>> be used on shmobile SoCs without device power domains (R-Car Gen1 and
>> Gen2, RZ).  This allows to power-manage the module clocks of SoC devices
>> that are part of the CPG/MSTP Clock Domain using Runtime PM, or for
>> system suspend/resume, similar to SoCs with device power domains
>> (SH-Mobile and R-Mobile).

[...]

> Unless it's too late; for the series - feel free to add:
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thank you.

I have to respin anyway, as new nodes have been added to various .dtsi files.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
