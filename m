From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 1/2] cpufreq: Allow light-weight tear down and bring up
 of CPUs
Date: Tue, 12 Feb 2019 11:54:29 +0100
Message-ID: <CAJZ5v0hez63un9g4h0U+YOZV1o7S+FT8NritiX6dxEcD1-fTSQ@mail.gmail.com>
References: <f48f04ddfe3bd072f40154cdd971079199db0e4b.1549955027.git.viresh.kumar@linaro.org>
 <15c641e4139d0b9a7d7540eefced1c012b608e91.1549968315.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <15c641e4139d0b9a7d7540eefced1c012b608e91.1549968315.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 12, 2019 at 11:47 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>

[cut]

> @@ -2488,7 +2505,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>                     driver_data->target) ||
>              (driver_data->setpolicy && (driver_data->target_index ||
>                     driver_data->target)) ||
> -            (!!driver_data->get_intermediate != !!driver_data->target_intermediate))
> +            (!!driver_data->get_intermediate != !!driver_data->target_intermediate) ||
> +            (!driver_data->online ^ !driver_data->offline))

Why do you need the ^ here?  != should be sufficient:

!driver_data->online != !driver_data->offline

?

>                 return -EINVAL;
>
>         pr_debug("trying to register driver %s\n", driver_data->name);
