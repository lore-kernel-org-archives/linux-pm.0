From: Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>
Subject: Re: [PATCH 3/3] soc/tegra: bpmp: Implement generic PM domains
Date: Wed, 15 Mar 2017 12:49:47 +0200
Message-ID: <06005f89-a3fd-ce7d-57f0-e77e866f7e8f@kapsi.fi>
References: <20170314191516.13083-1-thierry.reding@gmail.com>
 <20170314191516.13083-4-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170314191516.13083-4-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stefan Kristiansson <stefank-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 14.03.2017 21:15, Thierry Reding wrote:
> ...
> +
> +static inline bool tegra_bpmp_powergate_is_powered(struct tegra_bpmp *bpmp,
> +						   unsigned int id)
> +{
> +	return tegra_bpmp_powergate_get_state(bpmp, id) == PG_STATE_ON;
> +}

This should also check for PG_STATE_RUNNING and consider that to be on. 
There's this tristate thing for legacy reasons..

> ...

Cheers,
Mikko.
