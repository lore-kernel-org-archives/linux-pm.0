From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH 2/2] cpufreq: tegra: Re-model Tegra cpufreq driver
Date: Thu, 12 Sep 2013 13:14:59 +0300
Message-ID: <20130912101459.GG30013@tbergstrom-lnx.Nvidia.com>
References: <1378898355-31290-1-git-send-email-bilhuang@nvidia.com>
 <1378898355-31290-3-git-send-email-bilhuang@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1378898355-31290-3-git-send-email-bilhuang@nvidia.com>
Sender: cpufreq-owner@vger.kernel.org
To: Bill Huang <bilhuang@nvidia.com>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 11, 2013 at 01:19:14PM +0200, Bill Huang wrote:

> +static inline int tegra_cpufreq_init(void)
> +{
> +       retrun EOPNOTSUPP;

This should be -EOPNOTSUPP at least. I think -EINVAL might be better.

Cheers,

Peter.
