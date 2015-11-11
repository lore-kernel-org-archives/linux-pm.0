From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3 2/5] PM / OPP: Add {opp-microvolt|opp-microamp}-<name>
 binding
Date: Wed, 11 Nov 2015 14:31:00 -0600
Message-ID: <20151111203100.GA10702@rob-hp-laptop>
References: <cover.1447209519.git.viresh.kumar@linaro.org>
 <1f1d9dd73ff629504f3c730e4100dba800c6132a.1447209519.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53461 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752468AbbKKUbG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 11 Nov 2015 15:31:06 -0500
Content-Disposition: inline
In-Reply-To: <1f1d9dd73ff629504f3c730e4100dba800c6132a.1447209519.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org, lee.jones@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, m.szyprowski@samsung.com, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Wed, Nov 11, 2015 at 08:10:55AM +0530, Viresh Kumar wrote:
> Depending on the version of hardware or its properties, which are only
> known at runtime, various properties of the OPP can change. For example,
> an OPP with frequency 1.2 GHz, may have different voltage/current
> requirements based on the version of the hardware it is running on.
> 
> In order to not replicate the same OPP tables for varying values of all
> such fields, this commit introduces the concept of opp-property-<name>.
> The <name> can be chosen by the platform at runtime, and OPPs will be
> initialized depending on that name string. Currently support is extended
> for the following properties:
> - opp-microvolt-<name>
> - opp-microamp-<name>
> 
> If the name string isn't provided by the platform, or if it is provided
> but doesn't match the properties present in the OPP node, we will fall
> back to the original properties without the -<name> string, if they are
> available.
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 47 +++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index d072fa0ffbd4..a3e7f0d5e1fb 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -100,6 +100,14 @@ properties.
>    Entries for multiple regulators must be present in the same order as
>    regulators are specified in device's DT node.
>  
> +- opp-microvolt-<name>: Named opp-microvolt property. This is exactly similar to
> +  the above opp-microvolt property, but allows multiple voltage ranges to be
> +  provided for the same OPP. At runtime, the platform can pick a <name> and
> +  matching opp-microvolt-<name> property will be enabled for all OPPs. If the
> +  platform doesn't pick a specific <name> or the <name> doesn't match with any
> +  opp-microvolt-<name> properties, then opp-microvolt property shall be used, if
> +  present.
> +
>  - opp-microamp: The maximum current drawn by the device in microamperes
>    considering system specific parameters (such as transients, process, aging,
>    maximum operating temperature range etc.) as necessary. This may be used to
> @@ -112,6 +120,9 @@ properties.
>    for few regulators, then this should be marked as zero for them. If it isn't
>    required for any regulator, then this property need not be present.
>  
> +- opp-microamp-<name>: Named opp-microamp property. Similar to
> +  opp-microvolt-<name> property, but for microamp instead.
> +
>  - clock-latency-ns: Specifies the maximum possible transition latency (in
>    nanoseconds) for switching to this OPP from any other OPP.
>  
> @@ -528,3 +539,39 @@ Example 6: opp-supported-hw
>  		};
>  	};
>  };
> +
> +Example 7: opp-microvolt-<name>, opp-microamp-<name>:
> +(example: device with two possible microvolt ranges: slow and fast)
> +
 > +/ {
> +	cpus {
> +		cpu@0 {
> +			compatible = "arm,cortex-a7";
> +			...
> +
> +			operating-points-v2 = <&cpu0_opp_table>;
> +		};
> +	};
> +
> +	cpu0_opp_table: opp_table0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp00 {

Thought we are doing frequency for unit address here.

> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-microvolt-slow = <900000 915000 925000>;
> +			opp-microvolt-fast = <970000 975000 985000>;
> +			opp-microamp-slow =  <70000>;
> +			opp-microamp-fast =  <71000>;
> +		};
> +
> +		opp01 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt-slow = <900000 915000 925000>, /* Supply vcc0 */
> +					      <910000 925000 935000>; /* Supply vcc1 */
> +			opp-microvolt-fast = <970000 975000 985000>, /* Supply vcc0 */
> +					     <960000 965000 975000>; /* Supply vcc1 */
> +			opp-microamp =  <70000>; /* Will be used for both slow/fast */
> +		};
> +	};
> +};
> -- 
> 2.6.2.198.g614a2ac
> 
