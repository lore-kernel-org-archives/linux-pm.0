Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64823EC2EB
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782470219; cv=none; b=aOpjuzGvzor51RUG/u/BoN1IR/lYktOe9SC/QeA0SsQneeTS6LdX+ciTuZH5IlfZirRQh+q9JDdGBFruJCNH87FeaAtwFTfI743g+HkhWw7OC9GLS9J7SA8Ytl1WfVOPstBzioOIVG+ZJtw7LP/sLHGmpZ3tZ/xdDZ2wL8F6ca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782470219; c=relaxed/simple;
	bh=UYLMSQIhe6qO0sm3exwD+uQX3V04ifUVR98mAMtFHoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgMobTRnntxTGfOUCmexLSJzOUAJ8N3H/szq9e3ulzzkajM6pe7bEEBqXqZgBYV0LYyBZHE1QbxTLJuQ1YMJu0pj24yx5J2aM2AjudYMslriNOD6bUxBk/UWLPbCJnbyHqTn619FHdvU8Pm4Ol7QZZIEMH1425dGiVT+X5Rp5zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2j3FV8Z; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2j3FV8Z"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4627adcf4d6so513481f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 03:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782470212; x=1783075012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+LOxUqboNwspW3Z1iwsJeIpREU5uApJLby1JgVSadY=;
        b=F2j3FV8Zpg7Th038twotiuqJ1ag7ZpI/hjVGwW7cRO0MXKIUMcdcIsPHbCLvc1iZYy
         Ed6LUa9pMPAaFL2I6k3PPFTMnDZ705zw2nSXxKSKSPHvkKZ7CVZ0STeECFuRza6FI3fS
         vSjVEqVrwFoZ8h/epXLqKpkHXFnYzoV1LaRYEz0n3gxiotRPjIlbT5jup6PQuY5ug0+d
         RLo4HSL+gMyl4xJ7/rex8ecPEoHQ5AE7npABnkK4B3sE5y5/MXMdj9laNLDjl88zAeEL
         5AYCs60fx41Ao6ytq8tOqyFhL2UOFN7xzW+thLTRri0z1DoCNbluYo7ht8J210KG8Thf
         o89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782470212; x=1783075012;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+LOxUqboNwspW3Z1iwsJeIpREU5uApJLby1JgVSadY=;
        b=e2LadL9457+pTYcL+yA71I1FoTUAR5ip/wsxtvfg4k3H3GkFzqq/vpE4J4HSIx1w4J
         npQaXhGqofB0Wli+dNPB6pwAJobDBPi9fhKsY84bPl9DgIB0iHRKCv4NvKRI3VArFISy
         bvbTczbsXq7WhRTQ2YgXybpcCCOGt0YF3gdvpRvSO0XCTNhQ+o8RSlOyNMvDYmDcGPne
         g36+qhSymLAzb1/bEZTTyFF2xlLXGM6oD6OV4nA+OuxGkoF10hGqA0mBpx8ZhIATz0hJ
         YBPo9vOVONAs7VR3HR5VWRwwtINBA0hZ+4y6uqx+nUJpxwvZKJnF998oMAG7JF+HEjDG
         c2/w==
X-Gm-Message-State: AOJu0YxLFenGyw6nYxCKDBjMLU8d81WWhpmAtYp0gbae6Rz5d+J8NG3m
	g0rDI03g2EyxuqN1O1GK1PZXHk11PKqbOfnb5qifYCv7JNnEICHx8kUF
X-Gm-Gg: AfdE7clp2tXWSLS7O9OBWHdKlJnqasJh9xIWg0o4tUItg0KRPl/iC5tTJJ/YIGE8y0+
	xFMKNyMhw2GUWYElTQ/X3XM5rIYVEj2wrMQqxOtNtU9nrfYHWlLyyIM9vx2hAWXnQ511YGAORvF
	rHwFHirj6uI+DVgOctc5bnw4ExMOfx+fQxu1QiLIW+jmK27cnDmoEI8HFTgB4ORMb4OgjghjdBB
	i9fiI/kpld5Ku+VBIBG2TMNf/Qcca8VGeZ67Foju/qOZADQ3qb/IUAgyWoQSgvz/7C0fBuhOKc/
	ZVYo15IgeYyKTNVwmzuXn3BqDT0Y9zGGw8D/QNN79RwLGF2xyglLE7xVvIY2d+/8jzs7OFhyDog
	AKRMEWKK4nXzVY7a+okYLVOKFwCnLw/eEHW4QDLKCLjqanyeryW6lecsDT2ZCZcO+UyBAA9UzRi
	j0rnl/ByPCWzgpocvEtuFRumSsR8NeIfOkLXYeqBCXgpKRIXcxSK6VeTE=
X-Received: by 2002:a5d:6f11:0:b0:46e:341b:45dd with SMTP id ffacd0b85a97d-46e341b47c7mr8297132f8f.26.1782470211515;
        Fri, 26 Jun 2026 03:36:51 -0700 (PDT)
Received: from [192.168.0.40] (a89-182-137-217.net-htp.de. [89.182.137.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46dd5f9da4fsm15043736f8f.23.2026.06.26.03.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 03:36:50 -0700 (PDT)
Message-ID: <2a69d701-741b-4d65-bdbe-226610bf53b5@gmail.com>
Date: Fri, 26 Jun 2026 12:36:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] riscv: dts: spacemit: Add cpu scaling for K1 SoC
To: Shuwei Wu <shuwei.wu@mailbox.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 devicetree@vger.kernel.org
References: <20260626-shadow-deps-v4-0-bba9831f2f1d@mailbox.org>
 <20260626-shadow-deps-v4-2-bba9831f2f1d@mailbox.org>
From: Andre Heider <a.heider@gmail.com>
Content-Language: de-DE
In-Reply-To: <20260626-shadow-deps-v4-2-bba9831f2f1d@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.06.26 10:10 AM, Shuwei Wu wrote:
> Add CPU clock properties and OPP tables for the two CPU clusters in the
> SpacemiT K1 SoC. The OPP entries use voltage ranges because the CPU
> supply is shared by both clusters.
> 
> Enable CPU DVFS on Banana Pi BPI-F3 by including the OPP tables and
> wiring the CPU nodes to the CPU regulator supply.
> 
> Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>

With the musepi-pro dts enablement patch [0] on top, this is
Tested-by: Andre Heider <a.heider@gmail.com> # k1-musepi-pro

Works as advertised, I get two policies, matching the clusters:
$ cat /sys/devices/system/cpu/cpufreq/policy0/related_cpus
0 1 2 3
$ cat /sys/devices/system/cpu/cpufreq/policy4/related_cpus
4 5 6 7

Some time after boot:
$ cat /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state
614400 31124
819000 185
1000000 158
1228800 341
1600000 1148
$ cat /sys/devices/system/cpu/cpufreq/policy4/stats/time_in_state
614400 29232
819000 198
1000000 212
1228800 443
1600000 3428

Creating one single-threaded load increases max freq time_in_state in one policy (4 here):
$ yes > /dev/null &
(...after some time)
$ cat /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state
614400 45244
819000 187
1000000 169
1228800 345
1600000 1148
$ cat /sys/devices/system/cpu/cpufreq/policy4/stats/time_in_state
614400 38794
819000 201
1000000 226
1228800 450
1600000 7580

Creating load for all 8 cores in both:
$ yes > /dev/null &
$ yes > /dev/null &
$ yes > /dev/null &
$ yes > /dev/null &
$ yes > /dev/null &
$ yes > /dev/null &
$ yes > /dev/null &
$ yes > /dev/null &

$ cat /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state
614400 51371
819000 190
1000000 171
1228800 352
1600000 4391
$ cat /sys/devices/system/cpu/cpufreq/policy4/stats/time_in_state
614400 44121
819000 203
1000000 244
1228800 452
1600000 11812

Thanks!
Andre

[0] https://lore.kernel.org/all/20260614122812.2287506-1-a.heider@gmail.com/

> ---
> Changes in v4:
> - Use separate OPP tables for the two CPU clock clusters
> - Use voltage ranges for the shared CPU supply
> 
> Changes in v3:
> - Use one shared CPU OPP table for all CPUs
> 
> Changes in v2:
> - Add k1-opp.dtsi with OPP tables for both CPU clusters
> - Assign CPU supplies and include OPP table for Banana Pi BPI-F3
> ---
> ---
>   arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts |  35 +++++++-
>   arch/riscv/boot/dts/spacemit/k1-opp.dtsi        | 105 ++++++++++++++++++++++++
>   arch/riscv/boot/dts/spacemit/k1.dtsi            |   8 ++
>   3 files changed, 147 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> index 444c3b1e6f44..487179f7b9b9 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> @@ -4,6 +4,7 @@
>    */
>   
>   #include "k1.dtsi"
> +#include "k1-opp.dtsi"
>   #include "k1-pinctrl.dtsi"
>   
>   / {
> @@ -86,6 +87,38 @@ &combo_phy {
>   	status = "okay";
>   };
>   
> +&cpu_0 {
> +	cpu-supply = <&buck1_0v9>;
> +};
> +
> +&cpu_1 {
> +	cpu-supply = <&buck1_0v9>;
> +};
> +
> +&cpu_2 {
> +	cpu-supply = <&buck1_0v9>;
> +};
> +
> +&cpu_3 {
> +	cpu-supply = <&buck1_0v9>;
> +};
> +
> +&cpu_4 {
> +	cpu-supply = <&buck1_0v9>;
> +};
> +
> +&cpu_5 {
> +	cpu-supply = <&buck1_0v9>;
> +};
> +
> +&cpu_6 {
> +	cpu-supply = <&buck1_0v9>;
> +};
> +
> +&cpu_7 {
> +	cpu-supply = <&buck1_0v9>;
> +};
> +
>   &emmc {
>   	bus-width = <8>;
>   	mmc-hs400-1_8v;
> @@ -201,7 +234,7 @@ pmic@41 {
>   		dldoin2-supply = <&buck5>;
>   
>   		regulators {
> -			buck1 {
> +			buck1_0v9: buck1 {
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <3450000>;
>   				regulator-ramp-delay = <5000>;
> diff --git a/arch/riscv/boot/dts/spacemit/k1-opp.dtsi b/arch/riscv/boot/dts/spacemit/k1-opp.dtsi
> new file mode 100644
> index 000000000000..4cebfcd87485
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/k1-opp.dtsi
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/ {
> +	cluster0_opp_table: opp-table-cluster0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-614400000 {
> +			opp-hz = /bits/ 64 <614400000>;
> +			opp-microvolt = <950000 950000 1050000>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-819000000 {
> +			opp-hz = /bits/ 64 <819000000>;
> +			opp-microvolt = <950000 950000 1050000>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-microvolt = <950000 950000 1050000>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-1228800000 {
> +			opp-hz = /bits/ 64 <1228800000>;
> +			opp-microvolt = <950000 950000 1050000>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-1600000000 {
> +			opp-hz = /bits/ 64 <1600000000>;
> +			opp-microvolt = <1050000 1050000 1050000>;
> +			clock-latency-ns = <200000>;
> +		};
> +	};
> +
> +	cluster1_opp_table: opp-table-cluster1 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-614400000 {
> +			opp-hz = /bits/ 64 <614400000>;
> +			opp-microvolt = <950000 950000 1050000>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-819000000 {
> +			opp-hz = /bits/ 64 <819000000>;
> +			opp-microvolt = <950000 950000 1050000>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-microvolt = <950000 950000 1050000>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-1228800000 {
> +			opp-hz = /bits/ 64 <1228800000>;
> +			opp-microvolt = <950000 950000 1050000>;
> +			clock-latency-ns = <200000>;
> +		};
> +
> +		opp-1600000000 {
> +			opp-hz = /bits/ 64 <1600000000>;
> +			opp-microvolt = <1050000 1050000 1050000>;
> +			clock-latency-ns = <200000>;
> +		};
> +	};
> +};
> +
> +&cpu_0 {
> +	operating-points-v2 = <&cluster0_opp_table>;
> +};
> +
> +&cpu_1 {
> +	operating-points-v2 = <&cluster0_opp_table>;
> +};
> +
> +&cpu_2 {
> +	operating-points-v2 = <&cluster0_opp_table>;
> +};
> +
> +&cpu_3 {
> +	operating-points-v2 = <&cluster0_opp_table>;
> +};
> +
> +&cpu_4 {
> +	operating-points-v2 = <&cluster1_opp_table>;
> +};
> +
> +&cpu_5 {
> +	operating-points-v2 = <&cluster1_opp_table>;
> +};
> +
> +&cpu_6 {
> +	operating-points-v2 = <&cluster1_opp_table>;
> +};
> +
> +&cpu_7 {
> +	operating-points-v2 = <&cluster1_opp_table>;
> +};
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> index 529ec68e9c23..bdd109b81730 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -54,6 +54,7 @@ cpu_0: cpu@0 {
>   			compatible = "spacemit,x60", "riscv";
>   			device_type = "cpu";
>   			reg = <0>;
> +			clocks = <&syscon_apmu CLK_CPU_C0_CORE>;
>   			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
> @@ -84,6 +85,7 @@ cpu_1: cpu@1 {
>   			compatible = "spacemit,x60", "riscv";
>   			device_type = "cpu";
>   			reg = <1>;
> +			clocks = <&syscon_apmu CLK_CPU_C0_CORE>;
>   			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
> @@ -114,6 +116,7 @@ cpu_2: cpu@2 {
>   			compatible = "spacemit,x60", "riscv";
>   			device_type = "cpu";
>   			reg = <2>;
> +			clocks = <&syscon_apmu CLK_CPU_C0_CORE>;
>   			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
> @@ -144,6 +147,7 @@ cpu_3: cpu@3 {
>   			compatible = "spacemit,x60", "riscv";
>   			device_type = "cpu";
>   			reg = <3>;
> +			clocks = <&syscon_apmu CLK_CPU_C0_CORE>;
>   			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
> @@ -174,6 +178,7 @@ cpu_4: cpu@4 {
>   			compatible = "spacemit,x60", "riscv";
>   			device_type = "cpu";
>   			reg = <4>;
> +			clocks = <&syscon_apmu CLK_CPU_C1_CORE>;
>   			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
> @@ -204,6 +209,7 @@ cpu_5: cpu@5 {
>   			compatible = "spacemit,x60", "riscv";
>   			device_type = "cpu";
>   			reg = <5>;
> +			clocks = <&syscon_apmu CLK_CPU_C1_CORE>;
>   			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
> @@ -234,6 +240,7 @@ cpu_6: cpu@6 {
>   			compatible = "spacemit,x60", "riscv";
>   			device_type = "cpu";
>   			reg = <6>;
> +			clocks = <&syscon_apmu CLK_CPU_C1_CORE>;
>   			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
> @@ -264,6 +271,7 @@ cpu_7: cpu@7 {
>   			compatible = "spacemit,x60", "riscv";
>   			device_type = "cpu";
>   			reg = <7>;
> +			clocks = <&syscon_apmu CLK_CPU_C1_CORE>;
>   			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
> 

