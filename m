From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/3] PM / OPP: extend DT binding to specify phandle of
 another node for OPP
Date: Mon, 30 Sep 2013 09:52:27 +0100
Message-ID: <20130930085227.GB19738@e106331-lin.cambridge.arm.com>
References: <1379501893-12669-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1379501893-12669-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1379501893-12669-2-git-send-email-Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Sudeep,

I have a few comments.

On Wed, Sep 18, 2013 at 11:58:11AM +0100, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>
> 
> If more than one similar devices share the same operating points(OPPs)
> being in the same clock domain, currently we need to replicate the
> OPP entries in all the nodes.
> 
> This patch extends existing binding by adding a new property named
> 'operating-points-phandle' to specify the phandle in any device node
> pointing to another node which contains the actual OPP tuples.
> This helps to avoid replication if multiple devices share the OPPs.
> 
> Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
> Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/power/opp.txt | 152 ++++++++++++++++++++++--
>  1 file changed, 140 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
> index 74499e5..e9fea65 100644
> --- a/Documentation/devicetree/bindings/power/opp.txt
> +++ b/Documentation/devicetree/bindings/power/opp.txt
> @@ -4,22 +4,150 @@ SoCs have a standard set of tuples consisting of frequency and
>  voltage pairs that the device will support per voltage domain. These
>  are called Operating Performance Points or OPPs.
>  
> -Properties:
> +Required Properties:
>  - operating-points: An array of 2-tuples items, and each item consists
>    of frequency and voltage like <freq-kHz vol-uV>.
>  	freq: clock frequency in kHz
>  	vol: voltage in microvolt
>  
> +Optional properties:
> +- operating-points-phandle: phandle to the device tree node which contains
> +	the operating points tuples(recommended to be used if multiple
> +	devices are in the same clock domain and hence share OPPs, as it
> +	avoids replication of OPPs)
> +

I assume if you have an operating-points-phandle property,
operating-points it no longer required. That should probably be
described.

>  Examples:
>  
> -cpu@0 {
> -	compatible = "arm,cortex-a9";
> -	reg = <0>;
> -	next-level-cache = <&L2>;
> -	operating-points = <
> -		/* kHz    uV */
> -		792000  1100000
> -		396000  950000
> -		198000  850000
> -	>;
> -};
> +1. A uniprocessor system (phandle not required)
> +
> +	cpu0: cpu@0 {
> +		compatible = "arm,cortex-a9";
> +		reg = <0>;
> +		operating-points = <
> +			/* kHz    uV */
> +			792000  1100000
> +			396000  950000
> +			198000  850000
> +		>;
> +	};
> +
> +If more than one device of same type share the same OPPs, for example
> +all the CPUs on a SoC or in a single cluster on a SoC, then we need to
> +avoid replicating the OPPs in all the nodes. We can specify the phandle
> +of the node which contains the OPP tuples

This seems a bit out of place given the example immediately below.

> +
> +2a. Consider a SMP system with 4 CPUs in the same clock domain
> +    (backward compatible style, only CPU0 contains OPP)
> +
> +	cpu0: cpu@0 {
> +		compatible = "arm,cortex-a9";
> +		reg = <0>;
> +		operating-points = <
> +			/* kHz    uV */
> +			792000  1100000
> +			396000  950000
> +			198000  850000
> +		>;
> +	};
> +
> +	cpu1: cpu@1 {
> +		compatible = "arm,cortex-a9";
> +		reg = <1>;
> +	};
> +
> +	cpu2: cpu@2 {
> +		compatible = "arm,cortex-a9";
> +		reg = <2>;
> +	};
> +
> +	cpu3: cpu@3 {
> +		compatible = "arm,cortex-a9";
> +		reg = <3>;
> +	};

This "backward compatible style" doesn't seem to actually be described
anywhere, and the paragraph above about phandles makes it somewhat
confusing.

> +
> +2b. Consider a SMP system with 4 CPUs in the same clock domain
> +    (using operating-points-phandle)
> +
> +	cpu0: cpu@0 {
> +		compatible = "arm,cortex-a9";
> +		reg = <0>;
> +		operating-points-phandle = <&cpu_opp>;
> +	};
> +
> +	cpu1: cpu@1 {
> +		compatible = "arm,cortex-a9";
> +		reg = <1>;
> +		operating-points-phandle = <&cpu_opp>;
> +	};
> +
> +	cpu2: cpu@2 {
> +		compatible = "arm,cortex-a9";
> +		reg = <2>;
> +		operating-points-phandle = <&cpu_opp>;
> +	};
> +
> +	cpu3: cpu@3 {
> +		compatible = "arm,cortex-a9";
> +		reg = <3>;
> +		operating-points-phandle = <&cpu_opp>;
> +	};
> +
> +	operating_points {
> +		cpu_opp: cpu_opp {
> +			operating-points = <
> +				/* kHz    uV */
> +				792000  1100000
> +				396000  950000
> +				198000  850000
> +			>;
> +		};
> +		... /* other device OPP nodes */
> +	}

Is this all inside the /cpus node?

Is the "operating_points" name important?

Are all OPP tables expected to be in the same "operating_points" node?

Cheers,
Mark.

> +
> +3. Consider an AMP(asymmetric multi-processor) sytem with 2 clusters of CPUs.
> +   Each cluster has 2 CPUs and all the CPUs within the cluster share the clock
> +   domain.
> +
> +	cpu0: cpu@0 {
> +		compatible = "arm,cortex-a15";
> +		reg = <0>;
> +		operating-points-phandle = <&cluster0_opp>;
> +	};
> +
> +	cpu1: cpu@1 {
> +		compatible = "arm,cortex-a15";
> +		reg = <1>;
> +		operating-points-phandle = <&cluster0_opp>;
> +	};
> +
> +	cpu2: cpu@100 {
> +		compatible = "arm,cortex-a7";
> +		reg = <100>;
> +		operating-points-phandle = <&cluster1_opp>;
> +	};
> +
> +	cpu3: cpu@101 {
> +		compatible = "arm,cortex-a7";
> +		reg = <101>;
> +		operating-points-phandle = <&cluster1_opp>;
> +	};
> +
> +	operating_points {
> +		cluster0_opp: cluster0_opp {
> +			operating-points = <
> +				/* kHz    uV */
> +				792000  1100000
> +				396000  950000
> +				198000  850000
> +			>;
> +		};
> +		cluster1_opp: cluster1_opp {
> +			operating-points = <
> +				/* kHz    uV */
> +				792000  950000
> +				396000  750000
> +				198000  450000
> +			>;
> +		};
> +		... /* other device OPP nodes */
> +	}
> -- 
> 1.8.1.2
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
