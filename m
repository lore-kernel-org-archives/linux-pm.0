From: skannan@codeaurora.org
Subject: Re: [PATCH v3 1/2] PM / devfreq: Generic CPU frequency to device
 frequency mapping governor
Date: Tue, 07 Aug 2018 12:37:07 -0700
Message-ID: <496ac47a3c78f37655b60841fba7494c@codeaurora.org>
References: <1533171465-25508-1-git-send-email-skannan@codeaurora.org>
 <20180807164114.GA12587@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180807164114.GA12587@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Mark Rutland <mark.rutland@arm.com>, georgi.djakov@linaro.org, vincent.guittot@linaro.org, daidavid1@codeaurora.org, bjorn.andersson@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2018-08-07 09:41, Rob Herring wrote:
> On Wed, Aug 01, 2018 at 05:57:41PM -0700, Saravana Kannan wrote:
>> Many CPU architectures have caches that can scale independent of the 
>> CPUs.
>> Frequency scaling of the caches is necessary to make sure the cache is 
>> not
>> a performance bottleneck that leads to poor performance and power. The 
>> same
>> idea applies for RAM/DDR.
>> 
>> To achieve this, this patch adds a generic devfreq governor that takes 
>> the
>> current frequency of each CPU frequency domain and then adjusts the
>> frequency of the cache (or any devfreq device) based on the frequency 
>> of
>> the CPUs. It listens to CPU frequency transition notifiers to keep 
>> itself
>> up to date on the current CPU frequency.
>> 
>> To decide the frequency of the device, the governor does one of the
>> following:
>> 
>> * Uses a CPU frequency to device frequency mapping table
>>   - Either one mapping table used for all CPU freq policies (typically 
>> used
>>     for system with homogeneous cores/clusters that have the same 
>> OPPs).
>>   - One mapping table per CPU freq policy (typically used for ASMP 
>> systems
>>     with heterogeneous CPUs with different OPPs)
>> 
>> OR
>> 
>> * Scales the device frequency in proportion to the CPU frequency. So, 
>> if
>>   the CPUs are running at their max frequency, the device runs at its 
>> max
>>   frequency.  If the CPUs are running at their min frequency, the 
>> device
>>   runs at its min frequency. And interpolated for frequencies in 
>> between.
>> 
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> ---
>>  .../bindings/devfreq/devfreq-cpufreq-map.txt       |  53 ++
> 
> Bindings should be a separate patch.
> 
>>  drivers/devfreq/Kconfig                            |   8 +
>>  drivers/devfreq/Makefile                           |   1 +
>>  drivers/devfreq/governor_cpufreq_map.c             | 583 
>> +++++++++++++++++++++
>>  4 files changed, 645 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
>>  create mode 100644 drivers/devfreq/governor_cpufreq_map.c
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt 
>> b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
>> new file mode 100644
>> index 0000000..982a30b
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
>> @@ -0,0 +1,53 @@
>> +Devfreq CPUfreq governor
>> +
>> +devfreq-cpufreq-map is a parent device that contains one or more 
>> child devices.
>> +Each child device provides CPU frequency to device frequency mapping 
>> for a
>> +specific device. Examples of devices that could use this are: DDR, 
>> cache and
>> +CCI.
>> +
>> +Parent device name shall be "devfreq-cpufreq-map".
>> +
>> +Required child device properties:
>> +- cpu-to-dev-map, or cpu-to-dev-map-<X>:
>> +			A list of tuples where each tuple consists of a
>> +			CPU frequency (KHz) and the corresponding device
>> +			frequency. CPU frequencies not listed in the table
>> +			will use the device frequency that corresponds to the
>> +			next rounded up CPU frequency.
>> +			Use "cpu-to-dev-map" if all CPUs in the system should
>> +			share same mapping.
>> +			Use cpu-to-dev-map-<cpuid> to describe different
>> +			mappings for different CPUs. The property should be
>> +			listed only for the first CPU if multiple CPUs are
>> +			synchronous.
>> +- target-dev:		Phandle to device that this mapping applies to.
>> +
>> +Example:
>> +	devfreq-cpufreq-map {
>> +		cpubw-cpufreq {
>> +			target-dev = <&cpubw>;
>> +			cpu-to-dev-map =
>> +				<  300000  1144000 >,
>> +				<  422400  2288000 >,
>> +				<  652800  3051000 >,
>> +				<  883200  5996000 >,
>> +				< 1190400  8056000 >,
>> +				< 1497600 10101000 >,
>> +				< 1728000 12145000 >,
>> +				< 2649600 16250000 >;
> 
> Now we have frequencies listed in multiple places, the OPP tables and
> here? Perhaps it is grouping OPPs that should be done.

This doesn't list all OPPs (it can if necessary). This is listing the 
minimum frequency needed to give good performance/power for a 
device/product.

AFAIK, OPP grouping isn't something that's supported in OPP framework or 
in DT. Is there something specific you had in mind? Also, I'd like for 
this to work even with devices that don't have OPPs listed in DT.

Thanks,
Saravana
