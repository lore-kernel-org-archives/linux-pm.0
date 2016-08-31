From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH 1/4] cpu: clean up register_cpu func
Date: Wed, 31 Aug 2016 18:45:35 +0800
Message-ID: <57C6B54F.4000406@linaro.org>
References: <1472114562-2736-1-git-send-email-alex.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472114562-2736-1-git-send-email-alex.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>
Cc: linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Is there any concern on this patch?

Regards
Alex

On 08/25/2016 04:42 PM, Alex Shi wrote:
> This patch could reduce one branch in this function. Also
> make the code more readble.
> 
> Signed-off-by: Alex Shi <alex.shi@linaro.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> To: linux-kernel@vger.kernel.org
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/base/cpu.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 691eeea..4c28e1a 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -371,12 +371,13 @@ int register_cpu(struct cpu *cpu, int num)
>  	if (cpu->hotpluggable)
>  		cpu->dev.groups = hotplugable_cpu_attr_groups;
>  	error = device_register(&cpu->dev);
> -	if (!error)
> -		per_cpu(cpu_sys_devices, num) = &cpu->dev;
> -	if (!error)
> -		register_cpu_under_node(num, cpu_to_node(num));
> +	if (error)
> +		return error;
>  
> -	return error;
> +	per_cpu(cpu_sys_devices, num) = &cpu->dev;
> +	register_cpu_under_node(num, cpu_to_node(num));
> +
> +	return 0;
>  }
>  
>  struct device *get_cpu_device(unsigned cpu)
> 
