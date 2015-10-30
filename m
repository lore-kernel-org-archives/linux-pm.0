From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/3] PM / OPP: Add
 {opp-microvolt|opp-microamp|turbo-mode|opp-suspend}-<name> binding
Date: Fri, 30 Oct 2015 14:54:30 -0700
Message-ID: <20151030215430.GK19782@codeaurora.org>
References: <cover.1446167359.git.viresh.kumar@linaro.org>
 <980cdb9820db31e869c91b3dce8e71b89c216706.1446167359.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49738 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759803AbbJ3Vyc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2015 17:54:32 -0400
Content-Disposition: inline
In-Reply-To: <980cdb9820db31e869c91b3dce8e71b89c216706.1446167359.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, lee.jones@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On 10/30, Viresh Kumar wrote:
> Depending on the version of hardware or its properties, which are only
> known at runtime, various properties of the OPP can change. For example,
> an OPP with frequency 1.2 GHz, may have different voltage/current
> requirements based on the version of the hardware it is running on.
> Similarly, it may or may not be a turbo or suspend OPP on those
> circumstances.
> 
> In order to not replicate the same OPP tables for varying values of all
> such fields, this commit introduces the concept of opp-property-<name>.
> The <name> can be chosen by the platform at runtime, and OPPs will be
> initialized depending on that name string. Currently support is extended
> for the following properties:
> - opp-microvolt-<name>
> - opp-microamp-<name>
> - turbo-mode-<name>
> - opp-suspend-<name>
> 
> If the name string isn't provided by the platform, or if it is provided
> but doesn't match the properties present in the OPP node, we will fall
> back to the original properties without the -<name> string, if they are
> available.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
