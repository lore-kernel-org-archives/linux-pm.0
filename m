From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/3] PM / OPP: Add "opp-supported-hw" binding
Date: Fri, 30 Oct 2015 14:49:07 -0700
Message-ID: <20151030214907.GJ19782@codeaurora.org>
References: <cover.1446167359.git.viresh.kumar@linaro.org>
 <2d52388bd7d3cc546ac3ab5afeb47bfcb3012213.1446167359.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49489 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030984AbbJ3VtJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2015 17:49:09 -0400
Content-Disposition: inline
In-Reply-To: <2d52388bd7d3cc546ac3ab5afeb47bfcb3012213.1446167359.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, lee.jones@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On 10/30, Viresh Kumar wrote:
> +- opp-supported-hw: User defined array containing a hierarchy of hardware
> +  version numbers, supported by the OPP. For example: a platform with hierarchy
> +  of three levels of versions (A, B and C), this field should be like <X Y Z>,
> +  where X corresponds to Version hierarchy A, Y corresponds to version hierarchy
> +  B and Z corresponds to version hierarchy C.
> +
> +  Each level of hierarchy is represented by a 32 bit value, and so there can be
> +  only 32 different supported version per hierarchy. i.e. 1 bit per version. A
> +  value of 0xFFFFFFFF will enable the OPP for all versions for that hierarchy
> +  level. And a value of 0x00000000 will disable the OPP completely, and so we
> +  never want that to happen.

I suppose if you wanted to have 64 possible combinations of some
attribute you would just extend it to two 32 bit numbers in
sequence? I don't see the limitation here, and hopefully there
isn't a limitation so that we can specify sufficiently large
numbers with more bits if we need to.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
