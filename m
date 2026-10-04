Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2773A3F075E
	for <linux-pm@vger.kernel.org>; Sun,  4 Oct 2026 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791098982; cv=none; b=rZyCDAOQHBuNijajguMHuJzrqzH5gTEDowkGIj6V2HLaMd6nmGgoCAW6oLKo0v/e2RBZXTjTX2HWhVb4CJ1/13x4NEmgs4z7IebkTKcOc3fid9a9577U+iZM8/zNPuCSjO3fv9VsSSYcosHruvl6iiWqixm4pUP1kShQqsc7FH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791098982; c=relaxed/simple;
	bh=GDgnDBYuex57tNwK2PhV2zkX2AgKHFJq+4zTbUnDvD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHDb6hPgFuekCxyQBVfQ1FUSzQx9oRXIWK6SuJAiPCLPyKMZjo+sD2F7EqBRIGutX3E5cc/VVbq4xXUUniSYncrEm04VKhXo4pysfulJVBPlXtTLV/5r0jS3YC9didUGA/u/LmWqAGaqTWv+bgkZ1GtAsjvpsLl78iM74Pd+pXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DiJxafqy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z2CY93DF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DiJxafqy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z2CY93DF"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6944KoW61206230
	for <linux-pm@vger.kernel.org>; Sun, 4 Oct 2026 07:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+KFQGxLew24idt7h92w6GenazteN4CrjyYIuOgBPUYM=; b=DiJxafqy06xLrXDX
	A/GX9W/HMYUXIeq0IeqQZhIg20gDXKf8F6v+srhIOmT7z3ND8sAw/fnNtn7U8n/F
	ZzhRkeAjSCcSAm/RxqeD7zXRDjWzpohQDH7qSojyzyybdr3XjGn5qJEGXt/kSnw8
	UnH2e/Cg0fO6vYy7mXcCx0lIGJDRrpvX2wPIoIJj78LnC6rzigPyyAUHNmQNnNxc
	WNHxfGW4DxlxTOXKBfdTDkMOqSZVjKnAX1EHl6zqd5RYRzK6Nv1SLUNhtKSe4OIU
	IWKsEQarDvQ9C+K1K1F0duqeP7lFJ65qlr3i/ed6kkMdBHABm8Qe39OHHw8V0BkC
	UKeyrw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3chfgg4j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 04 Oct 2026 07:29:39 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso993368eec.0
        for <linux-pm@vger.kernel.org>; Sun, 04 Oct 2026 00:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791098979; x=1791703779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+KFQGxLew24idt7h92w6GenazteN4CrjyYIuOgBPUYM=;
        b=Z2CY93DFX/yaVrITF2KSTqTQLfEyIyKrXJNAs/p6N2OHhLvS494tjlKbaBWVEu6d5H
         L1DEOQ8emuk1a8nuNWxgs4ihtfGrzfxEhLD3Q+eaaDNKRQAHvIDkxDpoNRKOWyBhN+oR
         omxVjWyVCc+m0TtpQkqqaoe4jKxtQdMyBSvHSl5xQh4v6LuS1hi+wf4ZZkeCmmPLJdXt
         haB2op7VVkXkOpU5XVGqoLmjvv33yxOVHjN6C2gDE1lCG/qSy+Kq6K0owbj6/7SLJ+xb
         4DaahZSkk+fXSipuwCH7dIiEXP4TLoWalWwhAZ5kSiQWG7ljA1vgCrkcVHEyaLmNdiDS
         3xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791098979; x=1791703779;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+KFQGxLew24idt7h92w6GenazteN4CrjyYIuOgBPUYM=;
        b=bcE87H7BTQwzEcXTlDlQ6+/AE8oHP1g1oJUJ60T0hF6cSqIv6jbaIxTbUarT4cDp96
         EVcLNr49PQx22OQ9IWlNzGEGQaXzHM8q+0Tt8Z2GXdNVgXdROvJwdLQdeB5wXYBbB05V
         RqOOlPsKpDbn1h/5EfnFs0aQAhiFGuFm1wqPQfYYiVXZNE0lOt7iUq9mmzVSaOUOm833
         4j9ZLglL65qG9+nRFU+8Qk3Px5VWKo8ZtJPuUFi6xNB23mLR8/E/HHw6HI5krYocrQYG
         SeKGd7ytEmzus6t4kdivKRO4Hr8ouF6v/VDh9vv5A4JYOgjT5y0CspypbrxCUbKFDXm7
         PUNw==
X-Forwarded-Encrypted: i=1; AKwUvBzeioCSg/lYBCz8QxqlmIfGAnO6/RjGi6ZAsppTmMrQU9q1bHsUHIftUBrCWxt+69f1Ar/SgcE1AQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lh4iK0ZpynC4dfv8+yOZDGJHeGrEP4pDv9cnQV5P9pg+/i9RTp
	ESy1HE8dlP2t1rux8DRmErg0bz59ALjfHtjJydV0K0C3vUkf8woCo7Udkey9K4tZ3iZWuV4VgGt
	rUBnKs70cV4INHgJ2pshidPeKSKC7+Oi+P0ig5deLOpMu04alQtV74kfr04kU3g==
X-Gm-Gg: AYBFou0h6TH5/3jXkFG8SqPv/eB0WYOMoJCLsstwzcLiukJMJ7o3Gpw8Kvs4PBqyzuD
	Te39W/aGoF45TfAWI+c5BwbR56ghz/sLwKCpc4wYhPJ7rgLwO1LLq2oYI8rlr9gW3zHwnTY37fD
	NjxWlOrTl6SMrzhLCMolzSgkmjui4D6pXylsLmOTEeqrVhm3WLecq1viEWaIPXjy8fu8lHILnqJ
	fnxs9LMGmLO3O043PnK2ZNl7oe8pOcwz9RKS/IzPgEjwM8Aa1JTrc7Esg1sfJw7zbWjeeWW3REp
	dn45agFHTK7K6y/bwp5/JrqtBTPsvLplswJXtwd78qKaU3juS6ySUwg20MbMpSZixr3MxeRCqCI
	boZtXHzxuXFZbQ3usmiQsDTaGS+zgFno8eQ==
X-Received: by 2002:a05:701b:21c3:b0:14b:cf58:ce5e with SMTP id a92af1059eb24-14f5615f9d8mr10621690c88.0.1791098978755;
        Sun, 04 Oct 2026 00:29:38 -0700 (PDT)
X-Received: by 2002:a05:701b:21c3:b0:14b:cf58:ce5e with SMTP id a92af1059eb24-14f5615f9d8mr10621645c88.0.1791098978114;
        Sun, 04 Oct 2026 00:29:38 -0700 (PDT)
Received: from [192.168.29.31] ([49.43.234.47])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fc39a6cbsm11463837c88.5.2026.10.04.00.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 00:29:37 -0700 (PDT)
Message-ID: <04f1dcf3-cbf3-476f-bf94-ade87ce267ca@oss.qualcomm.com>
Date: Sun, 4 Oct 2026 12:59:21 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v26 06/10] power: reset: Add psci-reboot-mode driver
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz
 <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti
 <pavan.kondeti@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>
References: <20260928-arm-psci-system_reset2-vendor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com>
 <20260928-arm-psci-system_reset2-vendor-reboots-v26-6-b24e2348e8e1@oss.qualcomm.com>
 <CAMRc=MdSfBvZF4UJm=eBBD-GAJD7oFw3e+6UJeoXgidoPGzm-w@mail.gmail.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CAMRc=MdSfBvZF4UJm=eBBD-GAJD7oFw3e+6UJeoXgidoPGzm-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Li3LeH-B4lMVNLTyOrSwAcnzz8ZDRZpE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA0MDAyOSBTYWx0ZWRfX9VnbaHhNQaVQ
 JSXVfRj9eaEtgIBtj5/fCSTjhK/SH4C/+AZusrLjvyc5oMU93pl+qscijqBYOfHd7wJJ0x/AAhT
 WcLsQLpjTgRLb9oXwocow68olek5hfA=
X-Authority-Analysis: v=2.4 cv=eZSo7LEH c=1 sm=1 tr=0 ts=6ac20063 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Q9iloZ37mN+2Fnqau1qSyQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=3VLVDtZA9RXrKpJcTyoA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: Li3LeH-B4lMVNLTyOrSwAcnzz8ZDRZpE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA0MDAyOSBTYWx0ZWRfX71He4WSgDuoG
 +av6CrZsuh91PW8S1M5dPDBHIeD7gpqtDcf8GqhIPbfOE16oBMLIHGv13wsXgfBRCvnqIika6fy
 Gy3uJq0Ej6+HwhreVATWTdVD+/b8ZilXV1g1/dXtZ/2/UNSpXgwccTG2twCt/1i6NfqT/jg5FWe
 ZJty7cB/VzraXx1JMMKOAQy/R3v4XJle4n+MRY7+Nl+rfQMHbdpTrrOm7+RY91Ez5I2ziAZqN2l
 okA/Y+a1LVsIViCG0QmQr11ouwMBWUSpZvUKCCJZgs+9TT2XM5qFWDSHkrO2PyDZpSVwX+TjfUA
 6iR7ln4VOqoTxpCA836W7vjW/xDbiYMkAvp+QqtX/H9K/R6O/w+ekxc/vQbaY8VOQfvsbNUTbAf
 zwccVEx8UVZWmMQLKBXb+KRq6Q3uAHpO7cbEPldSWiFDsRnS9SBW28KQpLjE2PjorKgNMAHj7Mj
 +yyaOxvIWa3TD66yd6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-04_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610040029



On 10/2/2026 7:00 PM, Bartosz Golaszewski wrote:
> On Mon, 28 Sep 2026 08:09:18 +0200, Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> said:
>> PSCI supports different types of resets like SYSTEM_RESET, SYSTEM_RESET2
>> ARCH WARM reset and SYSTEM_RESET2 vendor-specific resets. Currently
>> there is no common driver that handles all supported psci resets at one
>> place. Additionally, there is no common mechanism to issue the supported
>> psci resets from userspace.
>>
>> Add psci-reboot-mode as an auxiliary device created by the psci-devices
>> driver. Define two types of PSCI resets, predefined-resets and
>> vendor-specific resets. Predefined-resets are defined by psci driver
>> and vendor-specific resets are defined by SoC vendors, under the
>> psci:reboot-mode node of SoC device tree.
>>
>> Register the driver with the reboot-mode framework to interface these
>> resets to userspace. When userspace initiates a supported command, pass
>> the reset arguments to the PSCI driver to enable command-based reset.
>>
>> This change allows userspace to issue supported PSCI reset commands
>> using the standard reboot system calls while enabling SoC vendors to
>> define their specific resets for PSCI.
>>
>> Suggested-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
>> Suggested-by: Lee Jones <lee@kernel.org>
>> Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>   MAINTAINERS                            |   1 +
>>   drivers/firmware/psci/psci-devices.c   |   4 ++
>>   drivers/power/reset/Kconfig            |  11 ++++
>>   drivers/power/reset/Makefile           |   1 +
>>   drivers/power/reset/psci-reboot-mode.c | 104 +++++++++++++++++++++++++++++++++
>>   5 files changed, 121 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 70a11f2ff61d..1007d5cd2e13 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -22058,6 +22058,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>   S:	Maintained
>>   F:	Documentation/devicetree/bindings/arm/psci.yaml
>>   F:	drivers/firmware/psci/
>> +F:	drivers/power/reset/psci-reboot-mode.c
>>   F:	include/linux/psci.h
>>   F:	include/uapi/linux/psci.h
>>
>> diff --git a/drivers/firmware/psci/psci-devices.c b/drivers/firmware/psci/psci-devices.c
>> index d23befc490ed..04f24b8d9943 100644
>> --- a/drivers/firmware/psci/psci-devices.c
>> +++ b/drivers/firmware/psci/psci-devices.c
>> @@ -20,6 +20,10 @@ static const struct arm_psci_device_info arm_psci_devices[] = {
>>   	{
>>   		.name = "psci-cpuidle-domain",
>>   	},
>> +	{
>> +		.name = "psci-reboot-mode",
>> +		.of_node_name = "reboot-mode",
>> +	},
>>   };
>>
>>   static void arm_psci_auxiliary_device_release(struct device *dev)
>> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
>> index bce996bbef28..f165a41d40ed 100644
>> --- a/drivers/power/reset/Kconfig
>> +++ b/drivers/power/reset/Kconfig
>> @@ -360,6 +360,17 @@ config NVMEM_REBOOT_MODE
>>   	  then the bootloader can read it and take different
>>   	  action according to the mode.
>>
>> +config PSCI_REBOOT_MODE
>> +	bool "PSCI reboot mode driver"
>> +	depends on ARM_PSCI_DEVICES
>> +	select AUXILIARY_BUS
>> +	select REBOOT_MODE
>> +	help
>> +	  Say y here to enable the PSCI reboot mode driver. The driver
>> +	  registers with the reboot-mode framework to configure PSCI
>> +	  reset commands, which are executed by the PSCI driver during
>> +	  psci_sys_reset().
>> +
>>   config POWER_MLXBF
>>   	tristate "Mellanox BlueField power handling driver"
>>   	depends on (GPIO_MLXBF2 || GPIO_MLXBF3) && ACPI
>> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
>> index e31cab4ba78e..45d8aaaffaa1 100644
>> --- a/drivers/power/reset/Makefile
>> +++ b/drivers/power/reset/Makefile
>> @@ -41,5 +41,6 @@ obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
>>   obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
>>   obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
>>   obj-$(CONFIG_NVMEM_REBOOT_MODE) += nvmem-reboot-mode.o
>> +obj-$(CONFIG_PSCI_REBOOT_MODE) += psci-reboot-mode.o
>>   obj-$(CONFIG_POWER_MLXBF) += pwr-mlxbf.o
>>   obj-$(CONFIG_POWER_RESET_QEMU_VIRT_CTRL) += qemu-virt-ctrl.o
>> diff --git a/drivers/power/reset/psci-reboot-mode.c b/drivers/power/reset/psci-reboot-mode.c
>> new file mode 100644
>> index 000000000000..bf2dd6626feb
>> --- /dev/null
>> +++ b/drivers/power/reset/psci-reboot-mode.c
>> @@ -0,0 +1,104 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/array_size.h>
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/device.h>
>> +#include <linux/errno.h>
>> +#include <linux/init.h>
>> +#include <linux/kconfig.h>
> 
> Huh?

Thanks for review! Will remove these.

thanks,
Shivendra
