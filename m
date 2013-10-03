From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [PATCH] cpufreq: arm-big-little: use clk_get instead of clk_get_sys
Date: Thu, 03 Oct 2013 09:57:20 +0100
Message-ID: <524D3170.7080406@arm.com>
References: <1380619803-2760-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <CAKohpom0iYB=HF+YaG9VzHu7LxVQsJww3oEVABRmeHTmwSnxTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpom0iYB=HF+YaG9VzHu7LxVQsJww3oEVABRmeHTmwSnxTA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On 03/10/13 05:52, Viresh Kumar wrote:
> On 1 October 2013 15:00, Sudeep KarkadaNagesha
> <Sudeep.KarkadaNagesha@arm.com> wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> Currently clk_get_sys is used with cpu-cluster.<n> as the device id
>> which is incorrect. It should be connection/consumer ID instead.
>>
>> It is possible to specify input clock in the cpu device node along
>> with the optional clock-name. clk_get_sys can't handle that.
>>
>> This patch replaces clk_get_sys with clk_get to extend support for
>> clocks specified in the device tree cpu node.
>>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
>> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>> ---
>>  drivers/cpufreq/arm_big_little.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
>> index 3549f07..501a091 100644
>> --- a/drivers/cpufreq/arm_big_little.c
>> +++ b/drivers/cpufreq/arm_big_little.c
>> @@ -127,7 +127,7 @@ static int get_cluster_clk_and_freq_table(struct device *cpu_dev)
>>         }
>>
>>         name[12] = cluster + '0';
>> -       clk[cluster] = clk_get_sys(name, NULL);
>> +       clk[cluster] = clk_get(cpu_dev, name);
> 
> This is not really CPUs clock and so passing cpu_dev would be wrong here.
> So, either this change should be clk_get(NULL, name);

Agreed, but there's no cluster node in DT. So platforms using DT would have
these clocks in cpu@n node as it's used for CPU frequency scaling. One example I
can see is highbank(it uses cpufreq-cpu0 meaning its single cluster clock). So
AFAICT if any big-little systems wants to pass cluster clocks through DT, it has
to be cpu@n nodes. Let me know if you have any alternate thoughts ?

Regards,
Sudeep

