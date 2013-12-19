From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Apply default governor for setpolicy drivers
Date: Thu, 19 Dec 2013 10:57:06 +0530
Message-ID: <CAKohpokxbAkXznyesdUAV7nhcdxMjcc=uOZE=hQhXnnD=bRNTw@mail.gmail.com>
References: <20131218203102.9F9692036@prod-mail-relay06.akamai.com>
	<1451068.r0h0sa1DaG@vostro.rjw.lan>
	<52B21508.3000303@akamai.com>
	<2651749.Dr3egRT25J@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2651749.Dr3egRT25J@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jason Baron <jbaron@akamai.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "dirk.brandewie@gmail.com" <dirk.brandewie@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 19 December 2013 05:03, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> +       if (cpufreq_driver->setpolicy) {
> +               unsigned int ret;
> +
> +               /* Use the default policyt if it is valid. */
> +               if (!cpufreq_parse_governor(policy->governor->name, &ret, NULL))
> +                       new_policy.policy = ret;
> +       }

What about this instead as cpufreq_parse_governor isn't supposed to change
value of ret in case of errors.

> +       if (cpufreq_driver->setpolicy)
> +               cpufreq_parse_governor(policy->governor->name, &new_policy.policy, NULL);
