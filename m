From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V4 04/10] PM / OPP: Manage supply's voltage/current in a
 separate structure
Date: Mon, 28 Nov 2016 16:58:21 -0800
Message-ID: <20161129005821.GS6095@codeaurora.org>
References: <cover.1479986491.git.viresh.kumar@linaro.org>
 <6078de802f62a50e4da80022949745fc9f0bdce8.1479986491.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46146 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754302AbcK2A6X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 19:58:23 -0500
Content-Disposition: inline
In-Reply-To: <6078de802f62a50e4da80022949745fc9f0bdce8.1479986491.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org, devicetree@vger.kernel.org

On 11/24, Viresh Kumar wrote:
> This is a preparatory step for multiple regulator per device support.
> Move the voltage/current variables to a new structure.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Tested-by: Dave Gerlach <d-gerlach@ti.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
