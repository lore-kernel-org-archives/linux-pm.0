From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v5 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
Date: Fri, 30 May 2014 09:31:49 +0200
Message-ID: <20140530093149.2e41bfb9@amdc2363>
References: <1401374319-4480-1-git-send-email-thomas.ab@samsung.com>
 <1401374319-4480-3-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:37296 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751AbaE3HcC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 May 2014 03:32:02 -0400
In-reply-to: <1401374319-4480-3-git-send-email-thomas.ab@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>, kgene.kim@samsung.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, viresh.kumar@linaro.org, t.figa@samsung.com, rjw@rjwysocki.net, Rob Herring <robh+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, Kumar Gala <galak@codeaurora.org>

Hi Thomas,

> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> Add a new optional boost-frequency binding for specifying the
> frequencies usable in boost mode.
> 
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-boost.txt  |   38
> ++++++++++++++++++++ 1 file changed, 38 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
> 
> diff --git
> a/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
> b/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt new
> file mode 100644 index 0000000..63ed0fc --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
> @@ -0,0 +1,38 @@
> +* Device tree binding for CPU boost frequency (aka over-clocking)
> +
> +Certain CPU's can be operated in optional 'boost' mode (or sometimes
> referred as +overclocking) in which the CPU can operate at
> frequencies which are not +specified by the manufacturer as CPU's
> operating frequency. +
> +Optional Properties:
> +- boost-frequencies: list of frequencies in KHz to be used only in
> boost mode.
> +  This list should be a subset of frequencies listed in
> "operating-points"
> +  property. Refer to Documentation/devicetree/bindings/power/opp.txt
> for
> +  details about "operating-points" property.
> +
> +Example:
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <0>;
> +
> +			operating-points = <
> +				1500000 1350000
> +				1400000 1287500
> +				1300000 1250000
> +				1200000 1187500
> +				1100000 1137500
> +				1000000 1087500
> +			>;
> +			boost-frequencies = <1500000 1400000>;
> +		};
> +		cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a9";
> +			reg = <1>;
> +		};
> +	};

Acked-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
