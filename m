From: Matt Longnecker <mlongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 4/4] thermal: update documentation for new device ops
Date: Wed, 30 Mar 2016 09:54:50 -0700
Message-ID: <56FC04DA.80700@nvidia.com>
References: <1459298497-29481-1-git-send-email-srikars@nvidia.com>
 <1459298497-29481-5-git-send-email-srikars@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459298497-29481-5-git-send-email-srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srikar Srimath Tirumala <srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Looks good to me.

On 03/29/2016 05:41 PM, Srikar Srimath Tirumala wrote:
> different threshold temperature points.
> +	.get_trip_state: get the current state (TRIPPED or NOT_TRIPPED) of a
> +		certain trip point.
> +	.set_trip_state: set the state of a certain trip point.
> +	.enb_temp_notify: check if temperature notifications are enabled for a
> +		certain trip point.
>       tzp: thermal zone platform parameters.
>       passive_delay: number of milliseconds to wait between polls when
>   	performing passive cooling.
