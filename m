From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/3] PM / OPP: Add "opp-supported-hw" binding
Date: Fri, 30 Oct 2015 15:18:26 -0700
Message-ID: <20151030221826.GM19782@codeaurora.org>
References: <cover.1446167359.git.viresh.kumar@linaro.org>
 <2d52388bd7d3cc546ac3ab5afeb47bfcb3012213.1446167359.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51050 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030387AbbJ3WS2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2015 18:18:28 -0400
Content-Disposition: inline
In-Reply-To: <2d52388bd7d3cc546ac3ab5afeb47bfcb3012213.1446167359.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, lee.jones@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On 10/30, Viresh Kumar wrote:
> +	opp_table {
> +		compatible = "operating-points-v2";
> +		status = "okay";
> +		opp-shared;
> +
> +		opp00 {

A side-note. I wonder if it would be better style to have the
node name be:

		opp@600000000 {

At least it seems that the assumption is we can store all the
possible combinations of OPP values for a particular frequency in
the same node. Following this style would make dt compilation
fail if two nodes have the same frequency.

Also, this makes it sound like opp-supported-hw is really just
telling us if this is a supported frequency or not for the
particular device we're running on. The current wording makes it
sound like we could have two OPP nodes with the same frequency
but different voltages inside them, which we're trying to
discourage by compressing the tables into less nodes.

I think in Lee's case we're only going to use the cuts parameter
to figure out if the OPP is supported or not. On qcom platforms
we will only use one parameter for this property as well, the
speed bin. The slow/fast and version stuff will be handled by
named opp properties.

> +			/*
> +			 * Supports all substrate and process versions for 0xF
> +			 * cuts, i.e. only first four cuts.
> +			 */
> +			opp-supported-hw = <0xF 0xFFFFFFFF 0xFFFFFFFF>
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <900000 915000 925000>;

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
