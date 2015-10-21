From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [GIT PULL] On-demand device probing
Date: Thu, 22 Oct 2015 01:39:42 +0200
Message-ID: <13395371.QJ0TvhYnx8@vostro.rjw.lan>
References: <561E1378.6000906@collabora.com> <4903022.NtioyRkmbB@vostro.rjw.lan> <CAMuHMdWoSdoT1p0e+Bc9ucrykxO7ESLKYHRzackpVjQAs_XaDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWoSdoT1p0e+Bc9ucrykxO7ESLKYHRzackpVjQAs_XaDg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?ISO-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gm>
List-Id: linux-pm@vger.kernel.org

On Wednesday, October 21, 2015 10:55:14 AM Geert Uytterhoeven wrote:
> Hi Rafael,
> 
> On Wed, Oct 21, 2015 at 1:34 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, October 20, 2015 09:15:01 AM Rob Herring wrote:
> >> On Tue, Oct 20, 2015 at 2:56 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > ACPI uses platform devices too.  In fact, ACPI device objects are enumerated as
> >> > platform devices by default now.
> >>
> >> Okay, I should have grepped for that:
> >> drivers/base/platform.c:                ACPI_COMPANION_SET(&pdev->dev, NULL);
> >> drivers/base/platform.c:        len = acpi_device_modalias(dev, buf,
> >> PAGE_SIZE -1);
> >> drivers/base/platform.c:        rc = acpi_device_uevent_modalias(dev, env);
> >> drivers/base/platform.c:        /* Then try ACPI style match */
> >> drivers/base/platform.c:        if (acpi_driver_match_device(dev, drv))
> >>
> >> These are all cases which have DT version as well, so we're not really
> >> all that different here. There's a few more for DT, but that probably
> >> means you have just not hit the problems we have yet. For example,
> >> what happens if you have an interrupt line in which the controller is
> >> probed after the device connected to the interrupt line? That required
> >> resolving irqs in platform_get_irq rather than using static resources
> >> to support deferred probe.
> >
> > We don't have this particular problem, because the IRQ controllers are
> > enumerated in a special way.
> 
> What does "in a special way" mean? Can you please be more specific?
> 
> Can you have interrupt controllers that depend on clocks, pin controllers,
> and PM domains?

Currently, there's no native way to represent those dependencies in ACPI.

Thanks,
Rafael
