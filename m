Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610A9383993
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713734; cv=none; b=jVrJeN4Gd2JTux0hqa6lk2vJbUweS/MMpcDq5WxEVMI3D5G8Ir3Jl4XHx4Ey4l9zOSWdLZBszOW/yI2/ZpDaNNNMlfY8zhKipUR1GqPppQsid2VJV2JG6WFujlX+GwBqNeNrcY/23q+Sg9mOIdObbpB2eY7gzymq2Uk6ZuGI9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713734; c=relaxed/simple;
	bh=QQvYXgQZ79JLNJp7VZ55ftJDAMYX1KQCsL1m6ngHEyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sY2JIIw/5GZGp0EhQOqmAgRJEGfwJUEeukg+ZeOM7dbY6Tj857zVUVvZzbnvGm6fXSry3PuBuQnDqo5njaMuWv1KBKynhJlqZImyKm3Aefe/x3pv6JSgsvtBR00WO6p/xe4qixelNx1S3OPKTliWSuqeg0e2+nKl5Pb2ZTng1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k+ZlAkV9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QGtU4FIC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k+ZlAkV9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QGtU4FIC"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P7QOBY3063427
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 12:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tNpASxgRfAk7e1AwXGXiG0LyhF1sC7Z8HgJNbKxjysw=; b=k+ZlAkV93y7QjTmq
	31m8q9bC/i9XmeB238hc/RckBBjaaH74Dsu1vE0hOd/7x4PinREo3lW7wlr8vKhJ
	5kwTe6Kbw+N4XahID2kuO4NmzehJmzVnOOdng6biu89t/xLqxJBajN1DtFjG79jS
	hVhIw4tFa0h6QKTJFfzM8L51RATLX8xQlRNgK2BYOHRp2NchJaYHFmqMnMiE3u29
	ad1MdSkw0eWd/HXbll2s0xFekZWbTT1D1nmWybBCd0Q4peYNtDMm0o/Umzd3lzKF
	t3dmWRBT+cGaCajwCd3xT7+mN2mRpSsI93MVcOgxBtXgtss38sl1zjANDfbmQWbe
	4xZLTA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecj1gh4x8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 12:55:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-516cd650fc2so11260501cf.0
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779713732; x=1780318532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tNpASxgRfAk7e1AwXGXiG0LyhF1sC7Z8HgJNbKxjysw=;
        b=QGtU4FIC+YujCVF0Kj8thTeO0HyJOqWYJKD5IZn8aRVLrGTZEqu9cSt4QPQu9mzxxa
         UYgHa1RTsOzd4AFXEIP2TgEgR0OEoz2hmZ2/l+suLYKjj5VYG/XNVCB8rSrvsgnKG6ii
         qEOUK0mfxwVO9leyzh8DAhxtzLZSwm+6O+WcuYmeDYOoQNi7cA1NAmFFHFWt6+ymu9BL
         ontm/rrzwjJ/DvGoZduZ4bmA2Z8Vfx3d8c/UzmsMvNzjS4173ybuAbdB/ssmymw+T8JE
         vFf8a44PhIeojdvRPcw9dPxcUqtNkEkPHOQvgTmRN1IcH+998WKW+4aM694sPdi8Wc8W
         aEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779713732; x=1780318532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNpASxgRfAk7e1AwXGXiG0LyhF1sC7Z8HgJNbKxjysw=;
        b=kMY1cjUrs65S/XNqL1zB4GqVvVCXVmjrEMy4DBQK1lfJWJiiMYcKw6Z9ND5L8QV0Eu
         MC/pN5e9F9a17/HL3NrcOJvO5yUF+TpPg9kHwkY0aGvvCuiCksYZq4B2QVjyOwnsjhA0
         ksObdoRzX0ZzcLSmWzpelCyx8B51emAn/MbV3Xw2WXYwm+AapNDyYzogLSKXMOGMssjb
         AjuDihNyzKGSCsDuhRNWqH2m2VIFE17JmxOXzgjWM1XjSa40Ah4v0TK8JVhvKVEU5IVv
         8eqKAk9msmNUhx0tEDwf7d13xxPa/S4IRfUGbegcmg7DAieXyVDZbqtfmu7PZgac77UY
         0kqA==
X-Forwarded-Encrypted: i=1; AFNElJ+E1KfOYoADkiUzuyqP/NLyIgtqWi2YuqdHHY0/iKNSMuzDy/moVDKVUY3WqocYs9jgEST+GWauVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVyOeVo2CpqJr/fuqFeCHghk1tL5wIukMiRq4qEVfHod+QXlX2
	c0TSKZeMtAEF9J5/x49FHRawz6F5sPtjD9u2QBJtU5OB6VPS5Mr5qmxyBJicPNn/A4qRqRtaeRr
	bpmocam7ntVxmg3Rsha5hu0zEyaeThrBtYtndLgw/+5JkH5ICSKJi9Lhivemo9g==
X-Gm-Gg: Acq92OEy/TbjqqJLNrebOkW8fEiS95hAnejGSyX9ZoFnd5VIWB9FlyMvnuTwbXMvhoD
	SwYRY4LamA44Kat3kbWC+GHdfMkKwmPYM3h3o8LBtpLmfdtQT9UV/k+XwgkQPj9bvZGEBcDlXKQ
	flTa4V5eUiCBMhA2W8kViWdX2SUh+52p8TZn36jgMbo3LIOHhQto+HhcVMPT70iu4zY2UZThnXU
	7KbNKvH2Fe7UoBayhWG/y+ETjHpHBAtB02QyJFv73F6pXOWkOdClV7dvPCGR16+JqqlLo/RXmf0
	fIRNSh1cR0egj3rwPyZ7Doyw/zM85a+LGupq1EMlWbUvs96SyQRTIy2Gt31AyiO/1k9S2OG8+AA
	1nVLYEwOYnRqNguiXFJ83hUKaKUmyORQ5LytAbKN7DUP6JQ==
X-Received: by 2002:a05:622a:8d02:b0:50b:2875:5782 with SMTP id d75a77b69052e-516d43a2865mr126389851cf.6.1779713731901;
        Mon, 25 May 2026 05:55:31 -0700 (PDT)
X-Received: by 2002:a05:622a:8d02:b0:50b:2875:5782 with SMTP id d75a77b69052e-516d43a2865mr126389501cf.6.1779713731405;
        Mon, 25 May 2026 05:55:31 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688bd00e751sm3897925a12.27.2026.05.25.05.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 05:55:29 -0700 (PDT)
Message-ID: <60f01a6d-015b-4a6d-be53-a5394ef0e037@oss.qualcomm.com>
Date: Mon, 25 May 2026 14:55:27 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] arm64: dts: qcom: shikra: Add EPSS L3 interconnect
 provider node
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-6-f51a9838dbaa@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260525-shikra-dt-m1-v1-6-f51a9838dbaa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: IXlbaTuu9LQdkcNySNv9BW5nweMu-NsR
X-Proofpoint-GUID: IXlbaTuu9LQdkcNySNv9BW5nweMu-NsR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEzMiBTYWx0ZWRfX10YM0QOUpomx
 JEwfsOL2YdziZpCIzdKgBvwAg2rUdXbOvW3a7keh0serZFKNdZw3D9LU5A3zS49A42AQ+l56UZ3
 r1QBcGDW6I+znKqsBmgSsbThzzAppFbpX8LN7o3OV5ZjzuZz4ezWGjm/7+DZjn8/Cjwjntck1F+
 eo9fJfU+1ctlQd/kWm0WAJdBuiH5ddFW/5H0CyHZThpO5XOIP8H+vgLyEqIPOWH9PXmuiu1EooU
 EXtj8a0/BDI2yaefaXNxRUeUvzm6Gdaue9r1aGPBevxyJMne9s/V1rJXTWbvaqL5FqHIZQUs+4Z
 OSKysrg2qBLFHY/WxS4K1xrUJqMuywZnQVTE7/od4caxzhB3nFwuY1gRAybNwC8GVswHfTuMQaN
 ZWgi70uq1W9vISq3Fub0vQ33Qv6a2gOk8LhB+2sHJf57umtppPz4tMYdsFmqV+BFpC2TcfaNltz
 8MDMUSmZHaW2EMVpWAA==
X-Authority-Analysis: v=2.4 cv=D8F37PRj c=1 sm=1 tr=0 ts=6a1446c4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=sDloKVZszu7f_yhO33kA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250132

On 5/24/26 9:49 PM, Komal Bajaj wrote:
> From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> 
> Add Epoch Subsystem (EPSS) L3 interconnect provider node for Shikra SoC.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
