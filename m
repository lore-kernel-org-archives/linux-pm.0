From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] PM / Domains: Add support for devices with
 multiple domains
Date: Wed, 21 Sep 2016 16:57:04 +0200
Message-ID: <CAMuHMdV9TENEt7y5Opehh1CC5+0=s4nRMvnh=0nTYOUuOOC2uw@mail.gmail.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
 <1474367287-10402-3-git-send-email-jonathanh@nvidia.com> <CAMuHMdVc+EjkbcpPKyzbCfDjp65gF3xP3bhkjh6SKLt6KDTtXg@mail.gmail.com>
 <658004af-e4f4-8b0c-cdc1-43661d331d70@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <658004af-e4f4-8b0c-cdc1-43661d331d70-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Jon,

On Wed, Sep 21, 2016 at 4:37 PM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> On 21/09/16 09:53, Geert Uytterhoeven wrote:
>> On Tue, Sep 20, 2016 at 12:28 PM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>> Some devices may require more than one PM domain to operate and this is
>>> not currently by the PM domain framework. Furthermore, the current Linux
>>> 'device' structure only allows devices to be associated with a single PM
>>> domain and so cannot easily be associated with more than one. To allow
>>> devices to be associated with more than one PM domain, if multiple
>>> domains are defined for a given device (eg. via device-tree), then:
>>> 1. Create a new PM domain for this device. The name of the new PM domain
>>>    created matches the device name for which it was created for.
>>> 2. Register the new PM domain as a sub-domain for all PM domains
>>>    required by the device.
>>> 3. Attach the device to the new PM domain.
>>
>> This looks a suboptimal to me: if you have n devices sharing the same PM
>> domains, you would add n new subdomains?
>
> BTW, would this be the case today for some renesas devices or are you
> just pointing this out as something that could be optimised/improved?

This is the case for all Renesas SoCs that have power areas: devices belong
to both the PM domain for the power area, and to the PM domain for the clock
domain.

See setting of .attach_dev in
    arch/arm/mach-shmobile/pm-rmobile.c (power areas + clock domain)
    drivers/clk/renesas/clk-mstp.c (pure clock domain)
    drivers/clk/renesas/renesas-cpg-mssr.c (pure clock domain)
    drivers/soc/renesas/rcar-sysc.c (power areas + clock domain)

AFAIK there are no devices that belong to multiple power areas (power areas may
be nested though, which is handled fine by the current framework, as created by
Rafael when he worked on Renesas SoCs).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
