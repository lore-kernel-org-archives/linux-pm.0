From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / Domains: Change prototype for the ->attach_dev() callback
Date: Sat, 15 Nov 2014 12:32:00 +0100
Message-ID: <CAMuHMdXHhcvar2RWVVXKwvqr1dbTnnZqbBYic53U3E8-EkcAjw@mail.gmail.com>
References: <1414670569-3002-1-git-send-email-ulf.hansson@linaro.org>
	<3267963.fqUYb7m9Rv@vostro.rjw.lan>
	<7hsihx1bvo.fsf@deeprootsystems.com>
	<1442757.2EcII903db@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:48086 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbaKOLcD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 15 Nov 2014 06:32:03 -0500
In-Reply-To: <1442757.2EcII903db@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Jack Dai <jack.dai@rock-chips.com>, Ji

Hi Rafael,

On Sat, Nov 15, 2014 at 12:48 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> Subject: [PATCH] PM / Domains: Change prototype for the attach and detach
>>  callbacks
>>
>> Convert the prototypes to return an int in order to support error
>> handling in these callbacks.
>>
>> Also, as suggested by Dmitry Torokhov, pass the domain pointer for use
>> inside the callbacks, and so that they match the existing
>> power_on/power_off callbacks which currently take the domain pointer.
>>
>> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> [khilman: added domain as parameter to callbacks, as suggested by Dmitry]
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>
> That's in the Linus' tree now.

Thank you very much.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
