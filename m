From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/9] PM / Domains: Remove dev->driver check for runtime PM
Date: Thu, 13 Aug 2015 10:57:38 +0200
Message-ID: <CAMuHMdVeffa-jgXuSjDQBKTrhgW-d87OKzs1iXX+4y-9U_AJbg@mail.gmail.com>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
	<1438731339-58317-3-git-send-email-lina.iyer@linaro.org>
	<7hfv3onv5c.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:35171 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbbHMI5j (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 04:57:39 -0400
Received: by obbop1 with SMTP id op1so32421570obb.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2015 01:57:38 -0700 (PDT)
In-Reply-To: <7hfv3onv5c.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Lina Iyer <lina.iyer@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>

Hi Kevin,

On Wed, Aug 12, 2015 at 9:50 PM, Kevin Hilman <khilman@kernel.org> wrote:
> Lina Iyer <lina.iyer@linaro.org> writes:
>
>> Remove check for driver of a device, for runtime PM. Device may be
>> suspended without an explicit driver. This check seems to be vestigial
>> and incorrect in the current context.
>
> This one should probably have been RFC.
>
> For a little more context here, this was uncovered when experimenting
> with using runtime PM for CPU devices which don't have a dev->driver.
>
> This check might have made sense before PM domains, but with PM domains,
> it's entirely possible to have a simple device without a driver and the
> PM domain handles all the necesary PM, so I think this check
> could/should be removed.
>
> Thoughts?

Simple devices without a driver aren't handled automatically.
At minimum, the driver should call pm_runtime_enable(), cfr.
drivers/bus/simple-pm-bus.c.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
