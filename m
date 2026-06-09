Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30EA3D34B3
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998160; cv=none; b=uiu1VhQev37vk9Wm28+rwfAp7U37k56BHMPZfmEzey0ikBS/5rngAyTXcZSiYxPV7ZODBzDpRg/4yk2aysw3Ua8zCgfl81UzuU63tW0a50E0jtSzGM5JKLNrH+Gx8xHUn1Og6JN35P5oHg9GiDXzwwTAQ2+Zy0NCXDMcgiM2kd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998160; c=relaxed/simple;
	bh=pRLtaagejePOW2Fg2YPKRLjIDCmXJrayZ7Q5GXWYh/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfNCpm4zBwGJQ5a8UR8nnm1qIQHvs3EA+pthdpuL6Zhgq25b/B1M+wCe2So3bdEsTwcOcs7I8BQD2u5dn8bYew9AmdOpSNcJS7C6cTah48xBoH/SUutVP5BX3bdJ6vLfw/ORb5mGgZx3gp6hXFU1dSoB2kLzp75Edoyn5e1uh/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K/WrcX8E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yong9F7i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K/WrcX8E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yong9F7i"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rsGw2001613
	for <linux-pm@vger.kernel.org>; Tue, 9 Jun 2026 09:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n3JNmHHdS4gAWMcgDN6ouymySktpffftWHFLxG6U5y0=; b=K/WrcX8E0ZBjISFp
	zvEvM2wWb6aedQVrpP1VJP7o/C2QZcd1L+J1uvQHY5Skc/GuVZUHIN+ohIPkyLnu
	UBBj8a/TkMuSDa0lnqUSXLsLbeNMxOSOllhLSgaNTIEQ5RaqIhJNSjnQwhjatAzy
	G/0tMUurbiV2rUQx7Mu2fay8naZ0d0GcaWY5He5Wc+UvP19Fhc3L6lxUNkJnA9Bi
	2B+Rv5bog9rDlUuyBzJ3/bXCBrir7s1eK0FonUZG0bSEYv3b0wVzjtReGPRhnBjD
	yyFpLMSKVTfY8WOja+ouWLEvt3PdJRXbrhpp/URUa97LmiCc72kCYOdK5g/RCh9d
	+dveCw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epe25rnkp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 09:42:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-915737aaf0bso133779685a.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 02:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780998157; x=1781602957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n3JNmHHdS4gAWMcgDN6ouymySktpffftWHFLxG6U5y0=;
        b=Yong9F7iRosT89uHwTFi9F0BxkFLr5GSPfEwGhTQr0HMJLcqwr7JNkibrrEPEDip6P
         gwXF2g+B9Or6UKSBomPBFOcD57qBKzDnSoscMtt53fbNMX9XFi/BAqyANvk4vCanRtg5
         iGCKpgV5aG9z0xqgJ0OT76yriXoZSIeHK5LLixCvgrX1+2JhfB0PLzGOBk0RVZbVHSGN
         0smtTIwMDATPjbC/MwE+s2eg/bs7KTcI3U88RhRLleXq5JQQL133RJUJL/Q8jTcf7e/p
         3lQFmOtGSW5Kz7xqBPRJapyj7obHFoJN7YSdtP/wjxtw8dGj0A/LOZgbuKier+tjbgN4
         iuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780998157; x=1781602957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3JNmHHdS4gAWMcgDN6ouymySktpffftWHFLxG6U5y0=;
        b=inWcuIFvXgk82QPPQDRD1sQA9ioOqnkBARa+O164cz9TRd7JrvLP44yczjvxmdfHpd
         nFLwQIYbBB2Q1m67kDez3B7wR2HWbnKKkrDjh4pz+bcg3j1yMEM/TlwtAIH9Fli2S0Ho
         K+O1507ax0svHvqgTHgYCWEm4ULOEuC3Ff2BNv42m/+3SAd+6qPH1N73ycDIAXHOR3hx
         reSNEwQLrP5X7vpARrq4895JzkOWCZmLuzs7nTh71JmCJPQDSOFbpgmmazLs78eC3TGf
         LAyamW3gTlunZbFV8KFZMkThM1QIOSrcpDiwCnXJLauQbT+6byCdVBrY0EVFaReEr3jE
         yBAg==
X-Forwarded-Encrypted: i=1; AFNElJ9ANeEGZcGGUfczjr9BjbrYkTxrfigwq3uLWFsEU6iNgHopAL6Pz/dtbqiruERo3raDBPtjMWltIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YygDjkCL+nmDRKXDzIWrNhgPxpm/9vLG1ODlsr6Hq3J08IEf2Am
	k7Gu9HPWSaLDdHtV7xnx+A3JL1YC9DfpAyQeroYzkzji5xTuHZ7DgIbk4X/76U20OVVES2NMChY
	S0/Kcr9JH27qjOeR17sqY0yZuqYZLBat9Y9cYb487PfoKyRkxur6Mvs9XY/ByEg==
X-Gm-Gg: Acq92OH768ZfMEtjvbslhuj1jHM2Mpd3dTDacekHshEi0NghpIy9P5e8Laaj/jgwg2r
	YbT1h4Jfiiou2WU5hK8ZzXgVXZ4kmaWndNevPbiFVGZS9tqCIgvFfz1349RUP5ITmFd6FjL1Bgn
	LDrmmXgWtuaZ45AVQKCN2JpsRIfTqw9cEuZgaifcxd77UZ15AAWTzo27/fm+KU7MCV66i9hS6uL
	sfCMburYEdh822tdu7ijdKZPLhU46QCHQpWSXGVjK0pWR3ili21qSQ1ensvf0cpT2Dx88o9R136
	QYvmRHs0mEROKlwUuv2kCUlwYMrt3NiTVnvYu9pUhNqqGi9SefIRT/6HahMKP4PneZlQcc5zfdn
	8RF0KpozTF+lJwTK/UvA1oc3bzXbaMhHLPg0JmUgfkGRO2s/S8gqaAM+x
X-Received: by 2002:ac8:7dcd:0:b0:517:8999:6c50 with SMTP id d75a77b69052e-517ca4855a0mr16784461cf.8.1780998157557;
        Tue, 09 Jun 2026 02:42:37 -0700 (PDT)
X-Received: by 2002:ac8:7dcd:0:b0:517:8999:6c50 with SMTP id d75a77b69052e-517ca4855a0mr16784311cf.8.1780998157110;
        Tue, 09 Jun 2026 02:42:37 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0559f1464sm1022558266b.55.2026.06.09.02.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 02:42:35 -0700 (PDT)
Message-ID: <d99447c8-f140-4ac1-85e1-a235c37eecde@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 11:42:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] power: supply: qcom_battmgr: Add thermal mitigation
 support
To: DhruvinRajpura <dhruvin.rajpura@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kamal.wadhwa@oss.qualcomm.com, jishnu.prakash@oss.qualcomm.com,
        Dhruvin Rajpura <drajpura@qti.qualcomm.com>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Umang Chheda <quic_uchheda@quicinc.com>
References: <20260609-cooling_device_reg-v1-0-e15bddcb0086@qti.qualcomm.com>
 <20260609-cooling_device_reg-v1-2-e15bddcb0086@qti.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260609-cooling_device_reg-v1-2-e15bddcb0086@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hjp7iyDEyzip86hJbeSq54bpYrZwFYnn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4OSBTYWx0ZWRfX2giMQPuo+1jf
 iNtyshNMFpv5MwKJ363Nr/zvV4hOca+25JCFXQTyFpPAhVBfXnj+PPNpnnrtUXQ9YSY/Lf/E81J
 xYmnrlqJ/ndv+F7shLZfmxiFKT2Nz5ORKisi+2fGqoPr9LlNDKn/anU+MHq93jdIHsrgo3nCwAJ
 xUeJJK0+vhpQjhsqjZE44VJAk3ZzlJxsuBrjHaLfBQxZBVHc8/alyXKAntSIf/0MajWpJnI1LVo
 5hdEheToPKydclsObJCuwpXbUecqTdDumtr+WQyLWArg/mwRYLqtt4glvNiVUKE9o7QYRDFvlkL
 kxZgekb3jW3Z968VZ7PWfgDqXPn0bZ9jdqm3V0qouJZUH0CrcWzaVZzqEIgc+rNJFcAPn3CnNKx
 u0V+JSLQIx1weTi779vQtoYltG8Q+mFc38uMSMHs2TzJq7Y3sQsQRe0osYGXNOQNh/pMHm3P4/i
 /3iuEj5NNcRDTlNTzYw==
X-Proofpoint-GUID: hjp7iyDEyzip86hJbeSq54bpYrZwFYnn
X-Authority-Analysis: v=2.4 cv=LoqiDHdc c=1 sm=1 tr=0 ts=6a27e00e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=yrFiz102X7FNP_QAQpQA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090089

On 6/9/26 11:16 AM, DhruvinRajpura wrote:
> From: Dhruvin Rajpura <drajpura@qti.qualcomm.com>
> 
> Earlier commit c85c191694cb ("power: supply: remove faulty cooling
> logic") removed the automatic cooling device registration from
> the power supply framework due to inverted cooling logic and
> missing CHARGE_CONTROL_LIMIT_MAX validation across drivers. As
> a result, drivers that need thermal mitigation support must now
> explicitly register their own cooling devices with correct
> semantics.
> 
> The battery charger firmware exposes a fast charge current (FCC)
> limit property that can be used to throttle charging current in
> response to thermal events. Without explicit cooling device
> registration, the thermal framework has no way to reduce charging
> current when the device is under thermal stress, which can lead
> to excessive heat buildup during charging. Register a thermal
> cooling device that maps discrete current levels defined in the
> qcom,thermal-mitigation DT property to cooling states, where
> level 0 represents the hardware maximum current queried from
> firmware and each subsequent level reduces current to the next
> DT-defined value. Track the last applied FCC value so thermal
> limits are preserved across firmware protection domain restart
> (PDR) events. Expose CHARGE_CONTROL_LIMIT and
> CHARGE_CONTROL_LIMIT_MAX as power supply properties to allow
> userspace to observe and control the current throttle level.
> 
> Co-developed-by: Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
> Signed-off-by: Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
> Co-developed-by: Umang Chheda <quic_uchheda@quicinc.com>
> Signed-off-by: Umang Chheda <quic_uchheda@quicinc.com>
> Signed-off-by: Dhruvin Rajpura <drajpura@qti.qualcomm.com>
> ---

[...]

> +static int __battery_psy_set_charge_current(struct qcom_battmgr *battmgr,
> +					    u32 fcc_ua)
> +{
> +	int ret;
> +
> +	mutex_lock(&battmgr->lock);
> +	ret = qcom_battmgr_request_property(battmgr, BATTMGR_BAT_PROPERTY_SET,
> +					    BATT_CHG_CTRL_LIM, fcc_ua);
> +	mutex_unlock(&battmgr->lock);

I think the entirety of this function, particularly the assignment,
could use this lock

[...]

> +	if (ret < 0) {
> +		dev_err(battmgr->dev, "Unable to read CHG_CTRL_LIMIT_MAX ret :%d\n", ret);

style: "ret: %d"

[...]

> +static int qcom_battmgr_parse_dt(struct qcom_battmgr *battmgr)
> +{
> +	struct device_node *node = battmgr->dev->of_node;
> +	int len, ret;
> +
> +	ret = of_property_count_elems_of_size(node, "qcom,thermal-mitigation", sizeof(u32));
> +	if (ret == -EINVAL)
> +		return 0;               /* property not defined, thermal mitigation disabled */
> +	if (ret <= 0)
> +		return ret;              /* real error, propagate */

Does battmgr really expect the OS to house this information? Can we not
retrieve it from the running firmware?

[...]

> +	/*
> +	 * Element 0 is for normal charging current. Elements from index 1
> +	 * onwards is for thermal mitigation charging currents.
> +	 */

Documentation/ABI/testing/sysfs-class-power:

What:           /sys/class/power_supply/<supply_name>/charge_control_limit
Date:           Oct 2012
Contact:        linux-pm@vger.kernel.org
Description:
                Maximum allowable charging current. Used for charge rate
                throttling for thermal cooling or improving battery health.

                Access: Read, Write

                Valid values: Represented in microamps

My reading of your patch is that you expect a level to be passed, not a
uA value

Konrad
