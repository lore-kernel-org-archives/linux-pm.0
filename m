From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: governors: Get rid of dbs_data->enable field
Date: Fri, 1 Feb 2013 09:22:35 +0530
Message-ID: <CAKohponyY1goyV_5U3f3ZFVuMqp2XsrAevNCvZ9Juoyg53LjnA@mail.gmail.com>
References: <09a94ff044ff6a6f7a5d953c3b1f3102c1dc50cf.1359653181.git.viresh.kumar@linaro.org>
	<20130131184449.GA20164@balto.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130131184449.GA20164@balto.lan>
Sender: cpufreq-owner@vger.kernel.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com
List-Id: linux-pm@vger.kernel.org

On 1 February 2013 00:14, Fabio Baltieri <fabio.baltieri@linaro.org> wrote:
> Hello Viresh, thanks for getting this done... looks much cleaner now!
>
> I tested both patches on my ux500 setup (dual Cortex-A9) and it seems to
> run correctly on both CPU load changes and CPU hotplug, so:
>
> Tested-by: Fabio Baltieri <fabio.baltieri@linaro.org>

Thanks.

> As a sidenote, I noticed just now that since:
>
> bc92bea cpufreq: Notify governors when cpus are hot-[un]plugged
>
> governor's sampling_rate gets reset to default every time you hotplug a
> CPU (the one you read/write on
> /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate).
>
> If you need further tests, I'll be back on Monday.

I will have a look.
