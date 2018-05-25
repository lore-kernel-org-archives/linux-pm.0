From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 2/2] cpufreq: tegra20: Use PLL_C as intermediate clock
 source
Date: Fri, 25 May 2018 11:28:00 +0300
Message-ID: <78d2aba0-b1e0-f667-8368-ed8c3e179499@gmail.com>
References: <20180523160020.15291-1-digetx@gmail.com>
 <20180523160020.15291-2-digetx@gmail.com>
 <20180524100413.GL6835@tbergstrom-lnx.Nvidia.com>
 <e6ee8116-7f73-fa7a-3df4-b17ccd8dcb0e@gmail.com>
 <20180525063225.GN6835@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525063225.GN6835@tbergstrom-lnx.Nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 25.05.2018 09:32, Peter De Schrijver wrote:
> On Thu, May 24, 2018 at 03:49:22PM +0300, Dmitry Osipenko wrote:
>> On 24.05.2018 13:04, Peter De Schrijver wrote:
>>> On Wed, May 23, 2018 at 07:00:20PM +0300, Dmitry Osipenko wrote:
>>>> PLL_C is running at 600MHz which is significantly higher than the 216MHz
>>>> of the PLL_P and it is known that PLL_C is always-ON because AHB BUS is
>>>> running on that PLL. Let's use PLL_C as intermediate clock source, making
>>>> CPU snappier a tad during of the frequency transition.
>>>>
>>>
>>> pll_c isn't necessarily 600Mhz when used as a source for the second display
>>> head.
>>
>> Hmm, indeed.
>>
>> Even if PLL_C rate will be adjusted, it will be higher than the PLL_P.. won't
>> it? That's likely to be good enough.
>>
> 
> Yes. I think it can be always higher than pll_p, but that assumes the display
> driver will always program the highest possible rate for pll_c for a given mode
> and then program the display divider to divide it down to the required rate.
> 
>> Do you know if any of the available CCLK parents has a glitch-less rate
>> switching? I.e. CPU won't hang on the rate switch.
>>
> 
> Tegra20 doesn't have dynamic ramp PLLs no. So you always have to switch to a
> backup clock source before changing the rate of pll_x.
> 
>> There is other possible 600MHz source, the PLL_M. Can we use it? This one also
>> may become dynamic if we'll consider implementing the memory scaling, but the
>> memory frequency probably will fit the transition role pretty well.
> 
> I think this should work, but as you mention it may very well be lower than
> pll_p if Tegra20 EMC scaling is re-introduced. I think that's why historically
> this was never done. 
> 
> Peter.
> 

Okay, thank you very much for the input. Let's put on hold these patches then.

Peter Geis just made a cpufreq driver for the Tegra30 and turned out it's just a
dozen lines of code that we'll have to add to the tegra20-cpufreq driver to
support Tegra30. The tegra20-cpufreq driver code suits very well for the Tegra30
integration, use of PLL_C for the intermediate scaling will make that
integration a bit messy. I'll return to considering of the different
transition-PLL variant after adding the Tegra30 support.
