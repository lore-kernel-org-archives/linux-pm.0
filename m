From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 0/4] thermal: add brcmstb AVS TMON driver
Date: Fri, 11 Aug 2017 13:35:56 +0800
Message-ID: <1502429756.2470.9.camel@intel.com>
References: <20170809220257.4234-1-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170809220257.4234-1-code-7CzEARzsJhSsTnJN9+BGXg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Mayer <code-7CzEARzsJhSsTnJN9+BGXg@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Doug Berger <opendmb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Broadcom Kernel List <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Power Management List <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2017-08-09 at 15:02 -0700, Markus Mayer wrote:
> From: Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> 
> This series adds the brcmstb AVS TMON driver.
> 
> The driver was originally written by Brian Norris.
> 
> This series is also available at
> https://github.com/mmayer/linux/tree/brcmstb-thermal-4.13-v4.
> 
> v1 of this series can be found at https://lkml.org/lkml/2017/6/5/921
> v2 of this series can be found at https://lkml.org/lkml/2017/7/21/585
> v3 of this series can be found at https://lkml.org/lkml/2017/7/31/710
> 
> Changes since v3:
> - Rebased on v4.13-rc3 to resolve conflicts in the MAINTAINERS file
> 
thanks, will apply this if we have ACK for patch 3 and 4.

thanks,
rui
> Changes since v2:
> - replaced calls to pr_debug() with calls to dev_dbg() [PATCH 2/4
> only]
> - all other patches are unchanged from v2
> 
> Changes since v1:
> - Fixed wording in binding document
> - Fixed lincensing to consistently mention GPL v2
> - Use thermal_zone_get_slope() and thermal_zone_get_offset()
> - Some minor clean-ups
> 
> Brian Norris (2):
>   Documentation: devicetree: add binding for Broadcom STB AVS TMON
>   thermal: add brcmstb AVS TMON driver
> 
> Markus Mayer (2):
>   ARM: multi_v7_defconfig: add CONFIG_BRCMSTB_THERMAL
>   arm64: defconfig: add CONFIG_BRCMSTB_THERMAL
> 
>  .../devicetree/bindings/thermal/brcm,avs-tmon.txt  |  20 ++
>  MAINTAINERS                                        |   8 +
>  arch/arm/configs/multi_v7_defconfig                |   1 +
>  arch/arm64/configs/defconfig                       |   1 +
>  drivers/thermal/Kconfig                            |   2 +-
>  drivers/thermal/broadcom/Kconfig                   |   7 +
>  drivers/thermal/broadcom/Makefile                  |   1 +
>  drivers/thermal/broadcom/brcmstb_thermal.c         | 386
> +++++++++++++++++++++
>  8 files changed, 425 insertions(+), 1 deletion(-)
>  create mode 100644
> Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
>  create mode 100644 drivers/thermal/broadcom/brcmstb_thermal.c
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
