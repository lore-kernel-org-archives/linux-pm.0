From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: exynos: simplify .init() for setting policy->cpus
Date: Thu, 7 Feb 2013 10:48:05 +0530
Message-ID: <CAKohpokJn5892Vt-M+5zNoe3Ebc5cOm-K7c1FzK7x2Ws=ysYmQ@mail.gmail.com>
References: <f216e85846c302756d55cb6753863a66697f79a6.1359599087.git.viresh.kumar@linaro.org>
	<CAKohpo=aWbJ9a9vKep1aGYTXr=5asYPCri1BPCww-3GxEo8F=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=aWbJ9a9vKep1aGYTXr=5asYPCri1BPCww-3GxEo8F=w@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl, jc.lee@samsung.com, Inderpal Singh <inderpal.singh@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, kgene.kim@samsung.com
List-Id: linux-pm@vger.kernel.org

On 4 February 2013 17:52, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 31 January 2013 07:56, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> With the recent changes in cpufreq core, we just need to set mask of all
>> possible cpus into policy->cpus. Rest would be done by core.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/cpufreq/exynos-cpufreq.c | 14 +-------------
>>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> Hi Rafael,
>
> Are you picking up this patch ?

Ping!!
