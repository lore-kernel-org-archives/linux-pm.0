From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [PATCH 0/2] PM / OPP: updates to enable sharing OPPs info
Date: Mon, 22 Jul 2013 13:56:34 +0100
Message-ID: <51ED2C02.3040202@arm.com>
References: <1367406679-21603-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <519B45C3.8050700@arm.com> <20130720050943.5EB853E169C@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:41726 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab3GVM4V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2013 08:56:21 -0400
In-Reply-To: <20130720050943.5EB853E169C@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: Sudeep.KarkadaNagesha@arm.com, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Landley <rob@landley.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Shawn Guo <shawn.guo@linaro.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, mturquette@linaro.org


On 20/07/13 06:09, Grant Likely wrote:
> On Tue, 21 May 2013 11:00:35 +0100, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com> wrote:
>> Hi Rob, Grant,
>>
>> On 01/05/13 12:11, Sudeep KarkadaNagesha wrote:
>>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>>
>>> These are couple of updates to existing PM/OPP library to support
>>> sharing of OPPs between different device nodes.
>>>
>>> Currently all the cpu nodes are parsed until the OPPs are found. This
>>> is essential to support cpuhotplug without having to replicate OPP
>>> information in all the cpu nodes.
>>>
>>> However in systems with multiple cpu power domain, its better to have
>>> OPP entry for each cpu. To avoid replication, phandle can be specified
>>> to the node which contains the full OPP information.
>>>
>> Is proposed option of phandle for OPP acceptable to avoid replication ?
>> Any suggestions to proceed on this ? This is needed to support CPU
>> hotplug on big LITTLE system where current methods like parsing all the
>> nodes or just CPU0 node will not work.
> 
> Looks fine to me.
Hi Grant,

Thanks for the response.

However I had a thought after seeing recent patch series by Mike[1]
Since the OPPs are usually associated with clocks, and multiple devices
sharing clocks will point to same clock node in DT, clk node is more
logical place to specify the OPPs. IMO this will be good alignment for
the consolidation effort by Mike. One issue with this approach is
backward compatibility(using old DT)

Regards,
Sudeep

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/182231.html

