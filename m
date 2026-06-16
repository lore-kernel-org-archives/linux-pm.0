Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCCF429810
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604622; cv=none; b=SJe3DO9pNDoEAyooTmcijD7PwYT9RS+d7MCMzTwGThNf8J0fzlmcpCROhrS1gSO7yRcyK5dMjJ8ocsBH0eHx42pbSy5CpQM2zIYT2JyAo8kAGRqOkqg+f4REHm7ez6K+hpWMmBfrdj+6k9M5U1MQ7tK9drl1FWnfrQg7O0MC6Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604622; c=relaxed/simple;
	bh=ufIc8ZHUf4Xrb8lSB6Ws/u1L1tyTF4Z3lOrI6M1Jtms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GtoLs5qxzSXaa75Qo0Na6VNGhyUj+eJvNBv287z9AxAECZVIAAHXNSzLx1mZsWUIJzVTf5RgGep8Mm4cQ6094mNOIPjK46HcTkSF1qGiW8Zlfetvna/h+rhDOqG/8WkFlLpgLOgfpcRHR5NhpVGT2RN+FsAsbqbHSUzpooueG9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JL1y8v5o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vq2eDI14; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JL1y8v5o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vq2eDI14"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GA9JVY2914529
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 10:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	isNgOMfZ65NTVt8FlgRDQNF31fC0tCGiPVqqs5w87EQ=; b=JL1y8v5owgkaqKiz
	ua7YLb0l2jDRlQvR7Ja1JNmeM/T0wY+NcJPxcnJEGNV4QNbgCkraByEoOXDqo2JQ
	QA/9k7+VOVJFCl1N+0bBh1d9ruTH7ZcAlYV7ngB6dbhX6kwiF5xIK+iPQZSzU/nK
	2wawpfw2r8ah5rSQpEJDWmKxQUMAflPG6XWluusV4xYyU2KMsRyOkXQ7alkqulys
	mejl/YSXN4D5LLONspAosjS+WC/gBwB9hfYZJkyacTYFDNpQ1mAEkeyIhXkt/ea5
	+Mr4VeRyMFWq6M5FPGFAi0MfhJIGx+9/e+INzScVMpbMGtbil53xJ9Eskfcevb4K
	klNjkQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1760wm5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 10:10:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51968526a68so6063211cf.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 03:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781604620; x=1782209420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isNgOMfZ65NTVt8FlgRDQNF31fC0tCGiPVqqs5w87EQ=;
        b=Vq2eDI14NYwA3fmO/itATCMrXO5YG2dbUw5F05WYEApbyHbC+vi2ky7g8tC9RLpAsE
         +Datp3hbSe5o9xJaB810UekTqa0WZulDCzEME9LA6bOCUq5a34MyNfINwlyXUZJPATuC
         oCto4ZuECrCq6st0Mp8vOgys2om7WzU35npJZ+LvrFd+KxY3ZMOI1y+0famjEV51qDRX
         V65e4CfQvLQLInOW/VMxMuBCNhcpmKOblmjRh1RVVQdPgZmxFPxmhi+4F/UQsjiY44ZF
         HX3z5rjRza8/yHfexCffmj3Gd6Nhkml6mj890iMJLOWFqggeJkdgY4UxdwyzvqEHzDwJ
         Co1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781604620; x=1782209420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isNgOMfZ65NTVt8FlgRDQNF31fC0tCGiPVqqs5w87EQ=;
        b=VscaoFy6+iQ/u/TdbM1X/GRiy9S60XheoD2gViWINzvsJLOccjygHnDsoQRiWw0Lv1
         LPK9QJWaoTcKqFdDlNZ/orv12H41iDu5s9gxcUrnCx9DfKMsNo9K2tI8gpLzOYL+Ag7R
         jkMbEzA2xcU+rQiUFqa1NO3F93OtAZTqFS8kPoprbjH1PCAFo6sE07MxHuvqGILITJHJ
         Rn8FYQRj5rHYV7+T7y01ajwOeLhd9v7He0gSbNzzSdPk83YQkk2AKAS8x555wMH6+xrn
         zK4I6GYE+V0KkUn3AYZaMGhJFO53stXR2jrwirXIgkAMV/SmfK4ifZppZ50O0ey0vvE7
         kAXA==
X-Forwarded-Encrypted: i=1; AFNElJ/RbnIjxPOz5oqA6LwmwoyAAeJ3iuFejbBM6T+3DL0XlQqwRS10sfozhl+zaupPAVSr9di0+kA+Ow==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKSf8HRmKD4V3ghTyLApwmvYMhue3Bcaw/HOaNk+qGGPMxNoYt
	GpOM+TqXs8710vRXxTtk1hZ1qvbY3Fch3JlyqWtKOM6EsivuoJAp94EOXMuiAYSN25ZDUsEyooF
	+xPtkgmFWEuFEHjfnN1gcxTmVBO4qdUn7Z//HOcFVNNce0/hu0e7KXuPCxcWeKQ==
X-Gm-Gg: Acq92OErJ/x671ncwqNWgFjxNrHr8MUHZcYhjU1SmNz1U3M+OGIFgPJS2ZSsOnfTPOj
	5IXYlvBcibxqyrJreUJ6oaScb8TBSQawZPO7C038BhEcFYf5FIkmeZhTl8tuho4wW4HakfhkYPq
	z567kbllk87SA2pu9CE5HmKCcEb9n78iF+Oc07ONBVn0VZdW3UFr9f9LTBEoHud7UojFDFAVVRg
	qX6qAgRFItwKHMq0Ynkiaa/YZtcVYUvjGw9cK66BwOz+DRD+E6IOkPjm9K539zIxbRXFgS7GPq1
	nVTR7Bemmv1/fg1WjxiHEd/0TpbpKXO+ZL2spqdYOVcyRlPpgjWOWT0m0SCIB7OnoECKcYnb8Pt
	vqnSDQvMMIKX+DiK1loa6h/hUMRO8wb6gBY6EIRuvdERFvw==
X-Received: by 2002:a05:620a:8011:b0:91c:9d38:30ac with SMTP id af79cd13be357-91c9d3836a4mr141779485a.4.1781604619597;
        Tue, 16 Jun 2026 03:10:19 -0700 (PDT)
X-Received: by 2002:a05:620a:8011:b0:91c:9d38:30ac with SMTP id af79cd13be357-91c9d3836a4mr141775985a.4.1781604619074;
        Tue, 16 Jun 2026 03:10:19 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0463a2d1f4sm100157166b.51.2026.06.16.03.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 03:10:15 -0700 (PDT)
Message-ID: <7478c540-a5fc-4238-bba0-5b04547f57c7@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 12:10:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] thermal: qcom: Add support for Qualcomm MBG thermal
 monitoring
To: Sachin Gupta <sachin.gupta@oss.qualcomm.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
References: <20260601-spmi-mbg-driver-v1-0-b4892b55a17f@oss.qualcomm.com>
 <20260601-spmi-mbg-driver-v1-2-b4892b55a17f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260601-spmi-mbg-driver-v1-2-b4892b55a17f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bcc9sWrsluu3NSOu_YfU33hIqLHrPAt6
X-Proofpoint-ORIG-GUID: bcc9sWrsluu3NSOu_YfU33hIqLHrPAt6
X-Authority-Analysis: v=2.4 cv=I4RVgtgg c=1 sm=1 tr=0 ts=6a31210c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=MUhxgwD4z-eir1BWSc8A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEwMiBTYWx0ZWRfXweT7WOsjHxZX
 ZH18itNmxr1O6Ko8jtrkGMFUoUA0uMsiXNp1NoGFS3u7vBV0erlwhXF62qAvlsLQK66pGTxiPoB
 nO2fPgOaub09vRZWO3CtkkngrlMzmow=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEwMiBTYWx0ZWRfX2RTG/0vfLjCh
 4Encp5zV2ckkKzK72YuVkHjFDTk5KHxNMC/XnWxISD6iZOeyJed+zuvGnuKm7ku8ScIgVXyMKId
 4Jqner5WgQhLDePh+0H7t3yvxHYZjnHtRJduf52feJQFmwDlfiyROFT8auDUgHsStrbLwvwDcp3
 OCOrx1PEWXkPZIkMTcFIuZp2+xGRXiU2HlpQyiIzrsFlZoFo9tCDlEAZEqaZ8VLTTgUXiNrtKND
 BMOCY3ofzrLBMdji7rMfcbT1z1iyhGp4ExDRqVnvWtRdGrJ+YhnwMVkDuGta40SuwUyX2myYsvi
 g8USiBUTavpFjIJVaGC9i9sBpSkGwgxLJI7Boku7sgMrSTAPU21O0+aoss9Kb7uBvXR6+bj563h
 VYxVd1xkFQvF8Qu72engM9HDnA3yivIJwBlOD5sNneqjsG4tEwQBNiDAlRp/oavIbtCJ4FlKYOa
 50VbG/YdI+3+613EAWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160102

On 6/1/26 1:01 PM, Sachin Gupta wrote:
> From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> 
> Add driver for the Qualcomm MBG thermal monitoring device. It monitors
> the die temperature, and when there is a level 1 upper threshold
> violation, it receives an interrupt over spmi. The driver reads
> the fault status register and notifies thermal accordingly.
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> Co-developed-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
> Signed-off-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
> ---

[...]

> +static const struct mbg_map_table map_table[] = {
> +	/* minT	vtemp0	tc */

The struct is defined 2 lines above, the reader can tell the names
of the fields
> +	{ -60000, 4337, 1967 },
> +	{ -40000, 4731, 1964 },
> +	{ -20000, 5124, 1957 },
> +	{ 0,      5515, 1949 },
> +	{ 20000,  5905, 1940 },
> +	{ 40000,  6293, 1930 },
> +	{ 60000,  6679, 1921 },
> +	{ 80000,  7064, 1910 },
> +	{ 100000, 7446, 1896 },
> +	{ 120000, 7825, 1878 },
> +	{ 140000, 8201, 1859 },
> +};

Please add a comment stating this map is not PMIC-specific

[...]

> +	/* The HW has a limitation that the trip set must be above 25C */
> +	if (temp > MBG_MIN_TRIP_TEMP && temp < MBG_MAX_SUPPORTED_TEMP) {
> +		ret = regmap_set_bits(chip->map, chip->base + MBG_TEMP_MON2_MISC_CFG,
> +				      MON2_UP_THRESH_EN);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = regmap_write(chip->map, chip->base + MON2_LVL1_UP_THRESH,
> +				   temp_to_vtemp_mv(temp));
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		dev_dbg(chip->dev, "Set trip b/w 25C and 160C\n");

Should this be an error print, returning an error condition?

> +		ret = regmap_clear_bits(chip->map, chip->base + MBG_TEMP_MON2_MISC_CFG,
> +					MON2_UP_THRESH_EN);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Configure the last_temp one degree higher, to ensure the
> +	 * violated temp is returned to thermal framework when it reads
> +	 * temperature for the first time after the violation happens.
> +	 * This is needed to account for the inaccuracy in the conversion
> +	 * formula used which leads to the thermal framework setting back
> +	 * the same thresholds in case the temperature it reads does not
> +	 * show violation.
> +	 */
> +	chip->last_temp = temp + MBG_TEMP_CONSTANT;

Will this work fine if the user tries to set the max temp supported
by the hardware (i.e. is there headroom for max+1)?

> +
> +	return ret;
> +}
> +
> +static const struct thermal_zone_device_ops mbg_tm_ops = {
> +	.get_temp = mbg_tm_get_temp,
> +	.set_trips = mbg_tm_set_trip_temp,
> +};
> +
> +static irqreturn_t mbg_tm_isr(int irq, void *data)
> +{
> +	struct mbg_tm_chip *chip = data;
> +	int ret, val;
> +
> +	scoped_guard(mutex, &chip->lock) {
> +		ret = regmap_read(chip->map, chip->base + MBG_TEMP_MON2_FAULT_STATUS, &val);
> +		if (ret < 0)
> +			return IRQ_HANDLED;
> +	}
> +
> +	if (FIELD_GET(MON_FAULT_STATUS_MASK, val) & MON_FAULT_LVL1_UPR) {
> +		chip->last_thres_crossed = true;
> +		dev_dbg(chip->dev, "Notifying Thermal, fault status=%d\n", val);
> +		thermal_zone_device_update(chip->tz_dev, THERMAL_TRIP_VIOLATED);

Should the assignment and this call also be guarded by the mutex?

Konrad
