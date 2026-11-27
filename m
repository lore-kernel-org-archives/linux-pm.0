Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770986;
	b=mwhqQiCYvLW3RpKJi96yPBxgWzRN09jJscEy8gtBQEyFiYWETXtt4wpEJNi1r2uFXklQ
	 jznjv0T/ukUCLs0pw1uAg+vcLZ0TQMXVCPwk4cO5AS/P46kQS5Dk5jhC8iYWQuvWA+LOH
	 L1dcgmA/cOYwl1tTECiFaZSzr9Q1+KRHD2Bimkb7gpm6knlHgeNGnjwJM5AKmLU9JhtYV
	 toL1CK1jjcdCvJYSuJw8uc9vxBh1cG9eD4R+/8bnhus2Oqe+y9EX6NF+2pktUqdi5sf3Z
	 YsRwj0cwPOEgV5ky61ESc6X+UhGkO91xEl1X8sMhMie/KwfNXgEjqx9NMiz/yiFskKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770986;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Fcf04Jxl6fK6hJQpv7NF6ewyNk/t7CcRJRXoJj/gHYs=;
	b=DdUNtAfJ4xeQNV5e7QBnbKQU1ZlKxQBJI+ddm+0DGLQSUbZThs/L1FzmQYzLApiL5yko
	 QOSUH1wgsQCXvnhp490ow4d9X+iKNOvmiKEbh1nHytxhadggrotqtrn3e3/UbGL3IngZD
	 f/eMkixvCTZY0+rjxZo6EF1oAmaMvMhIUYk59GGSSSLKYBQ/rIQIvsM4NdAX3I/LOWeaA
	 FtYHC+wJc2NPxKICVVJdRyP7WKW+aJGUZxOKuljUh49iL0rOunihyojgbMtwuVNsAG5uT
	 hNe49tujjxD9q+Xms5dBNp2b8dmodL0nPaiutjNc3rlChp0rh+PKbKid8AJI/oki5SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="h7a/XazE";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b0G9n9y1;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C08606A324
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 09:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55C08606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h7a/XazE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b0G9n9y1
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7H3qF1076532
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 09:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fcf04Jxl6fK6hJQpv7NF6ewyNk/t7CcRJRXoJj/gHYs=; b=h7a/XazE8FBb/WvA
	r64lseyDJH4D0lvjddy9criGTAeCYGSLTQ1WRdXiwTrF5gHCks9C78apUYIfzEYI
	NvrNAtNOmHrSjjk4Lba4Ch6TLI7ejt3ojPT0VMTOMQs5KmrH1ZMljmd/eYAFj4h+
	53QZ0j1aObEa2LX+HY4kul5TlGhGlBVpIFe2ubsuJjyICCoqtvk15TrciJOwdzdR
	SJYDeWZMPqkipA65SjHB5bx9FFSoiAtDrJ+/2eSn9GwJSmN9wWZxLKCkF5NQACfv
	T+kfAAdnprT3N6Ds3v8KikW4ZRSGWoK6orS9IpNjwmNcGAuqTrNXp1ttw9AETekK
	EWyPCg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u55t5pr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 09:16:24 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5ecba171914so361826e0c.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 01:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795770983; x=1796375783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fcf04Jxl6fK6hJQpv7NF6ewyNk/t7CcRJRXoJj/gHYs=;
        b=b0G9n9y16S4voYKJv/uzktEeyyCupLwFwg5SfcPI/RIHqBXvEJlkToP6Ud6FMAdlhl
         rf58YOdmS3imahF00HkKr3FPkqXYvhElHWkNgUIn/gJMEnOzan5LhgMgpc9eWGGvVDeR
         3/X6UPI//UobCTUEMzobMdaizh4+TDm33U+tYMe5FLoUnGU82COZ1yFZcvPjgwHXF3bA
         x+kI9RqMxla8E+W72pdasAgh+Ma4SJR4MjGZN3w+tBl9Y8yD+M4xHWtVv0nrmG3dXu6Z
         zOEZ4yyeagZ9n4zH2Kv2Ik3DVqJ929sXB3+sjiW991b3S5g4or2egNvoobDIqjo5tVwt
         g4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770983; x=1796375783;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fcf04Jxl6fK6hJQpv7NF6ewyNk/t7CcRJRXoJj/gHYs=;
        b=nKh+s1ClW2MUt3bvZgevxx97WwK01yQpiZvj2zG1yj7E+tMYsoseo8nltSEShYZisr
         TELbzs59yq6ejtN2YmzppdMNocarYJbaTdvvKz2aMD/tCCaZCwXR2f5Ve5eGLPmFKWDb
         ndOFnfLFnxY5gvPyNuZ0U3iGREe6CweDV63242j3q0E3cACVlhTl1/rvtskZkHYgebjN
         Hx97rb1rkSz/+rJWxObgqBMKwKa00ck2levU0VRnlge00mCWKTRQErgwYsBG+HdchzeF
         45R+eeoxPxyqEF4xYiSQUdAJmcj/1NdXmv2M3LH+Xq2tj10TVY59CLK5t/bd8sFprpuj
         TOYQ==
X-Forwarded-Encrypted: i=1; AL+hErFxXCGmbmZQ5VNms1pk3ZzvHog6pjU7ZK4oSDtNuALOZO/kCtZI5P6XAsJCk36Ze35EB+ysA1krFA==@vger.kernel.org
X-Gm-Message-State: APuU4Z++fkDgRfQeaDJKNqkTxdmVtdi8mRmHdiUbkHcGP3egnHEpGBpE
	X2/YGdACPVaUkj96P6r0jRlMOkoE2ETtqZlo4ia4OnY/vz6pHCMmXiPZq9lRDrlFxAr88MlPlZ8
	+ZzqZe91FEk2WczKYpoDiJA7jcRSJQRqjh9vQDTXL9hUUNVZSSZoyIOn/oXMg+g==
X-Gm-Gg: AZFdTZdx4FCC1USuGUpkx4uiwoltQ6pfxq8DovMgHorSI2EcBk2bNJmKiHnTEdbHZyl
	qi8VpcACw1UADLuxC49HLsjOmREiUbTFiCtAkstCbEqB76ynVoJxxeAw5J5C0VKtIyS03rwKbic
	GINImTqKFamjuRPsrLMqEMZI0E93YvADMnR3/q39gSib3I2JUvu1DZLPW+kzV8h7XP7WIzkcJ4k
	sBuSOwSNP8ba2vVI+3NiwvfBHERCx+HQoVWH1UqDrF+3oKkjGACBU5LI6fz5tYwILnaqDCyF2yA
	iXkGFMhdFQy4YdN0bu+HXrzZTNbKtgWAuIjrnR34uelSqjYZ90+MZMy8dC9jMCyIF4PY8GiQ0M4
	M9Z1znpCI0sdD6AjOinNbBf1QFadTv6U4jwStE6QCqoYYvseYjiLQZXSR9vw+hbLKtj+DO5s=
X-Received: by 2002:ac5:c00a:0:20b0:5ec:afc2:c0f6 with SMTP id 71dfb90a1353d-5ee8ae00500mr17415358e0c.2.1795770982646;
        Fri, 27 Nov 2026 01:16:22 -0800 (PST)
X-Received: by 2002:ac5:c00a:0:20b0:5ec:afc2:c0f6 with SMTP id 71dfb90a1353d-5ee8ae00500mr17415338e0c.2.1795770982220;
        Fri, 27 Nov 2026 01:16:22 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6bb11ff543fsm3852235a12.2.2026.11.27.01.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 01:16:20 -0800 (PST)
Message-ID: <483774ef-1125-44dc-8712-73c0850386f1@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 10:16:18 +0100
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
Subject: Re: [PATCH v3 2/2] interconnect: qcom: Add Netrani RPMh interconnect
 support
To: SignKirigami <prcups@krgm.moe>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261125-netrani-interconnect-v2-v3-0-1136e2cc6e3e@krgm.moe>
 <20261125-netrani-interconnect-v2-v3-2-1136e2cc6e3e@krgm.moe>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261125-netrani-interconnect-v2-v3-2-1136e2cc6e3e@krgm.moe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzNiBTYWx0ZWRfXwMSTBWXAskN1
 hquMHXCIR5lkyLuADSEpDCcpLvbbWyQIT6C4iBg+e9SLzxIsvZZegXiF8gR7HUQtagZvzmjl99o
 DqPUR3JlyBeRgrDa2a4AFW2ZeZA0oYE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzNiBTYWx0ZWRfXycGHAtN3MpS0
 r1cBGp0nGCQ79MXfEmk/aeLhMcqyqBp7wJtGWm65N9PQWLS4v9zHvPgnljwgIA0CHmvkiFea9d/
 Su9eBubf5x+yzVZ8qgCEmLRYgYXcvQ7dAMPzPcXx1oUf80uE5ApFfVn5oNaQ0bPqw7l/2qLs1no
 U1R1NzPqESdvWjE+T9cjbXwo2MGctUO05nMCzoyAUiS9Ro2lC8NGXzeyrDvcArarF43/jeAQyQE
 Sr8ZfmJBCuGmG/dp8VczpKOaVCqGSwE5CbH3rztF2WlmR+Py+0ULfMNPTGT1/Aiov8P3ihkjGnB
 NfqMjcEt3MSVDf7ZUABD5swj273iv2X/AWFz+KiSctXyAd49NpLnBonIk2seyPlJoMx7x6l0DVS
 R1b54X3giqNntHjRQ/u2W0lioXzlYm1VC7btcRCfzPfo+hcULm8z1XHCUUq3khGyWAh9nX0N/aF
 mdrFOuRbBzur4jQcAyA==
X-Proofpoint-ORIG-GUID: qpxqV4iv4LBKkuIZl8oKiyQfk6rApZny
X-Authority-Analysis: v=2.4 cv=Z795j3RA c=1 sm=1 tr=0 ts=6b094a68 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=HlFBRxzNr9Pio0NObxYA:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: qpxqV4iv4LBKkuIZl8oKiyQfk6rApZny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270036

On 11/25/26 4:45 PM, SignKirigami wrote:
> Add a driver for the twelve Netrani RPMh interconnect providers
> described by the previous binding patch. The provider tables define
> the bus topology and BCM mappings used to send aggregate bandwidth
> votes through the applications RSC.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> ---

[...]

> +static struct qcom_icc_node qhm_qspi;
> +static struct qcom_icc_node qhm_qup0;
> +static struct qcom_icc_node qnm_a1noc_cfg;
> +static struct qcom_icc_node xm_sdc1;
> +static struct qcom_icc_node xm_ufs_mem;
> +static struct qcom_icc_node xm_usb3_0;
> +static struct qcom_icc_node qhm_qdss_bam;
> +static struct qcom_icc_node qhm_qup1;
> +static struct qcom_icc_node qnm_a2noc_cfg;

You don't need these forward-declarations, check newer files in
this directory.

[...]

> +static struct qcom_icc_bcm * const lpass_ag_noc_bcms[] = {
> +};

Please drop the empty BCM lists

[...]

> +static const struct of_device_id qnoc_of_match[] = {
> +	{ .compatible = "qcom,netrani-aggre1-noc",
> +	  .data = &netrani_aggre1_noc },

And unroll these lines 

You're also missing QoS settings, please add that (along with their
clock dependencies + please make sure the platform boots succesfully
with clk_ignore_unused)

Konrad
