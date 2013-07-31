From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of another
 node for OPP
Date: Wed, 31 Jul 2013 10:53:39 -0500
Message-ID: <51F93303.7010609@ti.com>
References: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1375207217-4433-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <51F80750.8030701@wwwdotorg.org> <51F826A0.2000109@ti.com> <51F8F17B.1020304@arm.com> <51F9234A.6010501@ti.com> <51F92D3B.3070103@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51F92D3B.3070103@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On 07/31/2013 10:28 AM, Sudeep KarkadaNagesha wrote:
> On 31/07/13 15:46, Nishanth Menon wrote:
>> On 07/31/2013 06:14 AM, Sudeep KarkadaNagesha wrote:
>>> On 30/07/13 21:48, Nishanth Menon wrote:
> [...]
>>>> This should setup stage for many of the work we have been trying to
>>>> figure out on AM/OMAP and few other processors which has to depend on
>>>> few sets of OPPs which may not be supported on various platforms.
>>>>
>>> I still don't get the point why you would publish some OPP in the DT
>>> when the hardware which it describes doesn't support it.
>>>
>>> This may be already discussed when DT support was added to OPP library,
>>> IMO if for some reason the firmware/boot entity disables some of the
>>> OPPs, then it can append OPPs in DT with the state(enabled/disabled).
>>> But this needs extension of current binding.
>>
>> you could also have reduced OPP set which needs to be invoked, appending
>> wont really work if cpufreq table is built as part of probe - it kind of
>> creates all kind of races which I would really like to avoid.
>>
> IIUC opp_set_availability(opp_enable/opp_disable) is designed for such
> use-case ? Currently there are no users of this API but I see it fits
> your use case.
>
> Even with multiple OPP sets listed in DT as you described, you need to
> read those fuses and chose the right set of OPPs. Instead you can use
> opp_en(/dis)able methods to do that ?
>
yes when the efuse data is present, but look at the other case I had 
also pointed at:

Lets take an example: SoC X has OPPs 1,2,3,4

Same SoC is used on Board A and B.
Board A meets with all SoC vendor requirements for routing, IR drop 
limits etc
Board B *does not* meet with all SoC vendor requirements for routing, IR 
drop limits etc

we no longer have board files, board will have to have a mechanism to 
"state it is not optimal configuration".

A real life example is BeagleBoard Xm and another product board(which I 
cannot mention) -both use OMAP3630 1GHz part. 1GHz requirements are met 
on BeagleBoard Xm, but on the product board it is not. Chip used is 
exactly the same, we dont have "dts property" to mention "yes, this 
board meets SoC data manual and associated documentation requirement" - 
instead what we do have is what is the chip capable of doing.

opp_enable/disable wont work here unless there is board specific 
"properties" we introduce. However, board file could choose "low 
performance" option of OPPs.

the opp_enable/disable wont scale there. Further, opp_add is done 
enmasse by cpufreq-cpu0 and and cpufreq table is built off it, there is 
no option of SoC specific modification to the table (opportunity to do 
opp_enable/disable) there - not something that cannot be fixed, and 
eventually will be, but not there right now.

-- 
Regards,
Nishanth Menon
