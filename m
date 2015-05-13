From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 13 May 2015 11:34:13 -0500
Message-ID: <55537D05.4080009@ti.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org> <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org> <554FFFA3.1060801@ti.com> <20150512051633.GB32300@linux> <555224A2.7000308@ti.com> <20150513050559.GE28858@linux> <55536719.5050208@ti.com> <20150513151652.GX2761@sirena.org.uk> <5553784F.7040905@ti.com> <20150513162127.GA2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57577 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934366AbbEMQfI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2015 12:35:08 -0400
In-Reply-To: <20150513162127.GA2761@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, mike.turquette@linaro.org, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 05/13/2015 11:21 AM, Mark Brown wrote:
> On Wed, May 13, 2015 at 11:14:07AM -0500, Nishanth Menon wrote:
> 
>> To illustrate: What does it mean for a driver using regulator API?
>> Attempt X <-> (X+Y), if that fails (example PMIC SMPS max < X), try
>> (X-Y)<->(X)? If yes, then we do expect (X-Y)<->(X+Y) should be stable
>> for all operating conditions for the device, correct? If this is is
>> not stable at (X-Y), then we have a wrong specification for the device
>> for claiming X +/- Y is a valid range for the device.
> 
> We have an explicit regulator API call for setting by tolerance which
> tries to get as close as possible to the target voltage (currently the
> implementation is very cheap and nasty but ideally it'll get improved).
> 

Thanks - I think the original implementation was triggered by the old
"voltage-tolerance" mess, so wont be too surprised.

With respect to the property itself, I still am not completely
convinced that having typ actually helps. but having it does not hurt
either, since min could be == typ in SoC description if desired.

So, since I dont strongly feel either way here to reject things
completely, and supposedly, it does help some other SoC vendors(which
I am not convinced how), will leave the discussion alone for the moment.

-- 
Regards,
Nishanth Menon
