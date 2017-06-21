From: "Wangtao (Kevin, Kirin)" <kevin.wangtao@hisilicon.com>
Subject: Re: [PATCH 1/3] dt-bindings: Document the hi3660 thermal sensor
 bindings
Date: Wed, 21 Jun 2017 10:10:08 +0800
Message-ID: <9cccdaad-df22-0e4e-3c29-69d80e04832c@hisilicon.com>
References: <1497930035-60894-1-git-send-email-kevin.wangtao@hisilicon.com>
 <5948F89F.3070005@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([45.249.212.187]:8768 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752917AbdFUCM3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jun 2017 22:12:29 -0400
In-Reply-To: <5948F89F.3070005@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Xu <xuwei5@hisilicon.com>, rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sunzhaosheng@hisilicon.com, leo.yan@linaro.org



e
( 2017/6/20 18:27, Wei Xu ei:
> Hi Tao,
> 
> On 2017/6/20 4:40, Tao Wang wrote:
>> This adds documentation of device tree bindings for the
>> thermal sensor controller of hi3660 SoC.
>>
>> Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
>> ---
>>   .../devicetree/bindings/thermal/hi3660-thermal.txt |   17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/hi3660-thermal.txt
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/hi3660-thermal.txt b/Documentation/devicetree/bindings/thermal/hi3660-thermal.txt
>> new file mode 100644
>> index 0000000..c034670
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/hi3660-thermal.txt
>> @@ -0,0 +1,17 @@
>> +* Temperature Sensor on hisilicon hi3660 SoC
>> +
>> +** Required properties :
>> +
>> +- compatible: "hisilicon,thermal-hi3660".
> 
> It is better to put the SoC name before the function string.
ok, I will fix it, thank you.
> 
> BR,
> Wei
> 
>> +- reg: physical base address of thermal sensor and length of memory mapped
>> +  region.
>> +- #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
>> +
>> +Example :
>> +
>> +	tsensor: tsensor {
>> +		compatible = "hisilicon,thermal-hi3660";
>> +		reg = <0x0 0xfff30000 0x0 0x1000>;
>> +		#thermal-sensor-cells = <1>;
>> +		status = "ok";
>> +	 };
>>
> 
> 
> .
> 
