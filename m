From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] PM / devfreq: Remove redundant frequency adjustment from
 governors
Date: Thu, 17 May 2018 15:41:26 -0700
Message-ID: <20180517224126.GP19594@google.com>
References: <20180516211051.78875-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180516211051.78875-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 16, 2018 at 02:10:51PM -0700, Matthias Kaehlcke wrote:
> The performance, powersave, simpleondemand and userspace governors
> determine a target frequency and then adjust it according to the
> df->min/max_freq limits that might have been set by user space. This
> adjustment is redundant, it is done in update_devfreq() for any
> governor, right after governor->get_target_freq().
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/governor_performance.c    | 10 ++--------
>  drivers/devfreq/governor_powersave.c      |  5 -----
>  drivers/devfreq/governor_simpleondemand.c |  7 +------
>  drivers/devfreq/governor_userspace.c      | 16 ++++------------
>  4 files changed, 7 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
> index 4d23ecfbd948..31ee30622c00 100644
> --- a/drivers/devfreq/governor_performance.c
> +++ b/drivers/devfreq/governor_performance.c
> @@ -16,14 +16,8 @@
>  static int devfreq_performance_func(struct devfreq *df,
>  				    unsigned long *freq)
>  {
> -	/*
> -	 * target callback should be able to get floor value as
> -	 * said in devfreq.h
> -	 */
> -	if (!df->max_freq)
> -		*freq = UINT_MAX;
> -	else
> -		*freq = df->max_freq;
> +	*freq = UINT_MAX;
> +
>  	return 0;
>  }

For the record, the frequency adjustment in update_devfreq() is
currently broken for df->max_freq == 0:

https://patchwork.kernel.org/patch/10407827/
