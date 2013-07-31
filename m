From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of another
 node for OPP
Date: Wed, 31 Jul 2013 11:46:01 +0100
Message-ID: <51F8EAE9.8080309@arm.com>
References: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1375207217-4433-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <51F80750.8030701@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51F80750.8030701@wwwdotorg.org>
Sender: cpufreq-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

On 30/07/13 19:34, Stephen Warren wrote:
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

shared-operating-points makes sense, but I was thinking that name should
indicate it's reference to the device that it shares OPP with. I agree
'operating-points-phandle' is no good, is 'shared-opp-device' any better ?

Regards,
Sudeep


