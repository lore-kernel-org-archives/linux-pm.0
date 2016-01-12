From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 10/17] cpufreq: dt: Rename 'need_update' to 'opp_v1'
Date: Mon, 11 Jan 2016 17:41:03 -0800
Message-ID: <20160112014103.GO22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <0107c166a02315b3e04dd3a9e1af5c59f469ce3c.1450777582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42169 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760002AbcALBlF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 20:41:05 -0500
Content-Disposition: inline
In-Reply-To: <0107c166a02315b3e04dd3a9e1af5c59f469ce3c.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12/22, Viresh Kumar wrote:
> That's the real purpose of this field, i.e. to take special care of old
> OPP V1 bindings. Lets name it accordingly, so that it can be used
> elsewhere.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Ok...

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
