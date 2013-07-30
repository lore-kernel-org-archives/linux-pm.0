From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of another
 node for OPP
Date: Tue, 30 Jul 2013 15:48:32 -0500
Message-ID: <51F826A0.2000109@ti.com>
References: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1375207217-4433-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <51F80750.8030701@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51F80750.8030701@wwwdotorg.org>
Sender: cpufreq-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On 07/30/2013 01:34 PM, Stephen Warren wrote:
> On 07/30/2013 12:00 PM, Sudeep KarkadaNagesha wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> If more than one similar devices share the same OPPs, currently we
>> need to replicate the OPP entries in all the nodes.
>>
>> Few drivers like cpufreq depend on physical cpu0 node to specify the
>> OPPs and only that node is referred irrespective of the logical cpu
>> accessing it. Alternatively to support cpuhotplug path, few drivers
>> parse all the cpu nodes for OPPs. Instead we can specify the phandle
>> of the node with which the current node shares the operating points.
>>
>> This patch adds support to specify the phandle in the operating points
>> of any device node, where the node specified by the phandle holds the
>> actual OPPs.
>
>> diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
>
>> +Optional properties:
>> +- operating-points-phandle: phandle to the device node with which this
>
> That's a funny name. Bikeshedding a bit, how about shared-operating-points?
>
> I haven't thought at all about whether this change conceptually makes sense.
>

They may not really be shared- we could have phandle list even. one 
might have optional OPP sets for a chip family that one may  - I was 
about to suggest something similar to pinctrl

operating-points-names = "default", "performance", "cheapboard-config" ;)
operating-points-0 = <&...>
operating-points-1 = <&...>
operating-points-2 = <&...>

+ wanted also to consider how we might have a single definition to scale 
across to what Mike is attempting to do with a generic clock framework 
support for DVFS.

for compatibility sake, if operating-points is defined, we continue to 
expect old style definition, else we have options to pick from.

This should setup stage for many of the work we have been trying to 
figure out on AM/OMAP and few other processors which has to depend on 
few sets of OPPs which may not be supported on various platforms.

I am hoping our phandle solution could scale to all needed.
-- 
Regards,
Nishanth Menon
