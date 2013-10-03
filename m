From: Paul Walmsley <pwalmsley@nvidia.com>
Subject: Re: [PATCH V2 03/16] cpuidle: make __cpuidle_get_cpu_driver() inline
Date: Thu, 3 Oct 2013 13:14:44 -0700
Message-ID: <524DD034.30906@nvidia.com>
References: <cover.1380815504.git.viresh.kumar@linaro.org> <d95bfe847f8c6a89442004d0897f8f9ef5a53300.1380815504.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d95bfe847f8c6a89442004d0897f8f9ef5a53300.1380815504.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi

a comment on this one (and any similar patch)

On 10/03/2013 08:56 AM, Viresh Kumar wrote:
> __cpuidle_get_cpu_driver() is a single line function and so deserves to be
> marked inline.

In general, this is a violation of Documentation/CodingStyle - see 
Chapter 15.

Unless this produces a significant benefit, it's probably best to just 
let the compiler do this if it wants.

- Paul


> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpuidle/driver.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index ced1df6..25455e8 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -29,7 +29,7 @@ static DEFINE_PER_CPU(struct cpuidle_driver *, cpuidle_drivers);
>    * Returns a pointer to struct cpuidle_driver or NULL if no driver has been
>    * registered for @cpu.
>    */
> -static struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
> +static inline struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
>   {
>   	return per_cpu(cpuidle_drivers, cpu);
>   }
