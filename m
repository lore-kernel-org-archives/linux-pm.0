From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 5/6] ARM: Tegra: start using cpufreq-cpu0 driver
Date: Wed, 07 Aug 2013 11:53:14 -0600
Message-ID: <5202898A.6050006@wwwdotorg.org>
References: <cover.1375886595.git.viresh.kumar@linaro.org> <6610c86618b781b00eba446ca19035e077d99691.1375886595.git.viresh.kumar@linaro.org> <520287EA.5060508@wwwdotorg.org> <CAKohpokOn4-RZE5mfoM+2p8jszWoGfOErrLShZmv86OgCMv+JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpokOn4-RZE5mfoM+2p8jszWoGfOErrLShZmv86OgCMv+JA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, swarren@nvidia.com, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 08/07/2013 11:49 AM, Viresh Kumar wrote:
> On 7 August 2013 23:16, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 08/07/2013 08:46 AM, Viresh Kumar wrote:
>>> cpufreq-cpu0 driver can be probed over DT only if a corresponding device node is
>>> created for the SoC which wants to use it. Lets create a platform device for
>>> cpufreq-cpu0 driver for Tegra.
>>>
>>> Also it removes the Kconfig entry responsible to compiling tegra-cpufreq driver
>>> and hence there will not be any conflicts between two cpufreq drivers.
>>
>>> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
>>
>>>  static void __init tegra_dt_init(void)
>>>  {
>>> +     struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
>>>       struct soc_device_attribute *soc_dev_attr;
>>>       struct soc_device *soc_dev;
>>>       struct device *parent = NULL;
>>>
>>>       tegra_clocks_apply_init_table();
>>> +     platform_device_register_full(&devinfo);
>>
>> This seems awfully like going back to board files. Shouldn't something
>> that binds to the CPU nodes register the cpufreq device automatically,
>> based on the CPU's compatible value?
> 
> This link has got some information why we can't have a node for cpufreq
> or a compatibility value..
> 
> http://permalink.gmane.org/gmane.linux.kernel.cpufreq/9018

That link only describes why we shouldn't have a dedicated compatible
value for cpufreq. I certainly agree with that. However, I think it's
reasonable that whatever code binds to:

	compatible = "arm,cortex-a9";

... should instantiate any virtual devices that relate to the CPU.

Doing so would be similar to how the Tegra I2S driver instantiates the
internal struct device that ASoC needs for the PCM/DMA device, rather
than having board-dt-tegra20.c do it, like it would have done in
board-file days.
