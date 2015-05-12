From: Mason <slash.tmp@free.fr>
Subject: Re: schedule_timeout sleeps too long after dividing CPU frequency
Date: Tue, 12 May 2015 18:03:40 +0200
Message-ID: <5552245C.2080701@free.fr>
References: <55520F0F.5010906@free.fr> <20150512152332.GO2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20150512152332.GO2067@n2100.arm.linux.org.uk>
Sender: cpufreq-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, cpufreq <cpufreq@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 12/05/2015 17:23, Russell King - ARM Linux wrote:

> On Tue, May 12, 2015 at 04:32:47PM +0200, Mason wrote:
> 
>> I'm working on a Cortex A9 based platform.
>>
>> I have a basic clock tree, and a very basic cpufreq driver using
>> mostly generic driver glue:
>>
>> static struct cpufreq_driver tangox_cpufreq_driver = {
>> 	.name		= "tangox-cpufreq",
>> 	.init		= tangox_cpu_init,
>> 	.verify		= cpufreq_generic_frequency_table_verify,
>> 	.target_index	= tangox_target,
>> 	.get		= cpufreq_generic_get,
>> 	.exit		= cpufreq_generic_exit,
>> 	.attr		= cpufreq_generic_attr,
>> };
>>
>> My target_index function is trivial:
>>
>> static int tangox_target(struct cpufreq_policy *policy, unsigned int idx)
>> {
>> 	return clk_set_rate(policy->clk, freq_table[idx].frequency * 1000);
>> }
>>
>> I was testing an unrelated driver at low frequencies, with the nominal
>> frequency (999 MHz) divided by 54 (i.e. freq = 18.5 MHz) and I noticed
>> that when the driver calls
>>
>>     schedule_timeout(HZ);
>>
>> the thread sleeps 54 seconds instead of 1.
> 
> I'm guessing that this will be because your local timer changes frequency
> with the CPU, which means that the clockevent which was set for one second
> ends up timing out after 54 seconds.

That's the first thing I suspected, but smp_twd.c registers a clk_notifier
to be notified of CPU frequency changes:

static struct notifier_block twd_clk_nb = {
	.notifier_call = twd_rate_change,
};

static int twd_clk_init(void)
{
	if (twd_evt && __this_cpu_ptr(twd_evt) && !IS_ERR(twd_clk))
		return clk_notifier_register(twd_clk, &twd_clk_nb);

	return 0;
}

And I instrumented twd_update_frequency() to check it was being called.

Regards.

