From: Nishanth Menon <nm@ti.com>
Subject: Re: omap cpufreq driver in multi-platform kernels
Date: Mon, 1 Apr 2013 14:14:36 -0500
Message-ID: <CAGo_u6o5iZF_Bs_vh1vr7qOhX_gJ7nXA3u0FWpRpOZO2J15FJQ@mail.gmail.com>
References: <5152503C.2050503@gmail.com>
	<alpine.DEB.2.00.1303270212110.8161@utopia.booyaka.com>
	<20130327133220.GA30868@kahuna>
	<5153207A.4050109@gmail.com>
	<20130327170221.GA32231@kahuna>
	<87d2uk91ai.fsf@linaro.org>
	<20130327175621.GA32693@kahuna>
	<alpine.DEB.2.00.1303302156180.6436@utopia.booyaka.com>
	<5159C1FA.8090000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5159C1FA.8090000@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Mark Langsdorf <mark.langsdorf@calxeda.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

+cpufreq list as it seems most appropriate discussion forum.

discussion thread: http://marc.info/?t=136434901900001&r=1&w=2

On Mon, Apr 1, 2013 at 12:20 PM, Eduardo Valentin
<eduardo.valentin@ti.com> wrote:
> Hey Paul,
>
>
> On 30-03-2013 18:21, Paul Walmsley wrote:
>>
>> Hi folks,
>>
>> On Wed, 27 Mar 2013, Nishanth Menon wrote:
>>
>>> On 10:53-20130327, Kevin Hilman wrote:
>>>>
>>>> Nishanth Menon <nm@ti.com> writes:
>>>>>
>>>>> On 11:38-20130327, Rob Herring wrote:
>>>>>>
>>>>>> On 03/27/2013 08:32 AM, Nishanth Menon wrote:
>>>>>>>
>>>>>>> On 02:23-20130327, Paul Walmsley wrote:
>>>>>>>>
>>>>>>>> On Tue, 26 Mar 2013, Rob Herring wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Converting the driver to a platform driver would be another option.
>>>>
>>>>
>>>> I think the platform_device conversion is the way to go.  I think you
>>>> should do that instead of PATCH 8/8 of your OMAP conversion to the
>>>> generic driver[1].
>>>
>>>
>>> Yep, thinking about this over lunch, I came to the same conclusion that
>>> instead of checking on DT node existance, platform_device conversion
>>> will solve both parts of the puzzle.
>>
>>
>> Looked at this a little today.  I see that the platform_driver CPUFreq
>> driver approach was taken with several SoCs in mainline. Could someone
>> explain the theory behind making the CPUFreq drivers platform_drivers,
>> rather than just modules?
>>
>> The part that doesn't make sense to me is that the existing CPUFreq
>> drivers don't represent an actual hardware block.  Conceptually, they
>> aren't drivers for the CPU, nor are they drivers for a CPU frequency
>> scaling IP block.  One might as well bind a CPUIdle driver or a CPU
>> throttling thermal driver to the CPU device.
>
>
> I do agree with your point. On the other hand, I'd like to make a
> clarification here.
>
> CPU throttling feature not really done as a driver. The feature is exported
> to be used by policies built by other code. Check
> drivers/thermal/cpu_cooling.c.
>
> Thermal drivers are in fact drivers, as they are bound to an actual hardware
> block, a bandgap, a thermal sensor or a thermistor.
>
>
>
>
>>
>> Wouldn't it be best to just make them modules?
>
>
> Thermal policies are built as modules.
>
>
>>
>> Also, noticed that the Highbank CPUFreq driver creates a virtual device in
>> its code.  That also doesn't seem right.  Isn't device creation better
>> left to DT/ACPI/whatever?
>>

Regards,
Nishanth Menon
