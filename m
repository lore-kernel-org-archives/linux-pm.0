From: Mason <mpeg.blue@free.fr>
Subject: Re: How many frequencies would cpufreq optimally like to manage?
Date: Tue, 25 Nov 2014 14:02:50 +0100
Message-ID: <54747DFA.3040802@free.fr>
References: <546D26AE.50601@free.fr>	<CAOh2x==KZzq1wbQxGwsJjZW+=fBJDzcnmRoaZMh0UYH-=yBJ=g@mail.gmail.com>	<546DF891.2050401@free.fr> <CAKohpomzxnCy7X+cPsVdDvi0cMRMp2Am1O-S5BeQtTr1CqBhEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomzxnCy7X+cPsVdDvi0cMRMp2Am1O-S5BeQtTr1CqBhEw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, cpufreq <cpufreq@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 21/11/2014 04:36, Viresh Kumar wrote:

> All current governors depend on background timers for their functionality.
> These timers run at some sampling rate (in ms) and that time we change
> CPU's frequency depending on existing load on system.. So, that might
> not be fast enough.

As far as I can tell, on my SoC, the timer runs at 27 MHz.
But I have no idea how often it fires an interrupt.

I've been studying other cpufreq drivers, especially the OMAP driver.
I noticed that there is a lot of generic infrastructure that our driver
wasn't using, such as...

   cpufreq_generic_init
   cpufreq_generic_exit
   cpufreq_generic_frequency_table_verify
   cpufreq_generic_attr

I've changed our driver to use those.

I'm still confused about cpufreq_generic_get.
This is not a typical get/put type function, right?

What is it supposed to get?
Apparently, the actual frequency of the 'cpu-th' CPU?
I see that it calls clk_get_rate(policy->clk)

This 'struct clk' is an elusive beast.
Where is it defined? I only run into forward declarations.

On my platform, clk_get_accuracy returns -524 unconditionally,
and clk_prepare just returns 0.

of_clk_get and of_clk_get_by_name both return ERR_PTR(-2)

I suppose all this means I can't use this infrastructure "as-is",
correct? Where can I read more about it?

How is the kernel supposed to know what frequency each core is running at?
I imagine that's what the .get method override is for?

One more question (for now). Is the .get method supposed to return numbers
that match in freq_table, or can they be slightly different? For example,
I've defined my freq_table like this:

static struct cpufreq_frequency_table freq_table[] = {
	{ .driver_data = REG_VAL(1,0), .frequency = 999000 },
	{ .driver_data = REG_VAL(1,8), .frequency = 750000 },
	{ .driver_data = REG_VAL(2,0), .frequency = 500000 },
	{ .driver_data = REG_VAL(4,0), .frequency = 250000 },
	{ .driver_data = REG_VAL(8,0), .frequency = 125000 },
	{ .frequency = CPUFREQ_TABLE_END },
};

but the 3rd frequency is actually 999/2 MHz, not 500 MHz, etc.
Will that be a problem?

Regards.

