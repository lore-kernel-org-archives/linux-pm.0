From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 01/10] PM / OPP: Propagate the error returned by
 _find_opp_table()
Date: Fri, 22 Apr 2016 15:14:43 -0700
Message-ID: <20160422221443.GM13149@codeaurora.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
 <291931fc9dbd6b4fa44f88a2ffde03e1ba51249d.1461228504.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54889 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbcDVWOq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 18:14:46 -0400
Content-Disposition: inline
In-Reply-To: <291931fc9dbd6b4fa44f88a2ffde03e1ba51249d.1461228504.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, andrew@lunn.ch, gregory.clement@free-electrons.com, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org

On 04/21, Viresh Kumar wrote:
> Don't send -EINVAL and propagate what's received from _find_opp_table().
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
X-Patchwork-State: Not Applicable
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
