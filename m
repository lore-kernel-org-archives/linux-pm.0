From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Reformat printk() statement
Date: Mon, 10 Mar 2014 11:53:53 +0800
Message-ID: <CAKohpo=E2PAD7XNm4y3tXv6-ArPCj+8RG-WsJLOfvJoZ7EkstQ@mail.gmail.com>
References: <1394127279-29871-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1394127279-29871-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: cpufreq-owner@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 7 March 2014 01:34, Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:
> Reformat a printk statement to:
>  - use pr_warn
>  - bring the whole string into a single line in favor of being able to
>    grep for the message (ignoring the 80 char limit)
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  drivers/cpufreq/cpufreq.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index cb003a6b72c8..534c2df608ed 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1874,11 +1874,8 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
>                 if (!gov)
>                         return -EINVAL;
>                 else {
> -                       printk(KERN_WARNING "%s governor failed, too long"
> -                              " transition latency of HW, fallback"
> -                              " to %s governor\n",
> -                              policy->governor->name,
> -                              gov->name);
> +                       pr_warn("%s governor failed, too long transition latency of HW, fallback to %s governor\n",
> +                                       policy->governor->name, gov->name);
>                         policy->governor = gov;
>                 }
>         }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
