From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: cpufreq: Add binding for NVIDIA
 Tegra20/30
Date: Wed, 17 Oct 2018 16:07:10 +0300
Message-ID: <a0dd5d75-6683-f938-c5e5-a95a5c2b86e4@gmail.com>
References: <20180830194356.14059-1-digetx@gmail.com>
 <20180830194356.14059-2-digetx@gmail.com>
 <f38b38f1-0a60-d6fa-9047-23c619494b23@nvidia.com>
 <1448e619-35c9-0195-c68a-604d10f4dc8b@gmail.com>
 <a9b6e683-3802-896c-27ad-9c49853c231f@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a9b6e683-3802-896c-27ad-9c49853c231f@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/17/18 3:59 PM, Jon Hunter wrote:
> 
> On 17/10/2018 13:37, Dmitry Osipenko wrote:
>> On 10/17/18 11:40 AM, Jon Hunter wrote:
>>>
>>> On 30/08/2018 20:43, Dmitry Osipenko wrote:
>>>> Add device-tree binding that describes CPU frequency-scaling hardware
>>>> found on NVIDIA Tegra20/30 SoC's.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  .../cpufreq/nvidia,tegra20-cpufreq.txt        | 38 +++++++++++++++++++
>>>>  1 file changed, 38 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>>> new file mode 100644
>>>> index 000000000000..2c51f676e958
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>>>> @@ -0,0 +1,38 @@
>>>> +Binding for NVIDIA Tegra20 CPUFreq
>>>> +==================================
>>>> +
>>>> +Required properties:
>>>> +- clocks: Must contain an entry for each entry in clock-names.
>>>> +  See ../clocks/clock-bindings.txt for details.
>>>> +- clock-names: Must include the following entries:
>>>> +  - pll_x: main-parent for CPU clock, must be the first entry
>>>> +  - backup: intermediate-parent for CPU clock
>>>> +  - cpu: the CPU clock
>>>
>>> Is it likely that 'backup' will be anything other that pll_p? If not why
>>> not just call it pll_p? Personally, I don't 'backup' to descriptive even
>>> though I can see what you mean.
>>>
>>> I can see that you want to make this flexible, but if the likelihood is
>>> that we will just use pll_p then I am not sure it is warranted at this
>>> point.
>>
>> That won't describe HW, but software. And device tree should describe HW.
> 
> Hmm ... well that's my point exactly. So why call it 'backup'? Sounds
> like a software description to me.

Because HW is designed the way that CPU parent need to be switched to the backup clock source while main clock changes its rate. HW also allow to select among different parents, pll_p is one of those parents.

I think cpufreq-mediatek has a similar description, see Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
