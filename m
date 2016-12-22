From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 07/10] PM / OPP: Don't allocate OPP table from
 _opp_allocate()
Date: Wed, 21 Dec 2016 16:43:50 -0800
Message-ID: <20161222004350.GC8288@codeaurora.org>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
 <ab1dbd94f4638ac04a9dd4b526ddaaf136154dd1.1481015522.git.viresh.kumar@linaro.org>
 <20161207010221.GE4388@codeaurora.org>
 <20161207041744.GF31255@vireshk-i7>
 <20161207220525.GB5423@codeaurora.org>
 <20161208034558.GB24152@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48350 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761081AbcLVAnw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Dec 2016 19:43:52 -0500
Content-Disposition: inline
In-Reply-To: <20161208034558.GB24152@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/08, Viresh Kumar wrote:
> Subject: [PATCH] PM / OPP: Don't allocate OPP table from _opp_allocate()
> 
> There is no point in trying to find/allocate the table for every OPP
> that is added for a device. It would be far more efficient to allocate
> the table only once and pass its pointer to the routines that add the
> OPP entry.
> 
> Locking is removed from _opp_add_static_v2() and _opp_add_v1() now as
> the callers call them with that lock already held.
> 
> Call to _remove_opp_table() routine is also removed from _opp_free()
> now, as opp_table isn't allocated from within _opp_allocate(). This is
> handled by the routines which created the OPP table in the first place.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
