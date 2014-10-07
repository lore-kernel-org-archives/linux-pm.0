From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Powering down unused PM domains (was: Re: [PATCH 0/4] PM / Domains:
 Fix race conditions during boot)
Date: Tue, 7 Oct 2014 21:09:27 +0200
Message-ID: <CAMuHMdUwbOEfLcu_UVKq_iHx5Qzn7ne1+cwt58C0ntTZBf1esg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:64054 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754813AbaJGTJ2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Oct 2014 15:09:28 -0400
Received: by mail-lb0-f177.google.com with SMTP id w7so6672574lbi.22
        for <linux-pm@vger.kernel.org>; Tue, 07 Oct 2014 12:09:27 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>

Hi Ulf,

On Tue, Sep 30, 2014 at 2:43 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Instead, let's improve the situation, by preventing genpd from powering
> off any of the PM domains until late_init. At that point genpd already
> tries to power off unused PM domains, so it seems like a decent match.

Note that powering off unused PM domains is currently limited to
CONFIG_PM_RUNTIME=y.
If CONFIG_PM_RUNTIME is disabled, unused PM domains are not powered down,
and may even stay powered-up during system suspend.

With CONFIG_PM_RUNTIME=y, we have:
  A1. All PM domains are powered up during initialization.
  A2. After initialization, all unused PM domains are powered down by the
      genpd_poweroff_unused() late_initcall.
      "unused" means PM domains containing no active devices and no active
      subdomains. I.e. PM domains containing (a) only suspended devices, or
      (b) no[*] devices at all will be powered down.
  A3. PM domains will be powered up or down, depending on devices moving from
      inactive to active state, or vice versa. This includes system suspend,
      which can be considered some form of devices moving to an inactive
      state.

In contrast, with CONFIG_PM_RUNTIME=n, we have:
  B1. All PM domains are powered up during initialization,
  B2. After initialization, PM domains just stay powered up,
  B3. PM domains will be powered down on system suspend, and powered up on
      system resume, based on the dev_pm_ops of the PM domain each device
      belongs to.

While operation A2 is PM domain-centric (it walks the list of genpd domains),
A3 and B3 are device-centric (A3 operates on one specific device, B3 walks the
list of devices).
Hence B3 never touches PM domains that don't contain any devices[*].
So these PM domains are kept powered-up if CONFIG_PM_RUNTIME=n, even on
system suspend.

Shouldn't PM domains without devices be powered down at some point?
When? In B2, or in B3?

Thanks for your suggestions!

[*] It may sound strange to have a PM domain without devices. However, this may
    happen due to incomplete device trees, or for devices without existing
    bindings or without Linux support.

Gr{oetje,eeting}s,

                        Geert

P.S. Will any of you be at ELC-E next week, for further PM domain discussions?
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
