From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 08/35] cpufreq: cpufreq-cpu0: use cpufreq_table_validate_and_show()
Date: Mon, 12 Aug 2013 13:19:32 +0530
Message-ID: <CAKohpomRmEbHp0UMmNcrM815WS6fnBMfdoJRQY_dwZ5fW1SB_w@mail.gmail.com>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
	<59d56d7aea5dfb69bc7bda0c40529d3ef15efcab.1375964117.git.viresh.kumar@linaro.org>
	<20130812073522.GC25061@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130812073522.GC25061@S2101-09.ap.freescale.net>
Sender: cpufreq-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 12 August 2013 13:05, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Thu, Aug 08, 2013 at 07:18:10PM +0530, Viresh Kumar wrote:
>> Lets use cpufreq_table_validate_and_show() instead of calling
>> cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().
>>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> I'm not copied on the patch that introduces function
> cpufreq_table_validate_and_show().  So if it does the right/equivalent
> thing, for cpufreq-cpu0 and imx6q-cpufreq:

You better check it :)

https://lkml.org/lkml/2013/8/8/266

I wasn't probably following the right way for sending mails as I was expecting
people to look at these patches over list..

In the next series with 44 patch I tried to fix this issue. And so cc'd people
on cover-letter and the important patch they must check.

> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Thanks.
