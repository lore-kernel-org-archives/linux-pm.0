From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: qcom: Make oxili GDSC parent of oxili_cx GDSC
Date: Mon, 5 Oct 2015 11:13:51 -0700
Message-ID: <20151005181351.GD12338@codeaurora.org>
References: <1443035362-10914-1-git-send-email-sboyd@codeaurora.org>
 <560CED90.9050201@codeaurora.org>
 <20151001175227.GE19319@codeaurora.org>
 <20151001190639.GI19319@codeaurora.org>
 <56120582.1050707@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56120582.1050707@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Mike Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/05, Rajendra Nayak wrote:
> []...
> 
> >>> It would also be nicer if this parent/child relationship can
> >>> somehow be represented in data (struct gdsc) that gets passed to
> >>> the gdsc driver which then sets it up, instead of individual
> >>> clock drivers doing it.
> >>
> >> Agreed. I'd rather that we do nothing besides register domains
> >> and then let the core code handle hooking up domains and
> >> subdomains.
> > 
> > A little closer inspection makes me want to skip this. PM domains
> > can have multiple "master" domains, and pm_genpd_init() is the
> > only API that would be able to do the linking. That API is mostly
> > about initializing things to default values, so it doesn't seem
> > like a good fit. I'll send a v2 with the remove part and the
> > exports.
> 
> What I was suggesting is that the qcom gdsc driver handle this
> instead of the qcom clock drivers.
> Something like..

Ah ok. This patch will still need the gdscs to be in a certain
order though so that we don't add a subdomain on an uninitialized
domain. So I guess some list of pointer pairs to call the
function on could be done in the qcom_cc_desc structure if we
need to do this more than a couple times.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
