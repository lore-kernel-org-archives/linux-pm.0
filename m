From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 01/17] PM / OPP: get/put regulators from OPP core
Date: Tue, 12 Jan 2016 11:32:13 -0800
Message-ID: <20160112193213.GY22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <8731ff871e0eedfb08b9428af8da21b25d1ad283.1450777582.git.viresh.kumar@linaro.org>
 <20160111232118.GG22188@codeaurora.org>
 <20160112030543.GG1084@ubuntu>
 <20160112052346.GL1084@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41637 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbcALTcQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 14:32:16 -0500
Content-Disposition: inline
In-Reply-To: <20160112052346.GL1084@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 01/12, Viresh Kumar wrote:
> On 12-01-16, 08:35, Viresh Kumar wrote:
> > On 11-01-16, 15:21, Stephen Boyd wrote:
> > > Is there a reason we capitalize regulator?
> > 
> 
> Something went wrong, I have updated the code correctly. Let me paste
> it again..
> 
> -------------------------8<-------------------------
> 
> Subject: [PATCH] PM / OPP: get/put regulators from OPP core
> 
> The allows the OPP core to request/free the regulator resource, attached
> to a device OPP. The regulator device is fetched using device node and
> name of the device.
> 
> For example, a cpu0 device node needs to look like this:
> 		cpu0: cpu@900 {
> 			device_type = "cpu";
> 			compatible = "arm,cortex-a9";
> 			reg = <0x900>;
> 			cpu0-supply = <&varm>;
> 			...
> 		};
> 
> This will work for both OPP-v1 and v2 bindings.
> 
> This is a preliminary step in moving the OPP switching logic into the
> OPP core.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
