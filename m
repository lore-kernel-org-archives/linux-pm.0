Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E723ACA41
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857743; cv=none; b=GvPtUvV8caVRUBZgdao2XxeoKVS+MAyBcuwT2D2wyW+P0dw+L2No7Q1wr8xPeOiNUKEwyuYlayveb+zHFWoMvXLClnsSlsNCMheilW/0qf8vQzXWGDYgJvBzCa0LPetJ8DB0X87f4eVS2dp9/siBe7Rrlye7a7Ut7/C8BAMqXmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857743; c=relaxed/simple;
	bh=u5OPZFw6uTewcCwEAP3MO5eNUtHgT7VXCa4HLqbTtDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6sy77OZoOMhR4IZehOVtrEnJGGdOqUn9GlfPYIbgVfoRcycjO1j2OlJxS+rOnsyqNR20kU1XrwZOIeqowzImlCx3WAWOsgXL+hvm7oYqfGR4nUQKl8B5qiCACFW2NlRVTCeCni0rYt4bUelFJdNqdgxQGsrKO/wNBIg8uyQ+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lZV/YVhj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dH27mBzO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lZV/YVhj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dH27mBzO"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U6gTsr3438065
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 08:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hDTSMOGlUSoGnSk55MnV014+n+c+NRgq7zKWtSmXJMw=; b=lZV/YVhjVeXylJ8p
	rmaXgDctrQdalH984eJNIp9N2rSOWVaN5XXh5Bnr3XHhyJIsCqDUuTm2j67iC806
	Hf1yUoSbruXVRDbSG6WYX6fT6GmIDy7F4InwPMBnBbhofUOojjR+7Qy5YSHIR83s
	gD+q1bzb3yjQC7cp/oroFPjDC+TnQBkFPOOyl5lQyy5fooDErRVOMCvrczS5RWcx
	bZLOqjHqQ0aYP8TSW8Dvh+WTrYU6z5bjv9KaSHpOu94Q37DguVbQSVYi7KUdKMR2
	kU/f5QmKl4vj8LzhTugLvpl1RT4jFKLoKxfYQ3y616z9aeTkZnwkgKGoFuZZsanS
	9ATiow==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d66afw5w9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 08:02:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5093a985e21so86391131cf.3
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 01:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774857737; x=1775462537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDTSMOGlUSoGnSk55MnV014+n+c+NRgq7zKWtSmXJMw=;
        b=dH27mBzOn/AM4t50lrstU2ArrGlIBjGpS3CgCUjdPida+zXtB3IF3VOaujzrmdxrXH
         mbqcaHyW1RQgd4BD1l396pZCnC9OOZwGPNpnarI1h/dduUZQ7HsNWorzx39zyLztzo5a
         b3UF/hge26O+SkC2ip7J4jRJRMkUSPUI2o54QqBDsACnGNON/prJqGBECZODQj/ctmQE
         BDwybljPzanXi2Hm4qfrQCcpdYFIIq6vrF9LPmxqGK47bubMmXJOvbqp0sjaEeMc6W45
         vFuALT+rEc9LSuxdyFo9q6BrWzSjYaJHKpjkgLIfKTigH7OlukxSxln0iQo/pnOj++aI
         hnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774857737; x=1775462537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDTSMOGlUSoGnSk55MnV014+n+c+NRgq7zKWtSmXJMw=;
        b=E0P1UcXCZX9kX2bxl63UcwSFtf96+q8pspoPNOTUBNXGPyzWzMWFvWAdPgRrcxXBId
         YGvCabnMpje6RYvXL1YOaVTqIOpdwuiPeOfdPt+Cl6GQSBAoSCz52YtR08QS7fUmsJzS
         jlV/kIsmIbM2wesvL/Xm4P49n/1krEgGaQza91s3QLZ3BwVWt+0NR4ANC2h7pf/JiYn+
         krTpgX9RzC7MJNHSm7+dUbWkz4HVLHRPQziMhxmcObWIDzl+vdYRIKa2IgAZyCMULk2N
         be3mGhmrnlZmxf29cu9AtgwZgznhikkHEPFGxy02kJA/9lYPmdAuw24FZ3qSchnqYv+j
         8ANQ==
X-Gm-Message-State: AOJu0YwyuAiDmZIdNdnAN/fOn/nr6GaHvuQjLRx6F2Ochqkm7H25EH0k
	g8CT3RxP5I8/yh94CRY4OwNo0B2o0P4xrRceji0N9kc6Yj5vheNiSS/3HOoOssQyWoHN1Me9myv
	/Cnzau6EFF1BgtsltDkARqy3mbP2+AIXDGLJubJZF7CJVHYPE+PDIjFUL7V/Cvw==
X-Gm-Gg: ATEYQzwB1vDxQsGtodUxX4Llzl3XlTVLzSS3oL82+IOERvoPjOZpqmoPln1Xpvo5/yR
	6j7RczYDDJAdKNAf6KXePTdOk1tbgS/57Ea93tZe/iaCXbF/0k/4GbjbwvKIhaO1cDgApZRbJMY
	7apSBqRgbzKwcMqBXVdrX9zlIdnLzWDScsJuZ2623Jw5twZIkQHJvHic70ikiZhz/CGwtZMRD9n
	fqXz7SY2dsV2Yu5X9SSGZlYfEkHbFxqGYoyg0t1GMr+fajMwn/QJihi1+mYrt7eHSM1mfhrP0Xk
	pMCXmhpI7Cupxh0tj+iWMIGB3pZCRyhP37q2GvEjrHsldJb3qt/6dPT6V92zMlLyDpB7tRcV0K0
	cT28yY8DVzby63auXQqzWRxK6Xxqq8T3SL9yBRp5qQ+KkC/HGCgnYNCrGtSwyd+k0emVe9Fpgk2
	XJWToVVG8U
X-Received: by 2002:a05:622a:180b:b0:50b:6b39:4df9 with SMTP id d75a77b69052e-50ba387aaacmr152131441cf.30.1774857736832;
        Mon, 30 Mar 2026 01:02:16 -0700 (PDT)
X-Received: by 2002:a05:622a:180b:b0:50b:6b39:4df9 with SMTP id d75a77b69052e-50ba387aaacmr152131051cf.30.1774857736352;
        Mon, 30 Mar 2026 01:02:16 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1675:c176:3ec0:ea8b? ([2a05:6e02:1041:c10:1675:c176:3ec0:ea8b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873068858bsm153678045e9.9.2026.03.30.01.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 01:02:15 -0700 (PDT)
Message-ID: <6391971a-46bd-4ca2-b629-be0b02e48481@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 10:02:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: thermal: st,thermal-spear1340:
 convert to dtschema
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rafael@kernel.org,
        daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        robh@kernel.org, krzk+dt@kernel.org, vireshk@kernel.org,
        conor+dt@kernel.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@lists.linux.dev, daniel.baluta@nxp.com, simona.toaca@nxp.com,
        d-gole@ti.com, m-chawdhry@ti.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260329123449.309814-1-krishnagopi487@gmail.com>
 <20260329123449.309814-2-krishnagopi487@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260329123449.309814-2-krishnagopi487@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: eUaRnxD4-AfkZ3pwjbEOkbPvhrlhW-KD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA2MiBTYWx0ZWRfXzD0qW2l5iK1W
 E9U1sHWVrJnaJQGJXlKWVcLTdAGcsejpq/5d/ZbUmKbWyGsfO2w/wP5nFBYJV7JdofBU4WxUOl8
 f35qJi47KNBWTA14BUw3sSRyYK6wiboAXKTrOGUgtqg/OscTtja4+cFPxqBAu8ySfHbNVBU0BrO
 sZqsyZjDJA9G0Gaaa4c/Yh1qKJ1/HlgN0mCeXFZe0onDLMfC5ttFK607PWIkvuP9XsC4QOAm6tk
 rB4+8yzhVK1J8xmd/gX0RvK4VQxzCrvdJ0XjnowftkSRyHlM202eZx9YtrPDtnxU6PcG6FwbOmY
 GW49BEm8x5f1ADYbZ6717FIjGqzur2R3UNU434TNrzKAEwDMoL6pA8jc7rXH6aBbqFuYZ4J7lF9
 MDQH2MROA5k5wn21FOx2bJNH0fpYA0ld5VSf0J5feMqVCbh6vREpYUhA72quqwg8aPykJfjj8iF
 DjOAWVTjIX7WJvXaBUQ==
X-Authority-Analysis: v=2.4 cv=KN9XzVFo c=1 sm=1 tr=0 ts=69ca2e09 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=a0Vft8LJKfaWkH7qTSoA:9 a=QEXdDO2ut3YA:10 a=nnjH-3LFHp4A:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: eUaRnxD4-AfkZ3pwjbEOkbPvhrlhW-KD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300062

On 3/29/26 14:34, Gopi Krishna Menon wrote:
> Convert the SPEAr Thermal Sensor bindings to DT schema.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>

Applied patch 1/2,

Thanks
