Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203681;
	b=vxx7Y0pOk05L38QQlDSebIdhkOqI9/OBPjunqL7n0S4IaG/dEpXzBxW+gj6lAXAJ5e+D
	 ZkbOwOSI0gX21h+85S3hcQI6BM7n/+j7ZDVtTkGNnkQjOBIAxyZEmJd+E1HGLsGdFiM8G
	 j525CmGaqTUI+AjFv5oXe7bTx2faXfvJsFBkS7N8Rfjx/Y8eiyYr8VaX7TUj7GWiIzn7X
	 IezG8HxDEqX1VdeyLvQxbBlWwoohYdxF7yMTVdRzb5P5s8VmUvCycrRp6LYT6mk4PYFSg
	 C4BTL6D8t2XPbcffp3G+aBmGLfRDSEb8KLp/78GlD8HHPVhcLtuAqIebjCbhp1YtVpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203681;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=OvJdcLneWcdAZrlX+pjCRCZqVtPdNXDbzbSNDdyEqno=;
	b=tM7YAMw4vC7Von1ue087Sw8ckjSnIbZQRvKuT337dJvzeoh4jzvwUMXz+7n7diky81XH
	 I9Iz3wyMpyKHEdYOxTYOcldUpCIHLHQRjvanOONgSFWsp9Ifo9aoZnUt+rvheZSr33UU2
	 DT0+20r3R21KeyUomxrcKpXGZbvYrIDgZlUTItoSMFlNIQddpNjG96XjGYEcvTbA1xszE
	 X52k14unOL7axGfFsthhQNRwTzV+hcovZ3rBluoZU2lioveSzEYQJd0rAuEZ71Xk0mxJQ
	 GO4f/GHs7lrl80/WFmF4rcCdBbt071Oq/CC0ZcZzFYwotKNXa4E2amZEGROwQXXndrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TptoXtOZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fQL1zCXG;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9978606A323
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 16:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9978606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TptoXtOZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fQL1zCXG
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFAFKK2001768
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 16:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OvJdcLneWcdAZrlX+pjCRCZqVtPdNXDbzbSNDdyEqno=; b=TptoXtOZfVkvyWO7
	wT945Yf7V6tV7xhvIzg9p6o9dvNMIU0Je43wh4tEWOslhJ01HL4PKn2SV1PkclKV
	xa8VvtWSnHlG2zNL+AB2ugXA10GJEc2jdtkkvvRMg+XmcGwQl1Phr9MXOXftv3Il
	IBGf/uGcS2Axo+XQaOfPX71j6XsdH4IU4ZXEJEFvC8ZSHfug3obAU8BH2yUmOba8
	cH7VktgX8Ir5dNGmSkZMxvhWciKRpE3Bffb0ME/J6Aa4HtKJLtRhFE++5RVRCONZ
	6n8lhZl5PT0rsQzebFjsaoHXCVmQRXkGgVq36d0Hp3wWo41tsfobHNzIQVugInTh
	WGXDDw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkdf7sv8b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 16:07:49 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c82cf2652dso316330e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 09:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793203669; x=1793808469; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OvJdcLneWcdAZrlX+pjCRCZqVtPdNXDbzbSNDdyEqno=;
        b=fQL1zCXGs4C0dAhnT8Otxvs9L5cl1ehTZPdbZGYIwQgjkywMMWdNpKDgFVetl3oHgV
         u+EXUGL6wlFkmhjgc6IV9Vt29iX/5z5WzEF0ZBDvn2plaflrPezYkcA+DM4whUx23F8Q
         IH7Ppu+susjbFtLiraCc5MiZ64FSYaNgfQOwdWG4shUvzW0HKsza6+PU8hfPfZUU6PAD
         4fPnxzGb67Bmu0L8U1u+QSmfcsDzMwk4JJkDR5j4tXj5Fob606aIT21fTrbKkf+HRbvr
         LkRa7yKwigUdkkTIhxjbOeZyIEcI59s7fONIORCubsLm+sKoD7f6B6CWiRYc2u7cRx1W
         8NgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203669; x=1793808469;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OvJdcLneWcdAZrlX+pjCRCZqVtPdNXDbzbSNDdyEqno=;
        b=HnkThhoS2moii2xEAJHbuepdEh9wUUfqti7+qF+nNtn/6k9NWtwREMAi/SeRHYw8e0
         Rcl5pgjUHRETbfwdQFzC8VNSbQgUe3JUJa41u54BlWnp1mCCFHq19Q7LK73eG7YYJReW
         suTX5pdI/5NSkKgEs7+ZbAU9n+NBV6QjL9BoEb2THkh+ZWl1JPcQKizkiI3zuBwBOD8r
         sFu/NxTNTiIMywqXvKjhQjyYG03SMkoqXk3atI4qPpFBuck1iScfTL0b8sF4kiHJBgR2
         IN0ZVxR2y3iQj5Mal71+UPRbG322OGkomw7WiXIPPmOSwyqXjEUpMtTBZiXjsNA88Tr3
         8iDg==
X-Forwarded-Encrypted: i=1; AKwUvBwqBW7oWAfwEqKlTX0M98EgEChrdkMSd6kp9OjeCf+aCvl5ai8boD14J6YQFJMy1Y9c68LACoT2tA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLFrG+iupqIm+4k0V0p1NhLqLxdCP7TmK0uagVG6zO6Z0/LXHfi
	xFqpb86QYgv4Vf6DAhr+10g9OO8dZD0r+Za6aQrtvAQlbcTOnCOoHzhJKSAVWdykuckaW8MzSUV
	HcSKMWE3dFl9AyFTV9Avsb1HFpY+73tB15HOD4H+HXV6Pw1JDcltL7S5pBOt+bttMNMjWEQ==
X-Gm-Gg: AYBFou1OFhRen4gay35TZvCxYwkLd6TacWqZq9mDXV2aTbD63ZuLrbVX7L7voheOn/f
	xP9RFiH0D5p4Z8xW8Tg28zKRxr4WJ0TyslNHohRy3yyh/zZOFCnUXSKWHtmQxbmhAOWSWdgFjVi
	/1mEesKZ7Phd7Zdv/LBSdrvQ2jEZkBHvPRfXpCW+RdjkmNt2v1eBL5UMHvW4UMW/wf2BcVrcl+y
	HMq+mB7SRpBPVEUVrBXjOnLJqdub7kkt08D8twUJBsjgb+AnilHS0jiGNnhZCd/R6PFbuhUFxjx
	igwQP0jS0hE436nstRWhevrLOopq0lOC4m+Fv5B2F57IRD9Hjj0PyL2vkowJvmQAdxmjHEZsCgo
	nSUuD89FJZgMkvmDpNrARGOeA4dicNMH1wN7KovnMP/KYMyfQzhQCXHDr1CdZSy6lB9NrHyNleU
	wRbC8Ajdz3nV0tUbUghYVFspDTdAyIFEQ/
X-Received: by 2002:a05:6122:1351:b0:5c9:66f7:2f23 with SMTP id 71dfb90a1353d-5ec4cad0b76mr1280454e0c.2.1793203669098;
        Wed, 28 Oct 2026 09:07:49 -0700 (PDT)
X-Received: by 2002:a05:6122:1351:b0:5c9:66f7:2f23 with SMTP id 71dfb90a1353d-5ec4cad0b76mr1280418e0c.2.1793203668624;
        Wed, 28 Oct 2026 09:07:48 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:53b:4cdc:b68f:256f? ([2a05:6e02:1041:c10:53b:4cdc:b68f:256f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm27689459f8f.56.2026.10.28.09.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 09:07:47 -0700 (PDT)
Message-ID: <f054a608-730f-4415-87ef-510523a50ac5@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 17:07:46 +0100
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
Subject: Re: [PATCH] dt-bindings: thermal: Drop thermal zone node name length
 limit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20261026094956.2323036-1-daniel.lezcano@oss.qualcomm.com>
 <20261028-worthy-prudent-cuckoo-d5ed97@quoll>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20261028-worthy-prudent-cuckoo-d5ed97@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=M4bYuCws c=1 sm=1 tr=0 ts=6ae21dd5 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=vV7VIxlxivoAVXJuJQcA:9
 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: oWQ8bqiJFv1MsRz-UHdu4qljrpnUcKmm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2NCBTYWx0ZWRfXzHgGDxsZf3aD
 lrdluAAsVPRPcQzr0Y3S41d2zWTQFR60hIKB4rWrI3d602OLtFTvfTfNKRf8leKq0vE8VeqljRz
 ui4F5AqRKrUv/Dv3W7RMeWZhfgrJ27c=
X-Proofpoint-ORIG-GUID: oWQ8bqiJFv1MsRz-UHdu4qljrpnUcKmm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2NCBTYWx0ZWRfX9ahUNcWJgGbS
 oVNwt+ffKKQWvxNGzf43j8PQyoZtOAGvcfhOWKHvNq5UzHSluNksjLY8B4cpLIRzIREpIkGKXV4
 lC8Bj7R7UtRiTegTXPSsBt/GO9+dcGPw0ihKBzzCJAsvuL2X3u2rK2kiWfaLxGWV93VQ1e0+qgn
 Fm18nDz4eEgSUv5MP2hpQeyW8UDQo2anXvtI+KQwgBYRyclqRX4mikH1n8T3PjOVspcflT9Ld4y
 TLp0pv+YmE2Dij8LyctiSiH84Ek7adLNMChkS8Rv51Z3l7wCfv5qSnhBIZP8VyAFhj+uqKzQgaD
 LmSYlnr2VKuq0zXOnPm8g2rUcmm4ydQ8gBukdAHgeKdS/m6aCDPrwBlHmnTP8hC8UtDolC+8Tnm
 Sdm8vGMgnNb76ZOL0M7xOn3zPRh5NQKrfC4BWF6yPpdGQaVrslSe0xXEMO1RzAfqDRXQfFwvmJP
 oj5YBqrCs9ySO3iEgrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280064

On 10/28/26 14:00, Krzysztof Kozlowski wrote:
> On Mon, Oct 26, 2026 at 10:49:56AM +0100, Daniel Lezcano wrote:
>> Device Tree bindings describe hardware and must remain OS-agnostic.
> 
> DTS describes hardware. Bindings describe the ABI between hardware and
> software, so if SW requires something regarding the DTS, should be
> placed in the binding as well, IMO.
That's odd, if the Linux kernel changes the thermal zone name length to 
something else, then that impacts the bindings, no ?

I don't see a good reason why the node name must be limited by Linux.
