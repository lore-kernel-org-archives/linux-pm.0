Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B81F36DA0F
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978826; cv=none; b=tuFAzNhZ9yjTLMA8FSHzEcL+a2POhtwnWzsaMkDDNbZgl0ntNMlYa+Ab/xno9ZGSvL4dlffmdanlF8/cSkb41gmPPxnMwEo61WmoEXQuEZ4J5z4X2l8BaFTYhW9Y7O6hWL1sgsqhUjxrdOhZUs+Xd2x2utXgbCkfrBqxr0WLPog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978826; c=relaxed/simple;
	bh=dOHoGdSrbxBMY26bEZpdWKTbAmt3hyzNOpR3Jxbvfuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GoKpqm9znFrgVSF08XkZ3Q3LloOx/o5/M3z2qkvZJEy6lwSorDCxvDiUSGOnJkiQ1VM7GoQ6Sn9Z2j2vH9VcPD5kFe34a7BOrTaiKrLj8zcZPmot2GgWcaIRkrnNParYmmkdBdoQPA5pQD1sB8GoBz4QfUth1HPc7GU0G8uZ7x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kz2kc8FQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Te8OOsVe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kz2kc8FQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Te8OOsVe"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VGdcBf1349187
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 17:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	prcTw8kBLNsWmYJw7kmJsuCzftaG/a70zFO0VwJYO7Y=; b=Kz2kc8FQv5x70bYD
	bS7v9DqujY/zHmDKexrW8gt8skz9l5BfdRncBLBjCGsLFCSi830T9bJRvl//VNc7
	Qnn2zuzJvoEkhw92ySd0kWhAdqdFWW+wfGDd4LNO1eJiCCuvWor/nTF+uCGqlXMZ
	99wvqlcB1xCDkERzDseVmBwJrycr1MiBxzW2lrMK/PcHF9kP2xxQEVekEFFE1iHD
	Hq2btl9lpe/0j9dDb9WmAInES7QJ3J1Ko3KJDNkuuaLx7iBFu2323vV5li/r9KIM
	SjVPzGbxG6h+qgXY0pLYEX72JjVe7/2k2K9OrOfyKVDx7RP6lQOZ41ItVeDnnSSN
	VCAioQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8ahkth4b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 17:40:23 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82ca8323edbso5982365b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 10:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774978822; x=1775583622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=prcTw8kBLNsWmYJw7kmJsuCzftaG/a70zFO0VwJYO7Y=;
        b=Te8OOsVexdSVAmyuTnyj13ig/0jKx637B6FgHRSJ+J/eqiL018Rh6hCa+ON8B55kGw
         6HE6x6D2fS3XrXfd3iPueLuDCjdbbiFiTE5STnlNmC0ARlpHUets1f5XAC+2kkxl3z8A
         bjoqOGSiy8X0W9IzBj36zQEr3PYjRdXWvyZdqkyU0eoupBuTLSdQHGCtzwlwJiY1dX4/
         qDnUXJhXjbsFgsZCC/UiJ9XNCaCJMIWDTgjxLPIADcTF83YcyDszSzYo3ITk8RN0h9iW
         fhzaoqb9bPqGYWOKxF/SgfjwhXF6KwIuIqLQ3QoxWtZnFkTDPK4WVeW9nZZ53o1wSOFM
         8+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774978822; x=1775583622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=prcTw8kBLNsWmYJw7kmJsuCzftaG/a70zFO0VwJYO7Y=;
        b=bhVpTPbDgDsv/I0yunsAG4Qq8z+pW04jGzZsqpn/rBOua+TORJNjI0xpxrxo+f2jpl
         Bcdn+cZFSvNfyQ6flz41afVCtSb22JqpFzsdhKWLgX34BrasIVTIUtwOWop3fgsIeyYF
         SUSG/Jr+j5jVZZ05kZc0beg207GJcEserPDxwPA/sOSJaqvbA+aYDeGl7LXN9eqOOrsl
         3srQ9ShTP0M0vdhIDQAzrtxGF4EtoCafbxn5OKImdKNUQj7vcu7856AL25bq+uxD9O5P
         Us4dSVLwOEpAChgo+z8UxyWUFKXw9gCvy3qKy7eMBkWC049zv6lyh46jF8sOt7XzCv5d
         ARsw==
X-Forwarded-Encrypted: i=1; AJvYcCVYK8OPNUO58VhG7DWhsdJu75Muk3REpA3bOAKg63VFeCYArATGkCRx1POt/++hd/SY2DY1baqnmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtCJRtS228yWGB9KLByFpeVIDJeDkDc+tM6QZfeMgYQWH0XKlz
	gPAjmDyOQmyDlq42azy87FdwH/aKj4WTadQsReJb/jzffWWpo0U06twv80H5dUZudsO2TbhA/AN
	E11LX3Gg7XQHwX1kX8myoK7By3uSZRyVrF4eoGDzjPPgDLRdYNYnF8C6r0UdanA==
X-Gm-Gg: ATEYQzy7v92MDAGI93xoSXrzu39r8l7SSDPSyE1RvItkjJNW+xci6LlWy6UgYxiI7cz
	bW3IjceRksYqewLgfII/8zODRBq6ygnPAz1QZ+sU16L898mvsTX+EhQ++OyEzCUvKbtDXYA9hSU
	tvJKlkQUtEeTUJbLNujzRS1n4qoWe8xbzZr21JoiJ4BrCmUQ78hoH3oGc1TvDzuevLTX7icT9U1
	tB6lnv0+wYZzGdvhxoi1g+SszntRYz0z0nVy0TF7KAYqxWmeHHStMkTNQVuYx84GnvSXqDxte0G
	56zMuHZgZwlN8xpfjnTQ40k/dRpMda2WfjQKnvpZXmWOXO8YpQEzypQ3n1u7EgsnoPWgK6Eyiuq
	VZBWsuHRdFYJjBnGprVsqE1MB4ZFYtNwuq9OAyY8zR2QtqHTrJnw9r8s=
X-Received: by 2002:a05:6a00:44c9:b0:82c:d7e7:2f8a with SMTP id d2e1a72fcca58-82ce8b296c0mr488255b3a.39.1774978822204;
        Tue, 31 Mar 2026 10:40:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:44c9:b0:82c:d7e7:2f8a with SMTP id d2e1a72fcca58-82ce8b296c0mr488201b3a.39.1774978821720;
        Tue, 31 Mar 2026 10:40:21 -0700 (PDT)
Received: from [192.168.29.31] ([49.43.225.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85fc756sm10032533b3a.47.2026.03.31.10.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 10:40:21 -0700 (PDT)
Message-ID: <4836ecc6-611b-4f21-9213-7aa6ff0a53ec@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 23:10:12 +0530
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
 <acaQzmVhO50oAbbE@lpieralisi>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <acaQzmVhO50oAbbE@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE2OCBTYWx0ZWRfX8qKcUSn3hZfL
 qGDHNIOS0qiyrCC/fIeL9ZFzPLWavsGL21jyMjJXOl4B/mOL3ezc0si/XzVuM8bHMBYUuEK4f3f
 jZlFTl7MLJrrBIYznHfRK04RlN0OqSr0VnlRAa4sNV0LG1lvRofllrxKj6J4XruFBvTm2ajnxcA
 1dpNX3PAp7miv0rvCcNuL2/4r5DWc3M1kustr4Kjy2e1VHZ65mlAyTU7iS78VdW4HLIcqx6wQBy
 n0uMLUqK2RrXwGZvY+5Ot+bURAe5vYTOA66fwGf5AyMd/F8kaFbD0TS5LII6htyX//iTKF80V4y
 hzrf5dL7Kg41RUSdqJ5dvxyYnYNJSqh/oo5qVG3vjs8nITbgT9HAyIRyey7ndUMRn/KnAtq0EIJ
 Q8C3EK0d0ws/5NiY6NHjfHrl5deWNYZ6p+oDgsTeeX+yYzg2JFers1UlplvNRPJ6sg8/EyhPKE+
 nnSqs8MlRDoZ7spccTQ==
X-Authority-Analysis: v=2.4 cv=K4wv3iWI c=1 sm=1 tr=0 ts=69cc0707 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=mO+zk3XXGlxjkZV6yCQMJw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=lfiaEQAQ_OMEnm63DysA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: AzZawGisl9DXQRHWFOUo537mSgcxd_JM
X-Proofpoint-GUID: AzZawGisl9DXQRHWFOUo537mSgcxd_JM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_04,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310168



On 27-03-2026 19:44, Lorenzo Pieralisi wrote:
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
> 
> Add an entry into MAINTAINERS.POWER STATE COORDINATION INTERFACE for this
> specific file because I'd like to keep an eye on it, if you don't mind.
> 
> Creating a MAINTAINER entry just for this seems overkill to me, it
> does not look like it is done for other reboot mode drivers.

Ack.

thanks,
Shivendra
