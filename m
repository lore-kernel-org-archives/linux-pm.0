Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D0A1BBBE5
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780125323; cv=none; b=Ys9BLLSh4ZqTwJbqDhjo9vs2X6q/Qe5kwUXFWq6xQE9FbIvDFGPJuVD98b+g92RcwJr1ScD/X7ONYqgfwZeeQUT0xyhyhvcATmQY3GWLaxunTI/XqEuwBNnS4f6LxFQrGg7iMLjkLhJuOrq6S2po7dx6fDH4EZJlkS4RX4rGEik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780125323; c=relaxed/simple;
	bh=n6FSZ0aXMjJduAUKujyunarABj2DYY2l9P3G378CRPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6EgeS4tOEwe6c4DTA5iBbajPi/vKD4UU7UEGSDMDWFHMqcjo5fbxMRvaEAIajKbCk3fpG7nRddWRYiy9g4pq7pzCa+frruigVM0C5+0T50+hLNuelEJ0xrtewM19Ley9pAsJxcZhYczVVuKCbtbLiHNLwlEbFXEirSoy8qf+vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gbrnMjF4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AgunGd+u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gbrnMjF4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AgunGd+u"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64U2XYmP1400380
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 07:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zpLL/bJKhYc82nklFMC3Foe+8nUBtL56C8X+bnVjl+w=; b=gbrnMjF4LLenVLGs
	S6X2Wxwugv8VOgBYzORkSgsKrqYe1EmWqZEv6erzqnqaITW1zIjvX5VQKfdt4l3R
	9W6+1iIDi8/ft9A7CJ33GSZ0kIo7h22MvO7CT1UZOmroPRF7REfyin4FkQ6TtTjR
	8dcCQ27zjkni4WMh6YUhTRsudTa0EVc022w8io/Rm2tDIiDLB3xO6RkMO2TPpy2S
	iq3kkJqrv+kR5EW+YHKO+7ExMIfGQii3Ac8mqC9a8hoCHoSPNWTYPPu3ai3G+KzL
	IbTBB3NuW6QjSARj1fIBM707JJ/t4sgMPFC5nOOLS2lOagX9mEMsXRUzQt4s24+V
	gJDX/Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efq7f8hpw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 07:15:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-514b673c8f1so44106721cf.3
        for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 00:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780125320; x=1780730120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zpLL/bJKhYc82nklFMC3Foe+8nUBtL56C8X+bnVjl+w=;
        b=AgunGd+uFJj9peATTGeWhHbrqmRIK3wrDhwztfUK/X+gQ3hhYuostoiBiIl5M7YM16
         1iDK8alJDsE6vF9IL8/khrWhuPPIEraG+Z2nFgTXReod2mtCvLhijRuzGpCVqtA+MYgP
         rAEZMzkNsBpwyYyCD4N+LTeH6WAUQ+Ml4Y6ml0zwcme3mjXBY9BDVft4t5WZpUhF2wG2
         YzkvWFUH6wakDmZ42Rj2PRpn0iCEixUqZX7sit7oPaQ5nbBNgoLahjX/1BFziJR8K0vq
         NjUMfO0c6bJwO0QW8RCswONYY4PQrlaaCOL+VGKtDfLpOVrAzlxoMWRKBcd6mwx1EluC
         YHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780125320; x=1780730120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpLL/bJKhYc82nklFMC3Foe+8nUBtL56C8X+bnVjl+w=;
        b=RxDtGXrBUUAjjm0Dq+cjNCE71itv5ajKRMUb7dyoJ7+blbjeTfS5k37ii2plS0TxGq
         HkrlsdkXSUNhirx5fJRTy3BrIuNj/at7ZQ64LU6DL3f4QTxfjh6uByjs0i0pEg68ej9D
         mc3rTyNeUob9vBVfNYGaxQzLJHiGoQBKqzwuiw/7n8Oz8MQQnqf8mCNe5Xff5skYQrQ+
         8LWh/Rw5m8gNs2YqKP+ygoils4auIiiYg9RmbYaTgzUxk2svB9bXKSeM5F7oVRuLVe1E
         AXoiVksnzfp8vAGOlCUZcZhHQqt+uFIgRoCzTiAsDdDaPS6T1uMeoCNjGk0UV9Ysp7XG
         0afw==
X-Forwarded-Encrypted: i=1; AFNElJ/A95LjQBvYDXllB1Ft0BRCvjRuKU+gkmxCdOBcXGZp9WqeGC7DL736ckN1KmzoHO+cn2FgjxLJgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwY9ScSOUeYJ79ym0BUEceuFjKCQJbxRwvc8g6dsmtU2Ff9IWWU
	EX0V+hOCW+tbsza41OLO0l7Rtla50AiRBOUbvMlTwQElffbv/GtYKEVdELSb67Q1ZgiB9xVTwPo
	F0RLhbibsiIl9QXShbSqIndyXQXWNJCqTl9ipyr64ww6RL5N/3EdWqPGZ9XjCGA==
X-Gm-Gg: Acq92OHnCzsingXslPv6p/IeFI9KqRVKgAa6VtSKLLpAFAKPMK5Ya2BBdQzVwawq8q6
	jquYVk2nNgp1J53Fwc9rK3RFGUNF4I3hmdoJHLDkW445U0uqB25RNrbHRo5mfI2Gjyz1nWpfY8j
	+gvVtsReOU4zJUTl6ct5vWsUb2qGYn9j549Df3ovPpn+FRyK+1C54T4s/DSVNk3HmDHfIl10Dxz
	frBC8mMr6WTeMCjZs8vwUZpmXQwHTBfVYhoOeL2QhxzI4qyeBE78q5+l/ssR4GJcg7n+cUDGFYD
	uPAbaYjwTMLr8i3uv+ONaFVUrNYdIiZIrejeZgtbwpF9Y2SoXcOtOJfSMG5YOwxcPWxGRixyoRy
	mdsnfkbu4cPF9ot/0xuGq/UplqCJbCSRQGBjyzrYnZHJwoYb56uhWFCEYpaXSq1GkvB7JtQ+QEf
	vc093t+rz/XUGs98FrkV8=
X-Received: by 2002:ac8:5896:0:b0:516:e4bb:3bbc with SMTP id d75a77b69052e-5173a64a71amr36310001cf.22.1780125320180;
        Sat, 30 May 2026 00:15:20 -0700 (PDT)
X-Received: by 2002:ac8:5896:0:b0:516:e4bb:3bbc with SMTP id d75a77b69052e-5173a64a71amr36309651cf.22.1780125319739;
        Sat, 30 May 2026 00:15:19 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c13276dsm30282215e9.36.2026.05.30.00.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 00:15:19 -0700 (PDT)
Message-ID: <946af0af-6c4f-4e3f-9e8c-408b2c2b2a11@oss.qualcomm.com>
Date: Sat, 30 May 2026 09:15:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: meson: sm: add stub functions when
 CONFIG_MESON_SM is disabled
To: linux-kernel-dev@aliel.fr, Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20260530-fix-missing-meson_sm-symbol-v1-1-3fb672b989d4@aliel.fr>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260530-fix-missing-meson_sm-symbol-v1-1-3fb672b989d4@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8IUhf_cBgybJp6gX4G83OYlyibIseskk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDA3NSBTYWx0ZWRfXwT8wLkimYc6C
 gVKsp5nk05FVCksxJjnQqKOreRBOaleA9C/teP1XTB3DkbNVLdae8v/yJARz7skUIkIY/CmKPfm
 f0J53QWsm0YmCArnIKBLdXmWnrq+wSi59T9TckEKt2HHkQ/z3Vh3rh7+4bRmM915Zj2mtbDqPt7
 /BrPSHRKw02NdFZMZPZ1okXb0eQpUKtWEvlmWNvPWa21XFmEYNz9gLzfIgldTA3bVxWLIKPErFu
 8t7t6ADhtjLWdImm1SYIzF45KuwKXdTLMThH/4ftA1FaJ3FG5e35PRJiAI7E8vYOdr7sZii+RQk
 JMa7KudOfiN8DlL1bXnMkXQGXnqIwsP6xbBr8ByzJKDu+Iw4nSi+YaMF5CoJK/l2qorA18ba4Au
 +fbDJXQc4KW8omuCDAWduVVavMn2KMufv1SUYWFFT9rjNiMUMfkIOEyzH/g77/Namy920I/M5Vl
 NDD5IYvZdg6gPHkIRDQ==
X-Proofpoint-GUID: 8IUhf_cBgybJp6gX4G83OYlyibIseskk
X-Authority-Analysis: v=2.4 cv=XqzK/1F9 c=1 sm=1 tr=0 ts=6a1a8e88 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=UWCdJKDxNioY7VXa7sQA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605300075

On 5/30/26 09:05, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> After merging the thermal tree, linux-next build (arm_multi_v7
> defconfig) failed like this:
> 
> arm-linux-gnueabihf-ld: drivers/thermal/amlogic_thermal.o: in function `amlogic_thermal_probe_sm':
> /tmp/next/build/drivers/thermal/amlogic_thermal.c:196:(.text+0x2f4): undefined reference to `meson_sm_get'
> arm-linux-gnueabihf-ld: /tmp/next/build/drivers/thermal/amlogic_thermal.c:205:(.text+0x320): undefined reference to `meson_sm_get_thermal_calib'
> 
> Add inline stub implementations of meson_sm_get() and
> meson_sm_get_thermal_calib() behind an #else guard so that drivers
> including this header can be compiled without CONFIG_MESON_SM .
> 
> Fixes: b21d88de6918 ("thermal/drivers/amlogic: Add support for secure monitor calibration readout")
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---

Also added:

| Reported-by: kernel test robot <lkp@intel.com>
| Closes: 
https://lore.kernel.org/oe-kbuild-all/202605291530.en7aGn7w-lkp@intel.com/

and applied, thanks !
