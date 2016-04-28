From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v5 00/11] qcom: Add support for TSENS driver
Date: Wed, 27 Apr 2016 17:03:11 -0700
Message-ID: <20160428000309.GD2590@localhost.localdomain>
References: <1460626319-14516-1-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35838 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbcD1ADP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 20:03:15 -0400
Content-Disposition: inline
In-Reply-To: <1460626319-14516-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, sboyd@codeaurora.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com

On Thu, Apr 14, 2016 at 03:01:48PM +0530, Rajendra Nayak wrote:
> Current set of patches apply on 4.6-rc3. nvmem apis are currently
> broken and hence need to pull in the fixes for it as proposed here [1]

>From a glance overview of your series, looks good to me, but before I
start triggering my local scripts to check them, I want to know what is
the path for merging this.

If I understand correctly the above statement, merging this right now,
means merging a non-functional driver, right?


> 
> Changes since v4:
> * dropped qcom,tsens-slopes binding, used coefficients instead
> * dropped qcom,sensor-id binding
> * Added support for msm8996 family
> * Other minor review fixes from v4
> 
> Changes since v3:
> * Dropped 'clk: qcom: create virtual child device for TSENS' which
> is picked up by Stephen
> * Updated GCC bindings with optional TSENS properties
> 
> Changes since v2:
> * Minor review fixes from Stephen/Punit and rebase on 4.3-rc4
> 
> Changes since v1:
> * Created virtual tsens device from gcc driver for 8960,
> with DT having a single node for gcc and tsens
> * Minor fixes with rebasing on 4.3-rc1
> 
> Changes since RFC:
> * Added support for 8916 and 8084
> * Based off the latest nvmem framework patches [1]
> * Minor review fixes for comments mostly from Lina
> 
> This is an attempt to have a single TSENS driver for
> the different versions of the TSENS IP that exist, on
> different qcom msm/apq SoCs'
> Support is added for msm8916, msm8960, msm8974 and msm8996 families.
> 
> A lot of the work is based of original code from Stephen Boyd
> and Siddartha Mohanadoss. I have also picked some of what
> Narendran Rajan did in his attempt to upstream the support
> for 8960 family. I could not keep the original authorship on
> any of the patches because I ended up moving the code around
> quite a bit in an effort to have a single driver for the
> various devices. I would be glad to change the authorship
> for any of the patches if needed.
> 
> [1] https://lkml.org/lkml/2016/4/13/654
> 
> Rajendra Nayak (11):
>   thermal: qcom: tsens: Add a skeletal TSENS drivers
>   thermal: qcom: tsens-8916: Add support for 8916 family of SoCs
>   thermal: qcom: tsens-8974: Add support for 8974 family of SoCs
>   thermal: core: export apis to get slope and offset
>   thermal: qcom: tsens-8960: Add support for 8960 family of SoCs
>   thermal: qcom: tsens-8996: Add support for 8996 family of SoCs
>   arm: dts: msm8974: Add thermal zones, tsens and qfprom nodes
>   arm: dts: apq8064: Add thermal zones, tsens and qfprom nodes
>   arm: dts: apq8084: Add thermal zones, tsens and qfprom nodes
>   arm64: dts: msm8916: Add thermal zones, tsens and qfprom nodes
>   arm64: dts: msm8996: Add thermal zones, tsens and qfprom nodes
> 
>  .../devicetree/bindings/clock/qcom,gcc.txt         |  18 ++
>  .../devicetree/bindings/thermal/qcom-tsens.txt     |  21 ++
>  arch/arm/boot/dts/qcom-apq8064.dtsi                | 103 ++++++++
>  arch/arm/boot/dts/qcom-apq8084.dtsi                | 103 ++++++++
>  arch/arm/boot/dts/qcom-msm8974.dtsi                | 103 ++++++++
>  arch/arm64/boot/dts/qcom/msm8916.dtsi              |  64 +++++
>  arch/arm64/boot/dts/qcom/msm8996.dtsi              |  92 +++++++
>  drivers/thermal/Kconfig                            |   5 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/qcom/Kconfig                       |  11 +
>  drivers/thermal/qcom/Makefile                      |   2 +
>  drivers/thermal/qcom/tsens-8916.c                  | 113 ++++++++
>  drivers/thermal/qcom/tsens-8960.c                  | 293 +++++++++++++++++++++
>  drivers/thermal/qcom/tsens-8974.c                  | 244 +++++++++++++++++
>  drivers/thermal/qcom/tsens-8996.c                  |  82 ++++++
>  drivers/thermal/qcom/tsens-common.c                | 135 ++++++++++
>  drivers/thermal/qcom/tsens.c                       | 207 +++++++++++++++
>  drivers/thermal/qcom/tsens.h                       |  92 +++++++
>  drivers/thermal/thermal_core.c                     |  16 ++
>  include/linux/thermal.h                            |   8 +
>  20 files changed, 1713 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
>  create mode 100644 drivers/thermal/qcom/Kconfig
>  create mode 100644 drivers/thermal/qcom/Makefile
>  create mode 100644 drivers/thermal/qcom/tsens-8916.c
>  create mode 100644 drivers/thermal/qcom/tsens-8960.c
>  create mode 100644 drivers/thermal/qcom/tsens-8974.c
>  create mode 100644 drivers/thermal/qcom/tsens-8996.c
>  create mode 100644 drivers/thermal/qcom/tsens-common.c
>  create mode 100644 drivers/thermal/qcom/tsens.c
>  create mode 100644 drivers/thermal/qcom/tsens.h
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
