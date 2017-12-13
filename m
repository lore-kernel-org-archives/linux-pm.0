From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH v4 04/12] clk: qcom: Add HFPLL driver
Date: Wed, 13 Dec 2017 16:40:04 +0530
Message-ID: <929a3c5d-ed62-9cd7-2601-7f7dea6def8c@codeaurora.org>
References: <1512726150-7204-1-git-send-email-sricharan@codeaurora.org>
 <1512726150-7204-5-git-send-email-sricharan@codeaurora.org>
 <20171212203515.gpnu7cnxilkdz4hc@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51610 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbdLMLKN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 06:10:13 -0500
In-Reply-To: <20171212203515.gpnu7cnxilkdz4hc@rob-hp-laptop>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org

Hi Rob,
  Thanks for the review.

On 12/13/2017 2:05 AM, Rob Herring wrote:
> On Fri, Dec 08, 2017 at 03:12:22PM +0530, Sricharan R wrote:
>> From: Stephen Boyd <sboyd@codeaurora.org>
>>
>> On some devices (MSM8974 for example), the HFPLLs are
>> instantiated within the Krait processor subsystem as separate
>> register regions. Add a driver for these PLLs so that we can
>> provide HFPLL clocks for use by the system.
>>
>> Cc: <devicetree@vger.kernel.org>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>  .../devicetree/bindings/clock/qcom,hfpll.txt       |  40 ++++++++
>>  drivers/clk/qcom/Kconfig                           |   8 ++
>>  drivers/clk/qcom/Makefile                          |   1 +
>>  drivers/clk/qcom/hfpll.c                           | 106 +++++++++++++++++++++
>>  4 files changed, 155 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,hfpll.txt
>>  create mode 100644 drivers/clk/qcom/hfpll.c
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,hfpll.txt b/Documentation/devicetree/bindings/clock/qcom,hfpll.txt
>> new file mode 100644
>> index 0000000..fee92bb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,hfpll.txt
>> @@ -0,0 +1,40 @@
>> +High-Frequency PLL (HFPLL)
>> +
>> +PROPERTIES
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: must be "qcom,hfpll"
> 
> Fine for a fallback, but please add SoC specific compatibles.
> 

 sure, will all add them.

>> +
>> +- reg:
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: address and size of HPLL registers. An optional second
>> +		    element specifies the address and size of the alias
>> +		    register region.
>> +
>> +- clock-output-names:
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: Name of the PLL. Typically hfpllX where X is a CPU number
>> +		    starting at 0. Otherwise hfpll_Y where Y is more specific
>> +		    such as "l2".
>> +
>> +Example:
>> +
>> +1) An HFPLL for the L2 cache.
>> +
>> +	clock-controller@f9016000 {
>> +		compatible = "qcom,hfpll";
>> +		reg = <0xf9016000 0x30>;
>> +		clock-output-names = "hfpll_l2";
>> +	};
>> +
>> +2) An HFPLL for CPU0. This HFPLL has the alias register region.
>> +
>> +	clock-controller@f908a000 {
>> +		compatible = "qcom,hfpll";
>> +		reg = <0xf908a000 0x30>, <0xf900a000 0x30>;
>> +		clock-output-names = "hfpll0";
>> +	};
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 20b5d6f..6c811bd 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -205,3 +205,11 @@ config SPMI_PMIC_CLKDIV
>>  	  Technologies, Inc. SPMI PMIC. It configures the frequency of
>>  	  clkdiv outputs of the PMIC. These clocks are typically wired
>>  	  through alternate functions on GPIO pins.
>> +
>> +config QCOM_HFPLL
>> +	tristate "High-Frequency PLL (HFPLL) Clock Controller"
>> +	depends on COMMON_CLK_QCOM
>> +	help
>> +	  Support for the high-frequency PLLs present on Qualcomm devices.
>> +	  Say Y if you want to support CPU frequency scaling on devices
>> +	  such as MSM8974, APQ8084, etc.
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index 4795e21..4a4bf38 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -36,3 +36,4 @@ obj-$(CONFIG_MSM_MMCC_8996) += mmcc-msm8996.o
>>  obj-$(CONFIG_QCOM_CLK_RPM) += clk-rpm.o
>>  obj-$(CONFIG_QCOM_CLK_SMD_RPM) += clk-smd-rpm.o
>>  obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
>> +obj-$(CONFIG_QCOM_HFPLL) += hfpll.o
>> diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
>> new file mode 100644
>> index 0000000..7405bb6
>> --- /dev/null
>> +++ b/drivers/clk/qcom/hfpll.c
>> @@ -0,0 +1,106 @@
>> +/*
>> + * Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
> 
> It's 2017.
> 

 ok.

>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
> 
> Use SPDX tags.
> 

 ok.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
