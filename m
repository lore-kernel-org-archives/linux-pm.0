From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: v3.13.5 intel_pstate: cpufreq: __cpufreq_add_dev: ->get() failed
Date: Wed, 12 Mar 2014 13:22:54 +0800
Message-ID: <CAKohpokONW5Q2GqrvmKBh+NLSVA1RSZ_Fg+jKZQnReDXianvUg@mail.gmail.com>
References: <CAA7pwKNmosWaWPR0x3kNzL7eNLk8vdCB=NknU9ayLT9s1fJQYA@mail.gmail.com>
	<3509059.VnUUJct98J@vostro.rjw.lan>
	<3616342.xJi2LEuFEF@vostro.rjw.lan>
	<4501120.an62ETExKs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <4501120.an62ETExKs@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Patrik Lundquist <patrik.lundquist@gmail.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12 March 2014 07:53, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> Is having ->target set mutually exclusive with having ->setpolicy set?
>
> It is quite clear that having ->setpolicy implies having ->target unset,
> because both drivers with ->setpolicy (intel_pstate and longrun) don't
> have ->target set.
>
> Now, are there any *other* cpufreq drivers without ->target?
>
> In either case, in my opinion we should just make cpufreq_register_driver()
> fail for drivers having both ->set_policy and ->target set at the same time.
> Like in the patch below.
>
> Rafael
>
>
> ---
>  drivers/cpufreq/cpufreq.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -2306,7 +2306,9 @@ int cpufreq_register_driver(struct cpufr
>
>         if (!driver_data || !driver_data->verify || !driver_data->init ||
>             !(driver_data->setpolicy || driver_data->target_index ||
> -                   driver_data->target))
> +                   driver_data->target) ||
> +            (driver_data->setpolicy && (driver_data->target_index ||
> +                   driver_data->target)))
>                 return -EINVAL;
>
>         pr_debug("trying to register driver %s\n", driver_data->name);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
