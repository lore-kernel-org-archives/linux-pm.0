From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 03/10] PM / OPP: dev_pm_opp_set_sharing_cpus() doesn't
 depend on CONFIG_OF
Date: Fri, 22 Apr 2016 15:16:51 -0700
Message-ID: <20160422221651.GO13149@codeaurora.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
 <f13962883e1e55adb8a7391b4fb6538177168adc.1461228504.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55094 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbcDVWQx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 18:16:53 -0400
Content-Disposition: inline
In-Reply-To: <f13962883e1e55adb8a7391b4fb6538177168adc.1461228504.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, andrew@lunn.ch, gregory.clement@free-electrons.com, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org

On 04/21, Viresh Kumar wrote:
> dev_pm_opp_set_sharing_cpus() doesn't do any DT specific stuff and its
> declarations are added within the CONFIG_OF ifdef by mistake. Take them
> out of that.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
X-Patchwork-State: Not Applicable
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
