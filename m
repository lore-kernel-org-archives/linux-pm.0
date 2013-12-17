From: bilhuang <bilhuang@nvidia.com>
Subject: Re: [PATCH v3 2/2] cpufreq: tegra: Re-model Tegra cpufreq driver
Date: Tue, 17 Dec 2013 18:52:52 +0800
Message-ID: <52B02D04.4050905@nvidia.com>
References: <1386229462-3474-1-git-send-email-bilhuang@nvidia.com>	<1386229462-3474-3-git-send-email-bilhuang@nvidia.com> <CAKohponns4B+BPPum3EN6EuXx6U+6MzOa50gMdR1BNBtxMNf0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohponns4B+BPPum3EN6EuXx6U+6MzOa50gMdR1BNBtxMNf0Q@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Warren <swarren@wwwdotorg.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12/17/2013 02:54 PM, Viresh Kumar wrote:
> On 5 December 2013 13:14, Bill Huang <bilhuang@nvidia.com> wrote:
>> Re-model Tegra cpufreq driver to support all Tegra series of SoCs.
>>
>> * Make tegra-cpufreq.c a generic Tegra cpufreq driver.
>> * Move Tegra20 specific codes into tegra20-cpufreq.c.
>> * Bind Tegra cpufreq dirver with a fake device so defer probe would work
>>    when we're going to get regulator in the driver to support voltage
>>    scaling (DVFS).
>
> I strongly feel we must reuse cpufreq-cpu0 driver here after adding a
> clk/regulator driver for tegra to support all that.

Tegra20 DVFS is a little bit complicated due to the fact that we can't 
scale VDD_CPU directly, there are constraints or relationship to other 
power rails so I don't think it is a good idea to use generic 
cpufreq-cpu0 driver if we're going to support voltage scaling.
>
> @Stephen: If you want we can keep all that tegra specific stuff
> (clk/regulator) in
> tegra-cpufreq.c, but we can easily use cpufreq-cpu0 driver without much
> complications..
>
> I have tried it earlier, got some comments and then got busy in other stuff..
> https://lkml.org/lkml/2013/8/7/364
>
>>   static int tegra_cpu_exit(struct cpufreq_policy *policy)
>>   {
>> -       clk_disable_unprepare(cpu_clk);
>> -       clk_disable_unprepare(emc_clk);
>> +       cpufreq_frequency_table_cpuinfo(policy, tegra_data->freq_table);
>
> Btw, why do you need this here?
>
Actually the latest version is v4 which is quite different against v3.
