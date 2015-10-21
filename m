From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Wed, 21 Oct 2015 10:55:14 +0200
Message-ID: <CAMuHMdWoSdoT1p0e+Bc9ucrykxO7ESLKYHRzackpVjQAs_XaDg@mail.gmail.com>
References: <561E1378.6000906@collabora.com>
	<4025469.zmyipZqCsP@vostro.rjw.lan>
	<CAL_JsqJuu5_Osqi+X6M6UeRDZFQB+_8riYDF1gvsGayk5-4SFw@mail.gmail.com>
	<4903022.NtioyRkmbB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <4903022.NtioyRkmbB@vostro.rjw.lan>
Sender: linux-gpio-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Rob Herring <robh@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmai>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Wed, Oct 21, 2015 at 1:34 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, October 20, 2015 09:15:01 AM Rob Herring wrote:
>> On Tue, Oct 20, 2015 at 2:56 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > ACPI uses platform devices too.  In fact, ACPI device objects are enumerated as
>> > platform devices by default now.
>>
>> Okay, I should have grepped for that:
>> drivers/base/platform.c:                ACPI_COMPANION_SET(&pdev->dev, NULL);
>> drivers/base/platform.c:        len = acpi_device_modalias(dev, buf,
>> PAGE_SIZE -1);
>> drivers/base/platform.c:        rc = acpi_device_uevent_modalias(dev, env);
>> drivers/base/platform.c:        /* Then try ACPI style match */
>> drivers/base/platform.c:        if (acpi_driver_match_device(dev, drv))
>>
>> These are all cases which have DT version as well, so we're not really
>> all that different here. There's a few more for DT, but that probably
>> means you have just not hit the problems we have yet. For example,
>> what happens if you have an interrupt line in which the controller is
>> probed after the device connected to the interrupt line? That required
>> resolving irqs in platform_get_irq rather than using static resources
>> to support deferred probe.
>
> We don't have this particular problem, because the IRQ controllers are
> enumerated in a special way.

What does "in a special way" mean? Can you please be more specific?

Can you have interrupt controllers that depend on clocks, pin controllers,
and PM domains?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
