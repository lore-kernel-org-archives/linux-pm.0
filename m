From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 4/4] PM / OPP: Don't create debugfs "supply-0"
 directory unnecessarily
Date: Tue, 23 May 2017 14:01:58 -0700
Message-ID: <20170523210158.GP20170@codeaurora.org>
References: <cover.1495511998.git.viresh.kumar@linaro.org>
 <0381fc50b84535fcb7964eaa345d2501c5c903b3.1495511998.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52468 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162034AbdEWVCE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 17:02:04 -0400
Content-Disposition: inline
In-Reply-To: <0381fc50b84535fcb7964eaa345d2501c5c903b3.1495511998.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 05/23, Viresh Kumar wrote:
> We create "supply-0" debugfs directory even if the device doesn't do
> voltage scaling. That looks confusing, as if the regulator is found but
> we never managed to get voltage levels for it.
> 
> Avoid creating such a directory unnecessarily.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
