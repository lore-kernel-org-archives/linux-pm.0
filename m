From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Tue, 11 Aug 2015 19:58:12 +0530
Message-ID: <20150811142812.GJ5509@linux>
References: <CAL_JsqKQLQ15qSt95zBZykzzPhcUrtZzhk29a76n+r_3719AiA@mail.gmail.com>
 <20150731163715.GV3159@codeaurora.org>
 <20150803034642.GV899@linux>
 <20150810132247.GH3249@x1>
 <20150811080023.GB5509@linux>
 <20150811093039.GA18282@x1>
 <20150811100941.GG5509@linux>
 <20150811115425.GE18282@x1>
 <20150811120124.GH5509@linux>
 <20150811132756.GG18282@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150811132756.GG18282@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robherring2@gmail.com>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 11-08-15, 14:27, Lee Jones wrote:
> Okay, so what you're saying is that you've already made the decision
> to create a separate node for every OPP permutation,

Absolutely not.

> despite the fact
> that I've told you this could lead to more nodes than anyone would
> care to successfully write or maintain?

I have enough fear of yours and then I have to see you in another
month as well. I wouldn't dare to disobey your command SIR :)

> Perhaps an example might help explain the issue.
> 
> Using the current driver, we need to place the following in DT and the
> driver does the rest:
> 
> opp-list {
> 	opp1 {
> 		opp-hz = <1500000000>;
> 		st,avs = <1200 1200 1200 1200 1170 1140 1100 1070>;
> 		st,substrate = <0xff>;
> 		st,cuts = <0xff>;
> 	};
> 	opp0 {
> 		opp-hz = <1200000000>;
> 		st,avs = <1110 1150 1100 1080 1040 1020 980 930>;
> 		st,substrate = <0xff>;
> 		st,cuts = <0x2>;
> 	};
> };

Nothing is fixed as of now but this is what I am thinking of:

	cpu0_opp_table: opp_table0 {
		compatible = "operating-points-v2";
                opp-cuts = "10", "3c", "f0";
		supply-names = "vcc0", "vcc1", "vcc2";
		opp-shared;

		opp00 {
			opp-hz = /bits/ 64 <1000000000>;
			clock-latency-ns = <300000>;
			opp-microvolt-10 = <970000>;
			opp-microvolt-3c = <950000>;
			opp-microvolt-f0 = <930000>;
		};

		/* OR */

		opp00 {
			opp-hz = /bits/ 64 <1000000000>;
			clock-latency-ns = <300000>;
                        opp-microvolt = <970000>, <950000>, <930000>;
		};
        };

And then the platform code needs to tell OPP layer:
"Use OPPs for cut f0 for device X", and OPP layer will store that
somewhere.

And then it will only initialize OPPs after matching this string with
the values.

Out of the earlier two options, I may prefer the first one. As we will
be soon adding support for multiple regulators, and a single regulator
can have min/max/target values.. So, a single list will become too
long.

But, something like this should be generic enough to capture most of
the cases.

@Stephen/Rob ??

-- 
viresh
