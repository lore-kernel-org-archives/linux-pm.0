From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of another
 node for OPP
Date: Fri, 02 Aug 2013 14:43:36 +0100
Message-ID: <51FBB788.7040209@arm.com>
References: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1375207217-4433-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <51F80750.8030701@wwwdotorg.org> <51F826A0.2000109@ti.com> <51F8F17B.1020304@arm.com> <51F9234A.6010501@ti.com> <20130731152925.GP29859@e106331-lin.cambridge.arm.com> <51F9341E.60102@ti.com> <20130731161103.GS29859@e106331-lin.cambridge.arm.com> <51F93AFB.1030104@ti.com> <20130801135422.GA8095@e106331-lin.cambridge.arm.com> <51FA917D.4060408@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:46792 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab3HBNnl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Aug 2013 09:43:41 -0400
In-Reply-To: <51FA917D.4060408@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Nishanth Menon <nm@ti.com>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 01/08/13 17:49, Stephen Warren wrote:
> On 08/01/2013 07:54 AM, Mark Rutland wrote:
> ...
>> We seem to be going over two cases, which both feel wrong to me:
>>
>> * One SoC used in multiple boards, where on some boards an OPP cannot be
>>   used because some requirement is not met. In this case, the board's
>>   dts (by including the SoC's dtsi) describes something that's not
>>   necessarily usable, and we seem to have no way to describe in the OPP
>>   table that the OPP is not usable for that board.
> 
> There are probably a lot of examples of this already. For example, for
> pinctrl, people often want the SoC .dtsi file to include "pin
> configuration nodes" (see
> Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt) for many
> common pinmux configurations in the SoC .dtsi file, so that board files
> can simply refer to the already-existing nodes rather than having to
> write everything from scratch. Obviously, not all common configurations
> are used by every board.
> 
> ...
Agreed, but I am not convinced with the comparison(pinmux and OPPs).
The main concern I have is that if some developer wants to experiment
with various configurations provided by SoC(e.g. I have seen some SoC
where the pinmux have multiple functions and you can chose one of them)
But that's not true with OPPs, if someone experiments with wrong OPP
profile, then it might damage the board permanently.

Regards,
Sudeep

