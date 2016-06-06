From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 6/9] cpufreq: imx: Use 'index' only to index into
 policy->freq_table
Date: Mon, 6 Jun 2016 09:28:17 +0530
Message-ID: <20160606035817.GA16176@vireshk-i7>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
 <5be64daa9fc2967351f7e5949b814d866264598e.1464960877.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5be64daa9fc2967351f7e5949b814d866264598e.1464960877.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Shawn Guo <shawnguo@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Steven Miao <realmz6@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 03-06-16, 19:05, Viresh Kumar wrote:
> Later patches would make changes in cpufreq core, after which
> policy->freq_table may be reordered by cpufreq core and it wouldn't be
> safe anymore to use 'index' for any other local arrays.
> 
> To prepare for that, use policy->freq_table[index].driver_data for other
> driver specific usage of 'index'. The 'driver_data' fields are already
> set properly by the driver.
> 
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Fixing Shawn's id.

-- 
viresh
