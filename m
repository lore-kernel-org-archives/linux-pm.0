Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578951;
	b=L+fJy/DvRryqpoUNicYIIcL0VfI1wkJ6LcsjM+yQHKKaiDwHo4rQpsHgThdqzkxDzqYC
	 hnf8v5Ino27dw27ldMYwoHkoYnKpoCOMdF6Pq0Fan7UdW9Bpu2zBUd4lsIKRYPoV1Jwnu
	 pHew810U2HHNn6X4n7ErRCZxSr6AKRKyQIc63S9OiuF2bk0ONdd7Fi+A2zaXf1ascJFki
	 +rgVCJi6vwuGPCGAhap8uYl967NfFv0Bwerb0+tvOEJpdOVb6AEiukgTtL+X2Fs3kSg1N
	 b52g6J5IuuSLzTe2kCzQUhKesHhdbG+FPvevm2zWiDKkjSRm62IA4nPkg1qgvJ7E1ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578951;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=DVoFS5UdeUKhEoUyshqUvMPNFzcB9a4hiumD1nyvvGo=;
	b=3DybHQR/6v7xNDcxFQ01oHWj+PXZOVuCcqR+0pB9jzVNRBIbQ37EfMMvo0wtzGyis4aW
	 qYUbY5DHcRER+5FmzsFB2UCXah+KhyraYbfGQQCmKAnLMpesZ9eYGvKs/BRmerCmHyq+P
	 R1QfkCKW3GCE9E/S6WNxIRJL9sFuTEHqX6GeSeYTk3aQC2SEOnKY3nztqRfVCabl14E9x
	 83z37k65QQDFzwId9yJgTFQ0qpJbzLRwUGpdHhxwY8wj1VwH8mz1YfrhtZN4zJ23AMedP
	 7phvPF+mEnvlXeEIjDqasUl1f7XVEwMk1Eql15zuuW73DImVrdWvUBJutcRWHrKoT/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kj1lw3qc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QHNJF500;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96189606A322
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 10:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96189606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kj1lw3qc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QHNJF500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LAJTVS1422109
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 10:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DVoFS5UdeUKhEoUyshqUvMPNFzcB9a4hiumD1nyvvGo=; b=kj1lw3qcgVzh9yrJ
	g5cjz2WfGS0Mir4lkZ9p+r87Yd43Dsu6W5akW4KQwJu6YU+nkuAXn4z4hvdU/Iab
	3yHn1kXxaNt9Z4r5W5DfEtXpCQBAS86GEn7OO28q31v2KJDEKU//GWOKQM1179UW
	gpgbQdpQeSTmCnYTUK7yg17g4qzFpGnn6Q/Hp/UgEYNkb6T2Du6woWrKxEnfOSLW
	G7zyfNRFgu+WXetuKpXZnSvNbdza3+JXwuJr2JAOi806Z32cKEwUujkUWryipSan
	ftEzhBEyeSVcosL8BFYE/1+dSV35IkYCnXrHIJ4+cw3RBWReni4knJVjOd0Le6VZ
	70wL3g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heuhug1pb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 10:35:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93e58614290so11783785a.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 03:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792578949; x=1793183749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DVoFS5UdeUKhEoUyshqUvMPNFzcB9a4hiumD1nyvvGo=;
        b=QHNJF500GXzcexmKby7RzJq1l1wR8z4kNf1rextZyMGPKmacLPaH/VLrtq89/Fw/Ca
         efJz56j0rDwlyKEa4HU3VvMqhJgX2GsBcr2VYdVeNfz1as0QfHj6FN2u/LBQdQy8S8YB
         tesAsZfF95gx7+Q7PiiYLrgF9rz+ThM862HAfR8SoSY95tsyUxPJeFtE/tl/cdxgb2im
         gMR7MM3Z3metfv1TOfUrURfc2S0JzdmeFHmnl+YHJjV8Aa55Op4AsSOySUsvvxFeCH2g
         XWv/RRPW9nGFVEGkiI4g4I6+V0y2fvwAbVNw+3kZkJ84p3dWrS83xdt230bzRPpSnNfh
         JEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792578949; x=1793183749;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DVoFS5UdeUKhEoUyshqUvMPNFzcB9a4hiumD1nyvvGo=;
        b=z2KRfTeVGAIDvymFG9OfgbAT35SaGhBUK9+/SjVQ7KhGJpIF4qQVvCJrqc/VoOPU2Q
         SRc5/6mZPhoOIzDkJD+jBAo2Y1aEDDmdOrovX5F0xbKr0JLM/YEgFSa/3avY3aDgFUHw
         PQvYb5xtJiXFmCtaASSW2w0dhiLOMG8aIryJsavhiGDAwLx97gNXKxU2YkfkOnCEp7NO
         B4aDEIZdBVZX6BM1lnH7IhV3Bo09VyIs/zMlUC7pHcKujs17/XdFrukeRiBz0SzN2cEw
         fzdR+BI39cwLEkZWdmEyV4uV32b+7kx1+OH0cFEiXHMBiCC8RcDYrgZcf/hwuQnmVoSX
         vs1g==
X-Forwarded-Encrypted: i=1; AKwUvByIF+7/bH6g3/JTfTd5qIYehZ3W7ql719yA+CV0ltflvNRFSoyKQUWKxNywqdnQ3J3r6JGvg+bguA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIccqVokg3Fa/Be0PpyLVReSUjmGZpvzJu3j0kglX3owSKCWHj3
	B2AemNmTC8p3J/oqAr+h02TFtVYN9LnPaZzr+7hbtAE347Pzvs6sl9PTHDxGK+yFTYPlG03YpQ7
	l9RDVH+Gfr8hkIgrRGw1PriilS9ydND/6oqIX5nWuQdf8eMumNkWArqgOQ+KDZpKGDtXneeUocy
	E=
X-Gm-Gg: AYBFou1rORPJh9CxrCWGuhiGlfb5P6O11JF1iDxU43cIII63orqLEWsEpS2ngli5t4a
	svSxHZiMEQSoaMOVscVk0uhe9WajtV1NuqbMSEKIzn/mvrjpC3GtJj9Wj89G8p3zcx5oUWG8POr
	efG+L39wZmuyScflu3P1SPajfFQoMf3wEn6EGtCodpaPDos7hHF4bKSFW4MOv3JsupYcItPXd6f
	zo+sXogWtel7VGn7kcLG9ba0IblSHkoZV2BiTT+cZ8cUgj8gv1E6ySkPD6+DIkU2QUXifyTX4+n
	EaoSLFs9s6ujjCLYDivx6WJ68fPfxYWArlXiKKjfkNydiFUc/QlWVuVXWZPazVYujRYX7i40rN/
	zxhoRddI52NwJd81Ed/gWcA==
X-Received: by 2002:a05:620a:4687:b0:93f:1a1a:2974 with SMTP id af79cd13be357-93f580066d8mr439496885a.6.1792578948922;
        Wed, 21 Oct 2026 03:35:48 -0700 (PDT)
X-Received: by 2002:a05:620a:4687:b0:93f:1a1a:2974 with SMTP id af79cd13be357-93f580066d8mr439491185a.6.1792578948428;
        Wed, 21 Oct 2026 03:35:48 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b40315a59esm695162a12.32.2026.10.21.03.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 03:35:47 -0700 (PDT)
Message-ID: <193e4885-9d0d-4f33-b2b1-650021413bec@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 12:35:43 +0200
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
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: msm8917: Use a shallower cluster
 state to fix unresponsive idle
To: Reza Kurniawan <imkyufie@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Val Packett <val@packett.cool>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20261018-psci-fix-v2-0-35f65b59eb9a@gmail.com>
 <20261018-psci-fix-v2-4-35f65b59eb9a@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261018-psci-fix-v2-4-35f65b59eb9a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=d4JgWhjE c=1 sm=1 tr=0 ts=6ad89585 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=VTptWAqQFsUFMNnqaZMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0MiBTYWx0ZWRfXxivzmj4+fLCh
 enbCdwNrOj/W6o2mIdsf4V1L2ua8ktEMoRUo5HtBsmegV/uOfQP7ZMyH2h4KlHb+P+XX3GPY9hO
 rLCIQxo4jrYHX5Fn7ppQSaT8FuNHEl4=
X-Proofpoint-GUID: ikcsKqA7gXyRtUDwFIFU7dsSoxRP7cUY
X-Proofpoint-ORIG-GUID: ikcsKqA7gXyRtUDwFIFU7dsSoxRP7cUY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0MiBTYWx0ZWRfXxB8oDNIZvqgZ
 T/8HR986u5TWCtSdjQmuJ1gpFX8+o2NJq1K7xifMJOuamUUJuwdX2V6cnTT71UNP76jhHzcEkre
 +R5xOCpnwDrlZ7+sxdMoZefOfGRnkdGyhGQVxbvYSauDWom1REDKyubxiQAPHtIPsYe3jfTLfHx
 /ryPgnNXaSDmejzqfx5dnZJWS75QItMlxsYbzmLz0+fm7cG+8Kjjtln22Y1ruyuEcUn0CDccRnl
 eW7C35Gci0zHv2sSh8qqBqSTbTrKifBFa1GmI84KyEg+ZDvbDnSB1A7aG5HklnJfsWdbbpZPQO5
 3/GUqLk1EloRBlzi0DU1FH0CGOZqEgyHCDFc2rzkooDxxvCPImnnYBxzn7jb2m4QiK3UN1lIH9Z
 p0Rr1V+nF0IK9GI9olJj4tRjIwqGu4TA2dF0E5z0s5JojMt1b6MwxGtWjNK0Ns678I84FeZTk80
 oZW3hx7TU0XU8WQZafA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210042

On 10/18/26 6:29 AM, Reza Kurniawan wrote:
> MSM8917 is a single cluster SoC, so powering down the cluster means
> powering down the whole system. This causes two problems:
> 
> 1. The system becomes unresponsive, even to common interrupts. Waking it
>    requires an interrupt from the MPM (MSM Power Manager) or scheduling
>    the MPM to wake the system later. Linux currently has no way of doing
>    the latter, so the cluster may never resume operation.
> 
> 2. Entering power collapse blanks the screen. When the state is entered
>    and exited repeatedly, this shows up as visible flicker.
> 
> Even if MPM scheduling were implemented, the second problem would remain
> and it wouldn't fix the system being unresponsive at idle.
> 
> Replace the idle state with PSCI mode 4 (dubbed GDHS downstream), which
> is less aggressive and can wake up from conventional interrupt sources.
> 
> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> ---

For the sake of git bisect working, please order this patch before
patch 3.

Or alternatively, we can get rid of this one if the MPM rework
series lands first.

Konrad
