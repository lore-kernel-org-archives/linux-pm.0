From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 02/12] PM / OPP: Add 'struct kref' to OPP table
Date: Fri, 13 Jan 2017 00:54:30 -0800
Message-ID: <20170113085430.GT17126@codeaurora.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <3f23949c92492ea74a7a55cd04bcd41a37592ed5.1481106919.git.viresh.kumar@linaro.org>
 <20170109233627.GU17126@codeaurora.org>
 <20170110042312.GB6332@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45420 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdAMIyc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2017 03:54:32 -0500
Content-Disposition: inline
In-Reply-To: <20170110042312.GB6332@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 01/10, Viresh Kumar wrote:
> On 09-01-17, 15:36, Stephen Boyd wrote:
> 
> > It would be better to have _find_opp_table()
> > return the pointer with the reference already taken so that we
> > don't have to update callers with reference grabbing calls.
> > Typically if a function returns a reference counted pointer the
> > reference counting has already been done.
> 
> Absolutely, but that happens with later patches in the series. I couldn't have
> done it now, as something or the other would have broken.
> 

Ok, if things get better later in the series then you can have my

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
