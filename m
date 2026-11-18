Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010710;
	b=s7caZS5foZkadF+Y/sKS9RLy570FYuw9OUpdFJFg9AiWnsuXLXvGz0lTqW48YgchO6cC
	 aPYg3oP0vmSRBEl8YPxvJlOZSHKqMFtUJxCrp4wgny8HTvVFE+iyS+34o8f+BPzDi8ejh
	 dK/Trm28a4xZw97AJ9lHxeHyDcNqr/kpoWWQaq27gL+Az7uErMEJBcH653IdEjVgGkALR
	 h3QocSHT0cnoZ7MuY0xj7tzxpQKanaaCujzwDwjO8BoT30jfhgXKCYsm0b+H3y7OvpeXe
	 k+yyXa9UFDul7x4UbM0zibN9piUAwKtsawfqlsQ7Oftm7VfXvo150vaB4/VEZimCvHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010710;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=irAuZERJgfy5oKYpVBoCTW7OMNAhM+U1gISjyPpKtA0=;
	b=2Gdo4qv+e1lbb6BUdI+BVx0vBKECSyPNfpINS+PEVKbwpXI8HBdQRKM04g9zEQP68TJx
	 NyAiro2SyDL15jctMo7pY9tAOYbGbL01WeP2Uc/LzqB4AZjYJyPxUhcd34hAwvt2ns6g9
	 VpY7e3bezA34PQd1KZHZ6VvpxABhO6Sk4zQHl1mneyxvY8P9Hx3zRB6y+MalGclk6Ohr2
	 LSSIlPaz/yZEvMFzgLupvRXOM4zr9wERnML6f22kduFZeboTNcnRYvZ9xYdierN7Pp++/
	 lkoTeXluvASEb0dnbx7u0/VRewjGZlAsP3Oe0rC+uoGrCOTUMjHUohWCZwwgJgFfl0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lVw4OGBI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V0Chfiyd;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D600606A31C
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 14:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D600606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lVw4OGBI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V0Chfiyd
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQ9J03846490
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 14:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	irAuZERJgfy5oKYpVBoCTW7OMNAhM+U1gISjyPpKtA0=; b=lVw4OGBI//R0O3GC
	y0xtCNFAPqPFkKBCtFpt4YLH/8Zer++4XHZMZv8ReqbmkNVmWlVi/PMBg4YJwS+l
	evTvKOjcxIi4rEcsDI4U4EQv1YePooiLDCGpdKqgAQcvI3Og8wzszVmumcJb451n
	cYf3vmZhEu3g0Uvzsx1t5zLdF+8A0RKeJdzxToyM1w7qyfTtwRPtvmjMInDW1dta
	yTM05peS0dRl3S1GReMXA7CdmzLHr5kHisPNKDv/hLnVnmOYR/YmoYXFrfJZE6Bu
	I3sv/MgSTlPzf7K5WrirH8oOPh6L5B4sGGhEsCg+JxDQlw7eYIck6LIzQvebCG/4
	I16eVA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvauata-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 14:05:08 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cdb8c46e240so707390a12.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 06:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795010708; x=1795615508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=irAuZERJgfy5oKYpVBoCTW7OMNAhM+U1gISjyPpKtA0=;
        b=V0Chfiyd8RFmI/jweYojn+cPEBptqLIIaNT/htNHmcWIGKCKNB5FxGms2QgvJ0Y0Xg
         2/0YZVv80H4UhATbYo98vHVthOvxOnKLjY7ed0nvKCDpSE3KDicuRaiit6S55YcTXLAI
         U/NjhY9ggldLfbGlPgSGuzAqqOLIDF5TkKJp8Annmo1QIyqMLBGgt8ZC9AH4tGJeXlJr
         fuMQiVJuR1Nawahc3p8wQdrfbmiyplARNUip3Eeu7YZtn73He7A+ppkLTrxz7sbEkmE0
         GICv57xeGtweNPvHRJ0zTmX/i+eSNK1v/VtLXmM3J/1bonWSqXn0a8ggpvBxgIkSF74z
         F6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010708; x=1795615508;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=irAuZERJgfy5oKYpVBoCTW7OMNAhM+U1gISjyPpKtA0=;
        b=OimhJmiSraeaDRwXX5xImB/cnTMrdwOiQsbu9PZlp8mfgmF50n5430RvP7xe7pYnIM
         QiTVSdswMj3S3MGUQWHE7P/+elo1BAjqWxmeiRdcQJUdMG7ZKDrk85x6iblRGy6tRgjp
         3VSsDw+YunO+FswjevAqffc3+8kwD7hdSKMAztQstmstp4J/XPbPL33iqybQgaCbMUSi
         ZroQMt349Af/1LuJf4K3EiDHhkw9NULxSXdaWKDW62zpEVBIEkjMgyi8t0JzBtYDUEZH
         r451rbWg0ceqd+AQxpwcF5dpMszsJHDug5S8pPLnXKMJcDCM6EIiwDJIflZMma1Us0RI
         mcNg==
X-Forwarded-Encrypted: i=1; AL+hErGXxEp9JA7U0Kxpw+R5hkgH1OovdgzCRpPYPt9l19mDtX8uIYm5K8WTw+dY/pJUwQ8dS0sanHoaFg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Gq7gpT/7Ck7gnTauzF8WI5LzKbFzv9R6OmLwOzNRqZpexF6ph
	Fi4Rb6ZVzC8Dy66hOWZDdK22wCWXLAroywj50fWvdgTW1cZAHoplY7FY4EHVEfT15XO1XumrCFO
	vMDzUh9E++iwnb9Ddrm+jD/OzxFlT1ira7G7xlmfxUA/g+KhhjnKiLBiR60IsDA==
X-Gm-Gg: AZFdTZf0zg4BtcFSiAsLczNg5Ts/XLy3D9dRJ5oGs0uxbqaEQm7uWpVv0KbmtFxFseU
	L1bBC9nHWQ4/JwL2BTWMrU/pCWZo6i5MK2QLY8nPahL00mTEzMcqp6JpgVQF+rBDqM+pNbSmBBa
	T31g4iDWqPIi5lS5xymGBrCfG9aDSsQdAbQRtKl6db2gDMCGlBQb5Lbfkk49pxqeFpAZ2CHcQKE
	+aXzKkml5Wh8EurjgY/duOU6AGgKfP5rE18pnzH5S5X0uiVPNgNQLg3zCoDKcp0vRSTGu6GJ9vL
	5h/8p72G4iPvAtEjzu2vlFoeWR/jAEmcYcAP4js/1OmYTU/76V9QTdGmTMO9IX9pF2FcUutaAql
	Ac42PPm/MfcF08t7pbQMVxp3WNnI7bvksCybPA8snv/Jq9ckKuUzIIxxgT76jj8UNv3S8SB0HrH
	vNePrVZg==
X-Received: by 2002:a17:90b:180c:b0:3aa:f2c4:12e9 with SMTP id 98e67ed59e1d1-3b3d06a3a73mr3027619a91.3.1795010707878;
        Wed, 18 Nov 2026 06:05:07 -0800 (PST)
X-Received: by 2002:a17:90b:180c:b0:3aa:f2c4:12e9 with SMTP id 98e67ed59e1d1-3b3d06a3a73mr3027545a91.3.1795010707249;
        Wed, 18 Nov 2026 06:05:07 -0800 (PST)
Received: from [10.218.9.75] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d0b6b42dsm4695853a91.0.2026.11.18.06.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 06:05:06 -0800 (PST)
Message-ID: <7b409fd8-2bb1-4e4b-aa68-a13c30ed3c2c@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 19:34:53 +0530
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v27 06/10] power: reset: Add psci-reboot-mode driver
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Abel Vesa <abelvesa@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla
 <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
 <20261029-arm-psci-system_reset2-vendor-reboots-v27-6-fa4b3ff1359b@oss.qualcomm.com>
 <avo65hxiVDxpJRn-@venus>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <avo65hxiVDxpJRn-@venus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SMzXx+vH c=1 sm=1 tr=0 ts=6afdb094 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=_jzlLvw-XOvhGuOIOIMA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: czY_ZzUMuLdDH5_4Qfm2zm0yPE5Nwg-z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1NSBTYWx0ZWRfX7SyqJsoL2EHp
 k2k4j8wst+P06S2KUZqtf2z8ZEDZYGFChQ+h2e7fvXn764ho/cy1O0Tkah4V0c6aGUgt0HxZYxA
 g3tZeBxnw0pz/Nb7zwTAo9rFqRZ+4v0SsUAUHdICr9OAXEhdNWZb7F33cbg1LtHSfSCsVN3TWeb
 oggMA0ASsklM32mx3fzx8BQQ+tZlMdWngqIPPTRt/gh1ISUjlQQaj42wGV6NDeZboz72ZK8zPF7
 Ar+4urtCjne0uCnU3aLyFc5jBSFU59ALkjoNpVlHLaK55Q/IiIT7wun9n0COnx2asxEXxZ9tQ+J
 bo82Zr3nTaFZuT/v1faViv9kQEbeB2RBMqJwY5p3H4C+H/vg+iztEvH0fGeV5mFa64mZIWK5or8
 H5D+5JWR5cQ3P0srKcpXPfoT0rNuoti43Mb0Pi/biuP29amjSv+W2NcLpA6RSmQlmklGDzryR0B
 G8VBi8R/4JlrS7HM/Zw==
X-Proofpoint-ORIG-GUID: czY_ZzUMuLdDH5_4Qfm2zm0yPE5Nwg-z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1NSBTYWx0ZWRfX1D54dA0zpp0J
 uSOvDruRCpHpo3AbW5bHKJ8CVmVGrygK+cnyGe9PVSo9EBDfh3tVrCVmxmIXEtT5X8KfarrmnFq
 RzFFtgS8XRPfjp5b++2qb/mbyW7KuQ0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180055



On 11/16/2026 4:38 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Oct 29, 2026 at 02:31:00PM +0530, Shivendra Pratap wrote:
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
>> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>   MAINTAINERS                            |   1 +
>>   drivers/firmware/psci/psci-devices.c   |   4 ++
>>   drivers/power/reset/Kconfig            |  11 ++++
>>   drivers/power/reset/Makefile           |   1 +
>>   drivers/power/reset/psci-reboot-mode.c | 101 +++++++++++++++++++++++++++++++++
>>   5 files changed, 118 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e4ca41cdd872..0e03826eec48 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -22292,6 +22292,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
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
>> index 000000000000..c5dcfc40392a
>> --- /dev/null
>> +++ b/drivers/power/reset/psci-reboot-mode.c
>> @@ -0,0 +1,101 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/array_size.h>
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/psci.h>
>> +#include <linux/reboot-mode.h>
>> +#include <linux/slab.h>
>> +#include <linux/types.h>
>> +
>> +/*
>> + * Predefined modes use two arguments. arg1/magic[0] is always zero and
>> + * arg2/magic[1] is one of the values defined by enum psci_standard_resets.
>> + */
>> +static const struct reboot_mode_entry psci_resets[] = {
>> +	{
>> +		.name  = "psci-system-reset",
>> +		.magic = { 0, PSCI_SYSTEM_RESET_COLD_RESET },
>> +		.count = 2,
>> +	},
>> +	{
>> +		.name  = "psci-system-reset2-arch-warm-reset",
>> +		.magic = { 0, PSCI_SYSTEM_RESET2_ARCH_WARM_RESET },
>> +		.count = 2,
>> +	},
>> +};
>> +
>> +static u64 psci_reboot_mode_get_cookie(const u32 *magic, int count)
>> +{
>> +	u64 cookie = 0;
>> +	int i;
>> +
>> +	/*
>> +	 * For a 3-cell magic, arg2 is the high 32 bits and arg3 is the low 32 bits.
>> +	 * For a 2-cell magic, arg2 is the low 32 bits.
>> +	 */
>> +	for (i = 1; i < count; i++)
>> +		cookie = (cookie << 32) | magic[i];
>> +
>> +	return cookie;
>> +}
>> +
>> +static int psci_reboot_mode_write(struct reboot_mode_driver *reboot,
>> +				  const u32 *magic, u32 count)
>> +{
>> +	if (count < 2 || count > 3)
>> +		return -EINVAL;
>> +
>> +	/* Unexpected value at magic[1]/arg2 on a 32-bit system. */
>> +	if (!IS_ENABLED(CONFIG_64BIT) && count == 3 && magic[1])
>> +		return -EINVAL;
>> +
>> +	return psci_set_reset_cmd(magic[0],
>> +				  psci_reboot_mode_get_cookie(magic, count));
>> +}
>> +
>> +static int psci_reboot_mode_probe(struct auxiliary_device *auxdev,
>> +				  const struct auxiliary_device_id *id)
>> +{
>> +	struct reboot_mode_driver *reboot;
>> +	struct device *dev = &auxdev->dev;
>> +	size_t count;
>> +	int ret;
>> +
>> +	reboot = devm_kzalloc(dev, sizeof(*reboot), GFP_KERNEL);
>> +	if (!reboot)
>> +		return -ENOMEM;
> 
> reboot = devm_kzalloc_obj(dev, *reboot);

will update in next post.

thanks,
Shivendra
