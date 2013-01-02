From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] Fix problem with cpufreq_ondemand or cpufreq_conservative
Date: Wed, 2 Jan 2013 09:26:29 +0530
Message-ID: <CAOh2x==ER3j7P1U+VQEtv00LWWa8JJHu=22--+gTUPFdhiC_cQ@mail.gmail.com>
References: <50DE378D.4090008@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <50DE378D.4090008@lwfinger.net>
Sender: cpufreq-owner@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

I know, V4 is already accepted, but i had an small comment with one
of your earlier change, which doesn't exist anymore :)

On Sat, Dec 29, 2012 at 5:51 AM, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> Index: wireless-testing-new/drivers/cpufreq/cpufreq_governor.c

How are you creating these patches? wireless-testing-new (linux directory names)
aren't supposed to be present here.

> ===================================================================
> --- wireless-testing-new.orig/drivers/cpufreq/cpufreq_governor.c
> +++ wireless-testing-new/drivers/cpufreq/cpufreq_governor.c
> @@ -316,3 +316,8 @@ second_time:
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_governor_dbs);
> +
> +MODULE_AUTHOR("Alexander Clouter <alex@digriz.org.uk>");

You shouldn't be adding yourself as author here :)

MODULE_AUTHOR("Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>");
MODULE_AUTHOR("Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>");
