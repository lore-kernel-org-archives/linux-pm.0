From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Wed, 19 Apr 2017 17:17:40 +0530
Message-ID: <20170419114740.GD5436@vireshk-i7>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
 <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <0a7146f9-72f1-317c-3aab-770a72462968@arm.com>
 <20170413053736.GM5910@vireshk-i7>
 <3adbef6a-7b43-528f-e88f-c2121d30a5d3@arm.com>
 <20170417052758.GF28191@vireshk-i7>
 <95aa4b97-4e1a-13bb-f4d8-982b778012ba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <95aa4b97-4e1a-13bb-f4d8-982b778012ba@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 18-04-17, 17:01, Sudeep Holla wrote:
> Understood. I would incline towards reusing regulators we that's what is

It can be just a regulator, but it can be anything else as well. That
entity may have its own clock/volt/current tunables, etc.

> changed behind the scene. Calling this operating performance point
> is misleading and doesn't align well with existing specs/features.

Yeah, but there are no voltage levels available here and that doesn't
fit as a regulator then.

> Understood. We have exactly same thing with SCPI but it controls both
> frequency and voltage referred as operating points. In general, this OPP
> terminology is used in SCPI/ACPI/SCMI specifications as both frequency
> and voltage control. I am bit worried that this binding might introduce
> confusions on the definitions. But it can be reworded/renamed easily if
> required.

Yeah, so far we have been looking at OPPs as freq-voltage pairs ONLY
and that is changing. I am not sure if it going in the wrong
direction really. Without frequency also it is an operating point for
the domain. Isn't it?

-- 
viresh
