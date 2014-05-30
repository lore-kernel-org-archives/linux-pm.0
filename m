From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC 2/2] PM / OPP: extend DT parsing to allow voltage ranges
Date: Thu, 29 May 2014 19:06:03 -0500
Message-ID: <5387CB6B.2080100@ti.com>
References: <1400598429.4853.29.camel@weser.hi.pengutronix.de> <CAGo_u6ru5OgwCbJRrMNXUzeNLFMUvW=j8su6AAC4vmy3GOSM2g@mail.gmail.com> <CAGo_u6omOyuXvpDcirm36AnreGfa4nxisQ8BqZ8p2AVmWjfwbA@mail.gmail.com> <1400600908.4853.41.camel@weser.hi.pengutronix.de> <CAGo_u6pyU1O0uv-3CJc6OPoJ+bkcpNJ9_26JL3DxugX7dJhZfA@mail.gmail.com> <1400604324.4853.51.camel@weser.hi.pengutronix.de> <CAGo_u6ofuas-HBkAaKAUmKoOxjfWOpa7gmenS6Lspk9gWNt5cw@mail.gmail.com> <1400665634.5926.18.camel@weser.hi.pengutronix.de> <20140521233302.GA12304@sirena.org.uk> <1400754298.4913.15.camel@weser.hi.pengutronix.de> <20140522175846.GO12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45169 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753789AbaE3AGY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 29 May 2014 20:06:24 -0400
In-Reply-To: <20140522175846.GO12304@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Lucas Stach <l.stach@pengutronix.de>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawn.guo@linaro.org>

On 05/22/2014 12:58 PM, Mark Brown wrote:
> On Thu, May 22, 2014 at 12:24:58PM +0200, Lucas Stach wrote:
> 
>> This shifts things from a change to the OPP framework to a change to the
>> regulator framework, as I would like to add this property to the device
>> supply definition. Patches upcoming.
> 
> In the regulator framework this seems completely redundant - we already
> have the maximum voltage specifiable, it's hard to see a case where
> you'd want a maximum that wasn't the maximum for the board.  I'd expect
> the cpufreq code to just read the existing property.
> 
> This disadvantage of doing this without any explicit configuration on
> the cpufreq side is that it means we start ignoring the OPP constraints
> of CPUs that aren't specified to allow that.  Perhaps we don't care
> though.
> 
>> I would really like to have a clear absolute maximum per device, as this
>> would allow me to infer the voltage tolerance of the device from the
>> difference between the highest OPP and maximum voltage.
> 
> I don't think this is a good way of specifying this information.  I
> think if we want to start paying attention to the tolerances in that way
> (which we really ought to do) we should be actually teaching the
> framework about them - for example have the regulator driver able to
> specify the regulation accuracy so set_voltage() can guarantee that the
> constraint is met and probably also have a way of specifying tolerances
> on the ranged set_voltage() too.
> 
> Trying to infer this information from absolute numbers seems likely to
> get us into trouble at some point, both in terms of being harder for
> people to use to get the result they want and in terms of not being able
> to convey the information needed at all.
> 
Apologies on coming back to this discussion so late.

Digging through older emails on this topic, there is one more factor I
had forgotten - IR drop. Just to summarize the factors I can think of
for voltage:
a) OPP min operational voltage (specified in SoC data sheet) - covered
in operating-points dt description
b) device max operational voltage (specified in SoC data sheet) - this
is what we are discussing - I'd go with a max-operational-voltage dt
property to describe this. I see some old threads like [1] which tried
something similar.
c) certain devices allowing voltage tolerance ranges (original
definition of voltage-tolerance that I can find)

d) PMIC min/max voltage range - (specified in PMIC data sheet) - we
already have constraints description ability in DT today.
e) PMIC accuracy - voltage X set on the PMIC might depend on
peak-to-peak noise and after caps to cleanup might end up be +- y% of
attempted voltage X and may actually even vary (example - depending on
PMIC and current drawn, PWM to PFM mode transitions might result in
variant voltages). I think voltage-tolerance was used to compensate
here as well in certain instances?

f) based on board design, the voltage X set on PMIC and at PMIC
ball(after accounting for {e}), eventually results in Voltage Y at the
SoC ball where X-Y is the IR drop. I see some instances (like AM335x)
using voltage-tolerance to account for that as well. - this is
primarily a board factor. Some PMICs like TWL/TPS series have feedback
loop to account for this to save s/w from figuring this out, but not
all PMICs have that ability and some boards may not have wired in the
feedback loop properly.. Again, to complicate life, the current factor
varies depending on type of activity and type of device involved -
without proper characterization, this tends to be kinda hard to quantify.


[1]
http://www.gossamer-threads.com/lists/linux/kernel/1811056?do=post_view_threaded

-- 
Regards,
Nishanth Menon
