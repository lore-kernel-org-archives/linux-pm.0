From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Don't update new_policy on failures
Date: Wed, 16 Jan 2019 12:57:36 +0100
Message-ID: <3588039.3NVSA610fZ@aspire.rjw.lan>
References: <af05a5d2d3ef76402f54448a66cbd20ee98bceb8.1546844324.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <af05a5d2d3ef76402f54448a66cbd20ee98bceb8.1546844324.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, January 7, 2019 7:58:54 AM CET Viresh Kumar wrote:
> The local variable "new_policy" isn't getting used in the error path
> since the commit f9f41e3ef99a ("cpufreq: Remove policy create/remove
> notifiers"). Don't update it in error path.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7aa3dcad2175..9a5f82ef40e8 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1305,8 +1305,6 @@ static int cpufreq_online(unsigned int cpu)
>  	if (ret) {
>  		pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
>  		       __func__, cpu, ret);
> -		/* cpufreq_policy_free() will notify based on this */
> -		new_policy = false;
>  		goto out_destroy_policy;
>  	}
>  
> 

Applied, thanks!
