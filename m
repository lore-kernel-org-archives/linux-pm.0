From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V1 Resend 2/3] cpufreq: dt: Add generic platform-device
 creation support
Date: Fri, 1 Apr 2016 15:53:50 +0530
Message-ID: <20160401102350.GA5532@vireshk-i7>
References: <cover.1459233524.git.viresh.kumar@linaro.org>
 <12972545.Mi9sHiNJpR@wuerfel>
 <20160330032240.GB8773@vireshk-i7>
 <7250220.227umpmTug@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7250220.227umpmTug@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-kernel@lists.linaro.org, k.kozlowski@samsung.com, kgene.kim@samsung.com, heiko@sntech.de, linux-pm@vger.kernel.org, mmcclint@codeaurora.org, xf@rock-chips.com, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, slash.tmp@free.fr, rob.herring@linaro.org
List-Id: linux-pm@vger.kernel.org

Cc'ing Rob and Mason.

On 30-03-16, 09:53, Arnd Bergmann wrote:
> I think it should be something in the /cpus or the /opp_table hierarchy,
> not the root of the device tree, but other than that I don't care much
> whether it's a variation of the oppv2 compatible string or an additional
> property in any of the nodes.

So you mean for future DT files we can have something like this:

	cpus {
                compatible = "operation-points-v2";
		#address-cells = <1>;
		#size-cells = <0>;

		cpu@0 {
			compatible = "arm,cortex-a9";
			reg = <0>;
			next-level-cache = <&L2>;
			operating-points-v2 = <&cpu0_opp_table>;
		};
	};

	cpu0_opp_table: opp_table0 {
		opp@1000000000 {
			opp-hz = /bits/ 64 <1000000000>;
			opp-microvolt = <970000 975000 985000>;
			opp-microamp = <70000>;
			clock-latency-ns = <300000>;
			opp-suspend;
		};
		opp@1100000000 {
			opp-hz = /bits/ 64 <1100000000>;
			opp-microvolt = <980000 1000000 1010000>;
			opp-microamp = <80000>;
			clock-latency-ns = <310000>;
		};
	};
};


And the cpufreq-dt driver can match /cpus node's compatible string against
"operating-points-v2" and create a device at runtime ?

@Rob: Will that be acceptable to you? We are discussing (again) about how to
probe cpufreq-dt driver automatically for platforms :)

The cpus node doesn't have any 'compatible' property today, and I will be
required to add that in this case.

-- 
viresh
