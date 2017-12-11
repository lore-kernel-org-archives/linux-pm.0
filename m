From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 11/12] cpufreq: Add module to register cpufreq on
 Krait CPUs
Date: Mon, 11 Dec 2017 14:09:05 +0530
Message-ID: <20171211083905.GF25177@vireshk-i7>
References: <1512726150-7204-1-git-send-email-sricharan@codeaurora.org>
 <1512726150-7204-12-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45712 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdLKIjH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Dec 2017 03:39:07 -0500
Received: by mail-pg0-f68.google.com with SMTP id m25so10432296pgv.12
        for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2017 00:39:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1512726150-7204-12-git-send-email-sricharan@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08-12-17, 15:12, Sricharan R wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> Register a cpufreq-generic device whenever we detect that a
> "qcom,krait" compatible CPU is present in DT.
> 
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  .../devicetree/bindings/arm/msm/qcom,pvs.txt       |  38 ++++
>  drivers/cpufreq/Kconfig.arm                        |   9 +
>  drivers/cpufreq/Makefile                           |   1 +
>  drivers/cpufreq/qcom-cpufreq.c                     | 204 +++++++++++++++++++++
>  4 files changed, 252 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,pvs.txt
>  create mode 100644 drivers/cpufreq/qcom-cpufreq.c

This must be done differently as we have enhanced OPP core to support such
hardware. Look at: dev_pm_opp_set_prop_name() and the binding around it
(opp-microvolt-<name>). Talk to Stephen, he was part of all those discussions.

-- 
viresh
