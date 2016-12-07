From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 02/10] PM / OPP: Remove useless TODO
Date: Tue, 6 Dec 2016 17:10:08 -0800
Message-ID: <20161207011008.GG4388@codeaurora.org>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
 <1256ea9415bf9e6a4cf71b5b22e544e5b542a056.1481015522.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33674 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbcLGBSq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 20:18:46 -0500
Content-Disposition: inline
In-Reply-To: <1256ea9415bf9e6a4cf71b5b22e544e5b542a056.1481015522.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/06, Viresh Kumar wrote:
> This TODO doesn't make sense anymore as we have all the information in a
> single OPP table. Remove it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Was this for multiple phandles style of binding that we never
merged?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
