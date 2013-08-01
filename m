From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of another
 node for OPP
Date: Thu, 01 Aug 2013 10:49:01 -0600
Message-ID: <51FA917D.4060408@wwwdotorg.org>
References: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1375207217-4433-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <51F80750.8030701@wwwdotorg.org> <51F826A0.2000109@ti.com> <51F8F17B.1020304@arm.com> <51F9234A.6010501@ti.com> <20130731152925.GP29859@e106331-lin.cambridge.arm.com> <51F9341E.60102@ti.com> <20130731161103.GS29859@e106331-lin.cambridge.arm.com> <51F93AFB.1030104@ti.com> <20130801135422.GA8095@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:48149 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842Ab3HAQtE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2013 12:49:04 -0400
In-Reply-To: <20130801135422.GA8095@e106331-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Nishanth Menon <nm@ti.com>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 08/01/2013 07:54 AM, Mark Rutland wrote:
...
> We seem to be going over two cases, which both feel wrong to me:
> 
> * One SoC used in multiple boards, where on some boards an OPP cannot be
>   used because some requirement is not met. In this case, the board's
>   dts (by including the SoC's dtsi) describes something that's not
>   necessarily usable, and we seem to have no way to describe in the OPP
>   table that the OPP is not usable for that board.

There are probably a lot of examples of this already. For example, for
pinctrl, people often want the SoC .dtsi file to include "pin
configuration nodes" (see
Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt) for many
common pinmux configurations in the SoC .dtsi file, so that board files
can simply refer to the already-existing nodes rather than having to
write everything from scratch. Obviously, not all common configurations
are used by every board.

...
>> Are you suggesting we have OPP tables per board?
> 
> Yes, for the reasons I give above. Common OPP tabless can easily be
> factored into separate include files to allow for arbitrary composition.

Using separate include files sounds like a reasonable idea.
