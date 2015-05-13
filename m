From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 13 May 2015 10:43:40 -0500
Message-ID: <5553712C.9090603@ti.com>
References: <20150507221842.GW22845@sirena.org.uk> <CAKohpomU8wm0T=A7EkosdOjXbP8q2Cb726Hsjh08KTKYjoz3-A@mail.gmail.com> <555000B6.2010107@ti.com> <20150512052033.GC32300@linux> <20150512190134.16410.89041@quantum> <5552510B.9010306@ti.com> <20150512194134.GC3066@sirena.org.uk> <55525B29.2080307@ti.com> <20150513115422.GQ3066@sirena.org.uk> <CAGo_u6o5nw8C3uwLGmP+kbCOG5twmXgC2ATb5Gv-dL3G-grDSg@mail.gmail.com> <20150513150739.GW2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55362 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965538AbbEMPo6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2015 11:44:58 -0400
In-Reply-To: <20150513150739.GW2761@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Michael Turquette <mike.turquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>

On 05/13/2015 10:07 AM, Mark Brown wrote:
> On Wed, May 13, 2015 at 09:24:57AM -0500, Nishanth Menon wrote:
> 
>> - opp-microamp: The maximum current drawn by the device in microamperes
>>   considering system specific parameters (such as transients, process,
>> aging, etc.)
>>   as necessary,  at an  ambient temperature of 25C. This may be used to set
>>   the most efficient regulator operating mode.
> 
> Why specify the temperature?  That 25C is going to be terribly
> inefficient for my snowplow engine control system (or whatever).
> 
:) was trying to put a constraint since we do know that leakage
changes over temperature profile and the fact that operating
temperature ranges vary depending on device and market. rephrased
again below:

- opp-microamp: The maximum current drawn by the device in
  microamperes considering system specific parameters (such as
  transients, process, aging, maximum operating temperature range
  etc.) as necessary. This may be used to set the most efficient
  regulator operating mode.

-- 
Regards,
Nishanth Menon
