Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C2A3403F1
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722756; cv=none; b=sVByoJoWe5F5LmC+OlYMeDGfwNjZrxz6dE14mF0im2xaJswvdjG+xolpx3ENIpOgBhja6e74Vq9JpWDmyL3r9PQVOsA3++0Z3Jv7D1Dg2lU47TROchKJZz3oEUTM57INwFZxDm812zE3AnTITGRR10H8eA6RltLkASci4Xbd0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722756; c=relaxed/simple;
	bh=dqNLkYWW3gpedw8yQO06Nn2TvNDxzw6IotmjZsfjq4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZKJMOeAFkAANsTya8tCpXcVQUfjxOeE0x8t1ZlPFK0gowGUpy+b0169j3f3cB/WxnUyKmsjEpHzQMYRtebCJ/MnBn60IAjymFsObcvuXd8T57jQFegWmu0CiixbPBIyiSJZO6UXMZY2zJVLBScrDf75J1bsECrn9hRg1bvmscM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UCVq0oo8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CXZm6+iK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UCVq0oo8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CXZm6+iK"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5xtA5716908
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 09:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8KWbZAe8YVsxv2ruoBpbVgqJH0J7SyBNe9cK8WaU73A=; b=UCVq0oo8hh3zpuNN
	YkqNqbz3333d1T73kirv80Sdf81VJxW51udbIcADdlqdimOPwFrBroXRMNZmCa76
	kAeBZfibEQL0ApMCmDR5Yli8Eb+1FTGBUYooe/kIfRqwteQSs/Q9Kkw/lOQPmJcC
	P3C8IMJkP61fVh4FHZ2v/Dm7Wj+kidskCGgUH9uRCWb5JOlb7RmHS3xb+JwgGWeI
	Gp1UtYJuSXW/GoRn0ybRNCpk0pyvklL31mHpqb48WnvgoievVWUZysFa0eqKW9nD
	JzzYetzT3VYrkLgMM2DHhuCBz2nVo11zppWkJAlEXh3mCCNygH+p1RyoFvOwI4V3
	gMIuqQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grrg42dff-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 09:12:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93918756165so98425785a.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 02:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789722753; x=1790327553; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8KWbZAe8YVsxv2ruoBpbVgqJH0J7SyBNe9cK8WaU73A=;
        b=CXZm6+iKFUl+TDKQmvTF03XLC+tqEHyFbdUs8DsQtC8MSs7+xL5OZ/K9G/heFHiUWX
         oQXaCG9nNVt2rIoYlOW0tkGZTbNFomAszQiYfm+Tj9/+JB56xfKb2A9nc8EMD647booF
         68RU8CIZ2TtaSQ03T0/UXZKy7PGgiTcJYOJq3lWWuspLlpIGvSRnnte6CdJXPREGfWqp
         4npQ4h4G+tvMVppnC9mk7wuRC0N9BG9Vmil1rsPIUDntTLAjrm8cJjsCosAGwQx3Mury
         +5sxbPZuCT3ttuxXNgqrmIpjZFQ0hpw1lR59cv25tMCTPo1xVkTYWePP5At16cAvBGgc
         ZTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789722753; x=1790327553;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8KWbZAe8YVsxv2ruoBpbVgqJH0J7SyBNe9cK8WaU73A=;
        b=T3kypNoCX6D5MyFrtc3LKFH0rAXkzzDcdrIQDN5rri/+GOD6kp5wpw43pBlC3j6lqr
         7LEOf7e3LT/Sa8N6Z9qYvbKEd55dIo+ZXxbV7EaJbzwB3411dwusG3DuVio3gARzmXOb
         oPgpwO1ptHF3HN7+nPx/2XSbpZ8zjGci22gKJIi6gna+s383zMMC66mpkNYmsa6at88+
         plb40VddOdSD7kK6JlFRDYC9Jrp1XL+UVb65hdrb9trnxT6SOzqtUbqnUFtIFDwm8pFp
         erCxeBBDRjk8QUcwkHeCx9GLSulTgd7YmEEDYIetd8m2ZkoXrn3bagOlHz4VoGKi5aBF
         ClFw==
X-Forwarded-Encrypted: i=1; AKwUvBygLo8LrfP9MSlrk+t/pj5AEoRsC/2ctTEqYHUEqdjMjjxOdaVolvpWx3d098fB3BS5WHX/mp70Tg==@vger.kernel.org
X-Gm-Message-State: AFuF++nfybz93cVOgz838ICy6MS3ciil7FWvrPAj/Sq3RPWOKL5ZlZ/+
	5+Vo3oq2ItgpIZGlvxaQM3Z+oPacCgI14TiwmfovEpyXrfJ/pdq6943U7ve1ME0CT8km0/+1A3u
	i68B0kWrSZJ3uonfhz0UKm2knsrkWF3pX2QGOS/0UpbcmOhHp1+a4VAgJ7XdIAQ==
X-Gm-Gg: AYBFou2np6EqPN+Nmz+4ecWiqdYVtMfdR6ykhFz1uah7yxYhS/ZDuxenjsJ8wDGmU6w
	vKeANtqmgDEG/Y8iQ3koNVTJKNDIlvGj79Y2dy8oMB88DTTLhtWIE0etMVRURSnBV0p1ReMwlSZ
	Uca5FpU7CgTggNeUAx1UR6si9gTvtYj7WINdv1IT5dokZZIHwO7ag6PkMi+7/aVe4L87CPSvMb7
	YqYthY1NPzQCvtr9GcGVtSDp8BtuBsdftmvWJ8vONqhnaq+ISIvVT/YJEI5kxQUKjNiLF5JSosP
	+9wvVFIWS02ISo8fBfKo4DkXH8HJ58u8KJon3zVMvSDs4YL0mJusWlsBOWnfyA3C98a0T+v4Iwm
	2cQx1kDUoH/wVD+ajnNKZ+16vTDDvouFP23/OGSmbfvuhTv0k//KGWjCcdAUuovM=
X-Received: by 2002:a05:620a:6010:b0:939:f513:cc3b with SMTP id af79cd13be357-93bdca3b239mr216694485a.42.1789722752693;
        Fri, 18 Sep 2026 02:12:32 -0700 (PDT)
X-Received: by 2002:a05:620a:6010:b0:939:f513:cc3b with SMTP id af79cd13be357-93bdca3b239mr216692185a.42.1789722752340;
        Fri, 18 Sep 2026 02:12:32 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:82ae:cd75:d970:e66f? ([2a05:6e02:1041:c10:82ae:cd75:d970:e66f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc58a1176sm31018885e9.2.2026.09.18.02.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 02:12:31 -0700 (PDT)
Message-ID: <45768828-d0a7-40c1-8eec-3a1fb2d66a71@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 11:12:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 4/6] thermal: khadas-mcu-fan: Add fan config from
 platform data Add regulator support
To: linux-kernel-dev@aliel.fr, Neil Armstrong <neil.armstrong@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Beniamino Galvani <b.galvani@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        mfd@lists.linux.dev
References: <20260917-add-mcu-fan-khadas-vim4-v12-0-497cd543a148@aliel.fr>
 <20260917-add-mcu-fan-khadas-vim4-v12-4-497cd543a148@aliel.fr>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260917-add-mcu-fan-khadas-vim4-v12-4-497cd543a148@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dvPVQ0189-63z7-rfrJFXoeGlbg9Rlb4
X-Authority-Analysis: v=2.4 cv=ZO9CCn7b c=1 sm=1 tr=0 ts=6aad0081 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=YaFGZCiNkOP6CsGDcAoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: dvPVQ0189-63z7-rfrJFXoeGlbg9Rlb4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEyNiBTYWx0ZWRfXzXT/xpWfbHgN
 UyCGyBikFSA9yiWW1iL8FlKBLswONqw5tSQCy6QXRskYBihX1DzJaMeqpOIhYw5mwJy+HxOaU+K
 DF953tbUJ72jRQcpMUUQbwl0l439y4ajZo/D6q9lk+C1B1e93BrxyrfZwrGOpH38bUGrUchH07b
 rGYt/3Xll82b95i8ex4U1mjKFTYSmEUIKuP4CtSBfNIJR7Nj/Tsl2PikFrBSF9tefUJd0IcAwTX
 NWH38jV7ycz/77ov1kaRD3mHTotnMY8b3HZy/v8oXJnatvWdqTe/bBpdrywYxUJYGdcHZ/6R686
 o7ro6UMjgwlhqWNG3V0kyK8hxDN+jw5+VdNklVGwCSnN0Q1+y/3jCMC5waJ6nMR2aUNUdaONEcv
 XtZTgVB/q7HMDE2jW/kE6ao6jv8BXVSOpityM5Kb+pCBr8VjFGDbTQnvXhIkgbsbsQECMsLC5CI
 3PC/EA1Ao5Ts9653ekw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEyNiBTYWx0ZWRfX5oYLQtarRMNf
 OU1tFKKvJ8Yjq7guBJL4zQi5uws2sPviw15IXbQtiD4aYExBL87ihK+shxYbf519EfOMKtt4uX8
 Gd222QAgRYSNituWfgnlO7zIHruIh3A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180126

On 9/17/26 09:59, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Introduce platform name, control register and duty-cycle
> levels per variant.
> VIM4 uses a different register and level set (0-100)
>   declared as a list (0, 30, 40, 55, 75, 100) compared
>   to previous boards (0-3).
> 
> MAX_LEVEL is kept and bumped from 3 to 5 to make
> the speed change more gradual with the newer MCUs.
> 
> The cooling device's state is stored as an index into levels[],
> and khadas_mcu_fan_set_level() writes levels[state] to fan_reg,
> rather than writing the raw state value as before.
> 
> Optionally acquire and enable a "fan" regulator supply
> at probe time and on resume,
> so boards that gate fan power through a regulator are handled.
> The regulator is released via a devm_add_action_or_reset()
> callback.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
