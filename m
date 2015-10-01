From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: qcom: Make oxili GDSC parent of oxili_cx GDSC
Date: Thu, 1 Oct 2015 10:52:27 -0700
Message-ID: <20151001175227.GE19319@codeaurora.org>
References: <1443035362-10914-1-git-send-email-sboyd@codeaurora.org>
 <560CED90.9050201@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <560CED90.9050201@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Mike Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/01, Rajendra Nayak wrote:
> On 09/24/2015 12:39 AM, Stephen Boyd wrote:
> >The oxili_cx GDSC is inside the power domain of the oxili GDSC.
> >Add the dependency so that the CX domain can properly power up.
> >
> >Reported-by: Rob Clark <robdclark@gmail.com>
> >Cc: Rajendra Nayak <rnayak@codeaurora.org>
> >Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> >---
> >  drivers/clk/qcom/mmcc-msm8974.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
> >index fe8320dc41db..3613db0a73e3 100644
> >--- a/drivers/clk/qcom/mmcc-msm8974.c
> >+++ b/drivers/clk/qcom/mmcc-msm8974.c
> >@@ -2615,6 +2615,7 @@ MODULE_DEVICE_TABLE(of, mmcc_msm8974_match_table);
> >  static int mmcc_msm8974_probe(struct platform_device *pdev)
> >  {
> >  	struct regmap *regmap;
> >+	int ret;
> >
> >  	regmap = qcom_cc_map(pdev, &mmcc_msm8974_desc);
> >  	if (IS_ERR(regmap))
> >@@ -2623,7 +2624,14 @@ static int mmcc_msm8974_probe(struct platform_device *pdev)
> >  	clk_pll_configure_sr_hpm_lp(&mmpll1, regmap, &mmpll1_config, true);
> >  	clk_pll_configure_sr_hpm_lp(&mmpll3, regmap, &mmpll3_config, false);
> >
> >-	return qcom_cc_really_probe(pdev, &mmcc_msm8974_desc, regmap);
> >+	ret = qcom_cc_really_probe(pdev, &mmcc_msm8974_desc, regmap);
> >+	if (ret)
> >+		return ret;
> >+
> >+	ret = pm_genpd_add_subdomain(&oxili_gdsc.pd, &oxilicx_gdsc.pd);
> 
> We'll need pm_genpd_add_subdomain() to be EXPORT_SYMBOL_GPL'ed so
> clk-qcom can be built as a module.

Good catch! Do we need to call pm_genpd_remove_subdomain() too?

> 
> It would also be nicer if this parent/child relationship can
> somehow be represented in data (struct gdsc) that gets passed to
> the gdsc driver which then sets it up, instead of individual
> clock drivers doing it.

Agreed. I'd rather that we do nothing besides register domains
and then let the core code handle hooking up domains and
subdomains.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
