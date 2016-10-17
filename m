From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] cpufreq: fix overflow in cpufreq_table_find_index_dl()
Date: Tue, 18 Oct 2016 00:20:43 +0900
Message-ID: <20161017152043.GA502@swordfish>
References: <20161017151456.3573-1-sergey.senozhatsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161017151456.3573-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-Id: linux-pm@vger.kernel.org

On (10/18/16 00:14), Sergey Senozhatsky wrote:
[..]
>  include/linux/cpufreq.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 5fa55fc..2a7aa0b 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -677,10 +677,10 @@ static inline int cpufreq_table_find_index_dl(struct cpufreq_policy *policy,
>  		if (best == table - 1)
>  			return pos - table;
>  
> -		return best - pos;
> +		return pos - best;
>  	}
>  
> -	return best - pos;
> +	return pos - best;
>  }

hmm.., you know what... I'm now actually curious,
why does it do `pos - best' and not `best - table'?

	-ss
