From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 10/11] dt: cpufreq: st: Provide bindings for ST's
 CPUFreq implementation
Date: Tue, 8 Dec 2015 21:52:40 -0600
Message-ID: <20151209035240.GA25250@rob-hp-laptop>
References: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
 <1449585124-15596-11-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449585124-15596-11-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ajitpal.singh-qxv4g6HH51o@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 08, 2015 at 02:32:03PM +0000, Lee Jones wrote:
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> ---
>  .../devicetree/bindings/cpufreq/cpufreq-st.txt     | 91 ++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> new file mode 100644
> index 0000000..d91a02a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> @@ -0,0 +1,91 @@
> +Binding for ST's CPUFreq driver
> +===============================
> +
> +ST's CPUFreq driver attempts to read 'process' and 'version' attributes
> +from the SoC, then supplies the OPP framework with 'prop' and 'supported
> +hardware' information respectively.  The framework is then able to read
> +the DT and operate in the usual way.
> +
> +For more information about the expected DT format [See: ../opp/opp.txt].
> +
> +Frequency Scaling only
> +----------------------
> +
> +No vendor specific driver required for this.
> +
> +Located in CPU's node:
> +
> +- operating-points		: [See: ../power/opp.txt]
> +
> +Example [safe]
> +--------------
> +
> +cpus {
> +	cpu@0 {
> +				 /* kHz     uV   */
> +		operating-points = <1500000 0
> +				    1200000 0
> +				    800000  0
> +				    500000  0>;
> +	};
> +};
> +
> +Dynamic Voltage and Frequency Scaling (DVFS)
> +--------------------------------------------
> +
> +This requires the ST CPUFreq driver to supply 'process' and 'version' info.
> +
> +Located in CPU's node:
> +
> +- operating-points-v2		: [See ../power/opp.txt]
> +
> +Example [unsafe]
> +----------------
> +
> +cpus {
> +	cpu@0 {
> +		operating-points-v2	= <&cpu0_opp_table>;
> +	};
> +};
> +
> +cpu0_opp_table: opp_table {
> +	compatible = "operating-points-v2";
> +
> +	/* ############################################################### */
> +	/* # WARNING: Do not attempt to copy/replicate these nodes,      # */
> +	/* #          they are only to be supplied by the bootloader !!! # */
> +	/* ############################################################### */
> +	opp0 {
> +		/*			   Major       Minor       Substrate */
> +		/*			   2           all         all       */
> +		opp-supported-hw	= <0x00000004  0xffffffff  0xffffffff>;
> +		opp-hz			= /bits/ 64 <1500000000>;
> +		clock-latency-ns	= <10000000>;
> +
> +		opp-microvolt-pcode0	= <1200000>;
> +		opp-microvolt-pcode1	= <1200000>;
> +		opp-microvolt-pcode2	= <1200000>;
> +		opp-microvolt-pcode3	= <1200000>;
> +		opp-microvolt-pcode4	= <1170000>;
> +		opp-microvolt-pcode5	= <1140000>;
> +		opp-microvolt-pcode6	= <1100000>;
> +		opp-microvolt-pcode7	= <1070000>;
> +	};
> +
> +	opp1 {
> +		/*			   Major       Minor       Substrate */
> +		/*			   all         all         all       */
> +		opp-supported-hw	= <0xffffffff  0xffffffff  0xffffffff>;
> +		opp-hz			= /bits/ 64 <1200000000>;
> +		clock-latency-ns	= <10000000>;
> +
> +		opp-microvolt-pcode0	= <1110000>;
> +		opp-microvolt-pcode1	= <1150000>;
> +		opp-microvolt-pcode2	= <1100000>;
> +		opp-microvolt-pcode3	= <1080000>;
> +		opp-microvolt-pcode4	= <1040000>;
> +		opp-microvolt-pcode5	= <1020000>;
> +		opp-microvolt-pcode6	= <980000>;
> +		opp-microvolt-pcode7	= <930000>;
> +	};
> +};
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
