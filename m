From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v2 1/5] arm64: tegra: Add BPMP thermal sensor to Tegra186
Date: Thu, 27 Jul 2017 09:52:10 +0300
Message-ID: <0f9e5f15-c4e2-d897-df3e-5253c3b94007@nvidia.com>
References: <201707271402.PznRxqSc%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5650 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdG0GwP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 02:52:15 -0400
In-Reply-To: <201707271402.PznRxqSc%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, rui.zhang@intel.com, edubezval@gmail.com, thierry.reding@gmail.com, jonathanh@nvidia.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Good point, so patches 1/5 and 2/5 should be swapped around.

Mikko

On 27.07.2017 09:47, kbuild test robot wrote:
> Hi Mikko,
>
> [auto build test ERROR on tegra/for-next]
> [also build test ERROR on v4.13-rc2 next-20170726]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Mikko-Perttunen/arm64-tegra-Add-BPMP-thermal-sensor-to-Tegra186/20170726-055759
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
> config: arm64-allnoconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64
>
> Note: the linux-review/Mikko-Perttunen/arm64-tegra-Add-BPMP-thermal-sensor-to-Tegra186/20170726-055759 HEAD 2aebe2225f7f5f03abf6098e07387fa011ec16a8 builds fine.
>       It only hurts bisectibility.
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi:1:0,
>                     from arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts:5:
>>> arch/arm64/boot/dts/nvidia/tegra186.dtsi:7:55: fatal error: dt-bindings/thermal/tegra186-bpmp-thermal.h: No such file or directory
>     #include <dt-bindings/thermal/tegra186-bpmp-thermal.h>
>                                                           ^
>    compilation terminated.
>
> vim +7 arch/arm64/boot/dts/nvidia/tegra186.dtsi
>
>    > 7	#include <dt-bindings/thermal/tegra186-bpmp-thermal.h>
>      8	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
