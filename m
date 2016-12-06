From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: Fix NULL pointer comparison warning
Date: Tue, 6 Dec 2016 15:59:18 +0530
Message-ID: <20161206102918.GA31255@vireshk-i7>
References: <1481019475-26636-1-git-send-email-m.wasif@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481019475-26636-1-git-send-email-m.wasif@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mohamed Wasif <m.wasif@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vidushi.koul@samsung.com
List-Id: linux-pm@vger.kernel.org

On 06-12-16, 15:47, Mohamed Wasif wrote:
> Replace direct comparisons to NULL
> This problem was detected by checkpatch.
> 
> Signed-off-by: Mohamed Wasif <m.wasif@samsung.com>
> ---
>  drivers/cpufreq/cpufreq.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6e6c1fb..ca3542e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -590,7 +590,7 @@ static int cpufreq_parse_governor(char *str_governor, unsigned int *policy,
>  
>  		t = find_governor(str_governor);
>  
> -		if (t == NULL) {
> +		if (!t) {
>  			int ret;
>  
>  			mutex_unlock(&cpufreq_governor_mutex);
> @@ -601,7 +601,7 @@ static int cpufreq_parse_governor(char *str_governor, unsigned int *policy,
>  				t = find_governor(str_governor);
>  		}
>  
> -		if (t != NULL) {
> +		if (t) {
>  			*governor = t;
>  			err = 0;
>  		}

What exact checkpatch error did you get ?

This patch would still be not worth it, as the style of comparing with
NULL is just fine. But still I am unable to see the checkpatch warning
in my setup.

-- 
viresh
