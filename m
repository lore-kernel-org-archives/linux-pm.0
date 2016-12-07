From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V7 06/10] PM / OPP: Add infrastructure to manage multiple
 regulators
Date: Tue, 6 Dec 2016 16:39:15 -0800
Message-ID: <20161207003915.GD4388@codeaurora.org>
References: <cover.1480564564.git.viresh.kumar@linaro.org>
 <804d4f89c517f7a0b0bb98ef513c329fd5f76d39.1480564564.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49694 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbcLGAjR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 19:39:17 -0500
Content-Disposition: inline
In-Reply-To: <804d4f89c517f7a0b0bb98ef513c329fd5f76d39.1480564564.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org, devicetree@vger.kernel.org

On 12/01, Viresh Kumar wrote:
> This patch adds infrastructure to manage multiple regulators and updates
> the only user (cpufreq-dt) of dev_pm_opp_set{put}_regulator().
> 
> This is preparatory work for adding full support for devices with
> multiple regulators.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Tested-by: Dave Gerlach <d-gerlach@ti.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
