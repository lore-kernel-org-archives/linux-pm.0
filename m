From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Thu, 27 Apr 2017 10:42:49 +0100
Message-ID: <c66322f5-e2eb-5556-a5a5-14998a2f195d@arm.com>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <0a7146f9-72f1-317c-3aab-770a72462968@arm.com>
 <20170413053736.GM5910@vireshk-i7>
 <3adbef6a-7b43-528f-e88f-c2121d30a5d3@arm.com>
 <20170417052758.GF28191@vireshk-i7>
 <95aa4b97-4e1a-13bb-f4d8-982b778012ba@arm.com>
 <9cd9287c-392b-d3ca-db7d-75c49287448e@codeaurora.org>
 <20170426135532.ryrh276znet5yvks@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938029AbdD0Jmz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Apr 2017 05:42:55 -0400
In-Reply-To: <20170426135532.ryrh276znet5yvks@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, devicetree@vger.kernel.org



On 26/04/17 14:55, Mark Brown wrote:
> On Wed, Apr 26, 2017 at 10:02:39AM +0530, Rajendra Nayak wrote:
>>> On 17/04/17 06:27, Viresh Kumar wrote:
> 
>>>>> If we are looking this power-domains with performance as just some
>>>>> *advanced regulators*, I don't like the complexity added.
> 
>> + Mark
> 
>> I don;t see any public discussions on why we ruled out using regulators to
>> support this but maybe there were some offline discussions on this.
> 
>> Mark, this is a long thread, so just summarizing here to give you the context.
> 
>> At qualcomm, we have an external M3 core (running its own firmware) which controls
>> a few voltage rails (including AVS on those). The devices vote for the voltage levels

Thanks for explicitly mentioning this, but ...

>> (or performance levels) they need by passing an integer value to the M3 (not actual

you contradict here, is it just voltage or performance(i.e. frequency)
or both ? We need clarity there to choose the right representation.

>> voltage values). Since that didn't fit well with the existing regulator apis it was
> 
> As I'm getting fed up of saying: if the values you are setting are not
> voltages and do not behave like voltages then the hardware should not be
> represented as a voltage regulator since if they are represented as
> voltage regulators things will expect to be able to control them as
> voltage regulators.  This hardware is quite clearly providing OPPs
> directly, I would expect this to be handled in the OPP code somehow.

I agree with you that we need to be absolutely sure on what it actually
represents.

But as more and more platform are pushing such power controls to
dedicated M3 or similar processors, we need abstraction. Though we are
controlling hardware, we do so indirectly. Since there were discussions
around device tree representing hardware vs platform, I tend to think,
we are moving towards platform(something similar to ACPI).

-- 
Regards,
Sudeep
