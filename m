From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH] clk: qcom: Drop calls to qcom_cc_remove()
Date: Thu, 08 Oct 2015 15:34:07 +0530
Message-ID: <56163F97.1060604@codeaurora.org>
References: <1444288678-24594-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1444288678-24594-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com
List-Id: linux-pm@vger.kernel.org

On 10/08/2015 12:47 PM, Stephen Boyd wrote:
> Now that qcom_cc_remove() is a nop, drop calls to
> qcom_cc_remove() and any empty driver remove functions.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> And here's the driver part. I left 8960_remove in place to make your patch
> easier to apply. Time to sleep.

I was trying to test this out, but looks like none of our clock drivers
support a clean remove and reprobe (with or without this patch)

The problem seems to be the fixed rate clocks that get registered at probe,
never unregistered, causing the subsequent probe to fail.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
