Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427853D8127
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882532; cv=none; b=pPXofSJK0q82movFrjZEu1I6yDcpMK3qOS+llkL5uxhju5Z0xy6DZmnzZDJsZrlGwdANmmIsHGQrfqzxXUiBag2lRtdnUe4dsURJV4pGG3CtX2uAo3fHZMRZkVQrn0jMIrngigRhXmkwsq3tBgjMJCKEEmRE9gz9++ZprG1IDU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882532; c=relaxed/simple;
	bh=ZAyWoPFfctddUuPphDNAJoMEw4Bt+RcOIxpY2twczyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jNbz9zepmtbMIWBSGlp0RP6CLdfIu2HMuywoRV90ixX009VYa9kheG/Qc+vWUcK1z3wKjDCbBq2wa1adpk/Ji5ZGLRw5TGODV17m84taUYfb0kFDZH7rPv1/3upIyjc8nrkgE2KLC25exZWdhan2JpoE4LhRBLB0zTQd6TQEP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JHg/k9FQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d4HYEM1U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JHg/k9FQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d4HYEM1U"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8bEUJ302956
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 09:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Osl5MDk3OlUb+S44tTiya8LuoqHaUchW9RMiNgBRO4M=; b=JHg/k9FQQIxL6Zme
	V+B7tpU/dSampviXP3Opg6zIBx36OSrx+MAg/0p1StyQn/W/fspLPpxPxmwsc48p
	fwlqjaaRm2atIsx47QAvuty+lZur1dnYOczN6JY4qAu6RoVFzchuKjMWRkjy7JmD
	gdArz3Qh4zBpdN05SYsmhUUPTABl7z0Ju6VnFej9ugCwm7wHG9JbO3FML/vGvqjr
	D+CcrdHKkgLgw4NDWaG9tSl1P5Q6+b9iNnFFfmrwxvfxeXJjtkyyRtgBdk9cN1LQ
	ecRiAxDH3eYAgvWcqlZXDTcLJXk9V0tb1TX6APpTMraygQUxQuv9MYg9eO6aZ5e8
	Rvb4bg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98sqa1qw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 09:08:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb1091fffso18976685a.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 02:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791882529; x=1792487329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Osl5MDk3OlUb+S44tTiya8LuoqHaUchW9RMiNgBRO4M=;
        b=d4HYEM1UrWdfPcAqNGS9KdlTQ0rXo+uwgP01kurB9LCaqP6HpwiE8dg7Np4k/WwWbK
         GwlM22zpnpmJLh29MgHeHz1axCFV1MZbe7elUQU9y8AkqnoNRFTQHxCxrFwOIdJyzoXH
         w4RyOfpQy0Dv7kEoXhmOwPxlljoatBoWKzs6MHGBCc17lXUQLhc4eAEA3wIDI1rV0qcf
         4P5ALBlzR0MdHOphY7/Epmel6u/qkJjRiub2D7mXmf8uc/NbW3vdRVd+MMC0JoJNSb9/
         AD1+a4VJGc8VU+RQeYWENInbuX3IThgYdWSY9Ymyjhcassk9jbmRHz363B0xN81RmwS1
         715A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791882529; x=1792487329;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Osl5MDk3OlUb+S44tTiya8LuoqHaUchW9RMiNgBRO4M=;
        b=e7NFvfPa3rocPNzX0c0ezCN3cNxYDZUvcgTt1Lu6P98pJjI6o2aYU2vpR2XJXUVyYX
         i7ADGfcl6xNSb1TFwJfkQ+sVuKTSdjvv4ClmVklohJIn8PqouHiJ6h30Z4H7VZL8iQHL
         +t0z3L5F0aJNFEr/aExGZ8q5NYgfhiuO5O88m658BMFHXYOu0cFqV7ro+j3Iq7BWy2AH
         Ff054YFWBLINK7Wy85ffZr+QzBZIdfSOgdTk8yN9XoaZM8Vg6Jgt6sW8CDQYQoHKC5SP
         OxjBIhF0Gy5OK600ITgOhTntpf72QoMw2PAzuhaPpBqTKjRNDTL0GsA5Phk/nSHtwPyQ
         f0Tw==
X-Forwarded-Encrypted: i=1; AKwUvBzQqyoohPVc6ojHA14zXnuM+P7tR5rSOlfmX9JJKjgc5hODdkxdpSoRG0NRLEfjM68/Hb5zK4BgFg==@vger.kernel.org
X-Gm-Message-State: AFq9FYL7EcBOCwypg/A5ycdFnPb4jAvaKljZJEGalMUNKBbTmwNJyLce
	IgMjhluvIA2LISt3EnLzcz5m+piE61U2CZnFgO3LIlg2yojg2ykjB7UNQIpjtacGrlSPqtRFL8B
	9PMWFU/VIihwDl9O69wfonJxFwuKNEdeX5nKSfYK877Vk7AdOV6LAE7icW6y2uA==
X-Gm-Gg: AYBFou2QUoUH0II05LTF6koiOV9WIdOzG/yxJGXNhpi4Tw7okH7Wk/KvRgx66ZcPwCS
	nSvQYnWan+LKAXuR8Fs5w7/WmlZbku2ZxcF0D6cT0NiH6QSymx0yJWO43ODwIJEJmRAEE2uHbHh
	NowQHwCjS9/ZSyaElKjrF2RHayRFLoegO/UKqEJMkskUDotW9L/5Hy3xNXVmD62BzVr83BGakL5
	VsxaqFIA/Ln2i70yHDVa7Y0O3fg9UAvs+K37rBntDMzhdu4L4Q5aiCv2kL8v+QVolEiwcZe+ZPk
	f0T/fWRN+yaKfZg1CFZH4IUwDW2UijOcRWmFsglkVYDGNHpJBByK34heMrNOIxt1vFQXE4c7T24
	+NqnI8IdBCSDWLOyfmu+UjQ==
X-Received: by 2002:a05:620a:3725:b0:939:94c4:b799 with SMTP id af79cd13be357-93ebd25945cmr2264362085a.5.1791882528454;
        Tue, 13 Oct 2026 02:08:48 -0700 (PDT)
X-Received: by 2002:a05:620a:3725:b0:939:94c4:b799 with SMTP id af79cd13be357-93ebd25945cmr2264359285a.5.1791882527992;
        Tue, 13 Oct 2026 02:08:47 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c344ab1451esm268591366b.32.2026.10.13.02.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 02:08:47 -0700 (PDT)
Message-ID: <0afbd549-3e9c-4b06-928d-34b2912754be@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 11:08:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: monaco-evk: Add suspend-only power
 collapse state
To: Maulik Shah <maulik.shah@oss.qualcomm.com>, Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
 <20261005-s2idle_state-v1-3-3c402c66f388@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261005-s2idle_state-v1-3-3c402c66f388@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNiBTYWx0ZWRfX0rJaqqPF8vDM
 6Sv4QT+wutXv+NrtnRbbKGNem+gdJYmds75nDdUHDeNPMGwL1G/8xGYCjK9ZbFLSuqGGlUIEnhc
 e3hdoDzx9eSeYl6bW9yyJ73bqlYwU1WTTLIpvlPWff+i9lYfTZWlViffzNTQjbUtVzCTeLgaqdT
 rbeM5vC54OkTGCXqGSGE9Q75o0D4SLzIycrEGhfJ98Bc/aKYc89Tqj7+//uRbBTUdai/9VoEvcr
 ofDxvMra3e5ry3ffYg7U40JHA2lxjiGGwRfnBEvsx0PaFcxL2H/WfQ5XHBsFhM/ON++mxwYx5PL
 GHmig3q5m0S4iUXJb/gOseD5WxRY1nKrzwamB6sv4hVJfJDzbty6j5rND02ghgYvAMZKN3NXT8M
 sbr3cgCJC7qJJoIwTD3YKiFxcN0e218WOII1x4N9DmikUwXErqVU8ibi22i7FdLo26K1yhQoBB7
 Xfvlekvk6w2RDyK4wwA==
X-Authority-Analysis: v=2.4 cv=JN+uIMKb c=1 sm=1 tr=0 ts=6acdf521 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=qJe4qTQoNDkUl2DoRwIA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNiBTYWx0ZWRfXyRcQEqbcc3XX
 6tsHxuqbeXfVtmNNngubZu0rabQdD9qUcz3OfeSE5QoOUp1gWosbn8rqMP4h6KR75wjxSmmLTNH
 JRnIU47jyMntPx7jQe+BtnhRMGwEuFg=
X-Proofpoint-ORIG-GUID: UabbpIfmsYKvF0GuYC-Jax8iZhFPbuwG
X-Proofpoint-GUID: UabbpIfmsYKvF0GuYC-Jax8iZhFPbuwG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130036

On 10/5/26 5:29 PM, Maulik Shah wrote:
> To achieve SoC low power mode like chip rail power collapse (CxPC),
> the Monaco EVK board with four PMICs requires coordinated power-down of
> CPUSS and the Safety Island (SAIL) subsystem. This deepest system power
> collapse state is reserved for system-wide suspend (s2idle).
> 
> Add the system_suspend domain idle state, mark it with system-state,
> and reference it from the system power domain.
> 
> Assisted-by: Codex:GPT-6
> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco-evk.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
> index 539c9c80a808..b2978be6823d 100644
> --- a/arch/arm64/boot/dts/qcom/monaco-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts

Why is this board-specific?

> @@ -80,6 +80,19 @@ m2_e_uart_ep: endpoint@0 {
>  		};
>  	};
>  
> +	cpus {
> +		domain-idle-states {
> +			system_suspend: domain-suspend {
> +				compatible = "domain-idle-state";
> +				arm,psci-suspend-param = <0x4200C344>;

Please keep the hex numbers lowercase

Konrad

> +				entry-latency-us = <706562>;
> +				exit-latency-us = <706562>;
> +				min-residency-us = <709987>;
> +				system-state;
> +			};
> +		};
> +	};
> +
>  	dmic: audio-codec-0 {
>  		compatible = "dmic-codec";
>  		#sound-dai-cells = <0>;
> @@ -772,6 +785,10 @@ tpm@0 {
>  	};
>  };
>  
> +&system_pd {
> +	domain-idle-states = <&system_sleep>, <&system_suspend>;
> +};
> +
>  &tlmm {
>  	pcie0_default_state: pcie0-default-state {
>  		wake-pins {
> 
