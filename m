From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: qcom: Drop calls to qcom_cc_remove()
Date: Thu, 8 Oct 2015 11:09:36 -0700
Message-ID: <20151008180936.GG26883@codeaurora.org>
References: <1444288678-24594-1-git-send-email-sboyd@codeaurora.org>
 <56163F97.1060604@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50155 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755052AbbJHSJj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2015 14:09:39 -0400
Content-Disposition: inline
In-Reply-To: <56163F97.1060604@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com

On 10/08, Rajendra Nayak wrote:
> On 10/08/2015 12:47 PM, Stephen Boyd wrote:
> > Now that qcom_cc_remove() is a nop, drop calls to
> > qcom_cc_remove() and any empty driver remove functions.
> > 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> > 
> > And here's the driver part. I left 8960_remove in place to make your patch
> > easier to apply. Time to sleep.
> 
> I was trying to test this out, but looks like none of our clock drivers
> support a clean remove and reprobe (with or without this patch)
> 
> The problem seems to be the fixed rate clocks that get registered at probe,
> never unregistered, causing the subsequent probe to fail.

Yeah the gcc drivers are not so good there. We should probably fix those too.

The mmcc drivers support a clean remove and reprobe though. So I
tested it on msm8960 with these patches and everything looks
good. Removing gcc is sort of annoying because it provides the
clock for the serial console.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
