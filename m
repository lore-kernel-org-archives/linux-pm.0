From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V10 0/3] PM / Domains: Performance state support
Date: Wed, 4 Oct 2017 12:15:21 +0530
Message-ID: <20171004064521.GA3002@vireshk-i7>
References: <cover.1505859768.git.viresh.kumar@linaro.org>
 <CAPDyKFoG7MovwoSfagw-CTo7WBGcQGjHgNtornNKGXNJ_AxLag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFoG7MovwoSfagw-CTo7WBGcQGjHgNtornNKGXNJ_AxLag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 03-10-17, 09:52, Ulf Hansson wrote:
> We sorted out things at LPC!
> 
> However, the last weeks discussions at Linaro connect, raised a couple
> of more concerns with the current approach. Let me summarize them
> here.
> 
> 1)
> The ->dev_get_performance_state(), which currently translates
> frequency for a device to a performance index of its PM domain, is too
> closely integrated with genpd. Instead this kind of translation rather
> belongs as a part of the OPP core, because of not limiting this only
> to translate frequencies, but perhaps *later* also voltages.
> 
> 2)
> Propagating an aggregated increased requested performance state index
> for a genpd, upwards in the hierarchy of its master domains, is
> currently not needed by any existing SoCs.
> 
> 3) If some day the need for 2) becomes required, we must not assume a
> 1 to 1 mapping of the supported performance state index for a
> master/subdomain. For example a domain may support 1-5, while its
> master may support 1-8.
> 
> Taking this into consideration, this series need yet another round of
> re-spin. The ->dev_get_performance_state() part should be move to the
> OPP layer and the code dealing with the aggregation of the performance
> state index can be greatly simplified.

Thanks for the summary.

>From the above, it looks like I can send this series right away instead of
waiting for the multiple genpd per device thing? Is that the case ?

-- 
viresh
