From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v6 04/13] clk: qcom: gdsc: Manage clocks with !CONFIG_PM
Date: Wed, 29 Jul 2015 17:13:57 -0700
Message-ID: <20150730001357.GF3159@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org>
 <1437549069-29655-5-git-send-email-rnayak@codeaurora.org>
 <55B03D65.8040207@codeaurora.org>
 <55B0A764.6010708@codeaurora.org>
 <55B826B0.2090705@codeaurora.org>
 <55B85870.7060900@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47818 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbbG3AOA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2015 20:14:00 -0400
Content-Disposition: inline
In-Reply-To: <55B85870.7060900@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org

On 07/29, Rajendra Nayak wrote:
> 
> On 07/29/2015 06:34 AM, Stephen Boyd wrote:
> >
> >Sorry, I read the thread and I tried to understand what was going on but
> >I'm still lost. Can you clarify further in the commit text somehow?
> 
> So I can add this in the commit text, if it seems fine
> 
> "The use of pm_clk_add_notifier() isn't appropriate here since we need
> to only manage clocks with valid power domain associations done via
> DT, instead of what pm_clk_add_notifier() does, which is manage clocks
> for all on SoC/off SoC devices associating all of them to a dummy
> power domain instead"
> 

Yes that's good, thanks. But I still wonder why the code isn't
generic so that we don't have lots of drivers duplicating the
same logic. I guess we can consolidate another day.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
