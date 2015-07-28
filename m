From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 1/2] dt: cpufreq: st: Provide bindings for ST's
 CPUFreq implementation
Date: Tue, 28 Jul 2015 07:53:08 +0530
Message-ID: <20150728022308.GA1229@linux>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36530 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843AbbG1CXN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 22:23:13 -0400
Received: by pdjr16 with SMTP id r16so62903836pdj.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2015 19:23:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, sre@kernel.org, dbaryshkov@gmail.com

On 27-07-15, 16:20, Lee Jones wrote:
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> Changelog:
>  - Using OPP-v2
>  - Moved (and linked) a bunch of documentation to ../power/
> 
>  .../devicetree/bindings/cpufreq/cpufreq-st.txt     | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> new file mode 100644
> index 0000000..79add9d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> @@ -0,0 +1,40 @@
> +Binding for ST's CPUFreq driver
> +===============================
> +
> +Frequency Scaling only
> +----------------------
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
> +Located in CPU's node:
> +
> +- operating-points-v2-sti	: [See ../power/opp-st.txt]
> +
> +Example [unsafe]
> +----------------
> +
> +cpus {
> +	cpu@0 {
> +		operating-points-v2	= <[OPP list phandle]>;
> +	};
> +};
> +
> +For an example of an OPP list, see ../power/opp-st.txt.

I don't think you need this file/patch at all.. It is almost blank and
doesn't define a binding. And so there is no need to specify this at
all. Just an OPP binding file is enough.

-- 
viresh
