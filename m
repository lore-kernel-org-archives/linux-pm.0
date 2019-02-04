From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v4 1/5] PM / OPP: Introduce a power estimation helper
Date: Mon, 4 Feb 2019 18:21:48 +0000
Message-ID: <20190204182145.wgl3a72s2cwargdk@queper01-ThinkPad-T460s>
References: <20190204110952.16025-1-quentin.perret@arm.com>
 <20190204110952.16025-2-quentin.perret@arm.com>
 <20190204180303.GD117604@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190204180303.GD117604@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On Monday 04 Feb 2019 at 10:03:03 (-0800), Matthias Kaehlcke wrote:
> There is the option to remove the OPP check from the cpufreq drivers
> and instead return an error from dev_pm_opp_of_register_em(), but with
> the more complex error handling it might be more hassle than it's
> worth.

Agreed. And that would make the API a bit weird I guess, so I preferred
the simple solution.

> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Thanks !
Quentin
