From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 05/12] clk: qcom: Add MSM8960/APQ8064's HFPLLs
Date: Tue, 12 Dec 2017 14:36:31 -0600
Message-ID: <20171212203631.kyruwhtpmigkwfat@rob-hp-laptop>
References: <1512726150-7204-1-git-send-email-sricharan@codeaurora.org>
 <1512726150-7204-6-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:41198 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbdLLUgd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Dec 2017 15:36:33 -0500
Content-Disposition: inline
In-Reply-To: <1512726150-7204-6-git-send-email-sricharan@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org

On Fri, Dec 08, 2017 at 03:12:23PM +0530, Sricharan R wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> Describe the HFPLLs present on MSM8960 and APQ8064 devices.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/clk/qcom/gcc-msm8960.c               | 172 +++++++++++++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-msm8960.h |   2 +

For the binding,

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 174 insertions(+)
