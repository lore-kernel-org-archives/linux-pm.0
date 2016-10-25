From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 4/8] PM / OPP: Pass struct dev_pm_opp_supply to
 _set_opp_voltage()
Date: Tue, 25 Oct 2016 09:15:54 +0530
Message-ID: <20161025034554.GB9162@vireshk-i7>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
 <5f5f81da4b9773854fba72359cb911d2660e2957.1476952750.git.viresh.kumar@linaro.org>
 <20161024231453.GS26139@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33493 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbcJYDp6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Oct 2016 23:45:58 -0400
Received: by mail-pf0-f172.google.com with SMTP id 128so111015586pfz.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Oct 2016 20:45:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20161024231453.GS26139@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org

On 24-10-16, 16:14, Stephen Boyd wrote:
> On 10/20, Viresh Kumar wrote:
> > Pass the entire supply structure instead of all of its fields.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> 
> This patch should be combined with the previous one.

I think it is a fair to do this separately as this is a completely different
logical change.

> I'm still
> not sure if it even makes sense to do this though.

:)

> Do we really
> have to make duplicate "OPP snapshot" structures just because of
> how OPPs use RCU?

I agree. With RCU, yes this change is probably required. But I am not sure if
RCU fits that well to OPP core anymore. A rw-lock may be much easier to help.

-- 
viresh
