From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: cpufreq: Add binding for NVIDIA
 Tegra20/30
Date: Wed, 26 Sep 2018 00:57:57 +0300
Message-ID: <2f060ecc-44a2-9a8f-459e-5ae21990b65e@gmail.com>
References: <20180830194356.14059-1-digetx@gmail.com>
 <20180830194356.14059-2-digetx@gmail.com> <20180925165810.GA32430@bogus>
 <074a169d-294b-ad4b-ddbd-6db742278f2a@gmail.com>
 <CAL_JsqLf+_Q8ZQAo=k8yQ4XKMccUHpm8WsQ3z_Q-PMY6gbQbbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLf+_Q8ZQAo=k8yQ4XKMccUHpm8WsQ3z_Q-PMY6gbQbbA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 9/25/18 10:36 PM, Rob Herring wrote:
> On Tue, Sep 25, 2018 at 12:29 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> On 9/25/18 7:58 PM, Rob Herring wrote:
>>> On Thu, Aug 30, 2018 at 10:43:52PM +0300, Dmitry Osipenko wrote:
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
>>> The Cortex A9 has CLK, PERIPHCLK, and PERIPHCLKEN clocks and only CLK
>>> is used for the cpu core. You can't just define your own clocks that
>>> you happen to want access to.
>>>
>>> Otherwise, you're not defining anything new here, so a binding document
>>> isn't required.
>>
>> PERIPHCLK is a different thing.
> 
> Right, that's what I meant. Only CLK is used.
> 
>> Here we are defining the CPU clock and
>> its *parent* sources, the PLLX (main) and backup (intermediate clock
>> that is used while PLLX changes its rate). These are not some random
>> clocks "that you happen to want access to", they are essential for the
>> Tegra CPUFreq driver, CPU is running off them.
> 
> assigned-clocks is generally how we get parent clocks in this
> situation. "clocks" is for what physical clocks are attached to a
> given block. ARM very clearly documents the clocks for their IP
> blocks.

Okay, seems I see now what you're meaning. The PLLX is specifically
dedicated to CPU HW on Tegra, so it shouldn't be questioning to put it
within the CPU node, unlike the backup.

The assigned-clocks are about static clocks configuration, that is
exactly opposite to what is needed. I'm not sure what you are trying to
convey.. we don't need to get the parent clock, but set it.

How the backup/intermediate clock should be represented then? It is a
part of HW description which potentially may vary depending on the board
configuration.
