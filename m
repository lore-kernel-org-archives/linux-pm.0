From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Wed, 3 May 2017 12:21:54 +0100
Message-ID: <8aacc296-2549-f0b8-ac25-2f4000c084c1@arm.com>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <0a7146f9-72f1-317c-3aab-770a72462968@arm.com>
 <20170413053736.GM5910@vireshk-i7>
 <3adbef6a-7b43-528f-e88f-c2121d30a5d3@arm.com>
 <20170417052758.GF28191@vireshk-i7>
 <95aa4b97-4e1a-13bb-f4d8-982b778012ba@arm.com>
 <9cd9287c-392b-d3ca-db7d-75c49287448e@codeaurora.org>
 <20170426135532.ryrh276znet5yvks@sirena.org.uk>
 <c66322f5-e2eb-5556-a5a5-14998a2f195d@arm.com>
 <20170430124917.4m3d237pik7q47f3@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751766AbdECLV7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 May 2017 07:21:59 -0400
In-Reply-To: <20170430124917.4m3d237pik7q47f3@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, robh+dt@kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rajendra Nayak <rnayak@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, lina.iyer@linaro.org, devicetree@vger.kernel.org



On 30/04/17 13:49, Mark Brown wrote:
> On Thu, Apr 27, 2017 at 10:42:49AM +0100, Sudeep Holla wrote:
>> On 26/04/17 14:55, Mark Brown wrote:
> 
>>> As I'm getting fed up of saying: if the values you are setting are not
>>> voltages and do not behave like voltages then the hardware should not be
>>> represented as a voltage regulator since if they are represented as
>>> voltage regulators things will expect to be able to control them as
>>> voltage regulators.  This hardware is quite clearly providing OPPs
>>> directly, I would expect this to be handled in the OPP code somehow.
> 
>> I agree with you that we need to be absolutely sure on what it actually
>> represents.
> 
>> But as more and more platform are pushing such power controls to
>> dedicated M3 or similar processors, we need abstraction. Though we are
>> controlling hardware, we do so indirectly. Since there were discussions
>> around device tree representing hardware vs platform, I tend to think,
>> we are moving towards platform(something similar to ACPI).
> 
> I don't think there's a meaningful hardware/platform distinction here -
> in terms of what DT is describing the platform bit is just what the
> hardware (the microcontrollers) happen to do, 
> 

Yes agreed. It's similar to PSCI or any other platform firmware IMO.

The question is how do we deal with such controls that needs to be done
via the firmware ? We generally plug-in to the existing framework in
Linux using the existing bindings. Most of the time, much simpler
bindings than the one that present complete hardware description.

> DT doesn't much care about that though.

No sure about that, may be doesn't care about the internals, but we need
to care about interface, no ?

-- 
Regards,
Sudeep
