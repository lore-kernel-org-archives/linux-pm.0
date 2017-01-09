From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 06/12] PM / OPP: Add 'struct kref' to struct dev_pm_opp
Date: Mon, 9 Jan 2017 15:44:27 -0800
Message-ID: <20170109234427.GY17126@codeaurora.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <1d5f61440dbfb640c330f77c9090e2ac23482ebc.1481106919.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52482 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031934AbdAIXo2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2017 18:44:28 -0500
Content-Disposition: inline
In-Reply-To: <1d5f61440dbfb640c330f77c9090e2ac23482ebc.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/07, Viresh Kumar wrote:
> Add kref to struct dev_pm_opp for easier accounting of the OPPs.
> 
> Note that the OPPs are freed under the opp_table->lock mutex only.

I'm lost. Why add another level of krefs?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
