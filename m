From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of another
 node for OPP
Date: Wed, 31 Jul 2013 15:59:50 -0600
Message-ID: <51F988D6.6090104@wwwdotorg.org>
References: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1375207217-4433-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <51F80750.8030701@wwwdotorg.org> <51F826A0.2000109@ti.com> <51F8F17B.1020304@arm.com> <51F9234A.6010501@ti.com> <20130731152925.GP29859@e106331-lin.cambridge.arm.com> <51F9341E.60102@ti.com> <20130731161103.GS29859@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:50651 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756705Ab3GaV7y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2013 17:59:54 -0400
In-Reply-To: <20130731161103.GS29859@e106331-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Nishanth Menon <nm@ti.com>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 07/31/2013 10:11 AM, Mark Rutland wrote:
> On Wed, Jul 31, 2013 at 04:58:22PM +0100, Nishanth Menon wrote:
>> On 07/31/2013 10:29 AM, Mark Rutland wrote:
>>> On Wed, Jul 31, 2013 at 03:46:34PM +0100, Nishanth Menon wrote:
...
>>>> Let me try to explain since SoCs such as OMAP/AM family dont make life
>>>> trivial :)..
>>>>
>>>> An legacy example[1][2]
>>>>
>>>> SoC DM explains that the chip is capable of X opps:
>>>> opp1, 2 - for all devices
>>>> opp1,2, 3 - if efuse bit X@y is set
>>>> opp1,2,3,4 - if efuse bit X@y is set AND Board design meets SoC vendors
>>>> requirements (including additional features A, B is enabled).
>>>>
>>>> So, the same chip family has a hardware feature - not just as a pm
>>>> policy of selecting among a set of OPPs which opp to work on, but the
>>>> actual set of OPPs are actually options in themselves that is selected
>>>> based on board's SoC selection.
>>>
>>> This sounds like we're describing a set of features not applicable to
>>> the device, then removing them, rather than only describing those
>>> features applicable to the device. If you have to probe to figure out
>>> which values in the dt are applicable, I'm not sure I see the benefit of
>>> describing said values in dt.
>>
>> Device has *options* of operating points sets it can operate at. It is 
>> not like "these are not applicable" for the device.
> 
> I don't follow.
> 
> In the example above, if efuse bit X@y is not set, opp3 is not
> applicable, but we're describing it in dt. It's not an option for the
> particular device, yet it appears in the device's dt.
> 
> For opp4, it's even worse, as you're suggesting we describe an option
> for the device that requires the driver to use some additional platform
> knowledge to come to the conclusion that it cannot use. That sounds like
> device knowledge internal to a driver, not how you describe an instance
> of a device to an OS.
> 
> Have I misunderstood something here?

>From the kernel's perspective here, a simple approach would be to say
the the DT passed to the kernel must contain exactly the set of OPPs
that the kernel should use. If this requires probing HW (fuses, board
knowledge, etc.), then the bootloader/... must do that and fix up the DT
to correctly represent the board at boot time (or choose the correct DT
from a set of options in flash) or whoever flashed the board must have
simply put the correct DT onto the board.

Of course, that simply pushes back the issue onto the flashing utility
or bootloader. Perhaps pushing stuff back there isn't a good holistic
solution, since we only get a clean kernel by making life suck for
someone else, and we'd perhaps better optimize the entire SW stack.
