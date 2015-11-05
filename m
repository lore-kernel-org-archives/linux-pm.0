From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 4/5] PM / OPP: Rename OPP nodes as opp@<opp-hz>
Date: Wed, 4 Nov 2015 21:18:41 -0600
Message-ID: <20151105031841.GA27985@rob-hp-laptop>
References: <cover.1446687367.git.viresh.kumar@linaro.org>
 <5d5f139d334d5e503932c06694b47f0c3477caed.1446687367.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36394 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031616AbbKEDSr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 4 Nov 2015 22:18:47 -0500
Content-Disposition: inline
In-Reply-To: <5d5f139d334d5e503932c06694b47f0c3477caed.1446687367.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, sboyd@codeaurora.org, lee.jones@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, m.szyprowski@samsung.com, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Thu, Nov 05, 2015 at 07:11:55AM +0530, Viresh Kumar wrote:
> It would be better to name OPP nodes as opp@<opp-hz> as that will ensure
> that multiple DT nodes don't contain the same frequency. Of course we
> expect the writer to name the node with its opp-hz frequency and not any
> other frequency.
> 
> And that will let the compile error out if multiple nodes are using the
> same opp-hz frequency.
> 
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 38 +++++++++++++--------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 30c4bb3718bc..10ef08dc1b4c 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -183,20 +183,20 @@ Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> -		opp00 {
> +		opp@1000000000 {
>  			opp-hz = /bits/ 64 <1000000000>;
>  			opp-microvolt = <970000 975000 985000>;
>  			opp-microamp = <70000>;
>  			clock-latency-ns = <300000>;
>  			opp-suspend;
>  		};
> -		opp01 {
> +		opp@1100000000 {
>  			opp-hz = /bits/ 64 <1100000000>;
>  			opp-microvolt = <980000 1000000 1010000>;
>  			opp-microamp = <80000>;
>  			clock-latency-ns = <310000>;
>  		};
> -		opp02 {
> +		opp@1200000000 {
>  			opp-hz = /bits/ 64 <1200000000>;
>  			opp-microvolt = <1025000>;
>  			clock-latency-ns = <290000>;
> @@ -262,20 +262,20 @@ independently.
>  		 * independently.
>  		 */
>  
> -		opp00 {
> +		opp@1000000000 {
>  			opp-hz = /bits/ 64 <1000000000>;
>  			opp-microvolt = <970000 975000 985000>;
>  			opp-microamp = <70000>;
>  			clock-latency-ns = <300000>;
>  			opp-suspend;
>  		};
> -		opp01 {
> +		opp@1100000000 {
>  			opp-hz = /bits/ 64 <1100000000>;
>  			opp-microvolt = <980000 1000000 1010000>;
>  			opp-microamp = <80000>;
>  			clock-latency-ns = <310000>;
>  		};
> -		opp02 {
> +		opp@1200000000 {
>  			opp-hz = /bits/ 64 <1200000000>;
>  			opp-microvolt = <1025000>;
>  			opp-microamp = <90000;
> @@ -338,20 +338,20 @@ DVFS state together.
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> -		opp00 {
> +		opp@1000000000 {
>  			opp-hz = /bits/ 64 <1000000000>;
>  			opp-microvolt = <970000 975000 985000>;
>  			opp-microamp = <70000>;
>  			clock-latency-ns = <300000>;
>  			opp-suspend;
>  		};
> -		opp01 {
> +		opp@1100000000 {
>  			opp-hz = /bits/ 64 <1100000000>;
>  			opp-microvolt = <980000 1000000 1010000>;
>  			opp-microamp = <80000>;
>  			clock-latency-ns = <310000>;
>  		};
> -		opp02 {
> +		opp@1200000000 {
>  			opp-hz = /bits/ 64 <1200000000>;
>  			opp-microvolt = <1025000>;
>  			opp-microamp = <90000>;
> @@ -364,20 +364,20 @@ DVFS state together.
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> -		opp10 {
> +		opp@1300000000 {
>  			opp-hz = /bits/ 64 <1300000000>;
>  			opp-microvolt = <1045000 1050000 1055000>;
>  			opp-microamp = <95000>;
>  			clock-latency-ns = <400000>;
>  			opp-suspend;
>  		};
> -		opp11 {
> +		opp@1400000000 {
>  			opp-hz = /bits/ 64 <1400000000>;
>  			opp-microvolt = <1075000>;
>  			opp-microamp = <100000>;
>  			clock-latency-ns = <400000>;
>  		};
> -		opp12 {
> +		opp@1500000000 {
>  			opp-hz = /bits/ 64 <1500000000>;
>  			opp-microvolt = <1010000 1100000 1110000>;
>  			opp-microamp = <95000>;
> @@ -404,7 +404,7 @@ Example 4: Handling multiple regulators
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> -		opp00 {
> +		opp@1000000000 {
>  			opp-hz = /bits/ 64 <1000000000>;
>  			opp-microvolt = <970000>, /* Supply 0 */
>  					<960000>, /* Supply 1 */
> @@ -417,7 +417,7 @@ Example 4: Handling multiple regulators
>  
>  		/* OR */
>  
> -		opp00 {
> +		opp@1000000000 {
>  			opp-hz = /bits/ 64 <1000000000>;
>  			opp-microvolt = <970000 975000 985000>, /* Supply 0 */
>  					<960000 965000 975000>, /* Supply 1 */
> @@ -430,7 +430,7 @@ Example 4: Handling multiple regulators
>  
>  		/* OR */
>  
> -		opp00 {
> +		opp@1000000000 {
>  			opp-hz = /bits/ 64 <1000000000>;
>  			opp-microvolt = <970000 975000 985000>, /* Supply 0 */
>  					<960000 965000 975000>, /* Supply 1 */
> @@ -462,7 +462,7 @@ Example 5: opp-supported-hw
>  		status = "okay";
>  		opp-shared;
>  
> -		opp00 {
> +		opp@600000000 {
>  			/*
>  			 * Supports all substrate and process versions for 0xF
>  			 * cuts, i.e. only first four cuts.
> @@ -473,7 +473,7 @@ Example 5: opp-supported-hw
>  			...
>  		};
>  
> -		opp01 {
> +		opp@800000000 {
>  			/*
>  			 * Supports:
>  			 * - cuts: only one, 6th cut (represented by 6th bit).
> @@ -506,7 +506,7 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>, turbo-mode-<name>,
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> -		opp00 {
> +		opp@1000000000 {
>  			opp-hz = /bits/ 64 <1000000000>;
>  			opp-microvolt-slow = <900000 915000 925000>;
>  			opp-microvolt-fast = <970000 975000 985000>;
> @@ -516,7 +516,7 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>, turbo-mode-<name>,
>  			opp-suspend-slow; /* Will be used as suspend-opp only if 'slow' is chosen */
>  		};
>  
> -		opp01 {
> +		opp@1200000000 {
>  			opp-hz = /bits/ 64 <1200000000>;
>  			opp-microvolt-slow = <900000 915000 925000>, /* Supply vcc0 */
>  					      <910000 925000 935000>; /* Supply vcc1 */
> -- 
> 2.6.2.198.g614a2ac
> 
