Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591605;
	b=KmW132TEqP2xG7GcS+Ajq6Kn+c4xnRNxIqW2plxMNKYPgRw6Fvhd34tCTFIguDzjXj4f
	 t9l/4z2SDCE6VuhpzjNphxhWj00sGLxLsva40Xk3GgXGG07HsqEAdRv5zF+11nnxEZVSM
	 hHHKJRy25JRSTEHJhwlJsj+frmtCFWzW3mYKRxxHVf5ANCLqJn41KajOlf0Cq51G4ymrA
	 1OBUiTxXZra80z0dMTaLC0LpY8aCsPQlq1jslziffjbwfs+V11B08T4mrpvTU2ETczMdt
	 77CrGzLfjNqUo35FkF0FtnYbc8RRmEQp0o0rgecXQXiyIqliyZUHWrHnLEFIXsp13Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591605;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cER6PZfE63ZfwyWNRlY05y67PyxrF7hthCCcku5wocM=;
	b=1+eSleyWgRTO1vm49u0TRQarua5hP7/lws97i3XMTAk7kt8vh3lHfJT0Ki7Z8/o9K7jV
	 JB39jc6RSLlMrwoLiMKXAI7jfdSWPh1pzLfbv46MMzrGR1MOZPOK7Yysh4Y34ABw3qgJL
	 lonmXNpyVnhQ8tNnHkIwmQ5nTKBdYpgfftLTBmgxWs5Lt8uVibgV4Dgg+dDqA5uPBP0vf
	 R2PeXLZJapHHuK5UPH/HvDIQ+dU4OoL1ZPubvNCvvN9nP/zMIbtGvHJs9UbrSryJMjx4W
	 +9hkCtLE3vj9VRXjYnQzSU1JMnPnoc1xLvYDguHxevOrItzfhlzM1mzEZizR1j1j2Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Adlyp3EL;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UzWpeguv;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D694606A31B
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 14:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D694606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Adlyp3EL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UzWpeguv
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBft7S1599777
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 14:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cER6PZfE63ZfwyWNRlY05y67PyxrF7hthCCcku5wocM=; b=Adlyp3ELYkFxysWG
	3RVFTj5LBb8w4ZBV7I2s2yUeBtlczF6YuA0iNy87MMGeGqalnyv/IbYCWMB1vmkl
	Z/eLhtrOTtq5oMOBsTiCOfUwObu4cU7SerYsgb07VQC2w3JpOHqpgXR0y97LLHrI
	3cgKS2PwO/OHcIUnd2H7WPGsTagh02hD5bID4/pM2VhqhFAt1e6QTlXRCWP4q016
	KXZ4Z5jfBgXQh1rFW9xTPwyvtH8BIPGWmufEetif451xR5ax5d/h2+4ObDTmWSXH
	DxPbQT0K0Y44R9oXurNEkhbmqOk64/2IgtmPp3gKb26SfA9Y21eObX9B8TYy4MSW
	K9zmBw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heuhuguk3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 14:06:43 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-988c723394dso19520241.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792591603; x=1793196403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cER6PZfE63ZfwyWNRlY05y67PyxrF7hthCCcku5wocM=;
        b=UzWpeguv6FsfUh/0TnDvYebH1kzVmkID1zsEbawjqwJSvpcF+5h1dqSZmgKGfyOG7M
         j4mLmxhvDhxihQFfDcWFx7uWhluE/wxYQqWkTAdL7FbhRHw0s57vE/tZ7oiJDXRsyhop
         auichGK+GCAPCnEclqCip8gdpt+I4mar7UVxL83olscf3Oezn24S0oMyopQD1AGU6o3M
         ef3yS362X88I9Z/S3ieTnwBikKlz5cKbu0g2ufAbJH73vIRmJdHgPCROO+E5kLD10Non
         P3nq5BAOG5J0zZbE/a5xuTLc3j4Y44HuxcerJVn8DQOaO3fAdNWyEGloaQ7oYgUB2z75
         WZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792591603; x=1793196403;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cER6PZfE63ZfwyWNRlY05y67PyxrF7hthCCcku5wocM=;
        b=B299Hv6ZDWiWHwd6PZU2HF+bW8OVfrHEmFkb15TjxsqRg78FfyOojFG2WJyp1/+c/p
         j4Dl2wW+vbQD6GbIlqrSgvdfZSz98S9diIn3tNs8qFb8bNIVfNRdOa6YjhSI1N2T+Pth
         LPTI+3B96aKa/gTGJGqNPpM23JvkVCIp1dWjy2eDRMLFZgSYjHzs1a+nH8L539zUC1AF
         tTXyHe3P0xPtNYrgTbd2R2mtO+ldV7atUpv9eqa8NtBlNaQ+Z1sY2wRo+bb46H3DZ4HI
         ZtMsts34q90BxZS8LtzLgmwWijRuH8H2o2nAKfB8a08bxL//PISDEzPt03Skeq+7hZJl
         eSxQ==
X-Forwarded-Encrypted: i=1; AKwUvByYdgb+ym1OiT0gbgvzPeupu3nwyfqT7wgbRpezq9vE2wepRa5wGhN+5GuX7j11j7RxeDu2m6mE8g==@vger.kernel.org
X-Gm-Message-State: AFq9FYL9ieBXM+sNu8rQEN4BKrNczGOSLMxA6rH1DaqcmURJP4id2An0
	be+T8sgRfODpLGHY5jM3ADG0ntCdjrB21lHH9SJy/3J911Jc1b/g2oKj1ElRz+O+WXlQ3EehskC
	4ojVa6EBSgzTEfdQIL1Gw1Iogn3W0rZtt4DuZXhxTL/o3KuVFwRdavmSbide53A==
X-Gm-Gg: AYBFou148osaZx2XO3TmLC2Z8CPI1A7ReAp1UZVH3rYO6nT3lvUUYFGvIYpwgN3x7cp
	dCUMxnYhmI+VO+pnPVUfgk3BV2FK7Sd6cYHLq2QGI1tbFYbWaj/7iLIY9H41KQaYEyUaBVpkEyF
	TEYGuLKJ+QyxRpIaM7l6+TZCNnrZh+97ijDzmVp99qMiag9FVLyju6SrajPz/ERT0ymhA0HV2Le
	Awyj2TsGMi0avczccJRHGAsnxShr2dgyEsSmQvmgigEXnuJ7jKqTo/GHrQ9buz1PVu90DfyVRPX
	Kt3mXlTRpXODpamtDZwvbAoIZpi01b00b7Igv195nDk2wIBECYh6vebPurOXvEQHG1ww6BdCjQB
	mCGXO6n0vWu8eXuKsrzMIcw==
X-Received: by 2002:a05:6102:2d0d:b0:7c3:83a9:edb2 with SMTP id ada2fe7eead31-7cc9244d5f4mr680885137.1.1792591602787;
        Wed, 21 Oct 2026 07:06:42 -0700 (PDT)
X-Received: by 2002:a05:6102:2d0d:b0:7c3:83a9:edb2 with SMTP id ada2fe7eead31-7cc9244d5f4mr680854137.1.1792591602276;
        Wed, 21 Oct 2026 07:06:42 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a59ac2csm7665066b.51.2026.10.21.07.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 07:06:41 -0700 (PDT)
Message-ID: <5d3de423-e5e0-41b6-be5e-c1a46e53d570@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 16:06:39 +0200
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
Subject: Re: [PATCH 3/3] arm64: dts: qcom: glymur-crd: Describe the PCIe M.2
 Key B connector
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
 <20261021-pcie6_fix-v1-3-ad37134c35a3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261021-pcie6_fix-v1-3-ad37134c35a3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=d4JgWhjE c=1 sm=1 tr=0 ts=6ad8c6f3 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=WydMKwGuG-e24Vm_Hi4A:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1NiBTYWx0ZWRfXwYt9XwFhdGSL
 J66oh/0Yvi+DRZ0r6/1SOxiq0vqpDXJ5DB+z2R07FTM4nA+hAbSpH9TdgvtaiivEa4Y3XJVZFHZ
 BtuhxhbUb1MjNOyvLAcIPc3PwPI7xfI=
X-Proofpoint-GUID: 8HdBSVv7FwsHfcx5N-A5cyMithSOzq-L
X-Proofpoint-ORIG-GUID: 8HdBSVv7FwsHfcx5N-A5cyMithSOzq-L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1NiBTYWx0ZWRfX7tI/xuHyjqND
 bT2zWmIFaWBx6phhCY878oydTKvjqpui2bJIaDgOgMifaqvzeTU0ttuTuRtXHG44B7CCe6RX+bS
 pPDw8fC9ls7n5dsA9F+vqMfTbUcbFSQ6JtidFHysv58MsduL6UCYEx0hGd0hcd+NVFrccItbTST
 YvjjUiZwY66aZ7TtXQ4HSC5gypdlVZO3mMzqp/OpheZrrNALKjwsujM/pN6PVOuNo/qL+t3d9s8
 wLC4KZzaFhXT9W8aDPsuiM/jyuIE8t8uCe+Y26bfIgxFJ3hMDQf33x6W2cbG39BGagjGeFHFsoG
 hmANYKxkbnXn2QbYbVwLpld2JE6Zdfdrn7hmiCgmYyn/tcCBwvT2f+yu2ImztiSd2uKsoqcnTtw
 CKdQcLpz9Sl8xRuEu/9n/1fiATA4zt5OL50941u5LsxIeNuwMJ9nhW0AQkV3ItbiiqK8NEYXQNc
 8BVu3zq0J3h169R+aEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210056

On 10/21/26 3:51 PM, Krishna Chaitanya Chundru wrote:
> The Glymur CRD has a WWAN M.2 slot connected to PCIe6. Currently the
> vreg_wwan supply is described directly on the PCIe6 host bridge. As a
> result, the supply follows the PCIe controller power state and is turned
> off when the controller is powered down, regardless of the requirements
> of the device connected to the slot.

[...]

>  &pcie6 {
> -	vddpe-3v3-supply = <&vreg_wwan>;
> -
>  	pinctrl-0 = <&pcie6_default>;
>  	pinctrl-names = "default";
>  
> @@ -828,6 +847,12 @@ &pcie6_phy {
>  &pcie6_port0 {
>  	reset-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
>  	wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
> +
> +	port {
> +		pcie6_port0_ep: endpoint {
> +			remote-endpoint = <&wwan_m2_pcie_ep>;
> +		};
> +	};

This is already defined in glymur.dtsi, just reference it
directly as &pcie6_port0_ep {}

Konrad
