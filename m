From: "Javi Merino" <javi.merino@arm.com>
Subject: Re: [PATCH V2 25/26] thermal: cpu_cooling: Use
 cpufreq_dev->freq_table for finding level/freq
Date: Thu, 4 Dec 2014 10:52:40 +0000
Message-ID: <20141204105240.GC22781@e104805>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
 <45a3ff79a10b0618783f0043efa44966c758b410.1417664938.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:52631 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbaLDKwq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Dec 2014 05:52:46 -0500
In-Reply-To: <45a3ff79a10b0618783f0043efa44966c758b410.1417664938.git.viresh.kumar@linaro.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "amit.daniel@samsung.com" <amit.daniel@samsung.com>

Hi Viresh,

One minor nit

On Thu, Dec 04, 2014 at 04:12:07AM +0000, Viresh Kumar wrote:
> get_property() was an over complicated beast with BUGs. It used to believe that
> cpufreq table is present in ascending or descending order, which might not
> always be true.
> 
> Previous patch has created another freq table in descending order for us and we
> better use it now. With that get_property() simply goes away and another helper
> get_level() comes in.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 108 ++++++++----------------------------------
>  1 file changed, 19 insertions(+), 89 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index cb5a4b9..d97e14d 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -112,85 +112,27 @@ static void release_idr(struct idr *idr, int id)
>  
>  /* Below code defines functions to be used for cpufreq as cooling device */
>  
> -enum cpufreq_cooling_property {
> -	GET_LEVEL,
> -	GET_FREQ,
> -};
> -
>  /**
> - * get_property - fetch a property of interest for a given cpu.
> + * get_level: Find the level for a particular frequency
>   * @cpufreq_dev: cpufreq_dev for which the property is required
> - * @input: query parameter
> - * @output: query return
> - * @property: type of query (frequency, level)
> - *
> - * This is the common function to
> - * 1. translate frequency to cooling state
> - * 2. translate cooling state to frequency
> + * @freq: Frequency
>   *
> - * Note that the code may be not in good shape
> - * but it is written in this way in order to:
> - * a) reduce duplicate code as most of the code can be shared.
> - * b) make sure the logic is consistent when translating between
> - *    cooling states and frequencies.
> - *
> - * Return: 0 on success, -EINVAL when invalid parameters are passed.
> + * Returns: level on success, THERMAL_CSTATE_INVALID on error.

Should be "Return:", as it was.  See Documentation/kernel-doc-nano-HOWTO.txt

Cheers,
Javi

