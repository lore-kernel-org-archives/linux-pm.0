From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v7 01/13] clk: qcom: Add support for GDSCs
Date: Fri, 7 Aug 2015 16:52:31 -0700
Message-ID: <20150807235230.GE16477@codeaurora.org>
References: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
 <1438076046-4706-2-git-send-email-rnayak@codeaurora.org>
 <20150803192427.GA7096@codeaurora.org>
 <55C19FA4.4070402@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C19FA4.4070402@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, mturquette@baylibre.com, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, georgi.djakov@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 08/05, Rajendra Nayak wrote:
> 
> 
> On 08/04/2015 12:54 AM, Stephen Boyd wrote:
> >On 07/28, Rajendra Nayak wrote:
> >>+
> >>+#define PWR_ON_MASK		BIT(31)
> >>+#define EN_REST_WAIT_MASK	GENMASK(23, 20)
> >>+#define EN_FEW_WAIT_MASK	GENMASK(19, 16)
> >>+#define CLK_DIS_WAIT_MASK	GENMASK(15, 12)
> >
> >This trips up some static checker...
> >
> >drivers/clk/qcom/gdsc.c:234:53: warning: cast truncates bits from
> >constant value (fffffffffff006 becomes fffff006)
> >
> >So I think we can use GENMASK_ULL here instead.
> 
> Sure. btw, what static checker is this? I did not see it with sparse.

Pretty sure this was with sparse. Which now has me concerned that
my sparse is old!

$ sparse --version
v0.5.0-47-g0f71312959ed

But I updated to

$ sparse --version
v0.5.0-51-ga53cea28f0db

And I still see it.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
