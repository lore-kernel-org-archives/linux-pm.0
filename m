From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH V2 1/2] PM / Domains: Introduce domain-performance-states
 binding
Date: Fri, 06 Jan 2017 15:42:53 +0530
Message-ID: <586F6DA5.30203@codeaurora.org>
References: <cover.1481539827.git.viresh.kumar@linaro.org> <dd95df02a1c3efd00bd4890f8aceeb717ad38788.1481539827.git.viresh.kumar@linaro.org> <586F596C.7000807@codeaurora.org> <20170106092702.GH21926@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170106092702.GH21926@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 01/06/2017 02:57 PM, Viresh Kumar wrote:
> On 06-01-17, 14:16, Rajendra Nayak wrote:
>>
>> On 12/12/2016 04:26 PM, Viresh Kumar wrote:
>>> Some platforms have the capability to configure the performance state of
>>> their Power Domains. The performance levels are represented by positive
>>> integer values, a lower value represents lower performance state.
>>>
>>> The power-domains until now were only concentrating on the idle state
>>> management of the device and this needs to change in order to reuse the
>>> infrastructure of power domains for active state management.
>>>
>>> This patch adds binding to describe the performance states of a power
>>> domain.
>>
>> The bindings would also need to take into account the fact that a device
>> could (and is quite often the case with qcom platforms) have 2 separate
>> powerdomains, one for idle state management and another to manage active
>> states. I guess the below bindings assume that there's just one.
> 
> I have answered a similar question here..
> 
> https://marc.info/?l=linux-kernel&m=148067565219477&w=2

I read through that discussion, and I thought that was to do we
handling multiple powerdomains with performance states
(or in other words multiple voltage rails controlled by the M3)

What I was pointing to, was that devices quite often (again on qcom
platforms) have a power-switch (gdscs as we call it) which are modeled
as powerdomains (which have nothing to do with taking to the M3 core),
and with the proposed bindings one or more voltage rails controlled by the M3
also as powerdomains associated with a device and the bindings have just one
power-domains property in the device node, which runtime PM would use
to power_on/off the device and OPP core would use to set the performance
state?

+	leaky-device@12350000 {
+		compatible = "foo,i-leak-current";
+		reg = <0x12350000 0x1000>;
+		power-domains = <&power 0>;
+		domain-performance-state = <&domain_perf_state2>;
+	};

Lets say leaky-device needs to switch on/off a gdsc and also send a
value to M3 to set a minimum performance state (so M3 configures the
voltage rails accordingly) how would it work?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
