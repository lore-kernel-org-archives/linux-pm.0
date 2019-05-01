From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] PM / Domains: Improve support for multi PM domains
Date: Wed, 01 May 2019 12:25:46 +0200
Message-ID: <2833844.V0R6nlsLIU@kreacher>
References: <20190418102757.1246-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190418102757.1246-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Hunter <jonathanh@nvidia.com>, Rajendra Nayak <rnayak@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Niklas Cassel <niklas.cassel@linaro.org>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thursday, April 18, 2019 12:27:54 PM CEST Ulf Hansson wrote:
> It's been a while since the introduction for the support for multi PM domains
> per device in genpd. In this small series, a couple of different improvement
> are being made to this code in genpd.
> 
> Ulf Hansson (3):
>   PM / Domains: Don't kfree() the virtual device in the error path
>   PM / Domains: Allow OF lookup for multi PM domain case from
>     ->attach_dev()
>   PM / Domains: Enable genpd_dev_pm_attach_by_id|name() for single PM
>     domain
> 
>  drivers/base/power/domain.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

All [1-3/3] applied, thanks!
