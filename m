From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of another
 node for OPP
Date: Thu, 01 Aug 2013 10:46:35 -0600
Message-ID: <51FA90EB.2070001@wwwdotorg.org>
References: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1375207217-4433-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <51F80750.8030701@wwwdotorg.org> <51F826A0.2000109@ti.com> <51F8F17B.1020304@arm.com> <51F9234A.6010501@ti.com> <51F986D3.4060501@wwwdotorg.org> <20130801121506.GA3048@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:55845 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842Ab3HAQqi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2013 12:46:38 -0400
In-Reply-To: <20130801121506.GA3048@kahuna>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 08/01/2013 06:15 AM, Nishanth Menon wrote:
> On 15:51-20130731, Stephen Warren wrote:
>> On 07/31/2013 08:46 AM, Nishanth Menon wrote:
>> ...
>>> Let me try to explain since SoCs such as OMAP/AM family dont make life
>>> trivial :)..
>>>
>>> An legacy example[1][2]
>>>
>>> SoC DM explains that the chip is capable of X opps:
>>> opp1, 2 - for all devices
>>> opp1,2, 3 - if efuse bit X@y is set
>>> opp1,2,3,4 - if efuse bit X@y is set AND Board design meets SoC vendors
>>> requirements (including additional features A, B is enabled).
>>
>> Hopefully the text "board design meets SoC vendors requirements" means
>> something like "the board has a big fan capable of dissipating a lot of
>> heat" and not "the board manufacturer paid us a lot of money to license
>> the 'go faster' feature". The former could well be suitable to represent
>> in DT, the latter not.
> 
> Nope, these are technical requirements. In my company, these
> guidelines are called Power Distribution Network guideline - which
> control the IRDrop within reasonable limit, running DPLLs are varied
> frequencies have different current draw characteristics, such that noise
> limits, cleanup capacitors etc. For boards that dont care too much about
> higher frequencies, they tend to skimp a little on caps and board
> routing constraints to save on BOM (Bill Of Materials) cost.
> 
> I am sure similar constraints do exist in other SoC vendors as well.

Great, sounds good then.

