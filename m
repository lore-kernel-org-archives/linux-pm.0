From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Tue, 28 Jul 2015 07:59:36 +0530
Message-ID: <20150728022936.GB1229@linux>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
 <1438010430-5802-2-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36681 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446AbbG1C3k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 22:29:40 -0400
Received: by pachj5 with SMTP id hj5so61269813pac.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2015 19:29:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1438010430-5802-2-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, rob.herring@linaro.org, nm@ti.com, arnd.bergmann@linaro.org, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, sre@kernel.org, dbaryshkov@gmail.com

Cc'ing few people (whom I cc'd last time as well :)).

On 27-07-15, 16:20, Lee Jones wrote:
> These OPPs are used in ST's CPUFreq implementation.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> Changelog:
>  - None, new patch
> 
>  Documentation/devicetree/bindings/power/opp-st.txt | 76 ++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/opp-st.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/opp-st.txt b/Documentation/devicetree/bindings/power/opp-st.txt
> new file mode 100644
> index 0000000..6eb2a91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/opp-st.txt
> @@ -0,0 +1,76 @@
> +STMicroelectronics OPP (Operating Performance Points) Bindings
> +--------------------------------------------------------------
> +
> +Frequency Scaling only
> +----------------------
> +
> +Located in CPU's node:
> +
> +- operating-points	: [See: ./opp.txt]
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
> +Located in 'cpu0-opp-list' node [to be provided ONLY by the bootloader]:
> +
> +- compatible		: Should be "operating-points-v2-sti"
> +- opp{1..N} 		: Each 'oppX' subnode will contain the following properties:

Or should we mention:
- opp{1..N} 		: Each 'oppX' subnode shall contain below properties,
                          over what ./opp.txt defines:

?


> + - opp-hz		: CPU frequency [Hz] for this OPP [See: ./opp.txt]
> + - st,avs		: List of available voltages [uV] indexed by process code
> + - st,cuts		: Cut version this OPP is suitable for [0xFF means ALL]
> + - st,substrate		: Substrate version this OPP is suitable for [0xFF means ALL]
> +- st,syscfg		: Phandle to Major number register
> +				First cell: offset to major number
> +- st,syscfg-eng		: Phandle to Minor number and Pcode registers
> +				First cell: offset to process code
> +				Second cell: offset to minor number
> +
> +WARNING: The opp{1..N} nodes will be provided by the bootloader.  Do not attempt to
> +	 artificially synthesise the opp{1..N} nodes or any of their descendants.
> +	 They are very platform specific and may damage the hardware if created
> +	 incorrectly.
> +
> +Example [unsafe]
> +----------------
> +
> +cpus {
> +	cpu@0 {
> +		operating-points-v2	= <&cpu0_opp_list>;
> +	};
> +};
> +
> +/* ############################################################ */
> +/* # WARNING: Do not attempt to copy/replicate this node,     # */
> +/* #          it is only to be supplied by the bootloader !!! # */
> +/* ############################################################ */
> +cpu0-opp-list {
> +	compatible	= "operating-points-v2-sti";
> +	st,syscfg	= <&syscfg [major_offset]>;
> +	st,syscfg-eng   = <&syscfg_eng [pcode_offset] [minor_offset]>;
> +
> +	opp0 {
> +		opp-hz		= <1200000000>;
> +		st,avs		= <1110 1150 1100 1080 1040 1020 980 930>;
> +		st,substrate	= <0xff>;
> +		st,cuts		= <0xff>;
> +	};
> +	opp1 {
> +		opp-hz		= <1500000000>;
> +		st,avs		= <1200 1200 1200 1200 1170 1140 1100 1070>;
> +		st,substrate	= <0xff>;
> +		st,cuts		= <0x2>;
> +	};
> +};

I don't see more problems here, unless we can move some of this to the
generic bindings.

@Rob/Stephen: Please respond before it is late :)

-- 
viresh
