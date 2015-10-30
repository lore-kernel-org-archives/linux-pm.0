From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 3/3] PM / OPP: Remove 'operating-points-names' binding
Date: Fri, 30 Oct 2015 14:54:35 -0700
Message-ID: <20151030215435.GL19782@codeaurora.org>
References: <cover.1446167359.git.viresh.kumar@linaro.org>
 <0290b40c1cb5062335b74ad7e845a1f1d3111f13.1446167359.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49759 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759803AbbJ3Vyh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2015 17:54:37 -0400
Content-Disposition: inline
In-Reply-To: <0290b40c1cb5062335b74ad7e845a1f1d3111f13.1446167359.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, lee.jones@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On 10/30, Viresh Kumar wrote:
> These aren't used until now by any DT files and wouldn't be used now as
> we have a better scheme in place now, i.e. opp-property-<name>
> properties.
> 
> Remove the (useless) binding without breaking ABI.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
