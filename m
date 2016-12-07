From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 10/10] PM / OPP: Split out part of _add_opp_table() and
 _remove_opp_table()
Date: Tue, 6 Dec 2016 17:24:01 -0800
Message-ID: <20161207012401.GN4388@codeaurora.org>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
 <e46f477bcf5cfdb0a0d7642adb95bd15e89a974a.1481015522.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35274 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752104AbcLGBYH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 20:24:07 -0500
Content-Disposition: inline
In-Reply-To: <e46f477bcf5cfdb0a0d7642adb95bd15e89a974a.1481015522.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/06, Viresh Kumar wrote:
> Split out parts of _add_opp_table() and _remove_opp_table() into
> separate routines. This will be useful going forward (while doing
> further cleanups).
> 
> Should result in no functional changes.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

But perhaps this should wait until we have patches that actually
use them.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
