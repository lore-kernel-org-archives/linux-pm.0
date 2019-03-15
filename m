From: Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH 0/4] Introduce OPP bandwidth bindings
Date: Sat, 16 Mar 2019 00:32:49 +0530
Message-ID: <460be20a-0baa-cf9c-2d5c-ea825aa34bc4@codeaurora.org>
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190313090010.20534-1-georgi.djakov@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>, vireshk@kernel.org, sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net
Cc: jcrouse@codeaurora.org, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, myungjoo.ham@samsung.com, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org



On 3/13/19 2:30 PM, Georgi Djakov wrote:
> Here is a proposal to extend the OPP bindings with bandwidth based on
> a previous discussion [1].
> 
> Every functional block on a SoC can contribute to the system power
> efficiency by expressing its own bandwidth needs (to memory or other SoC
> modules). This will allow the system to save power when high throughput
> is not required (and also provide maximum throughput when needed).
> 
> There are at least three ways for a device to determine its bandwidth
> needs:
> 	1. The device can dynamically calculate the needed bandwidth
> based on some known variable. For example: UART (baud rate), I2C (fast
> mode, high-speed mode, etc), USB (specification version, data transfer
> type), SDHC (SD standard, clock rate, bus-width), Video Encoder/Decoder
> (video format, resolution, frame-rate)
> 
> 	2. There is a hardware specific value. For example: hardware
> specific constant value (e.g. for PRNG) or use-case specific value that
> is hard-coded.
> 
> 	3. Predefined SoC/board specific bandwidth values. For example:
> CPU or GPU bandwidth is related to the current core frequency and both
> bandwidth and frequency are scaled together.
> 
> This patchset is trying to address point 3 above by extending the OPP
> bindings to support predefined SoC/board bandwidth values and adds
> support in cpufreq-dt to scale the interconnect between the CPU and the
> DDR together with frequency and voltage.

Hey Georgi,
Having opp-bw-MBps as a part of cpu opp does greatly simplify the
problem of scaling multiple interconnect devices with change in cpu
frequency. But there is still a need to scale other devices (non 
interconnect based) according to cpu frequency. Having a devfreq
governor for the same would help to have the same generic solution
across SoCs (msm8916/8996/qcs405/sdm845). The devfreq maintainer did
like the idea but wanted it incorporated into the passive governor.

* 
https://lore.kernel.org/lkml/20180528060014epcms1p87ec68a4d44f9447b06f979a87e545b7d@epcms1p8/

* 
https://lore.kernel.org/lkml/20180802095608epcms1p33fb061543efc9ceb3ec12d5567ceffbc@epcms1p3/

I have a RFC series implementing ddr scaling with passive governor for 
sdm845 with the following bindings, will post it early next week.

cpus {
	...

	CPU0: cpu@0 {
		...
		operating-points-v2 = <&cpu0_opp_table>;
		...
	};
         ....

	CPU4: cpu@400 {
		...
		operating-points-v2 = <&cpu4_opp_table>;
		...
	};
         ...
};

cpu0_opp_table: cpu0_opp_table {
	compatible = "operating-points-v2";
	opp-shared;

	cpu0_opp1: opp-300000000 {
		opp-hz = /bits/ 64 <300000000>;
	};

	...

	cpu0_opp16: opp-1612800000 {
		opp-hz = /bits/ 64 <1612800000>;
	};

	...
};

cpu4_opp_table: cpu4_opp_table {
	compatible = "operating-points-v2";
	opp-shared;

	...

	cpu4_opp4: opp-1056000000 {
		opp-hz = /bits/ 64 <1056000000>;
	};

	cpu4_opp5: opp-1209600000 {
		opp-hz = /bits/ 64 <1209600000>;
	};

	...
};

bw_opp_table: bw-opp-table {
	compatible = "operating-points-v2";

	opp-200  {
		opp-hz = /bits/ 64 < 200000000 >; /* 200 MHz */
		required-opps = <&cpu0_opp1>;
		/* 0 MB/s average and 762 MB/s peak bandwidth */
		opp-bw-MBs = <0 762>;
	};

	opp-300 {
		opp-hz = /bits/ 64 < 300000000 >; /* 300 MHz */
		/* 0 MB/s average and 1144 MB/s peak bandwidth */
		opp-bw-MBs = <0 1144>;
	};

	...

	opp-768 {
		opp-hz = /bits/ 64 < 768000000 >; /* 768 MHz */
		/* 0 MB/s average and 2929 MB/s peak bandwidth */
		opp-bw-MBs = <0 2929>;
		required-opps = <&cpu4_opp4>;
	};

	opp-1017 {
		opp-hz = /bits/ 64 < 1017000000 >; /* 1017 MHz */
		/* 0 MB/s average and 3879 MB/s peak bandwidth */
		opp-bw-MBs = <0 3879>;
		required-opps = <&cpu0_opp16>, <&cpu4_opp5>;
	};
};

cpubw {
	compatible = "devfreq-icbw";
	interconnects = <&snoc MASTER_APSS_1 &bimc SLAVE_EBI_CH0>;
	operating-points-v2 = <&bw_opp_table>;
};


> > [1] https://patchwork.kernel.org/patch/10577315/
> 
> Georgi Djakov (4):
>    dt-bindings: opp: Introduce opp-bw-MBs bindings
>    OPP: Add support for parsing the interconnect bandwidth
>    OPP: Update the bandwidth on OPP frequency changes
>    cpufreq: dt: Add support for interconnect bandwidth scaling
> 
>   Documentation/devicetree/bindings/opp/opp.txt | 45 ++++++++++++
>   drivers/cpufreq/cpufreq-dt.c                  | 27 ++++++-
>   drivers/opp/core.c                            | 71 +++++++++++++++++++
>   drivers/opp/of.c                              | 44 ++++++++++++
>   drivers/opp/opp.h                             |  6 ++
>   include/linux/pm_opp.h                        | 14 ++++
>   6 files changed, 206 insertions(+), 1 deletion(-)
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
