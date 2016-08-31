From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 0/3] arm64: Hikey: enable CPUFreq and thermal drivers
Date: Wed, 31 Aug 2016 16:50:14 +0800
Message-ID: <1472633417-9330-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms+renesas@verge.net.au>, Krzysztof Kozlowski <krzk@kernel.org>, Thierry Reding <treding@nvidia.com>, Riku Voipio <riku.voipio@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

Currently most power management code of 96boards Hikey have been merged
into mainline kernel, but some of them have not been built by default;
So this patch series is to build all these modules properly.

The software layer is as below:

                        set constraint
    cpufreq-dt driver  <--------------  thermal/cpu_cooling driver
           |                                       |
	   V                                       V
  hi6220 stub clock driver                hisi thermal driver

So first two patches are two enable fundamental modules for hi6220 stub
clock driver and hisilicon thermal driver. Based on these two drivers,
we also need enable common drivers for cpufreq-dt.c and cpu_cooling.c;
these two drivers are commonly used by other platforms, so enable these
two common drivers in arm64's defconfig. arm32's defconfig has enabled
these two configurations yet.

Leo Yan (3):
  clk: Hi6220: enable stub clock driver for ARCH_HISI
  thermal: hisilicon: fix for dependency
  arm64: defconfig: enable two common modules for power management

 arch/arm64/configs/defconfig  | 2 ++
 drivers/clk/hisilicon/Kconfig | 1 +
 drivers/thermal/Kconfig       | 4 +++-
 3 files changed, 6 insertions(+), 1 deletion(-)

-- 
1.9.1
