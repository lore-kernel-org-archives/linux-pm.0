From: Nishanth Menon <nm@ti.com>
Subject: Re: Extending OPP bindings
Date: Tue, 4 Feb 2014 15:49:23 -0600
Message-ID: <52F16063.6070804@ti.com>
References: <52EA570A.8040501@arm.com> <52EAF1CA.3040702@ti.com> <20140131124620.GC2616@e102568-lin.cambridge.arm.com> <CAL_Jsq+Kq9C39xr9tY8gSX+6QFkNDqwmTyC+dBhLNcxKMweCpw@mail.gmail.com> <20140131180929.GH2616@e102568-lin.cambridge.arm.com> <52F12AE7.904@ti.com> <20140204182220.GQ22609@sirena.org.uk> <52F13F54.5060000@ti.com> <20140204201122.GB22609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58884 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932169AbaBDVuJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 4 Feb 2014 16:50:09 -0500
In-Reply-To: <20140204201122.GB22609@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robherring2@gmail.com>, Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "mturquette@linaro.org" <mturquette@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@ti.com>, Rob Herring <robh+dt@kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>

On 02/04/2014 02:11 PM, Mark Brown wrote:
> On Tue, Feb 04, 2014 at 01:28:20PM -0600, Nishanth Menon wrote:
>> On 02/04/2014 12:22 PM, Mark Brown wrote:
> 
>>> You're assuming that the frequency is a unique key here.  That may not
>>> be the case, for example two OPPs might have the same CPU clock
>>> (assuming that's the frequency you're referring to) but different bus
>>> clocking and of course the CPUs or CPU clusters might be individually
>>> scalable (this is common in big.LITTLE designs I think).
> 
>> Which is why OPPs are maintained per device, bus OPPs belong to bus
>> device (in TI terminology, we'd be talking of cross domain dependency
>> here for maintaining asynchronous bridge timing closure constraints -
>> but ofcourse, other SoCs may or maynot have such constraints). For
>> scaling bus frequency, we already have infrastructure in place - clock
>> notifiers - discussion of using that is much deeper topic of it's own.
> 
>> for each processor that is uniquely transitioning, we'd have it's own
>> sets of OPPs - the correct representation of the device node is the
>> key there.
> 
> I've seen some SoCs characterised over the whole device rather than with
> individual parts of the SoC done separately.
> 
Fair enough - however, the data characterized will imply individual
processor/bus specific tuples/parameters - the specific parameters
might be very unique for SoC, but we have ability to abstract it per
SoC already.

-- 
Regards,
Nishanth Menon
