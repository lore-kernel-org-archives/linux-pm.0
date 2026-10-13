Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752902253EB
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881331; cv=none; b=jlMrL1DboUuf422ZOjDvMNlYEjsjOUmEADAI2bqNSnBYzygg9xspAI1mGpNvesFoI3Oa+sxSQVdEfdm+WKa6ZDzi8ypdiPGFQvfsiRdIcgYwYAey8RcO6Gwc6UgR+nbj8eAK4T2i0lw0si2naoz0ppKUwqgcZsf5VtGyj+FkxZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881331; c=relaxed/simple;
	bh=YtQ34cQ9XmFi6zcNdYGMdmbtWTCoLVnZxtAsP94R6sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjpQEpHPrHtmjoPTBSgujvwScTy4WcAIPKa6TtVfJk4AVfvnoBXJqPHXWejZDRbCDK6HiBSGcx0BQK0LPzhzmly1sR8de9zftMwJ0fV6RW+6oIWdwY/Tk+N9KH88Chr70TLzimOqFbZmy0ER4YwDKP6h3SKlTyfNV+vvnb1eO4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K2VWao6A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LvpKYrS6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K2VWao6A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LvpKYrS6"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D6CRur949345
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 08:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JjxJi1akmR350BjqJjUpsg/JBkPEFxqTxpfhmQt0rP0=; b=K2VWao6AEPk4LMGn
	35Waa8iTcpOgbuYSmwTYe0FtW4M05O9CZjHTZDPpEvsNL+bMOWWfzPJf0pANq9Yg
	/SAzOHHOVcaQN7m3yIXKvms+ZydoW4SCvGfsblVH8cNoatZHKQaQFitxH4H2/O/k
	3duo9w7IfJu9Ad7Seh+0cgCLOSKXblbsQAHauG+ZcHTb2STCDzZ1CsDXoVMxUue4
	V02ncNdLbvWJW2iWtN0zayH6BvIrB9MsRXd4Sn7vwodCszH2V0VdeA/Zn6FhFZlw
	Kn86a9PB6mL2HKCtwYMLjyaF0avKCyYfOszNTJvw613zbP+nlycrEhyvCvk0hp3Y
	9U2eKg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9f628m3t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 08:48:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cbacbb996so444639885a.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 01:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791881328; x=1792486128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JjxJi1akmR350BjqJjUpsg/JBkPEFxqTxpfhmQt0rP0=;
        b=LvpKYrS6TBZWPt/wDNvEE6brivkqi0rTcljdTba60yGtlbHmv0mrLxwAzgKFdHNBFK
         69D4IOiGij/i/URa2558flsR3WdO+A2q+QHSUaqVqaUa9im80emTUThOU3YsUD+71C75
         /nqYQn0KQWt8RYYrH29IZPcNNSjw2d2f2ltpKy+l5FA8FKa0M4WggMMBgwnuAeY2CCLS
         kvyduHTnpvPzjz23xh4KnfO7KLu+uyCb1PBe5jnbgtqQbgt5MHtANzRnFcHJNyRcbV9r
         nis8BhBKisfDlsauM/yymZHgiUifFIeEp3nNgdAek2Wre5fbT6/DWtVCsv1KFDKw1MiE
         F/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881328; x=1792486128;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JjxJi1akmR350BjqJjUpsg/JBkPEFxqTxpfhmQt0rP0=;
        b=QVWDzRa6hV/v4QWZX5FBDSuvrhUFbeZRUf9i0YlM+yQaj60lMNkiNA3FoS23TdSMpz
         LOPOto9/8SnzUIDTU8FeVwNCSIGZy1EZkCaZWv/JOHabutrNwljaZqO7tvij4RBd1cd3
         Xq1CaGXs+1gGt6XJgnyBSgr0qZbOjOx9PFpN/R9SIfAv5wzSog6oKNMhm5iRuQUqL1mp
         6MJtfTkKPdBJmD960K/tNm0bgtMbv5TxbWyeX3j3cbUf7/+Kh9e/k80TD25mZyzIwJPA
         563L5BDT8EOdBzAj3Hn6xM7QgiN4fQs+5TxM1PSovDwSPn9xgTGgQPWmgWPZ0Vn5K0lX
         M8yg==
X-Forwarded-Encrypted: i=1; AKwUvBw84XCs/mSLGt9GKXur47y8Ag3VQp0usRZSLykhiid4dRfM4lfSCyHHVgZuYze5Zt//FWvzUz2uYA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLFGQ332Ez1cHfakn+/uVXOP1J3zN11W04lOgWjp/nreJIXWbMV
	CIaVulZ2Y6Au/89g3WMW6ErSjGA8vFcrc3qtIpTVWM1+pFCdiXxNAaqfkdgp6uoGWo4GFbluni5
	Oxz0pDT0P0IhC64ScSpiVFJp8jCH8Qfk9gLtie/QbxB3PJwFLWk/WhT7HOHuvBg==
X-Gm-Gg: AYBFou2WgbJikHNhD5Y2oUMWweXMApHLlKV7Wd4DhWyewE+GRsHhwwe2NqmQX+y4ioo
	FuH/3/drJzTgWMiaLogUbrMbtF2JBpLQc8o4ijtbKtGlV9kOyn1XUORpT4ivCFvznWf799INS3K
	q0+eSQPg5Yzyt/aTRacYfElQ2EJUlZMdrH9yGBZcNyNZIliRVrOoAnXPQ92j7wQAU3r6utpvkCi
	ITk4cJK5VLwLlwI+wkTWDHFMnf9sgO5xZ7PsAg67I0zCO6rkXGufJgST2mUcDk9aChKa7dOHeKr
	IMW3qJVR3HNgP0Ms6ZLWRlaMbrVfFHCDtEODmwMGQU87zKjX16Q9nKDRTrHFugdC9+dP9vwhz9t
	FydwC041JZAkhu1EJ+r6bHIVqLa2L4BNxR8/XKtgTpjZAWXRMcg+JCUFkrTvX0A==
X-Received: by 2002:a05:620a:170d:b0:93c:7f48:8f46 with SMTP id af79cd13be357-93ebd0cbba3mr2018273985a.4.1791881327659;
        Tue, 13 Oct 2026 01:48:47 -0700 (PDT)
X-Received: by 2002:a05:620a:170d:b0:93c:7f48:8f46 with SMTP id af79cd13be357-93ebd0cbba3mr2018271885a.4.1791881327187;
        Tue, 13 Oct 2026 01:48:47 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac35dfsm3905304f8f.33.2026.10.13.01.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 01:48:46 -0700 (PDT)
Message-ID: <8e42db37-3aad-4825-8287-8578fb3eadd3@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 10:48:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/8] thermal/drivers/loongson2: Fix Loongson-2K2000
 trip point programming
To: Binbin Zhou <zhoubinbin@loongson.cn>,
        Binbin Zhou
 <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Yinbo Zhu <zhuyinbo@loongson.cn>,
        zhanghongchen <zhanghongchen@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, stable@vger.kernel.org
References: <cover.1791512067.git.zhoubinbin@loongson.cn>
 <93d78dbedc091117d8fc7ecb29a0fdf2a6d096b7.1791512067.git.zhoubinbin@loongson.cn>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <93d78dbedc091117d8fc7ecb29a0fdf2a6d096b7.1791512067.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FOKOVOos c=1 sm=1 tr=0 ts=6acdf070 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=B0Tmh5SJC70KtaT1dDUA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfX3fXpMuDt2CeG
 8iYgWR0EiqjKO/3gNl1axvm1yIWc6OgtunKP3FVbhcdxF9htPA0S9/sAH2U9SSkwV6b5yNfVceT
 Z02eXFIceKm00TgVlosjaR18agjwrFc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfX62mXWLg5E1Yh
 iyqRAwWtScHVv91ZuBMmtWh5X5ZuEApEK3Y+worOttaqf6ojmGSTY486OzjgKXZx0IVPoFwC4hH
 IH1/EFXcTNLMF1rKci/POdRjn3cGMkpSokfAXdLByufU9tts2rUHVINHePTcrN8UomugIh21f9C
 UEBIkBTB1WDqfO3I5deYtSuvfOiM8NKC646TGZVr8oZ3aLVKsIOtZ5tRHgcSUzDMdNCKjXOth+g
 ZEFobJgsxW3btjYtDA9MXYE3ooiiwC7kOyIY8gKtiikTCZzCV47Zesc5sl5jFPQBzrWU4d5xi27
 +IEsumRb6WB3eMf+FpzEs6mELa1P0mPg5mOyU25tVgCeOJ3zACs7IVphG0xY2s5vHwnxTBnC+Im
 MOByOqVU8vUwjclddPgHmib5hbFkseJTEXyNXK33S6lYEI51Gvoq9QdNhU5eLp6Gy+PFlT+jsmC
 yPUnV+o6276g3PAzRlA==
X-Proofpoint-GUID: nL4flHnyOTi1gzxPCVGYzBSbcJreqaoE
X-Proofpoint-ORIG-GUID: nL4flHnyOTi1gzxPCVGYzBSbcJreqaoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130034

On 10/9/26 04:58, Binbin Zhou wrote:
> The Loongson-2K2000 splits its 16-bit gate value across the control
> register (low byte) and a dedicated HI_GATE register (high byte), and
> derives the gate value from the target temperature with a different
> formula than the Loongson-2K1000.
> 
> Add a per-SoC set_trips_regs callback and implement the Loongson-2K2000
> variant alongside the existing Loongson-2K1000 one.
> 
> Cc: stable@vger.kernel.org
> Fixes: 734b5def91b5 ("thermal/drivers/loongson2: Add Loongson-2K2000 support")
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---

[ ... ]

> +static void loongson2_thermal_set_trip_temp(struct loongson2_thermal_data *data,
> +					    int low, int high, bool enable)
>   {
> -	int reg_ctrl = 0;
> -	int reg_off  = data->chip_data->thermal_sensor_sel * 2;
> -	int ctrl_reg = low ? LOONGSON2_THSENS_CTRL_LOW_REG : LOONGSON2_THSENS_CTRL_HI_REG;
> +	low = clamp(low, -40000, 125000);
> +	high = clamp(high, -40000, 125000);
>   
> -	reg_ctrl = ctrl_data + HECTO;
> -	reg_ctrl |= enable ? 0x100 : 0;
> -	writew(reg_ctrl, data->ctrl_reg + ctrl_reg + reg_off);
> +	/* Set low temperature threshold */
> +	data->chip_data->set_trips_regs(data, low / (int)MILLI, true, enable);
> +
> +	/* Set high temperature threshold */
> +	data->chip_data->set_trips_regs(data, high / (int)MILLI, false, enable);

MILLIDEGREE_PER_DEGREE

>   }
>   
> -static int loongson2_thermal_set(struct loongson2_thermal_data *data,
> -				 int low, int high, bool enable)
> +static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
>   {
> -	/* Set low temperature threshold */
> -	loongson2_set_ctrl_regs(data, clamp(low, -40, 125), true, enable);
> +	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
>   
> -	/* Set high temperature threshold */
> -	loongson2_set_ctrl_regs(data, clamp(high, -40, 125), false, enable);
> +	loongson2_thermal_set_trip_temp(data, low, high, true);
>   
>   	return 0;
>   }
>   
> +static void loongson2_2k1000_set_trips_regs(struct loongson2_thermal_data *data,
> +					    int temp, bool low, bool enable)
> +{
> +	int reg_ctrl = 0;
> +	int reg_off  = data->chip_data->thermal_sensor_sel * 2;
> +	int ctrl_reg = low ? LOONGSON2_THSENS_CTRL_LOW_REG : LOONGSON2_THSENS_CTRL_HI_REG;
> +
> +	reg_ctrl = temp + HECTO;
> +	reg_ctrl |= enable ? 0x100 : 0;

bitfield.h helpers

> +	writew(reg_ctrl, data->ctrl_reg + ctrl_reg + reg_off);
> +}
> +
>   static int loongson2_2k1000_get_temp(struct thermal_zone_device *tz, int *temp)
>   {
>   	int val;
> @@ -81,6 +99,27 @@ static int loongson2_2k1000_get_temp(struct thermal_zone_device *tz, int *temp)
>   	return 0;
>   }
>   
> +static void loongson2_2k2000_set_trips_regs(struct loongson2_thermal_data *data,
> +					    int temp, bool low, bool enable)
> +{
> +	unsigned int sel = data->chip_data->thermal_sensor_sel;
> +	int hi_reg, ctrl_reg, val, gate;
> +
> +	gate = (temp + 311) * 0x4000 / 820;

litterals -> macro

> +	/* Low byte of the gate value goes to the control register */
> +	ctrl_reg = low ? LOONGSON2_THSENS_CTRL_LOW_REG : LOONGSON2_THSENS_CTRL_HI_REG;
> +	val = gate & 0xff;
> +	val |= enable ? 0x100 : 0;
> +	val |= sel << 10;
> +	writew(val, data->ctrl_reg + ctrl_reg + sel * 2);

bitfield.h helpers

> +	/* High byte of the gate value goes to the low byte of the HI_GATE register */
> +	hi_reg = low ? LS2K2000_THSENS_HI_GATE_LOW_REG : LS2K2000_THSENS_HI_GATE_HI_REG;
> +	val = (gate >> 8) & 0xff;
> +	writeb(val, data->ctrl_reg + hi_reg + sel);
> +}
> +

[ ... ]
