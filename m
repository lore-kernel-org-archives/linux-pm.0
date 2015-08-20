From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] thermal: cpu_cooling: Remove usage of devm functions
Date: Thu, 20 Aug 2015 21:47:04 +0530
Message-ID: <20150820161704.GD4159@linux>
References: <20150820161402.GA4951@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150820161402.GA4951@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 20-08-15, 21:44, Vaishali Thakkar wrote:
> In the function cpufreq_get_requested_power, the memory allocated
> for load_cpu is live within the function only. And after the
> allocation it is immediately freed with devm_kfree. There is no
> need to allocate memory for load_cpu with devm function so replace
> devm_kcalloc with kcalloc and devm_kfree with kfree.
> 
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
> ---
> Changes since v1:
> 	- Introduce new label based on Viresh Kumar's suggestion
> ---
>  drivers/thermal/cpu_cooling.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
