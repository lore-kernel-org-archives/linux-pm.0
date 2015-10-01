From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: qcom: Make oxili GDSC parent of oxili_cx GDSC
Date: Thu, 1 Oct 2015 12:06:39 -0700
Message-ID: <20151001190639.GI19319@codeaurora.org>
References: <1443035362-10914-1-git-send-email-sboyd@codeaurora.org>
 <560CED90.9050201@codeaurora.org>
 <20151001175227.GE19319@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151001175227.GE19319@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Mike Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/01, Stephen Boyd wrote:
> On 10/01, Rajendra Nayak wrote:
> > On 09/24/2015 12:39 AM, Stephen Boyd wrote:
> > >+
> > >+	ret = pm_genpd_add_subdomain(&oxili_gdsc.pd, &oxilicx_gdsc.pd);
> > 
> > We'll need pm_genpd_add_subdomain() to be EXPORT_SYMBOL_GPL'ed so
> > clk-qcom can be built as a module.
> 
> Good catch! Do we need to call pm_genpd_remove_subdomain() too?

Looks like yes.

> 
> > 
> > It would also be nicer if this parent/child relationship can
> > somehow be represented in data (struct gdsc) that gets passed to
> > the gdsc driver which then sets it up, instead of individual
> > clock drivers doing it.
> 
> Agreed. I'd rather that we do nothing besides register domains
> and then let the core code handle hooking up domains and
> subdomains.

A little closer inspection makes me want to skip this. PM domains
can have multiple "master" domains, and pm_genpd_init() is the
only API that would be able to do the linking. That API is mostly
about initializing things to default values, so it doesn't seem
like a good fit. I'll send a v2 with the remove part and the
exports.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
