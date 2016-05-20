From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: Re: [PATCH 0/5] Qualcomm Suspend to Idle Support
Date: Fri, 20 May 2016 11:39:33 +0530
Message-ID: <CANYu_0u7Q-iTDB17mmfByPULXgzqjnSQ1w_7qUg-ms9OBkdmGw@mail.gmail.com>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34602 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020AbcETGJe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 02:09:34 -0400
Received: by mail-yw0-f177.google.com with SMTP id j74so100324776ywg.1
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2016 23:09:34 -0700 (PDT)
In-Reply-To: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stanimir Varbanov <stanimir.varbanov@linaro.org>

On 19 May 2016 at 10:30, Andy Gross <andy.gross@linaro.org> wrote:
> This set of patches adds suspend to idle support for the Qualcomm APQ8084
> and MSM8916 platforms.  The patches add a minimal set of suspend ops and
> init functions to properly configure the enter_freeze function.
>
> This patch set is based on the work done in the following:
> [RFC v3 00/12] PM: SoC idle support using PM domains
> http://comments.gmane.org/gmane.linux.ports.arm.msm/17966
>
> The relevant prerequisites are the PSCI enablement DT patches.  PSCI based
> firmware is also required for the MSM8916 to work properly.
>
> Andy Gross (5):
>   soc: qcom: Add suspend to idle support
>   arm: defconfig: Add Qualcomm Suspend options
>   arm64: dts: msm8916: Add spc compat tag

Tested this series on DB410C. So for these three patches:

Tested-by: Pramod Gurav <pramod.gurav@linaro.org>

>   ARM: dts: qcom: Remove size elements from pmic reg
>   ARM: dts: qcom: pma8084: Add pwrkey entry
>
>  arch/arm/boot/dts/qcom-pma8084.dtsi   | 20 ++++++---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi |  2 +-
>  arch/arm64/configs/defconfig          |  2 +
>  drivers/soc/qcom/Makefile             |  1 +
>  drivers/soc/qcom/suspend.c            | 77 +++++++++++++++++++++++++++++++++++
>  5 files changed, 95 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/soc/qcom/suspend.c
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
