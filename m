From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v7 01/13] clk: qcom: Add support for GDSCs
Date: Mon, 3 Aug 2015 12:24:27 -0700
Message-ID: <20150803192427.GA7096@codeaurora.org>
References: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
 <1438076046-4706-2-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438076046-4706-2-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 07/28, Rajendra Nayak wrote:
> +
> +#define PWR_ON_MASK		BIT(31)
> +#define EN_REST_WAIT_MASK	GENMASK(23, 20)
> +#define EN_FEW_WAIT_MASK	GENMASK(19, 16)
> +#define CLK_DIS_WAIT_MASK	GENMASK(15, 12)

This trips up some static checker...

drivers/clk/qcom/gdsc.c:234:53: warning: cast truncates bits from
constant value (fffffffffff006 becomes fffff006)

So I think we can use GENMASK_ULL here instead.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
