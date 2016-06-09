From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] cpufreq: mvebu: fix integer to pointer cast
Date: Thu, 9 Jun 2016 09:11:38 +0100
Message-ID: <63e7df1a-4ddf-8de0-a600-a09983ecbce6@codethink.co.uk>
References: <1465299013-32369-1-git-send-email-ben.dooks@codethink.co.uk>
 <5757CF9B.3080402@free.fr>
 <d3c117ea-2dce-63a2-7888-31ee8320a3dd@codethink.co.uk>
 <32804824.nq0AOIbNnC@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:38894 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091AbcFIILo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2016 04:11:44 -0400
In-Reply-To: <32804824.nq0AOIbNnC@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: Mason <slash.tmp@free.fr>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@lists.codethink.co.uk, linux-pm@vger.kernel.org

On 09/06/16 08:07, Arnd Bergmann wrote:
> On Wednesday, June 8, 2016 9:59:26 AM CEST Ben Dooks wrote:
>> On 08/06/16 08:56, Mason wrote:
>>> On 07/06/2016 13:30, Ben Dooks wrote:
>>>
>>>> Fix the use of 0 instead of NULL to clk_get() call. This stops the
>>>> following warning:
>>>>
>>>> drivers/cpufreq/mvebu-cpufreq.c:73:40: warning: Using plain integer as NULL pointer
>>>
>>> May I ask which compiler/version produced that diagnostic?
>>
>> I was running with "make C=2 bzImage" for ARM multi_v7_config
>>
>> $ sparse --version
>> v0.5.0
>>
> 
> I believe gcc-6 will also produce a similar warning when building with
> 'make W=1'. I've started looking into moving some of the warnings from
> W=1 level to default, which can probably be done with relatively little
> effort for many warnings.

Would be interesting to see, I tried W=2 and W=3 and ended up with
hundreds of MiB of logs.

Out of interest, which other warnings do you think would make good
next targets?

> I see that you are making very good progress at eliminating the
> -Wmissing-declarations warnings, which are also at W=1 level. Do
> you have an estimate of how many there are? Do you plan to do them
> all, or just the ones for some subsystems? I've stayed away from
> this one for now since there are lots of such warnings, but it
> seems particularly worthwhile.

Yes, got bored so went at a lot of the warnings that sparse produces
and may consider having a go with gcc6 now it is being packaged by
Debian. I've been building with multi_v7_defconfig

I may look at some of the other ARM configurations and build options
in the next few days.

So far i've got 61 fix patches for issues such as missing includes or
people doing very silly things with pointers. The branch as of last
night is now up at:

git://git.codethink.co.uk/public/linux bjdooks/fixup_warnings

Ben Dooks (61):
      mmc: dw_mmc: fix 32bit little-endian access of des1 field
      cpufreq: mvebu: fix integer to pointer cast
      watchdog: sirf: fix __iomem * warnings
      irqchip/sirfsoc: fix sparse warnings on __iomem
      irqchip/tegra: fix fix sparse warnings on __iomem
      iommu/exynos: update to use iommu big-endian
      clk: hi6220: fix missing clk.h include
      clk: ti: fapll: fix address space warnings
      clocksource/drivers/digicolor: fix warning of non-static function
      clocksource/drivers/armada-370-xp: make syscore_ops static
      dmaengine: ste_dma40_ll: make d40_width_to_bits static
      dmaengine: sirf: fix un-exported struct warnings
      dmaengine: at_xdmac: fix un-exported functions
      dmaengine: bcm2835: fix unexported function
      gpio: bcm-kona: fix bcm_kona_gpio_reset() warnings
      clk: iproc: fix missing include of clk-iproc.h
      clk: at91: make of_sama5d2_clk_generated_setup() static
      ata: sata_mv: fix mis-conversion in mv_write_cached_reg()
      pinctrl: nsp-gpio: fix non-static functions
      pinctrl: at91-pio4: fix non-exported functions
      phy-sun4i-usb: fix missing __iomem *
      pinctrl: sh-pfc: fix warnings by include core.h
      regulator: twl: fix use of integer as pointer
      ARM: bcm2835: remove unused __packet
      soc: brcmstb: fix warning from missing include
      serial: sirf: make fifo functions static
      serial: sirf: make uart register info static
      tty: serial: msm: fix definition of msm_stop_dma
      USB: core: fix missing include <linux/usb/of.h>
      net-sysfs: fix missing <linux/of_net.h>
      mvebu: fix missing includes in pmsu.c
      mvebu: fix missing include of common.h in pm.c
      mvebu: fix missing include of common.h in cpu-reset.c
      mvebu: make mvebu_armada375_smp_wa_init() static
      mvebu: add definition for coherency_base
      pinctrl: nomadik: fix warnings from unexported functions
      ARM: make unexported functions static
      arm: dma-mapping: make unexported items static
      ARM: bcm: fix missing include of kona_l2_cache.h
      ARM: tegra: irq: fix missing include of irq.h
      ARM: tegra: fix missing include <soc/tegra/cpuidle.h>
      ARM: tegra: fix missing include of cpuidle.h
      ARM: tegra: fix missing common.h include
      vexpress/spc: fix missing include of spc.h
      ARM: vexpress: fix missing core.h include
      ARM: versatile: fix missing <plat/platsmp.h> include
      ARM: imx: fix missing includes
      ARM: imx: fix missing include of common.h
      ARM: imx: fix missing cpuidle.h include
      EDAC: make dev_attr_sdram_scrub_rate static
      irqchip/bcm2836: make bcm2836_smp_boot_secondary static
      irqchip/omap-intc: fix missing <linux/irqchip/irq-omap-intc.h> include
      irqchip/gic-v2m: fix missing include of <linux/irqchip/arm-gic.h>
      irqchip/armada-370-xp: make syscore_ops static
      irqchip/bcm7120-l2: make probe functions static
      irqchip/brcmstb-l2: make of probe function static
      mfd: omap-usb-tll: fix include of omap-usb.h
      mmc: mmci: add missing include of mmci_qcom_dml.h
      stmmac: fix parameter to dwmac4_set_umac_addr()
      power: vexpress: make dev_attr_active static
      power/reset: make syscon_poweroff() static



-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
