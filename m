From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 13 May 2015 11:14:07 -0500
Message-ID: <5553784F.7040905@ti.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org> <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org> <554FFFA3.1060801@ti.com> <20150512051633.GB32300@linux> <555224A2.7000308@ti.com> <20150513050559.GE28858@linux> <55536719.5050208@ti.com> <20150513151652.GX2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56684 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbbEMQPC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2015 12:15:02 -0400
In-Reply-To: <20150513151652.GX2761@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, mike.turquette@linaro.org, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 05/13/2015 10:16 AM, Mark Brown wrote:
> On Wed, May 13, 2015 at 10:00:41AM -0500, Nishanth Menon wrote:
> 
>> What I dont see in the thread, and the point I raised here, why have
>> nominal/typical voltage at all? min<->max should be sufficient,
>> correct? If the device cannot function at min, then it should not be
>> documented as part of valid range at all.
> 
> Going for the minimum specified voltage is asking for trouble with
> regard to tolerances and so on, see also your concern about process
> corners.  If the electrical engineers specify things as X +/- Y the
> most conservative thing to do is to try to hit X rather than going
> straight for the limits.


I've had the same debate with my company's SoC designers as well on
various occasions as well. At least for the SoCs I deal with, X +/- Y
range specification involves PMIC/Board variations, where X is the
least voltage that is attempted to be set on PMIC, X-Y is the min
voltage allowed at the SoC ball, due to SMPS noise/IRDrop and other
board specific behavior.

I am not saying all SoC vendors do specifications the same way, but
our interest from device tree description is the operating voltage
range for the device that we can control on the PMIC. if setting (X-Y)
is not stable voltage for the device, then it should not be stated in
the description.

To illustrate: What does it mean for a driver using regulator API?
Attempt X <-> (X+Y), if that fails (example PMIC SMPS max < X), try
(X-Y)<->(X)? If yes, then we do expect (X-Y)<->(X+Y) should be stable
for all operating conditions for the device, correct? If this is is
not stable at (X-Y), then we have a wrong specification for the device
for claiming X +/- Y is a valid range for the device.

-- 
Regards,
Nishanth Menon
