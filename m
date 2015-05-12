From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: Re: [PATCH RESEND v4 0/2] 96boards: add thermal senor support to
 hikey board
Date: Tue, 12 May 2015 11:12:39 +0800
Message-ID: <55516FA7.3040808@hisilicon.com>
References: <1430707940-14468-1-git-send-email-kong.kongxinwei@hisilicon.com> <20150512013107.GE4810@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:35385 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbbELDLa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2015 23:11:30 -0400
In-Reply-To: <20150512013107.GE4810@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhuang@intel.com, amit.kucheria@linaro.org, punit.agrawal@arm.com, Javi.Merino@arm.com, jorge.ramirez-ortiz@linaro.org, haojian.zhuang@linaro.org, linux-pm@vger.kernel.org, linuxarm@huawei.com, devicetree@vger.kernel.org, dan.zhao@hisilicon.com, liguozhu@hisilicon.com, mporter@konsulko.com, gongyu@hisilicon.com, guodong.xu@linaro.org, robh@kernel.org, leo.yan@linaro.org, zhenwei.wang@hisilicon.com, zhangfei.gao@linaro.org, z.liuxinliang@huawei.com, xuwei5@hisilicon.com, w.f@huawei.com, yuanzhichang@hisilicon.com, mark.rutland@arm.comLeo Yan <leo.yan@linaro.org>



On 2015/5/12 9:31, Eduardo Valentin wrote:
> On Mon, May 04, 2015 at 10:52:18AM +0800, Xinwei Kong wrote:
>> From: kongxinwei <kong.kongxinwei@hisilicon.com>
>>
>> The Linaro connect introduce 96boards series in Hong Kong,The HiKey board
>> is the first board to be certified 96Boards Consumer Edition compatible.
>> This board is based on the HiSilicon SoC. you can get more information
>> from https://www.96boards.org.
>>
>> The hisilicon SoC contains thermal module, this thermal module has 4 sensors,
>>
>> 	- sensor 0: local sensor;
>> 	- sensor 1: remote sensor for ACPU cluster 1;
>> 	- sensor 2: remote sensor for ACPU cluster 2;
>> 	- sensor 3: remote sensor for GPU;
>>
>> It can obtain this device temperature by operating this hardware. The new
>> sensor driver satisfies thermal framework and to realize the ACPU ,GPU and
>> so on to cool function.
>>
>> Changes v0->v1;
>> * Delete this hi6220 dtsi.
>> * Fix documentation and error checks.
>> * Modify this driver which makes use of kernel to decide how to dynamically
>>   bind the interrupt to hottest sensor.
>> * Delete "sensor-thres-temp" property and read thermal_zone trips points
>>   replace of it.
>> * Delete "sensor-reset-temp" property and define the fixed value replace
>>   of it.
>>
>> Changes v1->v2;
>> * change patch's position between binding document and driver file
>> * clean up some regiser for enabling thermal sensor
>> * use mutex lock to replace the spin lock
>>
>> Changes v2->v3;
>> * delete sensor id property in binding document 
>> * fix sensor driver to satisfy sensor register after deleting sensor id
>>   property
>>
>> Changes v3->v4;
>> * using "usleep_range" function instead of "msleep" function
>> * delete code detail error
>>
>> kongxinwei (2):
>>   dt-bindings: Document the hi6220 thermal sensor bindings
>>   thermal: hisilicon: add new hisilicon thermal sensor driver
>>
>>  .../bindings/thermal/hisilicon-thermal.txt         |  23 ++
>>  drivers/thermal/Kconfig                            |   8 +
>>  drivers/thermal/Makefile                           |   1 +
>>  drivers/thermal/hisi_thermal.c                     | 437 +++++++++++++++++++++
> 
> Can you please include a patch adding the DT bindings for a board in you
> next version? Even if the patches don't go in one single tree, it is
> good to review all patches (DT and drivers) in one single patch series.
> 

Ok, accept it.

>>  4 files changed, 469 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
>>  create mode 100644 drivers/thermal/hisi_thermal.c
>>
>> -- 
>> 1.9.1
>>
>>

