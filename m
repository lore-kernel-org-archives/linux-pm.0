From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 15/15] devicetree: bindings: Document qcom,pvs
Date: Wed, 20 Dec 2017 08:56:14 +0530
Message-ID: <20171220032614.GQ19815@vireshk-i7>
References: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
 <1513698900-10638-16-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44631 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754372AbdLTD0T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Dec 2017 22:26:19 -0500
Received: by mail-pl0-f65.google.com with SMTP id n13so8247071plp.11
        for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2017 19:26:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1513698900-10638-16-git-send-email-sricharan@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org

On 19-12-17, 21:25, Sricharan R wrote:
> +	cpu@0 {
> +		compatible = "qcom,krait";
> +		enable-method = "qcom,kpss-acc-v1";
> +		device_type = "cpu";
> +		reg = <0>;
> +		qcom,acc = <&acc0>;
> +		qcom,saw = <&saw0>;
> +		clocks = <&kraitcc 0>;
> +		clock-names = "cpu";
> +		cpu-supply = <&smb208_s2a>;
> +		operating-points-v2 = <&cpu_opp_table>;
> +	};
> +
> +	qcom,pvs {
> +		qcom,pvs-format-a;
> +	};

Not sure what Rob is going to say on that :)

> +
> +
> +	cpu_opp_table: opp_table {
> +		compatible = "operating-points-v2";
> +
> +		/*
> +		 * Missing opp-shared property means CPUs switch DVFS states
> +		 * independently.
> +		 */
> +
> +		opp-1400000000 {
> +			opp-hz = /bits/ 64 <1400000000>;
> +			opp-microvolt-speed0-pvs0-v0 = <1250000>;

Why speed0 and v0 in all the names ?

-- 
viresh
