From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 7/9] PM / Domains: Split genpd_dev_pm_attach()
Date: Thu, 31 May 2018 12:34:26 +0530
Message-ID: <20180531070426.3olmew36foji32ge@vireshk-i7>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-8-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180529100421.31022-8-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Hunter <jonathanh@nvidia.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Todor Tomov <todor.tomov@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Vincent Guittot <vincent.guittot@linaro.org>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 29-05-18, 12:04, Ulf Hansson wrote:
> To extend genpd to deal with allowing multiple PM domains per device, some
> of the code in genpd_dev_pm_attach() can be re-used. Let's prepare for this
> by moving some of the code into a sub-function.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 60 ++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 27 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
