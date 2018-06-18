From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: kryo: Fix possible error code dereference
Date: Mon, 18 Jun 2018 10:25:23 +0530
Message-ID: <20180618045523.p5keat3323wymvpu@vireshk-i7>
References: <20180614202921.32535-1-ilia.lin@gmail.com>
 <20180617195842.22818-1-ilia.lin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180617195842.22818-1-ilia.lin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ilia.lin@gmail.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 17-06-18, 21:58, ilia.lin@gmail.com wrote:
> From: Ilia Lin <ilia.lin@gmail.com>
> 
> In event of error returned by the nvmem_cell_read() non-pointer value
> may be dereferenced. Fix this with error handling.
> Additionally free the allocated speedbin buffer, as per the API.
> 
> Fixes: 9ce36edd1a52 (cpufreq: Add Kryo CPU scaling driver)
> Signed-off-by: Ilia Lin <ilia.lin@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index d049fe4b80c4..74b9b93d511b 100644
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
> @@ -127,6 +129,7 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  		BUG();
>  		break;
>  	}
> +	kfree(speedbin);
>  
>  	for_each_possible_cpu(cpu) {
>  		cpu_dev = get_cpu_device(cpu);

Ideally this should have been two patches as you were fixing two
different problems. But anyway, you can go through this time.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
