From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 2/3] PM / Domains: Add support for devices with
 multiple domains
Date: Wed, 21 Sep 2016 10:53:01 +0200
Message-ID: <CAMuHMdVc+EjkbcpPKyzbCfDjp65gF3xP3bhkjh6SKLt6KDTtXg@mail.gmail.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com> <1474367287-10402-3-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1474367287-10402-3-git-send-email-jonathanh@nvidia.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Jon,

On Tue, Sep 20, 2016 at 12:28 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
> Some devices may require more than one PM domain to operate and this is
> not currently by the PM domain framework. Furthermore, the current Linux
> 'device' structure only allows devices to be associated with a single PM
> domain and so cannot easily be associated with more than one. To allow
> devices to be associated with more than one PM domain, if multiple
> domains are defined for a given device (eg. via device-tree), then:
> 1. Create a new PM domain for this device. The name of the new PM domain
>    created matches the device name for which it was created for.
> 2. Register the new PM domain as a sub-domain for all PM domains
>    required by the device.
> 3. Attach the device to the new PM domain.

This looks a suboptimal to me: if you have n devices sharing the same PM
domains, you would add n new subdomains?

Having a clean way to specify multiple PM domains is very useful, though.

E.g. on Renesas ARM SoCs, devices are usually part of two PM domains:
  1. A power area (can be "always-on",
  2. The clock domain.

As power areas and clock domains are fairly orthogonal (the former use the
.power_{off,on}() callbacks, the latter set GENPD_FLAG_PM_CLK and use the
{at,de}tach_dev() callbacks), we currently setup both in the same driver
(SYSC, for controlling power areas), which forwards the clock domain operations
to the clock driver (CPG/MSTP or CPG/MSSR).
Hence we have only single references in the power-domains properties, but
having two would allow to drop the hardcoded links between the two drivers.

(Oh no, more DT backwards compatibility issues if this is accepted ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
