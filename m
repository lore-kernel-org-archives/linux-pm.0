From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 01/16] PM / OPP: Add 'supply-names' binding
Date: Tue, 1 Mar 2016 09:09:02 -0600
Message-ID: <56D5B08E.1080201@ti.com>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
 <2b87b162eabd1570ae2311e1ef8655acda72f678.1441972771.git.viresh.kumar@linaro.org>
 <55F72C97.2030306@kernel.org>
 <CAKohpo=fcab=eisbwMw=wvbmuXVY5iw_CSe3QK1Ax_i-56JAzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60594 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964AbcCAPJN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 10:09:13 -0500
In-Reply-To: <CAKohpo=fcab=eisbwMw=wvbmuXVY5iw_CSe3QK1Ax_i-56JAzA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Dave Gerlach <d-gerlach@ti.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <rob.herring@linaro.org>, Mark Brown <broonie@kernel.org>

On 03/01/2016 12:45 AM, Viresh Kumar wrote:
> [Removed few people and LKML from CC as its not really about DT
> change anymore but OPP]
> 
> Hi Guys,
> 
> On 15 September 2015 at 01:52, Rob Herring <robh@kernel.org> wrote:
> 
>> Remind me of when do we have multiple regulators for a cpu? The number
>> of supplies should be defined by the cpu binding as function of how many
>> supply rails a cpu has.
> 
> This thread died long back and we never worked out support for multiple
> regulators into the OPP core.
> 
> But, Dave and Nishanth (from TI) pinged me last week about it. According
> to them, their platform has got two regulators for the CPU device and they
> want OPP layer to have this support.
> 
> I was expecting them to reignite this thread, but don't know what happened.

Thanks a ton viresh bringing this back up again.

> 
> And so, I am starting it here.
> 
> @Dave/Nishanth: Can you please explain the use-case here please? So
> that we can get convinced that you really need OPP-core to support multiple
> regulators..
> 

For controlling leakage and switching frequency of the transistors,
traditional controls are usually around the voltage rail alone. This is
not entirely accurate. many SoC vendors including TI [1] and others[2]
use Body Biasing to control leakage. in fact this is already modeled as
a regulator for controlling the SoC internal LDO for TI devices in Linux
kernel (drivers/regulator/ti-abb-regulator.c).


What this means is something as simple as follows:

Typical usage:
    VDD
    ---
     |
     |
     /
   |/
 --|
   |\
     V
     |
     |
    GND


Here we provide voltage optimized for the switching frequency required
for operation.

With Body Biasing: (simplified diagram)
    VDD   VBB (Body Bias)
    ---   ---
     |     |
     |     |
     /     |
   |/      |
 --|   ----/
   |\
     V
     |
     |
    GND


This implies that for an OPP, we have the triplet {frequency, VDD(SMPS
voltage), VBB(Bias voltage) } - Multi regulator is key for all OMAP
generation SoCs since OMAP3 to function for frequencies -> DRA7 for
example mandates ABB for all OPPs.

For some reason, this entire thread slipped out attention :( - Thanks
viresh for bringing it back to focus.


[1] http://www.ti.com/product/DM3730/technicaldocuments including
http://www.ti.com/product/am5728?keyMatch=am5728  (TI) OMAP3, OMAP4,
OMAP5, DRA7, AM57xx SoCs all have this

[2] http://www.techdesignforums.com/practice/guides/dvfs-body-back-bias/
(ST Micro for example)


-- 
Regards,
Nishanth Menon
