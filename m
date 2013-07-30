From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of another
 node for OPP
Date: Tue, 30 Jul 2013 15:25:03 -0600
Message-ID: <51F82F2F.4080003@wwwdotorg.org>
References: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1375207217-4433-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <51F80750.8030701@wwwdotorg.org> <51F826A0.2000109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:33959 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756852Ab3G3VZH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2013 17:25:07 -0400
In-Reply-To: <51F826A0.2000109@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 07/30/2013 02:48 PM, Nishanth Menon wrote:
> On 07/30/2013 01:34 PM, Stephen Warren wrote:
>> On 07/30/2013 12:00 PM, Sudeep KarkadaNagesha wrote:
>>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>>
>>> If more than one similar devices share the same OPPs, currently we
>>> need to replicate the OPP entries in all the nodes.
>>>
>>> Few drivers like cpufreq depend on physical cpu0 node to specify the
>>> OPPs and only that node is referred irrespective of the logical cpu
>>> accessing it. Alternatively to support cpuhotplug path, few drivers
>>> parse all the cpu nodes for OPPs. Instead we can specify the phandle
>>> of the node with which the current node shares the operating points.
>>>
>>> This patch adds support to specify the phandle in the operating points
>>> of any device node, where the node specified by the phandle holds the
>>> actual OPPs.
>>
>>> diff --git a/Documentation/devicetree/bindings/power/opp.txt
>>> b/Documentation/devicetree/bindings/power/opp.txt
>>
>>> +Optional properties:
>>> +- operating-points-phandle: phandle to the device node with which this
>>
>> That's a funny name. Bikeshedding a bit, how about
>> shared-operating-points?
>>
>> I haven't thought at all about whether this change conceptually makes
>> sense.
>>
> 
> They may not really be shared- we could have phandle list even.

Well, they are shared, or you wouldn't have one node pointing at another
node and hence sharing the same property...

> one
> might have optional OPP sets for a chip family that one may  - I was
> about to suggest something similar to pinctrl
> 
> operating-points-names = "default", "performance", "cheapboard-config" ;)
> operating-points-0 = <&...>
> operating-points-1 = <&...>
> operating-points-2 = <&...>

There is an assertion that DT should only represent the absolute max
limits for things like this, and not policy-oriented data such as
different performance profiles. I don't expect you'll see anything like
the above in DT, since it's more policy than HW description.
