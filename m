From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V4 2/3] OPP: Allow multiple OPP tables to be passed via DT
Date: Tue, 19 May 2015 17:52:07 -0700
Message-ID: <20150520005207.GQ31753@codeaurora.org>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d734a94af2263285fe8cef9f177212f15f218944.1430394884.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37596 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbbETAwK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 20:52:10 -0400
Content-Disposition: inline
In-Reply-To: <d734a94af2263285fe8cef9f177212f15f218944.1430394884.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mike.turquette@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 04/30, Viresh Kumar wrote:
> On some platforms (Like Qualcomm's SoCs), it is not decided until
> runtime on what OPPs to use. The OPP tables can be fixed at compile
> time, but which table to use is found out only after reading some efuses
> (sort of an eeprom) and knowing characteristics of the SoC.
> 
> To support such platform we need to pass multiple OPP tables per device
> and hardware should be able to choose one and only one table out of
> those.
> 
> Update OPP-v2 bindings to support that.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
