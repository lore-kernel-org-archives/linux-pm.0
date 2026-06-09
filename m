Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36828283FDD
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011439; cv=none; b=Nm2KWZ97gI1GZ3SXpf9vc9o/0nHDqYzZrxfXqoBPGMVITR6AbOLcvdIURnk07z2d9gXKG9SxThtox5M3OAX1PCIj66gm52y4krjhanO9Ln924ghHvNjXcp/hAvtlFoF7EKVcmxheqOos5S+jP1iQOX7AJYTno0E+ByHPU1D7/vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011439; c=relaxed/simple;
	bh=KRYfsk/GmXVNGtS/PPsItrFkz/Fpb7nExo5NBBcViYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/rQ+8KHeDBGhbegfHgNBpTmFZqZ+woTGMtzHbU+rpRq1Du2VEQfy4eocw7cVyB0rmlmNcuiypLt6l+td2omcK8hQQLXVQx22JUljtNc+F2WtPAVnlkLGC0E7bd1dGuhAD/xaDuE6cemHo895dzGo9s5d5ziQQzLqYTB0bwb+UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mu4ip5bh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PJ42frEx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mu4ip5bh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PJ42frEx"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659ClUCn2286837
	for <linux-pm@vger.kernel.org>; Tue, 9 Jun 2026 13:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WkHFj6Qo495pjgmFOkOfPVQH0xZPeXZfvpX0xr+9B2M=; b=Mu4ip5bh5bQSCRnY
	ct82BbsltaP526UqST9WoCQvRzfqexnIlzzvSR6fFPkfqYX7VNyQ7CNek93y1DcL
	KmIghn4bdmmgRofk4lhp4IPi0PpSdSQffnYnOS7s5/T+lFyPcGnI9dpIdknvBEol
	dVxRAGQc99DR/MBTnhGwDY9tbEZC5I7ObhdMQBIyheKc8g5D2bHml8BBoT2f3a3e
	aYaVIDgsA1TdI3CCAdrz4e2vLVITLOmjXN21mSSSzuaYBWzglCwSantI5q9qBRJW
	88w/4KLNaa7dWJPAmPx0pzPDfg6JPk+H+Ay7GlyHE8PBl3fxpjnsqYuXhosYJgtF
	EKoBxg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3js1nj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 13:23:56 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8428419982eso4824445b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781011436; x=1781616236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WkHFj6Qo495pjgmFOkOfPVQH0xZPeXZfvpX0xr+9B2M=;
        b=PJ42frExys0h8mx6NR4gA0p4UiJksx4KbYb9+GZiyAybBqXvXhsAKiTHGeHMyTjeC5
         pWQPq/dMyHqcCWekWz0pVu8m60k5hZEuFbC1JpmLHwPxLmfzZZE9VIq7OdNPr1XwtA1h
         Red0fuTEeHURCQtCIneEOe+wOn27hd57YyNB2ep+WM76h69pDLa8w3R5dfkmIT2ocRKW
         cD7m6+wJ51Xl8P8otRggtL8rlpeSNPEqkdH5dLaFpgN5FnfPbi7HLaJkgczcDx4ddTQh
         5/kRvWc+hsZga+YmXL7UoBOW21Ky6y4n61MrvcfTvlTVIVjDdcB+w6gN5OEib6riREdz
         16JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011436; x=1781616236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkHFj6Qo495pjgmFOkOfPVQH0xZPeXZfvpX0xr+9B2M=;
        b=Ws/tALWD6mio5W1oXTJ0RM0/jZXH3FpUqrLPyaMmwLkUKvn0YNqqnx+DDLJE3O4jkK
         C+Jy8wq7pnZkrd4SnP6DhsJsJBNczwtU6vUbpPENh6G6XhXBgWvITMbMs5gTDfvJYi7Z
         XI/to/BwdQKTP6rVuwz6sCz0p9e+Ojs/nR9hXo4pKJid6JaYajK6wLjHWmSJfIUL4R0j
         oi2PA3jfpbP1oXZ9i7g4DSIXR2OT/RGClvOxI+V0oKyeLwN49qg2E+n1I/QhaC8vGzEA
         2gQPWB0FXJGRizxPSdTptC920BTpP9mIAtetuu1+8fAGQRCfGgJ2/bcvm+V7YzH0oRt/
         oLVA==
X-Forwarded-Encrypted: i=1; AFNElJ9jbhJw/e0WwRiNnv5Ng4Uf88X7Nqb2H0dzr7l0CKLIxP4AN+cwFTOsD43K2Y2nyuu0WvlrTRZqGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzCDUVb7hZbhy9nz1qwpDO7RrActmd3PUZfVMjB8cDjnIkfXDQ
	pkWwsc11IZXGHCUY33fGYElKBTWthAJOBkjPwxWmn4mfNdAzcfXJKGbffDQeK6NuLZ/6z0wnL04
	PXCi0eBS2jTfmqRtXFRnkikl7csy3i3f7lDUanjEfA3Ro6Qc20EYMcBT8zBfaxw==
X-Gm-Gg: Acq92OFDD1BwCzrBvWvog6L37fzag/NWtO1o0DEXZLJCPkluxddV9GQAW5/X4L9Kcra
	beqGOALVYeUrBji8X+LkvlO0yv9XY8oi9prIr46Ye+QZP2+n8ExRiNp/j6uLLK+tS4lsgw/HBc3
	k0IB984xrISX1NUl85dhHUH69bgxlmAHL0R3xvhemR0TGpFYlRmi4lqhCrkgzMycqiVLQGtWsJU
	YMcfoDDgvKBJIMWsFDxaL58zlb3HxZFmS1ip1JnjCdVy2Ig7Sj7O6tzAo/kyXMEDq0wgULQZyeR
	OXLCwlfoGF4wow6lAU7c4m7Z326lhidZ2rWJSxAla+iKiPbcruKQz9iJAlk5LM/9G8qtnbqx597
	QGUFGGCN/cx6SP+7hlxlkDxQBgZx5tYceKY3Lng4SIeXvdZB5Q2NaCLkeDpLBW9wSdMY=
X-Received: by 2002:a05:6a00:808f:b0:838:127d:a167 with SMTP id d2e1a72fcca58-842b0e6bb0bmr19975879b3a.16.1781011435774;
        Tue, 09 Jun 2026 06:23:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:808f:b0:838:127d:a167 with SMTP id d2e1a72fcca58-842b0e6bb0bmr19975821b3a.16.1781011434968;
        Tue, 09 Jun 2026 06:23:54 -0700 (PDT)
Received: from [10.92.193.107] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828d6bc5sm20261369b3a.43.2026.06.09.06.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 06:23:54 -0700 (PDT)
Message-ID: <8f045340-a6c8-41c7-b1c7-6d9b87b05d90@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 18:53:49 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] powercap: qcom: Add SPEL powercap driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
References: <20260519-qcom_spel_driver_upstream-v1-0-75356d1b7f94@oss.qualcomm.com>
 <20260519-qcom_spel_driver_upstream-v1-2-75356d1b7f94@oss.qualcomm.com>
 <7ea2f2cc-ef11-4727-810c-e32e815bd973@oss.qualcomm.com>
Content-Language: en-US
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
In-Reply-To: <7ea2f2cc-ef11-4727-810c-e32e815bd973@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UQLZmUriQFx9gzlijD8HnkmE0otddUzh
X-Authority-Analysis: v=2.4 cv=aa9RWxot c=1 sm=1 tr=0 ts=6a2813ec cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=bEeoLGOZ4EoZlHOPchMA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEyNyBTYWx0ZWRfX4aniAY6ODvRe
 aVmWbaOWl3+a9giuB5pRm5E/sRD01GWU5oK1A183kVOOu4siEGxBG/+RoCqtNcKu56pPp4BHO6E
 c4/lHrD1iRD30l7qQG1Kav/DYNjgepodCR/BrV51rtStnEQ0RL5h0UiWFfX7lCfik4umLYWyMQX
 wYTiJqRGnB7wlq1gz0uLcmyUhn/s3Xow1IGuHWTRgBBV8Aq5F7WgPVUeEkRPprPAaDwoONoAsN7
 KUggNgHJgTwtxZgcsDILTBVdrlrv/HhgAqdMttGt22h3dWO1axbG0TQXj5MBEN143MBAoIj3YCi
 Ms/6GIDamkUfhR2StaLPS2hck8c1qJuJWB7XisIdPyLVSQZIpecynRvMhkXMQKgJgM8YDQ0Tl6B
 QgpFJTs5IWM+7FPfsGfjxWpMgerYaKSn/ZG+xs4LcaPFpTPWaVoQGgPyahPWdHwg8gpfQdmk2TG
 PhBe7McbElFH0jXgXIw==
X-Proofpoint-ORIG-GUID: UQLZmUriQFx9gzlijD8HnkmE0otddUzh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090127

Hi Konrad,


On 5/21/2026 4:46 PM, Konrad Dybcio wrote:
> On 5/19/26 12:49 PM, Manaf Meethalavalappu Pallikunhi wrote:
>> The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
>> based power monitoring and limiting capabilities for various power
>> domains including System, SoC, CPU clusters, GPU, and various other
>> subsystems.
>>
>> The driver integrates with the Linux powercap framework, exposing SPEL
>> capabilities through powercap sysfs interfaces.
>>
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +/* SPEL register bitmasks */
>> +#define ENERGY_STATUS_MASK		0xFFFFFFFF
> 
> GENMASK(m, n), across the other defines too, please
> 
> Then, you can drop the _OFFSET defines as FIELD_PREP/GET/MODIFY
> accessors will derive them from the mask
> 
> Please also use lowercase hex, file-wide

ACK

> 
> [...]
> 
>> +/* Constraint configuration */
>> +static struct spel_constraint_info constraints[] = {
>> +	/* SYS domain constraints */
>> +	{ 0x10, 0x70, BIT(0), SPEL_DOMAIN_SYS, POWER_LIMIT1 },
>> +	{ 0x14, 0x74, BIT(1), SPEL_DOMAIN_SYS, POWER_LIMIT2 },
>> +	{ 0x18, 0x78, BIT(2), SPEL_DOMAIN_SYS, POWER_LIMIT3 },
>> +	{ 0x1C, 0x7C, BIT(3), SPEL_DOMAIN_SYS, POWER_LIMIT4 },
>> +	/* SOC domain constraints */
> 
> "SoC"

ACK

> 
> 
>> +/* Helper functions */
>> +static bool is_pl_valid(struct spel_domain *sd, int pl)
>> +{
>> +	if (pl < POWER_LIMIT1 || pl >= NR_POWER_LIMITS)
>> +		return false;
>> +	return sd->pl_name[pl] ? true : false;
> 
> return !!sd->pl_name[pl]

ACK

> 
> [...]
> 
>> +static u64 spel_unit_xlate(struct spel_domain *sd, enum unit_type type,
>> +			   u64 value, int to_raw)
>> +{
>> +	struct spel_system *sp = sd->sp;
>> +	u64 units = 1;
>> +	u64 scale = 1;
>> +
>> +	switch (type) {
>> +	case POWER_UNIT:
>> +		units = sp->power_unit;
>> +		break;
>> +	case ENERGY_UNIT:
>> +		scale = ENERGY_UNIT_SCALE;
>> +		units = sp->energy_unit;
>> +		break;
>> +	case TIME_UNIT:
>> +		units = sp->time_unit;
>> +		break;
>> +	default:
>> +		return value;
> 
> nit: maybe setting units and scale explicitly in each entry could
> be better for maintainability, but potayto/potahto

ACK

> 
>> +static int spel_register_powercap(struct spel_system *sp)
>> +{
>> +	struct spel_domain *sd;
>> +	struct powercap_zone *power_zone = NULL;
>> +	int nr_pl, ret, i;
>> +
>> +	/* Register SYS domain as parent zone */
>> +	for (sd = sp->domains; sd < sp->domains + SPEL_DOMAIN_MAX; sd++) {
>> +		if (sd->id == SPEL_DOMAIN_SYS) {
>> +			nr_pl = spel_find_nr_power_limit(sd);
>> +
>> +			power_zone = powercap_register_zone(&sd->power_zone,
>> +							    sp->control_type, sd->name,
>> +					NULL, &zone_ops, nr_pl,
>> +					&constraint_ops);
>> +			if (IS_ERR(power_zone)) {
>> +				dev_err(sp->dev, "Failed to register power zone %s\n",
>> +					sd->name);
>> +				return PTR_ERR(power_zone);
>> +			}
>> +			sp->power_zone = power_zone;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!power_zone) {
> 
> I believe this is only possible if ARRAY_SIZE(sp->domains) == 0,
> but it's not obivous that it's to protect it from that specifically

It will also catch a case where domains defined without root domain 
SPEL_DOMAIN_SYS
> 
> [...]
> 
>> +	/* Map spel domain registers (energy counters) */
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "nodes");
>> +	if (!res) {
>> +		dev_err(dev, "Failed to get nodes resource\n");
>> +		return -EINVAL;
>> +	}
>> +	sp->node_base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(sp->node_base))
>> +		return PTR_ERR(sp->node_base);
> 
> devm_platform_get_and_ioremap_resource()

ACK

> 
> [...]
> 
>> +static void spel_remove(struct platform_device *pdev)
>> +{
>> +	struct spel_system *sp = platform_get_drvdata(pdev);
>> +	int i;
>> +
>> +	if (!sp)
>> +		return;
>> +
>> +	/* Unregister in reverse order: children first, then SOC, then SYS */
>> +	for (i = SPEL_DOMAIN_MAX - 1; i >= 0; i--)
>> +		powercap_unregister_zone(sp->control_type, &sp->domains[i].power_zone);
> 
> Could you try adding a devm_ variant of these register functions?

Powercap framework doesn't support any devm_* API, you meant add this 
support in framework in this series ?

> 
> [...]
>> +static const struct of_device_id spel_of_match[] = {
>> +	{ .compatible = "qcom,spel" },
> 
> The compatible must contain a SoC name

ACK

Thanks,
Manaf
> 
> Konrad

