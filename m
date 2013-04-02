From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 1/2] cpufreq: split the cpufreq_driver_lock and use the rcu
Date: Tue, 2 Apr 2013 10:35:46 +0530
Message-ID: <CAKohpok7MR28trAddHRi5Lcg0bGBHBnOfJO=yu7SQqGnV5ZCRg@mail.gmail.com>
References: <5159C147.70800@sgi.com>
	<1364847069-2887-1-git-send-email-nzimmer@sgi.com>
	<1364847069-2887-2-git-send-email-nzimmer@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1364847069-2887-2-git-send-email-nzimmer@sgi.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nathan Zimmer <nzimmer@sgi.com>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2 April 2013 01:41, Nathan Zimmer <nzimmer@sgi.com> wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c

> +static struct cpufreq_driver __rcu *cpufreq_driver;
> +static DEFINE_SPINLOCK(cpufreq_driver_lock);

You really need this lock? This is only used in cpufreq_register_driver
and unregister_driver... And it doesn't protect other routines at all. And
because we are using rcu stuff now, probably this lock is just not required.

> +static DEFINE_SPINLOCK(cpufreq_data_lock);

Only this one is required and it can be the rwlock which is already pushed
by rafael.
