From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 16/16] cpufreq: dt: No need to allocate resources
 anymore
Date: Mon, 8 Feb 2016 14:58:11 -0800
Message-ID: <20160208225811.GH10791@codeaurora.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
 <6c45d5257ba11485719d3cb3a795ccb6ca1670d5.1453965717.git.viresh.kumar@linaro.org>
 <20160202061228.GE31828@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49910 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755975AbcBHW6M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 17:58:12 -0500
Content-Disposition: inline
In-Reply-To: <20160202061228.GE31828@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, open list <linux-kernel@vger.kernel.org>

On 02/02, Viresh Kumar wrote:
> +	name = find_supply_name(cpu_dev);
> +	if (IS_ERR(name))
> +		return PTR_ERR(name);
> +

Same IS_ERR question as before. Otherwise the patch looks ok.

> +	if (!name)
> +		return 0;
>  
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
