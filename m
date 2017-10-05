From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Add missing of_node_put(np)
Date: Thu, 5 Oct 2017 10:13:50 +0530
Message-ID: <20171005044350.GA18345@vireshk-i7>
References: <3a82b2d3311e16f0f638de18bf0ee803540014a3.1507096875.git.viresh.kumar@linaro.org>
 <a3dd282e-220d-5a10-7a0e-10c1acaee737@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a3dd282e-220d-5a10-7a0e-10c1acaee737@codeaurora.org>
Sender: stable-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, Tobias Jordan <Tobias.Jordan@elektrobit.com>, "4 . 3+" <stable@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04-10-17, 09:42, Stephen Boyd wrote:
> On 10/03/2017 11:05 PM, Viresh Kumar wrote:
> > From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
> >
> > The for_each_available_child_of_node() loop in _of_add_opp_table_v2()
> > doesn't drop the reference to "np" on errors. Fix that.
> >
> > Fixes: 274659029c9d ("PM / OPP: Add support to parse "operating-points-v2" bindings")
> > Cc: 4.3+ <stable@vger.kernel.org> # 4.3+
> > Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
> > [ VK: Improved commit log. ]
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> Looks like that opp_table->np = opp_np assignment in this function needs
> to do an of_node_get() because the caller of this function puts the
> pointer unconditionally.

We only use that pointer (opp_table->np) in _managed_opp() to compare the
address. Perhaps we don't need to do a of_node_get() there.

-- 
viresh
