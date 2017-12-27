From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [RFC PATCH v12 0/5] PCI: rockchip: Move PCIe WAKE# handling into pci core
Date: Wed, 27 Dec 2017 01:44:03 +0100
Message-ID: <1979156.HCZ09VA8ni@aspire.rjw.lan>
References: <20171226023646.17722-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171226023646.17722-1-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Xinming Hu <huxm-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nishant Sarmukadam <nishants-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ganapathi Bhat <gbhat-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Amitkumar Karwar <amitkarwar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, December 26, 2017 3:36:41 AM CET Jeffy Chen wrote:
> 
> Currently we are handling wake irq in mrvl wifi driver. Move it into
> pci core.
> 
> Tested on my chromebook bob(with cros 4.4 kernel and mrvl wifi).
> 
> 
> Changes in v13:
> Fix compiler error reported by kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> Changes in v12:
> Only add irq definitions for PCI devices and rewrite the commit message.
> Enable the wake irq in noirq stage to avoid possible irq storm.
> 
> Changes in v11:
> Address Brian's comments.
> Only support 1-per-device PCIe WAKE# pin as suggested.
> Move to pcie port as Brian suggested.
> 
> Changes in v10:
> Use device_set_wakeup_capable() instead of device_set_wakeup_enable(),
> since dedicated wakeirq will be lost in device_set_wakeup_enable(false).
> 
> Changes in v9:
> Add section for PCI devices and rewrite the commit message.
> Fix check error in .cleanup().
> Move dedicated wakeirq setup to setup() callback and use
> device_set_wakeup_enable() to enable/disable.
> Rewrite the commit message.
> 
> Changes in v8:
> Add optional "pci", and rewrite commit message.
> Add pci-of.c and use platform_pm_ops to handle the PCIe WAKE# signal.
> Rewrite the commit message.
> 
> Changes in v7:
> Move PCIE_WAKE handling into pci core.
> 
> Changes in v6:
> Fix device_init_wake error handling, and add some comments.
> 
> Changes in v5:
> Move to pci.txt
> Rebase.
> Use "wakeup" instead of "wake"
> 
> Changes in v3:
> Fix error handling.
> 
> Changes in v2:
> Use dev_pm_set_dedicated_wake_irq.
> 
> Jeffy Chen (5):
>   dt-bindings: PCI: Add definition of PCIe WAKE# irq and PCI irq
>   of/irq: Adjust of_pci_irq parsing for multiple interrupts
>   mwifiex: Disable wakeup irq handling for pcie
>   PCI / PM: Add support for the PCIe WAKE# signal for OF
>   arm64: dts: rockchip: Move PCIe WAKE# irq to pcie port for Gru
> 
>  Documentation/devicetree/bindings/pci/pci.txt | 10 ++++
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 11 ++--
>  drivers/net/wireless/marvell/mwifiex/main.c   |  4 ++
>  drivers/of/of_pci_irq.c                       | 71 +++++++++++++++++++++++--
>  drivers/pci/Makefile                          |  1 +
>  drivers/pci/pci-driver.c                      | 10 ++++
>  drivers/pci/pci-of.c                          | 75 +++++++++++++++++++++++++++
>  include/linux/of_pci.h                        |  9 ++++
>  8 files changed, 183 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/pci/pci-of.c

I'm going to ignore this version till the discussion on the previous one is
over.

Thanks,
Rafael


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
