Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605213;
	b=OfL5ba3q6c6qQ5CAnFwfBeD4txMvUPw7kowY9YAtnhwyuJi1M4aR2LISJFrs1eNCwRVj
	 Ya1Mg8eonLwBhVjU/fbk6U1eWRWQsDBqZCIpN8b9Y8Wv9CH4EgS4niPY4e7dqFEQU487K
	 4dK926/jXb6XuOBDhZeSxPDlM+5iITXMAXr+HsL+vWfJc/1xS2YCCm/nFsVDQckf8NDbd
	 mn13zwntn+DU4rYEY7HRzoOlPn0aKcHaVA2eHC0csZXUB0Eir6kpWnKDjkIQJZ2fpPlEH
	 x20E1jI+yzC9WjMXuXxrBpOiKs82CKX9jAvM/Mr2fKUWMOi6DxOWT891WlH7UoMNKUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605213;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mN5Wi/oP+/iEZPIHVVYdEV/26IVRoESzTs9DlS/w+zw=;
	b=TNa4Nv7dhZSD0vzXlOZT5PGK5s2Q2I5BtTZTnhhRBp8p8cY82+LMjfOLZQ23UN376s5S
	 FCCPHobWG9ruPq960F8ep/7E/g3ltzk/yWn477sulkVeidC/1jk6bbyCh00KvHjc/KjYH
	 3DbWBPxJyFAFFzGNOgRJVzoewNKDK8herEl6JdnKfh8651HG9qv9UFBLzfvFlI/F6mXRO
	 g3l/Z1NXMDvRAyxBtbB8PHqybNAmCQM5c6qft0thE3pvuR78vNnymNz9V4oDuG99i4od4
	 EzmRSoL093O3n2COOlyZfQgjRya1ApLuBqfMIQxTX4NkyR2xOM1RbdQTB2xIaJs7dUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o9MBqwBO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h6ZbwCHi;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83730606A321
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83730606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o9MBqwBO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h6ZbwCHi
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mMxG2356515
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mN5Wi/oP+/iEZPIHVVYdEV/26IVRoESzTs9DlS/w+zw=; b=o9MBqwBOu3LAk3Ql
	kluDjP24AD5Fne6UqAfHIGo4aXZyOPqqNhGWSMuLNOSzZjicR5UqeSWaXbzQRXpC
	3S3swPaoOA2/2pfeLK9d2q60YA6NW3o3k2M7kqjahCRwHEdXGu2VXsKVK1N3XgsZ
	GksJF0GKZyCRJ4lZx4U1z6Z1+Ow8Q527VpGzEaa9uz5cHC3dp/nR+xbu2dNLJlY5
	FCGD5GihpERpZoM47wKRHcbqGFn2tMDIVhD9Sx1KWJROBzqzDOxGvGsuq+J6CfMk
	o0mkvgLk1sjDO6DsCgr3DhlD4tNBN24Fob5Y9fb9gNq6l5d4gdTozjxZ5YTltUDq
	VexuVg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5nu6a7yt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:13:32 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53635fe2335so8476391cf.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795605212; x=1796210012; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mN5Wi/oP+/iEZPIHVVYdEV/26IVRoESzTs9DlS/w+zw=;
        b=h6ZbwCHibim5dZLdQTk/KVIK7DHkQFXs5f9wRPTh96Muk4tbeCJJqgCHL7Z/e0Jedc
         TekoU1O25P/yI1+9qVgzPaqcMKSHASm1kZZu2T7j/Eno9s7aaumrfCs5aEv+nXoVygI8
         adNWrRp3i1xX2Gi62yz1ksyqUkOeeVkOrpfy98JV5lh/Fd4MU9rbRy3KkykFP6uYnXJI
         6fEThBtu4ZqXOlvdhyYeoPD/xjATetEUqCMjMfECyvva6EeGe8SfOH5/qF/zCFrmrcP/
         cjhgLkvK79I/HsPFV2tvbY9i2USI+TIP7h0hNlEJ44lBZc5aBvGuUNybglgNFByMPiRD
         5/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605212; x=1796210012;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mN5Wi/oP+/iEZPIHVVYdEV/26IVRoESzTs9DlS/w+zw=;
        b=f+2FIU2cbAVk0juew9Hxonp66WwBaJEbdjHoZHjK1s1SUjaUgD9d3tAg2KfborMEF/
         j9FNQpMUxsdEeBmo3DhMFoAiGPjyAZ0TwPJcqbNsCeOx2GwsVTYDO4i4rVneAvRFiDvz
         NRPEjRFi8hx8rodxAus3NRPSZkjXSjgVfbRi9u/Wstmia6mMfuNlX+4oV56viOMe2nIM
         7QO8i6MdP//uJCqDoL4EtktxnYJjwN+g+6/omkDCoHVSpeyDbBSk7dv3te4Hv2geCrZ8
         6L47NJVJR3WRmdY8JOeYc4nWYBWe07Av7eVDzY2f03KrOwp8HvfMhSS+6enYdu2Fp+Zm
         wUvQ==
X-Forwarded-Encrypted: i=1; AL+hErECAEMs2hw+PmDEx525OCojkV9tldMqfdxPX28XXy/DaPxBKIXK/4dHbBFLWb4vU4jPDyy4u1ZAdg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8WRVT3LbLHuV7D0kpmAa0+hLR8qamzkmn7VdkAaQNeDDWNAJ+4
	sRqPSKpbqjp0aKZdu8qdYs50gcO+3qeXmCiaRDAX5NkSEmBKVWGBoOahNbTYlzlFBsum7LlfoF8
	ArdQKsudmdRdj5gkgLpAIJdNQqb3lLhFxSd7rRzyQysJeFQPyZQHdQRihuAB6QQ==
X-Gm-Gg: AZFdTZc2kKu4HLpyGwBO2SfdpKCrPHayhpv+mQz0k3lLFtwmPCKvZG9sWV1FDhPe27H
	dnNttaF6P+ZLTUJ22cnIRCVZBl4n6cNiiZ/Y4tIrB/yXPKy5Us0VJy4Vo08d5Lm9nXUMmUf2Cyf
	UWtsNy723ytYeWDkhicLDggD0ABwTUpvyYVl1tXkogek7KIYXAiobR0Nezw9kTP7Ni3VtWtdauM
	O25J4Kov6nWOmduB9abQtxZ7Y7y7V1fKFeT0jZF64GuOLGZcCagWGyxrIMdKI9WaBBTe9p8NNiv
	uoP/ibiJjzu0r/Uo3IidL5hb/2POv44Zz2CQnHZEO0TdwlL+8yvV+6P8nHqpZyz6qdiPlXQFsb3
	kZFuiluiPC1iEb6VIrIqcyusbtPAepXfZdwtza+Rx4AtAyCj5AAw132Orfr3xJi4Is3foejs=
X-Received: by 2002:a05:622b:57:10b0:536:61d4:cc80 with SMTP id d75a77b69052e-55d76a6b28dmr296719661cf.5.1795605211544;
        Wed, 25 Nov 2026 03:13:31 -0800 (PST)
X-Received: by 2002:a05:622b:57:10b0:536:61d4:cc80 with SMTP id d75a77b69052e-55d76a6b28dmr296719371cf.5.1795605211141;
        Wed, 25 Nov 2026 03:13:31 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba36e35641sm8146988a12.1.2026.11.25.03.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:13:30 -0800 (PST)
Message-ID: <e3add71f-8624-457b-a304-d5791015bae1@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 12:13:26 +0100
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
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: glymur-crd: Describe the PCIe
 M.2 Key B connector
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>, alchark@flipper.net,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com>
 <20261122-pcie6_fix-v2-3-2e0fe615d90b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261122-pcie6_fix-v2-3-2e0fe615d90b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RodGwsLetO7zJEi3NQkC0AM1rz6Llx2j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0NCBTYWx0ZWRfX9je6xjqkTS1O
 KnpkH5cEHf+wG1eDirrcVfHhYy6uXQFY5wiBmmpsGqZOianu48FM3V8x4oRJcfEX8xy7/vx6hxe
 KHD1S2dVkV85EKhNfgEusvxUlM3Zucg=
X-Proofpoint-GUID: RodGwsLetO7zJEi3NQkC0AM1rz6Llx2j
X-Authority-Analysis: v=2.4 cv=Vra2kO2n c=1 sm=1 tr=0 ts=6b06c2dc cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=fmVD6mvdgdatrdQPAe4A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0NCBTYWx0ZWRfX6cdzbzEVdGB9
 x2h9zfXKwa10mOcQaIKGRsVylzM9AfLxesPtspsbEbVHWCxoMwZHPM2TPUzMFrBDsO6aZ03yAsX
 SqWxwNexs3ko6gp2Zjc2wQt/LKWM4AhwEKMxxyESX/k8HUGqxYE5peNXuxZIVTSfUBR3pacnZrs
 NyVxNsgPb5TrOBhly7yjVHXcXwAe8XMuKM8PsMGDs6RxEiZQ3MwA70w5Zct3KL1SR5qm5LCJz+2
 InnKvfnjW4iYZMXIhyVSjayKv1f3xEP5aOSqlS3rqTllphnMgOiNG7TQLZ/ICgsLY5mrrPsodga
 DAzHiuvUKRaOsx9CrrVqMWqzOEEWsTm1bdzmc5hnY/s3fvtQRjEmovdzsVzNmf1xSGgHKcWdaJG
 bFFq7kyt12BpIgmV0jx0dOTtQ91+90RcfEz1AHNT+QSmBhBRJ2k67kDdpGaLTatn6bYT2pL/R8S
 rk0fHvw0J8BmUsrI+mA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250044

On 11/22/26 7:45 AM, Krishna Chaitanya Chundru wrote:
> The Glymur CRD has a WWAN M.2 slot connected to PCIe6, whose vreg_wwan
> supply is described on the PCIe6 Root Port. Describe the slot as a PCIe
> M.2 Mechanical Key B connector that owns the supply, so that the slot
> power is controlled through the pwrseq-pcie-m2 driver and the PCI
> pwrctrl framework, like the other M.2 connectors on this platform.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur-crd.dtsi | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
> index 3a9cd5f3ec2b..a66ba8c0ac8c 100644
> --- a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
> @@ -230,6 +230,27 @@ vreg_wwan: regulator-wwan {
>  		pinctrl-names = "default";
>  	};
>  
> +	wwan-connector {
> +		compatible = "pcie-m2-b-connector";
> +		vpcie3v3-supply = <&vreg_wwan>;

On the schematic I have, it also routes FULL_CARD_POWER_OFF_N,
DISABLE_N, GPS_DISABLE_N, 2 UART ports (one muxed down the line),
and a USB port (also muxed down the line), plus of course the
m.2 config pins

Konrad
