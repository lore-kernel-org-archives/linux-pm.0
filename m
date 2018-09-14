From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 0/5] CPUFREQ OPP's and Tegra30 support by
 tegra20-cpufreq driver
Date: Fri, 14 Sep 2018 13:30:13 +0300
Message-ID: <09451207-ee77-7b4e-54cf-7a7a7ab67400@gmail.com>
References: <20180830194356.14059-1-digetx@gmail.com>
 <1536237301.25080.22.camel@toradex.com>
 <6c5b6eb4-f809-1a31-acbc-ea27e5cb891b@gmail.com>
 <1536654470.32292.31.camel@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536654470.32292.31.camel@toradex.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>, "pdeschrijver@nvidia.com" <pdeschrijver@nvidia.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 9/11/18 11:27 AM, Marcel Ziswiler wrote:
> On Fri, 2018-09-07 at 19:59 +0300, Dmitry Osipenko wrote:
> 
> - snip -
> 
>>> - With "cpufreq-info -f" I could only observe like the top 3-4 OPPs
>>> while it does not to go further down even when idling. Why could
>>> that
>>> be resp. what could cause this?
>>
>> What cpufreq governor are you using?
> 
> ondemand
> 
>> Here is my 'cpufreq-info --stats' output from Tegra30 after a several
>> minutes of idling after boot:
>>
>> 408000:245884, 456000:445, 608000:251, 760000:151, 816000:82,
>> 912000:75, 1000000:163  (561)
>>
>> And full cpufreq-info:
>>
>> cpufrequtils 008: cpufreq-info (C) Dominik Brodowski 2004-2009
>> Report errors and bugs to cpufreq@vger.kernel.org, please.
>> analyzing CPU 0:
>>     driver: tegra
>>     CPUs which run at the same hardware frequency: 0 1 2 3
>>     CPUs which need to have their frequency coordinated by software: 0
>> 1 2 3
>>     maximum transition latency: 50.0 us.
>>     hardware limits: 408 MHz - 1000 MHz
>>     available frequency steps: 408 MHz, 456 MHz, 608 MHz, 760 MHz, 816
>> MHz, 912 MHz, 1000 MHz
>>     available cpufreq governors: conservative, userspace, powersave,
>> ondemand, performance, schedutil
>>     current policy: frequency should be within 408 MHz and 1000 MHz.
>>                     The governor "ondemand" may decide which speed to
>> use
>>                     within this range.
>>     current CPU frequency is 608 MHz (asserted by call to hardware).
>>     cpufreq stats: 408 MHz:99.53%, 456 MHz:0.18%, 608 MHz:0.10%, 760
>> MHz:0.06%, 816 MHz:0.03%, 912 MHz:0.03%, 1000 MHz:0.07%  (563)
>> analyzing CPU 1:
>>     driver: tegra
>>     CPUs which run at the same hardware frequency: 0 1 2 3
>>     CPUs which need to have their frequency coordinated by software: 0
>> 1 2 3
>>     maximum transition latency: 50.0 us.
>>     hardware limits: 408 MHz - 1000 MHz
>>     available frequency steps: 408 MHz, 456 MHz, 608 MHz, 760 MHz, 816
>> MHz, 912 MHz, 1000 MHz
>>     available cpufreq governors: conservative, userspace, powersave,
>> ondemand, performance, schedutil
>>     current policy: frequency should be within 408 MHz and 1000 MHz.
>>                     The governor "ondemand" may decide which speed to
>> use
>>                     within this range.
>>     current CPU frequency is 608 MHz (asserted by call to hardware).
>>     cpufreq stats: 408 MHz:99.53%, 456 MHz:0.18%, 608 MHz:0.10%, 760
>> MHz:0.06%, 816 MHz:0.03%, 912 MHz:0.03%, 1000 MHz:0.07%  (563)
>> analyzing CPU 2:
>>     driver: tegra
>>     CPUs which run at the same hardware frequency: 0 1 2 3
>>     CPUs which need to have their frequency coordinated by software: 0
>> 1 2 3
>>     maximum transition latency: 50.0 us.
>>     hardware limits: 408 MHz - 1000 MHz
>>     available frequency steps: 408 MHz, 456 MHz, 608 MHz, 760 MHz, 816
>> MHz, 912 MHz, 1000 MHz
>>     available cpufreq governors: conservative, userspace, powersave,
>> ondemand, performance, schedutil
>>     current policy: frequency should be within 408 MHz and 1000 MHz.
>>                     The governor "ondemand" may decide which speed to
>> use
>>                     within this range.
>>     current CPU frequency is 608 MHz (asserted by call to hardware).
>>     cpufreq stats: 408 MHz:99.53%, 456 MHz:0.18%, 608 MHz:0.10%, 760
>> MHz:0.06%, 816 MHz:0.03%, 912 MHz:0.03%, 1000 MHz:0.07%  (563)
>> analyzing CPU 3:
>>     driver: tegra
>>     CPUs which run at the same hardware frequency: 0 1 2 3
>>     CPUs which need to have their frequency coordinated by software: 0
>> 1 2 3
>>     maximum transition latency: 50.0 us.
>>     hardware limits: 408 MHz - 1000 MHz
>>     available frequency steps: 408 MHz, 456 MHz, 608 MHz, 760 MHz, 816
>> MHz, 912 MHz, 1000 MHz
>>     available cpufreq governors: conservative, userspace, powersave,
>> ondemand, performance, schedutil
>>     current policy: frequency should be within 408 MHz and 1000 MHz.
>>                     The governor "ondemand" may decide which speed to
>> use
>>                     within this range.
>>     current CPU frequency is 608 MHz (asserted by call to hardware).
>>     cpufreq stats: 408 MHz:99.53%, 456 MHz:0.18%, 608 MHz:0.10%, 760
>> MHz:0.06%, 816 MHz:0.03%, 912 MHz:0.03%, 1000 MHz:0.07%  (563)
>>
>>
>>> - Unfortunately "cpufreq-info --stats" currently does not seem to
>>> output anything. Would that require something special to be
>>> implemented?
>>
>> Make sure that CONFIG_CPU_FREQ_STAT is enabled in the kernels config.
> 
> Yes, sorry. That was it, of course. Just wondering why that one isn't
> enabled in tegra_defconfig...

That option isn't essential for the kernel, though usually such useful and 
low-overhead features are welcome. IIRC, tegra_defconfig misses more important 
options (like namespaces) that are required by Linux distro's to work properly.

>>> Other than that you may add the following to the whole series:
>>>
>>> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>
>> Thank you very much!
> 
> You are very welcome. Thank you!
> 
