From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V6 08/10] PM / OPP: Allow platform specific custom
 set_opp() callbacks
Date: Wed, 30 Nov 2016 14:04:19 -0800
Message-ID: <20161130220419.GL6095@codeaurora.org>
References: <cover.1480481312.git.viresh.kumar@linaro.org>
 <152e4a2c876449f3e47c206f5120cafdfd48b976.1480481312.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51472 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759407AbcK3WEU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2016 17:04:20 -0500
Content-Disposition: inline
In-Reply-To: <152e4a2c876449f3e47c206f5120cafdfd48b976.1480481312.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org, devicetree@vger.kernel.org

On 11/30, Viresh Kumar wrote:
> The generic set_opp() handler isn't sufficient for platforms with
> complex DVFS.  For example, some TI platforms have multiple regulators
> for a CPU device. The order in which various supplies need to be
> programmed is only known to the platform code and its best to leave it
> to it.
> 
> This patch implements APIs to register platform specific set_opp()
> callback.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Tested-by: Dave Gerlach <d-gerlach@ti.com>
> 
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

So this one has the same set/put problem the other APIs has?
Presumably we're going to need to fix and change the API that is
introduced here. Wouldn't it be better to do that first though?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
