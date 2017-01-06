From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 1/2] PM / Domains: Introduce domain-performance-states
 binding
Date: Fri, 6 Jan 2017 15:53:08 +0530
Message-ID: <20170106102308.GI21926@vireshk-i7>
References: <cover.1481539827.git.viresh.kumar@linaro.org>
 <dd95df02a1c3efd00bd4890f8aceeb717ad38788.1481539827.git.viresh.kumar@linaro.org>
 <586F596C.7000807@codeaurora.org>
 <20170106092702.GH21926@vireshk-i7>
 <586F6DA5.30203@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <586F6DA5.30203@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06-01-17, 15:42, Rajendra Nayak wrote:
> I read through that discussion, and I thought that was to do we
> handling multiple powerdomains with performance states
> (or in other words multiple voltage rails controlled by the M3)

I thought about it as multiple power domains available for a device,
and the device will be in a single domain out of those at a time. So
perhaps it is about the problem you mentioned.

> What I was pointing to, was that devices quite often (again on qcom
> platforms) have a power-switch (gdscs as we call it) which are modeled
> as powerdomains (which have nothing to do with taking to the M3 core),
> and with the proposed bindings one or more voltage rails controlled by the M3
> also as powerdomains associated with a device and the bindings have just one
> power-domains property in the device node, which runtime PM would use
> to power_on/off the device and OPP core would use to set the performance
> state?
> 
> +	leaky-device@12350000 {
> +		compatible = "foo,i-leak-current";
> +		reg = <0x12350000 0x1000>;
> +		power-domains = <&power 0>;
> +		domain-performance-state = <&domain_perf_state2>;
> +	};
> 
> Lets say leaky-device needs to switch on/off a gdsc and also send a
> value to M3 to set a minimum performance state (so M3 configures the
> voltage rails accordingly) how would it work?

So the way I proposed this earlier is that every device will have a
single power domain for it. In your case that power domain will
represent gdscs. Idle state and performance state request will go to
that level and then its up to the gdscs domain specific code to choose
the right domain and its performance state. The parent domain shall
then pass on the performance state to the next level power domain
controlled by the M3 core.

For example a device can have I power domain for idle state management
and A power domain for active state management. The device will also
have a M power domain which represents the gdscs. M can choose I or A
as its parent. The power domain A (and similar power domains for all
other devices) will have a parent power domain P. Now P is controlled
or configured via the M3. Will that make sense ?

-- 
viresh
