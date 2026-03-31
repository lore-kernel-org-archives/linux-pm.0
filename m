Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7EA43D4EA
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980028; cv=none; b=jAPKBhB8ipo1NUt99C0xo2itycHmpH4zossD21HB+PRmayJiPLViJXldJqf/9T+VGVRuHsRCFpLZmFB9CusUWlYLmCTCp62e0ZazJ+vXBQ6EH/tLqeH/yZXdLieGkgs99RdLSzopHB5+GrOL7lzp2PSTlOTZuzB9GnJ9XPTWxA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980028; c=relaxed/simple;
	bh=qkF7LCy5dw2bwyara7za2iN2mL7PefiNtH+7ums/WFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsCR1rveNv2LVSW7Le3I2GpNQqnDdiNnX3zOILQ2+ESbAuJh7b4uHaFph5yu9CfkpQqeYvrdBf7uGptSjmWwQVJM+bYJElj4kA3fhaSrCkzswMmMMSMqr/TXGWpkY3B6t6Xi4Zy4c/Kk4Hdl7XGO9ZhELDgX3Acky3pjPvxH6EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mJGBOu7c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BrGIMF0F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mJGBOu7c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BrGIMF0F"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VGdcpp453797
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 18:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TS3a+ptOlcMaz3jbXy49Anmk6ZAeQ1zF4OuWWpLrnuI=; b=mJGBOu7cmnVlWToe
	p26xjkmWqNlEUU2kL0ft4DSZNw7b9Aaj8gs5oNf8YbiYGW3yTT5x1UeRAjrFDMjb
	pnK0neiAJtrjjZAW7sEByzwzTFG7pdwiUWfLo/wRI+e8X1sYCWriQ9oc5kDIsUFp
	iT+1BumGzjRS4V/eUzFo8oRuBRFKtjfxDFsEwv+4HP/gNREeWEs1B0rYggtqWFwc
	esIy7WDvb8/IZV3fnslc2mbnRnOEE294HdCQdkUtBK2w9zYY8Vw3060w/yX8Oxes
	Dx9l83OddKeHGS2/8ndTiwzPp0ktwKp/1M082bqPAArGMEXHwT4IzB+yMWsQLJb6
	x1Ba0w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d80rsmmcx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 18:00:21 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c76bb22a8ceso255107a12.2
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 11:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774980021; x=1775584821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TS3a+ptOlcMaz3jbXy49Anmk6ZAeQ1zF4OuWWpLrnuI=;
        b=BrGIMF0FjsGiaQAh7FbSIpD5gw8dA7NnHjhQLJmWOUv9O5odMc1SU7FBvwbI3+CN+T
         aXJodWdYVXTzNdwnLB6M+IZlOX8b+iAmCy2+TA+hHvW8KjhFZ1pSkEypcyDmJLaJ7P/2
         Q3QWeRDEO37B7azwsBjZzeQ+JRawrJh/pWcMbRQMFb/PNx3wvFMscMTSJGEbcbqj0RVH
         xa+55ks4tJHFfqHrwxc3B9lnTpB7SFADPFl94z44MrSx+34dp8w7vP2qc5uppzPbVTrw
         fbEYrZF2At9DnR0ZljbtTy/CZcXJzSmFv4DufrTudBm3tdyNZuXEiJPpHJGTQEz+3+/K
         lRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774980021; x=1775584821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TS3a+ptOlcMaz3jbXy49Anmk6ZAeQ1zF4OuWWpLrnuI=;
        b=KZXxH3VYfO7HzI7lRs8pMm6WWDkMCUhM+NmaozYIUEnuc5Sg6nEgw3ok9zN0VZX94O
         a0QmjKXFaoOXNCsdg9jG7kDDRggCxabS6imeBeq7BwaZqgiXjF3eKycXBVga1OMnstf7
         sWX8xSQkpvKKH9LZM5LpE6GQbO4lTzPmHM1w5e8PdL0y8hSFdrcEFU+fIpT9m1xRpIZX
         Hei1l58idAhzUdQhRNSdVbTobfZye08q/pMLwEEqslymVIpf2igqg8wnCkzLnBKj8iLL
         JrsKoV5mZij1x5HKuUKog2bgRn7/XRllRU0k5PIWff+2NhyEl1t0poA5sDCYldR6l77v
         RHiw==
X-Forwarded-Encrypted: i=1; AJvYcCUPUz4xr2bH3YtpQ+cLEdkzyOOhJtohoHr7bc0KEdhE9axCxXP0zjRqssOcfmrpqapwfxQjG7y0/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcLebUqSU2lZxLm5IFfcFam00uWywrww7lzHKKl2YUUD/UFwIf
	Z9IwY1c8d8Xl4mXG9ZuF1rskjp+srwcfYiR0PsZi5YK38Myvonec5cYXKrgouqKvcbgA4YXZHNf
	TyZqdzKe4pvrWVaZnv7/HeOPt1581WZKb82wOM/ECSRheyMoLYKiH/n0k76RxiA==
X-Gm-Gg: ATEYQzwzrOsqfFQ/R2uiO5JHPF381939mSDFOlAULCNFlvDoZDFaZP8BKODsipvca6T
	se3gkHEd+Bm5CaF0TFu3K3+mq1QAUJoFETvz+qD8wJbe7zfY+dw9kwjg4LwJ5+25mVP/Yoh7Klg
	Je0nXWli++MbZRrjL/vLWS2k9wucBFo7qXRUY8Js3PJ9al8XWiF2dM3iGl0Muh7b8uJQM9zvlBk
	Q8w8M+jVGQIfM12kiSJVA+4x6H85K5YukVML5akgLCBT1ZwFFmQX8KA9p0faWVG8d7/m9xM16Ao
	YCheFb7qael4pr5qyL0rEkqbyffI2LWoASPuhCDVtauESFpmcam6hZlQFrDkYDh7Xn2oRcXpO1B
	FVEYx4Sgaxrks91vPg068i8r/VagJybBiD1peqYAd4/UKDkdhoSeQ9b4=
X-Received: by 2002:a05:6a00:278a:b0:82a:6e7f:4c14 with SMTP id d2e1a72fcca58-82ce89b58c1mr495096b3a.27.1774980020659;
        Tue, 31 Mar 2026 11:00:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:278a:b0:82a:6e7f:4c14 with SMTP id d2e1a72fcca58-82ce89b58c1mr495025b3a.27.1774980019787;
        Tue, 31 Mar 2026 11:00:19 -0700 (PDT)
Received: from [192.168.29.31] ([49.43.225.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85fc72asm11012404b3a.48.2026.03.31.11.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 11:00:19 -0700 (PDT)
Message-ID: <93a78bc2-4fd1-41bd-bf4a-b433b06fc218@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 23:30:09 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 06/10] power: reset: Add psci-reboot-mode driver
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan
 <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz
 <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla
 <sudeep.holla@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>
References: <20260304-arm-psci-system_reset2-vendor-reboots-v20-0-cf7d346b8372@oss.qualcomm.com>
 <20260304-arm-psci-system_reset2-vendor-reboots-v20-6-cf7d346b8372@oss.qualcomm.com>
 <acaMPgRALnoUIHMC@lpieralisi>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <acaMPgRALnoUIHMC@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: F1hxBA5MTA2AWEPcwh8QhqVBS8AUUXyV
X-Authority-Analysis: v=2.4 cv=VInQXtPX c=1 sm=1 tr=0 ts=69cc0bb5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=mO+zk3XXGlxjkZV6yCQMJw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=xx8M9eIzLlJJCfGiN1QA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: F1hxBA5MTA2AWEPcwh8QhqVBS8AUUXyV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE3MyBTYWx0ZWRfXy+rHJUgYBXi8
 ieDcm3IhuLoo3K6gPfWinRzaLhM/07ZtxNoWIhGansye+JILRkdoogwAo8XGAu+Z4IvIQpLD61y
 +31OhXXTT3qnRfD0fJDmh04DYlplMFhK9S10vpct4bdOxmuWILyCoENPFs5AELn+HiwuUWbyuC0
 Z0Py+eoE3dKGwWsKwroP6H5U7lhtPHebfFvnrFQ/Y8XL3AZppXlseaUxEOFi39Qk/N6OH1WgXtb
 Hkf0jKBR4vJ75FszKx7SlY28a4N8EiA1LdnklMrj9oIEANJygNVDjym4W+YmnZQGxEPhYnups/G
 jg94+CkYPjFQa8PS6cwxZwI9OKQjH225Gv8MeECf5oAMUWJnQP3agd5pT7yxnanyagP/nVZSbsj
 qVY8zUQUiaZOxLf1+dUzkoe3JadkpIA5W3E53eN2yC2oZFLc3dvW2bV9APq33KuSq4esb4M9RN7
 R5fj61/MTm/VJ1ONGJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_04,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310173



On 27-03-2026 19:25, Lorenzo Pieralisi wrote:
> On Wed, Mar 04, 2026 at 11:33:06PM +0530, Shivendra Pratap wrote:
>> PSCI supports different types of resets like COLD reset, ARCH WARM
>> reset, vendor-specific resets. Currently there is no common driver that
>> handles all supported psci resets at one place. Additionally, there is
>> no common mechanism to issue the supported psci resets from userspace.
>>
>> Add a PSCI reboot mode driver and define two types of PSCI resets in the
>> driver as reboot-modes: predefined resets controlled by Linux
>> reboot_mode and customizable resets defined by SoC vendors in their
>> device tree under the psci:reboot-mode node.
>>
>> Register the driver with the reboot-mode framework to interface these
>> resets to userspace. When userspace initiates a supported command, pass
>> the reset arguments to the PSCI driver to enable command-based reset.
>>
>> This change allows userspace to issue supported PSCI reset commands
>> using the standard reboot system calls while enabling SoC vendors to
>> define their specific resets for PSCI.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>   drivers/power/reset/Kconfig            |  10 +++
>>   drivers/power/reset/Makefile           |   1 +
>>   drivers/power/reset/psci-reboot-mode.c | 119 +++++++++++++++++++++++++++++++++
>>   3 files changed, 130 insertions(+)
>>
>> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
>> index f6c1bcbb57deff3568d6b1b326454add3b3bbf06..529d6c7d3555601f7b7e6199acd29838030fcef2 100644
>> --- a/drivers/power/reset/Kconfig
>> +++ b/drivers/power/reset/Kconfig
>> @@ -348,6 +348,16 @@ config NVMEM_REBOOT_MODE
>>   	  then the bootloader can read it and take different
>>   	  action according to the mode.
>>   
>> +config PSCI_REBOOT_MODE
>> +	bool "PSCI reboot mode driver"
>> +	depends on OF && ARM_PSCI_FW
>> +	select REBOOT_MODE
>> +	help
>> +	  Say y here will enable PSCI reboot mode driver. This gets
>> +          the PSCI reboot mode arguments and passes them to psci
>> +	  driver. psci driver uses these arguments for issuing
>> +	  device reset into different boot states.
>> +
>>   config POWER_MLXBF
>>   	tristate "Mellanox BlueField power handling driver"
>>   	depends on (GPIO_MLXBF2 || GPIO_MLXBF3) && ACPI
>> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
>> index 0e4ae6f6b5c55729cf60846d47e6fe0fec24f3cc..49774b42cdf61fd57a5b70f286c65c9d66bbc0cb 100644
>> --- a/drivers/power/reset/Makefile
>> +++ b/drivers/power/reset/Makefile
>> @@ -40,4 +40,5 @@ obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
>>   obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
>>   obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
>>   obj-$(CONFIG_NVMEM_REBOOT_MODE) += nvmem-reboot-mode.o
>> +obj-$(CONFIG_PSCI_REBOOT_MODE) += psci-reboot-mode.o
>>   obj-$(CONFIG_POWER_MLXBF) += pwr-mlxbf.o
>> diff --git a/drivers/power/reset/psci-reboot-mode.c b/drivers/power/reset/psci-reboot-mode.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..86bef195228b0924704c2936b99f6801c14ff1b1
>> --- /dev/null
>> +++ b/drivers/power/reset/psci-reboot-mode.c
>> @@ -0,0 +1,119 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/device/faux.h>
>> +#include <linux/device.h>
> 
> Nit: swap the two.

Ack. thanks.


>> +#include <linux/err.h>
>> +#include <linux/of.h>
>> +#include <linux/psci.h>
>> +#include <linux/reboot.h>
>> +#include <linux/reboot-mode.h>
>> +#include <linux/types.h>
>> +
>> +/*
>> + * Predefined reboot-modes are defined as per the values
>> + * of enum reboot_mode defined in the kernel: reboot.c.
>> + */
>> +static struct mode_info psci_resets[] = {
>> +	{ .mode = "warm", .magic = REBOOT_WARM},
>> +	{ .mode = "soft", .magic = REBOOT_SOFT},
>> +	{ .mode = "cold", .magic = REBOOT_COLD},
>> +};
>> +
>> +static void psci_reboot_mode_set_predefined_modes(struct reboot_mode_driver *reboot)
>> +{
>> +	INIT_LIST_HEAD(&reboot->predefined_modes);
>> +	for (u32 i = 0; i < ARRAY_SIZE(psci_resets); i++) {
>> +		/* Prepare the magic with arg1 as 0 and arg2 as per pre-defined mode */
>> +		psci_resets[i].magic = REBOOT_MODE_MAGIC(0, psci_resets[i].magic);
> 
> This looks weird to me, why can't we just initialize the array with the values
> directly ?

Ack. The idea was to avoid Typecasting. Will check on this.

>> +		INIT_LIST_HEAD(&psci_resets[i].list);
>> +		list_add_tail(&psci_resets[i].list, &reboot->predefined_modes);
>> +	}
>> +}
>> +
>> +/*
>> + * arg1 is reset_type(Low 32 bit of magic).
>> + * arg2 is cookie(High 32 bit of magic).
>> + * If reset_type is 0, cookie will be used to decide the reset command.
>> + */
>> +static int psci_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
>> +{
>> +	u32 reset_type = REBOOT_MODE_ARG1(magic);
>> +	u32 cookie = REBOOT_MODE_ARG2(magic);
>> +
>> +	if (reset_type == 0) {
>> +		if (cookie == REBOOT_WARM || cookie == REBOOT_SOFT)
>> +			psci_set_reset_cmd(true, 0, 0);
>> +		else
>> +			psci_set_reset_cmd(false, 0, 0);
>> +	} else {
>> +		psci_set_reset_cmd(true, reset_type, cookie);
>> +	}
> 
> I don't think that psci_set_reset_cmd() has the right interface (and this
> nested if is too complicated for my taste). All we need to pass is reset-type
> and cookie (and if the reset is one of the predefined ones, reset-type is 0
> and cookie is the REBOOT_* cookie).
> 
> Then the PSCI firmware driver will take the action according to what
> resets are available.
> 
> How does it sound ?

So we mean these checks will move to the psci driver? Sorry for 
re-iterating the question.

>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +static int psci_reboot_mode_register_device(struct faux_device *fdev)
>> +{
>> +	struct reboot_mode_driver *reboot;
>> +	int ret;
>> +
>> +	reboot = devm_kzalloc(&fdev->dev, sizeof(*reboot), GFP_KERNEL);
>> +	if (!reboot)
>> +		return -ENOMEM;
>> +
>> +	psci_reboot_mode_set_predefined_modes(reboot);
>> +	reboot->write = psci_reboot_mode_write;
>> +	reboot->dev = &fdev->dev;
>> +
>> +	ret = devm_reboot_mode_register(&fdev->dev, reboot);
>> +	if (ret) {
>> +		dev_err_probe(&fdev->dev, ret, "devm_reboot_mode_register failed %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init psci_reboot_mode_init(void)
>> +{
>> +	struct device_node *psci_np;
>> +	struct faux_device *fdev;
>> +	struct device_node *np;
>> +	int ret;
>> +
>> +	psci_np = of_find_compatible_node(NULL, NULL, "arm,psci-1.0");
>> +	if (!psci_np)
>> +		return -ENODEV;
>> +	/*
>> +	 * Look for reboot-mode in the psci node. Even if the reboot-mode
>> +	 * node is not defined in psci, continue to register with the
>> +	 * reboot-mode driver and let the dev.ofnode be set as NULL.
>> +	 */
>> +	np = of_find_node_by_name(psci_np, "reboot-mode");
>> +
>> +	fdev = faux_device_create("psci-reboot-mode", NULL, NULL);
> 
> Same comment as Bartosz (have you picked up his work and working towards
> a solution) ?
Working on this via MFD. Some issue as again MFD framework does not 
allows a fwnode based driver registration. Will update.

thanks,
Shivendra
