Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613528;
	b=DR8uGdgO7b++EhxIU91EXFAJoKSXBZFdz3Fr9yK3XwMDJIeGfEgaR7glc9UvO47P86Vx
	 gHS+BtVqQbsw0wdIzaox3QMkKhxnkxAbDAON+e2KnjqQa7of+MWipf5V/HZflsbnxxjn0
	 7qU75bhhSTWHlJowITP+h2zaeMdUgoBljBjmbnDELIys6Q0+rCUINEKimXrK00uci5k19
	 NOnil9IZN1EDZWy8uiKGXoSVhUcFyF19dmWh6l7TDbgFPXUrZCZPkwh6lHwEVRKTWYJzj
	 t01a/JF7NUchUvp5w1mnMqSLPCp4UFiGVGSrgb0GvBbXvSox34PdLSbMq8wez8ubagQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613528;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jzIkZr3x3Xp86Z0mA98bwB9IrYK6czMaDjUmIisQr7k=;
	b=JeR6LBbibBHZ4qRps2UufHqa8II4mYYfz/U9RgWkTfQsCGkbodMwqOr9uRIvvT6CXGFB
	 KS4XK9goiX+hcDItUL+7KtH1afkiy5zH//oVrLuT9ySWrJkfyNjBvXK1OiNvqZrZL/vFa
	 qnj8mVyGVJmb4k3htpmZVP2H8+39dxZ0aDVwsqKWR+xe/nHVA6mpEMLBVN+FuLuF9/Tnp
	 2mowq8T6tdzeFaxnHCU41Nvw1gR+sKCMRwpY00EvzTUWwpG6IIjQ1rlynKCxiUXU7Ofhm
	 ls6Byb2GEY3aEpUL2tRfTKz05b+tb7YXQ+OApm2u24P2SGlb59hU1U3YdHi1HvfRWpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DDYU+IvQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="D59iB/J4";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EB3606A327
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 09:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47EB3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DDYU+IvQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D59iB/J4
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29B2dS4015097
	for <linux-pm@vger.kernel.org>; Mon, 2 Nov 2026 09:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jzIkZr3x3Xp86Z0mA98bwB9IrYK6czMaDjUmIisQr7k=; b=DDYU+IvQRYoSsgfY
	xxuhpLvMBKfk8QDJxkkquXf0u2tNrUP3w6sywVqWAJ/vgf/GhWmwHJ11HdBX9L2+
	XPySOuGi0kQOsvmb8zaDHROIEMJSf4xWYOErtSQ3nJkIyIf9M3oY/ruEf5JJcbx/
	Ct1BjNTmZFc98EhAYZtvJmVC3C/IzfaeS6CRdetp7/4wyfcvnfanWS5t87ikBL9+
	RlG2ebhU4xLxO1msW+9hlrgd8Fg79S3OBm8eqoKXJJHMVekGIVdmIhGOwt6Sfqw7
	YYRUIRKKADAI6m/I3tyLlCEe+5hjPUNJ17euSIVJ29Fs4j1MD7D3QEKTX8Bn9fud
	hW7t8w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7b6pf4g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 09:58:45 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91c7fe5576bso20034206d6.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 01:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793613525; x=1794218325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jzIkZr3x3Xp86Z0mA98bwB9IrYK6czMaDjUmIisQr7k=;
        b=D59iB/J4WBanpS234LJvwRPWBCLA/EQVcMDCCgrlI8g2NICiad8Px3CKBrFoHo7Cx4
         TlSopvbQ/cK4FpUwOiQInPPM1IljqvR4tgdZX6eNo8paDKA2MEGN/z+e+8DEc7L2ILHI
         H/0IG8g5WJAjHH4V1qb4v2Ejo1dTCLSL5M9862+CXB7AGKtnX1W4KGrvIgMlAx3eIML0
         dIdAK7R9P7OjsO/e0jGR/TvLb20QuJHguOTKpWrghRJyopAmpCRabWk63d2B0oT2064I
         xo9A/xbIQZOKX+9lpzQuBs0giL0A875vctfsNcgT8Hr440M8+ihVsdRiH9CJL5Mg5Mtn
         5d7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793613525; x=1794218325;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jzIkZr3x3Xp86Z0mA98bwB9IrYK6czMaDjUmIisQr7k=;
        b=t2XGQjnbtyUfQoZ2025SvHOjmpjulSlTg83h7mwUVZjXkh7yoy7SKq88DFvfs0xUsk
         Bh6+k34xYsRPEIHbDNX5RbOnFVae0YhWHFbT4g5pNIQ4A+fqS/OUUiKKbwXqaWZFgJQt
         6kDB7T/HSNjL6WX9pGK6vlaSpD5gNxr8JaaqTqRqWNAKa4T+Q9UsQvaKwp4f4zT22rdH
         9J/1LWx0uDakaLiEbWNPkVWP56wiEk1hYt+qRfiGX3NIfr35T+qdCY+PrVuJgGp/FG28
         +dcgco0OSoc7Xhv63GjHLY90vNNIcKic01WiUjIIXcKAWtRm+/RAiRAtfJsyLafCKCTp
         8WLg==
X-Forwarded-Encrypted: i=1; AKwUvBwStRXIn4ZB/TuEpnbPs3pejXViZoEh3XVz3nC08oxK3yNRaFF+OIOylnyf3E/BhO1Yje63NKQwfw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLTAu+9dKF4zc782aLfQtjTeikET6BfaZ7z+Snuz6BLd442sxMr
	2t7Z3AJhFmALOp3qqLM8tQfpz1BS9DWiw6UfREuMr2BlXhWowpUP21IT2st/xix0T+CLfVxf1zP
	NH6rOXdK8GKHitCkoGGYBUxRmDxhimdb42oD1qOSvGaMufP+tLfcYuurYIMgE7g==
X-Gm-Gg: AYBFou1Uc8QIlfjW44hCiRPJe4U/BrK6chOxMHJ5Pr6UwvcoTN5GEvo46aNcQ+96Pj4
	a3ytA6HDlJVjyKpzdQ/HsFI634MjNFKU0AROGfGSxitw6t83s3xZ00EZQSTnW/FNR8i61fp/GI6
	cFoCJYEtIrTvkO//DkF93ut816pkz6a0xhkuRVi+sr8YeujEkvgWnN8y/lXgMifEwAnqTNvSreP
	DlwxyLQFWbFhiZ5RN4n/nZ8xAm/YitWp4i5g+nsKq6bWGV0hR71l1XxGqo5Q4LOyoHvdtQF42jp
	p5VOFQD0fCXjuvO95DZvDwYNOeRdNGR06Nvxge9HXkPUKg466ROi1xcbnbaKgCp3JdvDbNJ+rQp
	Dw/JbB87qg/PEXPtCYF2eHkWemscDgSyWzbjFJEa+0tpYBDr7EHILGk8nBRDkqMZuXcr+sQg=
X-Received: by 2002:a05:620a:2246:20b0:93f:1fc5:f07b with SMTP id af79cd13be357-9442151da69mr1551972985a.2.1793613525328;
        Mon, 02 Nov 2026 01:58:45 -0800 (PST)
X-Received: by 2002:a05:620a:2246:20b0:93f:1fc5:f07b with SMTP id af79cd13be357-9442151da69mr1551971885a.2.1793613524919;
        Mon, 02 Nov 2026 01:58:44 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4ec9fc668sm3100901a12.15.2026.11.02.01.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 01:58:44 -0800 (PST)
Message-ID: <8433ec2e-0f0e-4816-b3a5-6cdd7a6d1040@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 10:58:40 +0100
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
Subject: Re: [PATCH 03/11] dt-bindings: regulator: qcom,usb-vbus-regulator:
 Add pmi8998 and pm660
To: david@ixit.cz, Alexey Minnekhanov <alexeymin@minlexx.ru>,
        Robin Snyders <robin@snyders.xyz>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: Richard Acayan <mailingradian@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, phone-devel@vger.kernel.org
References: <20261031-pmi8998-vbus-v1-0-4d805e5a0f27@ixit.cz>
 <20261031-pmi8998-vbus-v1-3-4d805e5a0f27@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261031-pmi8998-vbus-v1-3-4d805e5a0f27@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zbNeHWqHAPWmOi2PlKrLWKZA8db-nRpK
X-Authority-Analysis: v=2.4 cv=QuvLTlyd c=1 sm=1 tr=0 ts=6ae85ed5 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=nHuvgkJ7WHa1mimDmQUA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: zbNeHWqHAPWmOi2PlKrLWKZA8db-nRpK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfXwxI5dVRxIC6M
 W6b0+TWK8A47nSgBWCw1H127IYUahCtpXECeYUJeoEGXQkF5D9l0MA1xxu/BAUJpw2KHm/qIeb4
 yS79yqcRf2ZH0zKfew54IQC3tOxR9wg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfX0XG9isDIrsDb
 wUTO7Cb/0xVzzjKs/6mH8/Pp2bjagbF7lKTHPk6h3OP/la9Zbg4lWPxUYs2qXl1jpOSboOSH6ym
 31DHjc+dTWV8+F84m+qz4ns1Kd05WLoLBQniPR4W216P3Mot0ToORYPSyxrBgtOtxgD57VtF7Te
 e6FMCOc03hjTafsIEgNWl4gmGiyqHe3sCFnZj2ifIkQdpLsCU5BmS0FOiee3hFEKyKTtxlMsmvX
 6vx5VJI2FEcrDH852CUDd2mkvWZecoFj/1LzvehEZx9/RCUnYj6L7FKPzVtPTPpJfKV8bO4LKqR
 y+aF7uhKxs3X1ZAu13TK21kk+9W6AP5GnieUDNnPyhXuNzVe2X1uYC/Agb1M3SuBZkoRLsOq5fP
 66wh4Od85T40EHSpUx3/XFOScyoYQ2JNx0ljLKS7M+lFZzwE+AUczPr1oJ3t/rcb0os9m1DT7/2
 U0vtRPo11dMUPu0E0JQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020039

On 10/31/26 4:05 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> The VBUS register block on the PMI8998 and PM660 PMIC shares the design
> with the PM8150B one. Define corresponding compatible string, having the
> qcom,pm8150b-vbus-reg as a fallback.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

This is absolutely not true. They both have a similar CMD_OTG
register at +0x40 which makes the driver seem like it's working
for you, but otherwise the register layout diverges a lot.

Konrad
