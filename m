From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of another
 node for OPP
Date: Wed, 31 Jul 2013 17:40:28 +0100
Message-ID: <51F93DFC.7070904@arm.com>
References: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1375207217-4433-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <51F80750.8030701@wwwdotorg.org> <51F826A0.2000109@ti.com> <51F8F17B.1020304@arm.com> <51F9234A.6010501@ti.com> <51F92D3B.3070103@arm.com> <51F93303.7010609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51F93303.7010609@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On 31/07/13 16:53, Nishanth Menon wrote:
> On 07/31/2013 10:28 AM, Sudeep KarkadaNagesha wrote:
>> On 31/07/13 15:46, Nishanth Menon wrote:
>>> On 07/31/2013 06:14 AM, Sudeep KarkadaNagesha wrote:
>>>> On 30/07/13 21:48, Nishanth Menon wrote:
>> [...]
>>>>> This should setup stage for many of the work we have been trying to
>>>>> figure out on AM/OMAP and few other processors which has to depend on
>>>>> few sets of OPPs which may not be supported on various platforms.
>>>>>
>>>> I still don't get the point why you would publish some OPP in the DT
>>>> when the hardware which it describes doesn't support it.
>>>>
>>>> This may be already discussed when DT support was added to OPP library,
>>>> IMO if for some reason the firmware/boot entity disables some of the
>>>> OPPs, then it can append OPPs in DT with the state(enabled/disabled).
>>>> But this needs extension of current binding.
>>>
>>> you could also have reduced OPP set which needs to be invoked, appending
>>> wont really work if cpufreq table is built as part of probe - it kind of
>>> creates all kind of races which I would really like to avoid.
>>>
>> IIUC opp_set_availability(opp_enable/opp_disable) is designed for such
>> use-case ? Currently there are no users of this API but I see it fits
>> your use case.
>>
>> Even with multiple OPP sets listed in DT as you described, you need to
>> read those fuses and chose the right set of OPPs. Instead you can use
>> opp_en(/dis)able methods to do that ?
>>
> yes when the efuse data is present, but look at the other case I had 
> also pointed at:
> 
> Lets take an example: SoC X has OPPs 1,2,3,4
> 
> Same SoC is used on Board A and B.
> Board A meets with all SoC vendor requirements for routing, IR drop 
> limits etc
> Board B *does not* meet with all SoC vendor requirements for routing, IR 
> drop limits etc
> 
> we no longer have board files, board will have to have a mechanism to 
> "state it is not optimal configuration".
> 
But we still have DTS per board(I assume each board will at-least
different in IRQ/GPIO assignments or even different pin-mux configuration)

> A real life example is BeagleBoard Xm and another product board(which I 
> cannot mention) -both use OMAP3630 1GHz part. 1GHz requirements are met 
> on BeagleBoard Xm, but on the product board it is not. Chip used is 
> exactly the same, we dont have "dts property" to mention "yes, this 
> board meets SoC data manual and associated documentation requirement" - 
> instead what we do have is what is the chip capable of doing.
> 
If SoC gives configuration w.r.t OPPs, then its board property like
pin-mux. Why is it not possible to have 1GHz only in BeagleBoard Xm and
not in product board X ?

> opp_enable/disable wont work here unless there is board specific 
> "properties" we introduce. However, board file could choose "low 
> performance" option of OPPs.
> 
Again board file choice of selecting OPPs is policy and DT must describe
all the features board supports.

> the opp_enable/disable wont scale there. Further, opp_add is done 
> enmasse by cpufreq-cpu0 and and cpufreq table is built off it, there is 
> no option of SoC specific modification to the table (opportunity to do 
> opp_enable/disable) there - not something that cannot be fixed, and 
> eventually will be, but not there right now.
> 
Freescale iMX6 seems to be using it, not use if its SoC level or board
level.(imx6q_opp_check_1p2ghz in arch/arm/mach-imx/mach-imx6q.c)


I just had a look @arch/arm/boot/dts/omap36xx.dtsi and
omap3-beagle-xm.dts. This is my opinion(if you can't handle this
dynamically):

Now you have omap36xx SoC on 2 products X and BeagleBoard Xm.
omap36xx can support up to 1GHz but depends on actual products.
So its better not to publish OPPs in omap36xx.dtsi but leave to product
X and BeagleBoard Xm to describe what that hardware supports.

Regards,
Sudeep




