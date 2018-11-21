From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/4] PM / Domains: Propagate performance state updates
Date: Wed, 21 Nov 2018 11:11:40 +0530
Message-ID: <20181121054140.c64qf6m2kl2rfc5d@vireshk-i7>
References: <cover.1541399301.git.viresh.kumar@linaro.org>
 <7e1ea283f9eebce081af80ddb8d3ca5c9c76cd3b.1541399301.git.viresh.kumar@linaro.org>
 <71530b01-eefa-4778-0b17-d7774eb48356@codeaurora.org>
 <20181121051626.izb6dem62zoaf2c4@vireshk-i7>
 <68a3294f-5556-4b5f-f8c7-79c20b5c70fb@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <68a3294f-5556-4b5f-f8c7-79c20b5c70fb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 21-11-18, 11:01, Rajendra Nayak wrote:
> I would think this is analogous to a driver calling clk_set_rate() first and
> then a clk_enable(), which is certainly valid.
> So my question is, if calling a dev_pm_genpd_set_performance_state()
> and then runtime enabling the device would work (and take care of propagating the performance
> state).

Two things here..

- First, it should work.

- Second, we don't look at device RPM states but only if a genpd is on
  or off. Maybe we should look at device states as well, but then we
  need to initiate set-performance-state routine from runtime enable
  as well. But that is completely different work and would require its
  own series.

> In my testing I found it does not.

As I said, we don't do anything in RPM enable of the device currently,
but only during genpd_power_on(). So if the genpd was previously
disabled, RPM enable of the device should have done propagation of
states as well. Otherwise, we should already have take care of the
vote from the device. So, it should have worked.

Needs some investigation on why this isn't working for you.

-- 
viresh
