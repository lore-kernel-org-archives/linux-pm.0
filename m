From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V8 1/6] PM / Domains: Add support to select
 performance-state of domains
Date: Mon, 31 Jul 2017 09:44:24 +0530
Message-ID: <20170731041424.GA5804@vireshk-i7>
References: <cover.1498026827.git.viresh.kumar@linaro.org>
 <52daf22d2c9d92b0e61c8c5c5a88516d7a08a31a.1498026827.git.viresh.kumar@linaro.org>
 <CAPDyKFqaFvET9yM_6wr7b1Zw=hePQrE-Ak-7YPCR9izooh4LBA@mail.gmail.com>
 <20170719123751.GF352@vireshk-i7>
 <CAPDyKFr0ZMeS=57p48W9f_j3U0T41msxOqQHBXB_soA8-weM+w@mail.gmail.com>
 <20170728110030.GG352@vireshk-i7>
 <CAPDyKFrt8_dWZSFYh3ERfDSxBGjfEHFEYbeMnnT7tfNKnBp6dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrt8_dWZSFYh3ERfDSxBGjfEHFEYbeMnnT7tfNKnBp6dw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 29-07-17, 10:24, Ulf Hansson wrote:
> Let's invent a new genpd flag, GENPD_FLAG_PERF_STATE!
> 
> The creator of the genpd then needs to set this before calling
> pm_genpd_init(). Similar as we are dealing with GENPD_FLAG_PM_CLK.
> 
> The requirement for GENPD_FLAG_PERF_STATES, is to have the
> ->get_performance_state() assigned. This shall be verified during
> pm_genpd_init().
> 
> The pm_genpd_has_performance_state() then only need to return true, in
> cases the device's genpd has GENPD_FLAG_PERF_STATE set - else false.
> 
> Regarding ->set_performance_state(), let's just make it optional - and
> when trying to set a new performance state, just walk the genpd
> hierarchy, from bottom to up, then invoke the callback when it's
> assigned.

Sounds good.

-- 
viresh
