From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] cpufreq: governors: Remove code redundancy between governors
Date: Fri, 01 Feb 2013 23:32:30 +0100
Message-ID: <41218306.bQmZmWoL7T@vostro.rjw.lan>
References: <09a94ff044ff6a6f7a5d953c3b1f3102c1dc50cf.1359653181.git.viresh.kumar@linaro.org> <CAKohpomdOzuXXGAr2r0LFULhr5AYLHWyhDON+9AKjMv9L6zkAg@mail.gmail.com> <CAKohponEPOO3vH3Kn8UChXEaNP36gDaDh-ym4Z9ZjcHbs418cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohponEPOO3vH3Kn8UChXEaNP36gDaDh-ym4Z9ZjcHbs418cQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Fabio Baltieri <fabio.baltieri@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com
List-Id: linux-pm@vger.kernel.org

On Friday, February 01, 2013 08:08:42 AM Viresh Kumar wrote:
> On 1 February 2013 08:01, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Really!! I see bleeding edge as df0e3f4 and i don't see the $(subject) patch
> > in it :)
> 
> Well it might have been dropped by Rafael due to build error,

Precisely.

> which would be fixed by:
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c
> b/drivers/cpufreq/cpufreq_governor.c
> index dc99472..7aaa9b1 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -194,6 +194,7 @@ bool need_load_eval(struct cpu_dbs_common_info *cdbs,
> 
>         return true;
>  }
> +EXPORT_SYMBOL_GPL(need_load_eval);
> 
>  int cpufreq_governor_dbs(struct dbs_data *dbs_data,
>                 struct cpufreq_policy *policy, unsigned int event)
> 
> 
> Original patch attached with this change.

OK, thanks!

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
