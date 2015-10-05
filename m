From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH] clk: qcom: Make oxili GDSC parent of oxili_cx GDSC
Date: Mon, 05 Oct 2015 10:37:14 +0530
Message-ID: <56120582.1050707@codeaurora.org>
References: <1443035362-10914-1-git-send-email-sboyd@codeaurora.org> <560CED90.9050201@codeaurora.org> <20151001175227.GE19319@codeaurora.org> <20151001190639.GI19319@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20151001190639.GI19319@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mike Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

[]...

>>> It would also be nicer if this parent/child relationship can
>>> somehow be represented in data (struct gdsc) that gets passed to
>>> the gdsc driver which then sets it up, instead of individual
>>> clock drivers doing it.
>>
>> Agreed. I'd rather that we do nothing besides register domains
>> and then let the core code handle hooking up domains and
>> subdomains.
> 
> A little closer inspection makes me want to skip this. PM domains
> can have multiple "master" domains, and pm_genpd_init() is the
> only API that would be able to do the linking. That API is mostly
> about initializing things to default values, so it doesn't seem
> like a good fit. I'll send a v2 with the remove part and the
> exports.

What I was suggesting is that the qcom gdsc driver handle this
instead of the qcom clock drivers.
Something like..

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index da9fad8..00edb2d 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -226,6 +226,8 @@ int gdsc_register(struct device *dev, struct gdsc **scs, size_t num,
 		if (ret)
 			return ret;
 		data->domains[i] = &scs[i]->pd;
+		if (scs[i]->parent)
+			pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
 	}
 
 	return of_genpd_add_provider_onecell(dev->of_node, data);
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 5ded268..bc5791f 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -49,6 +49,7 @@ struct gdsc {
 	struct reset_controller_dev	*rcdev;
 	unsigned int			*resets;
 	unsigned int			reset_count;
+	struct generic_pm_domain	*parent;
 };
 
 #ifdef CONFIG_QCOM_GDSC
diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
index fe8320d..51ad8de 100644
--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -2400,6 +2400,7 @@ static struct gdsc oxilicx_gdsc = {
 	.pd = {
 		.name = "oxilicx",
 	},
+	.parent = &oxili_gdsc.pd,
 	.pwrsts = PWRSTS_OFF_ON,
 };

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
