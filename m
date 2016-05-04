From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / OPP: Remove useless check
Date: Wed, 4 May 2016 11:21:27 -0700
Message-ID: <20160504182127.GR3492@codeaurora.org>
References: <080908c24c189b44442b2fee7be83e760a6dac49.1462367990.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51108 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbcEDSV3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2016 14:21:29 -0400
Content-Disposition: inline
In-Reply-To: <080908c24c189b44442b2fee7be83e760a6dac49.1462367990.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, linux-kernel@vger.kernel.org

On 05/04, Viresh Kumar wrote:
> Regulators are optional for devices using OPPs and the OPP core
> shouldn't be printing any errors for such missing regulators.
> 
> It was fine before the commit 0c717d0f9cb4, but that failed to update
> this part of the code to remove an 'always true' check and an extra
> unwanted print message.
> 
> Fix that now.
> 
> Fixes: 0c717d0f9cb4 ("PM / OPP: Initialize regulator pointer to an error value")
> Reported-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
