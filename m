From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: kryo: Fix possible error code dereference
Date: Fri, 15 Jun 2018 08:16:25 +0530
Message-ID: <20180615024625.rzr4644n77zrtomm@vireshk-i7>
References: <20180614202921.32535-1-ilia.lin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180614202921.32535-1-ilia.lin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ilia.lin@gmail.com
Cc: Ilia Lin <ilialin@codeaurora.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Dan Carpenter <dan.carpenter@oracle.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 14-06-18, 22:29, ilia.lin@gmail.com wrote:
> From: Ilia Lin <ilia.lin@gmail.com>
> 
> In event of error returned by the nvmem_cell_read() non-pointer value
> may be dereferenced. Fix this with error handling.
> 
> Signed-off-by: Ilia Lin <ilia.lin@gmail.com>

Fixes tag ?

> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index d049fe4b80c4..5e9511223ce9 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -115,6 +115,8 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  
>  	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
>  	nvmem_cell_put(speedbin_nvmem);
> +	if (IS_ERR(speedbin))
> +		return PTR_ERR(speedbin);
>  
>  	switch (msm8996_version) {
>  	case MSM8996_V3:
> -- 
> 2.11.0

-- 
viresh
