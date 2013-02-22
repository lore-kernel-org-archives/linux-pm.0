From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 1/4] cpufreq: Add per policy governor-init/exit infrastructure
Date: Fri, 22 Feb 2013 07:38:12 +0530
Message-ID: <CAKohpom8HiBEXE54BL72s-nWaeXzSRTrp7=MQKrJcon17T9tXQ@mail.gmail.com>
References: <cover.1360568193.git.viresh.kumar@linaro.org>
	<ece24bb874ad1834fc43b83f053b2560db8c25d3.1360568193.git.viresh.kumar@linaro.org>
	<3793606.bilcxohA80@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <3793606.bilcxohA80@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, linaro-dev@lists.linaro.org, francescolavra.fl@gmail.com, toddpoynor@google.com
List-Id: linux-pm@vger.kernel.org

On 22 February 2013 05:05, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, February 11, 2013 01:20:00 PM Viresh Kumar wrote:

>> This patch is inclined towards providing this infrastructure. Because we are
>> required to allocate governor's resources dynamically now, we must do it at
>> policy creation and end. And so got CPUFREQ_GOV_POLICY_INIT/EXIT.
>
> Are those new events NOPs now?

No. These are used atleast for ondemand & conservative.

>> +#define CPUFREQ_GOV_POLICY_INIT      4
>> +#define CPUFREQ_GOV_POLICY_EXIT      4
>
> Why don't you use different values here?
>
> If you need only one value, one #define should be sufficient.

Naah, something happened... I got fixed this locally but couldn't
get that into the commit somehow. EXIT should have 5 here.
