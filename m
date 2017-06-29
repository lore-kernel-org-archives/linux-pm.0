From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: Clocks used by another OS/CPU
Date: Thu, 29 Jun 2017 15:18:11 +0200
Message-ID: <b42a6818-4bc1-6556-5adf-c74a205b745b@de.bosch.com>
References: <CAMuHMdW9+CNTTOVO4SRRUxuz3ajLbY2j1uG8b_RpHX52NPwXrQ@mail.gmail.com>
 <b2328038-64ac-f7e0-d8a9-434f2f0b0300@de.bosch.com>
 <CAMuHMdVD3i0YhGCf-HSS+y+4SHvXi9sW3V4-ScQX=7R+DX=kEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVD3i0YhGCf-HSS+y+4SHvXi9sW3V4-ScQX=7R+DX=kEQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@baylibre.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 29.06.2017 13:18, Geert Uytterhoeven wrote:
> Hi Dirk,
> 
> On Thu, Jun 29, 2017 at 12:28 PM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
>> On 29.06.2017 11:27, Geert Uytterhoeven wrote:
>>> CC clock, ARM, DT, PM people
>>>
>>> TL;DR: Clocks may be in use by another CPU not running Linux, while Linux
>>> disables them as being unused.
>>>
>>> On Mon, Jun 26, 2017 at 1:30 PM, Dirk Behme <dirk.behme@de.bosch.com>
>>> wrote:
>>>> With commit 72f5df2c2bbb6 ("clk: renesas: cpg-mssr: Migrate to
>>>> CLK_IS_CRITICAL") we are able to handle critical module clocks.
>>>> Introduce the same logic for critical core clocks.
>>>>
>>>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>>>> ---
>>>> Commit
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/clk/renesas?id=72f5df2c2bbb66d4a555cb51eb9f412abf1af77f
>>>>
>>>> is quite nice to avoid *module* clocks being disabled. Unfortunately,
>>>> there are *core* clocks, too. E.g. using an other OS on the Cortex R7
>>>> core of the r8a7795, the 'canfd' is a quite popular core clock which
>>>> shouldn't be disabled by Linux.
>>>>
>>>> Therefore, this patch is a proposal to use the same 'mark clocks as
>>>> critical' logic implemented for the module clocks for the core
>>>> clocks, too.
>>>>
>>>> Opinions?
>>>
>>> On r8a7795, there are several Cortex A cores running Linux, and a Cortex
>>> R7
>>> core which may run another OS.
>>> This is an interesting issue, and relevant to other SoCs, too.
>>>
>>> In this particular case, the "canfd" clock is a core clock used as an
>>> auxiliary clock for the CAN0, CAN1, and CANFD interfaces.  This can lead
>>> to three scenarios:
>>>     1. Linux controls all CAN interfaces
>>>        => no issue,
>>>     2. The OS on the RT CPU controls all CAN interfaces
>>>        => issue, Linux disables the clock
>>>     3. Mix of 1 and 2
>>>        => More issues.
>>> Of course this is not limited to clocks, but also to e.g. PM domains.
>>>
>>> How can this be handled?
>>> I believe just marking the "canfd" clock critical is not the right
>>> solution,
>>> as about any clock could be used by the RT CPU.
>>>
>>> Still, Linux needs to be made aware that devices (clocks and PM domains)
>>> are
>>> controlled by another CPU/OS.
>>>
>>> Should this be described in DT? It feels like software policy to me.
>>>
>>> Note that we (mainline) currently don't describe the Cortex R7 core in DT.
>>> Dirk: do you describe it?
>>
>> No, we don't describe anything R7 related in DT, too.
>>
>>> Summary:
>>>     1. Core/module clocks are described in the clock driver (not in DT),
>>>     2. Unused clocks are disabled by CCF,
>>>     3. Clocks may be in use by the Real-Time CPU core, running another OS,
>>>     4. How to communicate to Linux which clocks are under control of the RT
>>> CPU?
>>
>>> Thanks for your comments!
>>
>> While I appreciated that the overall issue is discussed, I'm not sure if
>> there is anything really special we don't support generally, yet.
>>
>> We have an infrastructure to mark clocks enabled anywhere else to be not
>> disabled by Linux kernel (CLK_IS_CRITICAL). From my point of view, for this
>> infrastructure, it doesn't matter, where this 'anywhere else' is. To take
>> some concrete Renesas RCar3 examples, from my point of view it doesn't
>> matter if its a GIC-400 clock enabled in the boot loader (U-Boot) or a CAN
>> clock enabled by the R7. In both cases marking them as critical on Linux
>> side does the trick.
> 
> Yes, it does the trick. But is it the proper solution?
> 
>> The issue I just want to address (discuss) with this RFC patch is that for
>> Renesas RCar3 we have CLK_IS_CRITICAL support for module clocks, but not for
>> core clocks. From my point of view, this is a completely Renesas
>> implementation specific discussion.
> 
> Correct. How the Renesas CPG/MSSR driver decides which clocks are marked
> critical is a Renesas-specific implementation issue.
> And indeed, currently the driver only handles critical module clocks
> (more specifically, the GIC module clock, due to the lack of runtime PM
> support in the GIC driver).
> It does not handle critical core clocks, as so far no use case required
> such support.
> 
>> So I would rephrase the initial sentence above
>>
>> "Clocks may be in use by another CPU not running Linux, while Linux disables
>> them as being unused."
>>
>> to anything like
>>
>> "Clocks may be enabled (used) by others (U-Boot/CPUs/Hypervisors), while
>> Linux disables them as being unused"
> 
> If a clock is used by Linux, Linux must make sure it is enabled when
> needed.
> If a clock is needed to run Linux, without driver support, Linux must still
> make sure it is enabled. This is were critical clocks enter the game.
> The above includes CPU clocks.
> 
> If a clock is used by U-Boot, U-Boot must make sure it is enabled when
> needed.  Once U-Boot has transferred control to Linux, this no longer
> matters.
> 
> if a clock is used by a HV, the HV must make sure it is enabled when
> needed. I believe this is handled in secure mode? R-Car Gen3 SoCs already
> have several module clocks that cannot be disabled (i.e. MSTPSRx != OR of
> all yMSTPCRx).
> 
> If a clock is used by the RT CPU, the RT CPU must make sure it is enabled
> when needed.
> There are several options to do that:
>    - Secure mode,
>    - Communicating the clock requirements to Linux, either statically or
>      dynamically,
>    - DT? (but this is software policy?)
>    - ???
> 
>> And I think this is completely addressed by CLK_IS_CRITICAL, as far as I can
>> see :)
> 
> While this is a solution that works (for your use case), IMHO it's not the
> right thing to do.
> However, if we decide to go this route, which other clocks should be marked
> critical? Almost (all?) peripherals can be used by the RT CPU. Hence all
> clocks should be enabled and marked critical, unconditionally?


First of all, just the clocks we know (*) are used by the R7 side *and* 
are disabled by the kernel (for a practical demo this are e.g. ~7 clocks).

(*) Yes, this is board (and R7 software) related. And yes, this might 
result in board specific r8a7795_crit_mod_clks/r8a7795_crit_core_clks[] 
tables. So yes, most probably device tree would be an option. While there is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk.c#n3402

unfortunately

a) its marked as "Do not use this function"

and

b) even if we would ignore (a) we couldn't figure how to use this for 
the RCar3 clocks (being no clock expert)

Best regards

Dirk

