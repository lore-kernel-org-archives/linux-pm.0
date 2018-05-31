From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/9] PM / Domains: Drop __pm_genpd_add_device()
Date: Thu, 31 May 2018 11:43:29 +0530
Message-ID: <20180531061329.2sy7tl7gjhwqv276@vireshk-i7>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-3-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180529100421.31022-3-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Hunter <jonathanh@nvidia.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Todor Tomov <todor.tomov@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Vincent Guittot <vincent.guittot@linaro.org>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 29-05-18, 12:04, Ulf Hansson wrote:
> There are still a few non-DT existing users of genpd, however neither of
> them uses __pm_genpd_add_device(), hence let's drop it.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 10 ++++------
>  include/linux/pm_domain.h   | 14 +++-----------
>  2 files changed, 7 insertions(+), 17 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
