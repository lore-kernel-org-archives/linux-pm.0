Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480290;
	b=ZMQkkwXTH6EDAcvRLVyOIzJEHn0/ovTv8VNAsUrqrGjS1rYKYr3HwPC2/KaFERuIey7R
	 +DbMMbH7y9KlH2trvcbgVSOv00wIzOv1SKRAsjRgATOhsnzIl0RLUA6XKpKnq/tTt42Wv
	 kBehV0RR0dtdcLpCZvEcPQfkD6NlAAcAqCTy+DtoGg0Lnp6Uhd7xWOPKH8MMCMlpLiC/j
	 0xZb/15K4EePd0NaUhCKvGK0XPud+U3V5Yup7BIHt4P1k9Fk6a/l4wUXSaSA/N4WQQ+SA
	 OkrFfAbmisHHFRvRE0l/ltmxunuru8JAPUav9fvSXALzBSizetZyUc2ruOSTWI/0pqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480290;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wTX1XPUrH8Y+FoYjz13zUU9//OlPh4ZooYpUqnx0wTA=;
	b=4N0rqJaxutHvEp9C3J/MNcMYQMWCY9hiiXohwhudriogLfki/4EPH/aQWwmkq/ntc44I
	 Q9zYi+ljGdQ+OqLTyyAZtQ9lpvKcNsQt1n6wjxjyPnXlWGe68jNFKq/DLrq4P26Jd0AaN
	 QbY7lIC/i00pGcmV2i6Qkh+99Ob/he4yPU5cOSGyFJhQtEGUbH68rdlwb21LiKBE8udux
	 7/VO3b8JJq4hZnsfB8THKRFED2wToRd0/32zGOiO/bFAmHHx6hCqywJmDwtddfLnHPgAC
	 h+eIMM/MahyGI0/aQbk6yY4zy/ISOxXyRfaZ0pw/Zbbq1D7CmJv0H2v737uUusxm45A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fLerq1Xf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=evDz+Z51;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9677606A32A
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 07:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9677606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fLerq1Xf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=evDz+Z51
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K0t3gO3485517
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 07:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wTX1XPUrH8Y+FoYjz13zUU9//OlPh4ZooYpUqnx0wTA=; b=fLerq1XfWL0LqVaw
	Ktqz+9wIp9AdPxGf5kZdqOdJj6h4ARs0mg51SqZhjHHJbom0WLOIMreSGHtGmb9x
	bno2pBWyH+3b+DKnUPt3pEfX2d6kN242wgNvc2h+Cw9CPPUJHfZx2vOvxloqkJgd
	YAcsOxVknSZ10CRZwdcWCA79VO6+oIz/QeX+yxfZliso3Cu3GqyvXoGgszgLeIEI
	g12cPBYCp6T7yhfZyUKYld/yS57OHooBztGXO53qMWlkuKWUg4lc4UN4PhDisVly
	EL56zvL6g8TQQWKmDhNHwQ3z4hgX7er0sKXTUN0X8uAIpsIhmWIvb0Cvw9lMSimb
	9FfV6w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n1ad5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 07:11:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cc50fb0d2so71960185a.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 00:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792480287; x=1793085087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wTX1XPUrH8Y+FoYjz13zUU9//OlPh4ZooYpUqnx0wTA=;
        b=evDz+Z51PVZQCgJ6QR0OfOlawoPCURORf4Re5W3IAIYXIrgtdWkOe1qgbZF/8Vhe5H
         2PqPwF25Avx4/ZPmOU/yqMuFvJH4+PTa6+cuoSvQE6AOLp/7Sy9l2IkN53LfO9T9JHlh
         gqWHwxVQ1ImHLijlNVBhmPmdlt0UjGakZN4GNp5XeoKvPZkSlxz4iYDZYNT13Pwxzv1J
         7i2455Dx0xG/dVkh97ZVizQezpqDo4oZmEHhajkyyjg+b7vEA2KosnebjR6/IIEeJTNA
         IfycqoPNlx5zwFcszKDg/EvdhTLWm8GYnajF+SI9pKHqzO/vTyGfHdo8+Z8uXKYAdd2K
         9ySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792480287; x=1793085087;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wTX1XPUrH8Y+FoYjz13zUU9//OlPh4ZooYpUqnx0wTA=;
        b=KGNav9Ril5r/sNqrz4Gbb112Ylf5qiHSZPnSVojjEW5cDIrw43Hsayr+bEBjHmvXun
         iTv8BFGslixVCaMUks1G6shPdtkp6Aegy/MTrctYXuG8SL6QetW8XgS7xoRf1NWBo1A3
         mwZh8rnEH7cIksy2eQPcNb5PKB/tkseuW1DMvS10/D8BwFZy8xlmSHDScDpUt+jGjeP1
         /1DnvDuLmW/4L5tG6VpsFlsDQutRLP1/9mM+ql6+kI2T9NY1cmZJ5+AnsrKfllEEMu+K
         2QbAW0grKOWrAsxn8IzYfwdYeQOzheQ8jhuRktJl10od2liLa5T+cF1/y+sZUSv3CGKo
         NRZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxY2l5BIc5q969bwK2FaYhT74NKGmxlvml8/C8JV7L5j6JbmequRtNQdiy9e3B7tWId6tZGySi7fA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIUtq0Y8stmYGhAgqWJJNIey4NlJtu9xjzRFlqUw4qOhSVdn/le
	pESr76cBpWm5AIRu8PvYPBr/9pxy5HiRYHFSXYmvdw3NkkS09ptaEtbyzY1QORooFk8EMqA6+Yk
	uXq7578DLoIfF4dR6rBQ+UmK5dwGW9K5p8wL208HAV0IEsqtazVn1qFDtOygLdQ==
X-Gm-Gg: AYBFou3kl2Hf8zoqcaQ7nkpeDGpfp1MRUPZiX13FCsNaJedNs2BwjNDjc00fgFHakTc
	UrKJtIpVZkBz/BKK7Y47fbvov3N9TzYfa7sisxVlW7bAbpzDTO69eI6Jiv66rB5hWwoVXy5oUFo
	RsaC0Nq/hw/p/MzRTxsnIKxqbTye5k83ei9gyMAtdQE9KrkaDgAzqtQnC2wJtMr5YGAUlZSXT2g
	hH8wW1Y0/YA766x8Ryp6NWQ2CJQnwU17ktPbv2RtCEj6BV08nZXGN1NaFwIZCG9CNSC0AETqFKt
	pgGG8IZF05dGyJCAu2fnj1ZlmJk+93OshvWG6bKujVTt/RVi98y3VPQCSiF0nw/hHfPezMjWKNd
	R70HxJIdpY+PYS1ZK9lhRWw==
X-Received: by 2002:a05:620a:c4f:b0:939:c7d1:7471 with SMTP id af79cd13be357-93f29cf1ca8mr1876234185a.4.1792480286781;
        Tue, 20 Oct 2026 00:11:26 -0700 (PDT)
X-Received: by 2002:a05:620a:c4f:b0:939:c7d1:7471 with SMTP id af79cd13be357-93f29cf1ca8mr1876231685a.4.1792480286369;
        Tue, 20 Oct 2026 00:11:26 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091fade41sm448370066b.82.2026.10.20.00.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 00:11:25 -0700 (PDT)
Message-ID: <c694383b-7a22-4cfd-81e9-0a06ded60393@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 09:11:22 +0200
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
Subject: Re: [PATCH 7/8] arm64: dts: qcom: msm8998: add interconnect provider
 nodes
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andy Gross <agross@codeaurora.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261019-msm8998-icc-v1-0-c2da3934b6c8@oss.qualcomm.com>
 <20261019-msm8998-icc-v1-7-c2da3934b6c8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261019-msm8998-icc-v1-7-c2da3934b6c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aIplOr9m c=1 sm=1 tr=0 ts=6ad7141f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=QbpiU1Sgz_2JnChUH38A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAyOCBTYWx0ZWRfX7De7181OofHr
 s2PgKrFfSvWCtmLe4iqC2zbMjcRycJ6NEZEZCI9gnyPYhqZPwmF6ePcfIQ7m19qrWIcyHiNnSMS
 KF19LUrjfD3tKHcixjSofe2EZ0hdnXU=
X-Proofpoint-GUID: NcRu5yYLUL2JdwLT74xcyVOOirK9aOZk
X-Proofpoint-ORIG-GUID: NcRu5yYLUL2JdwLT74xcyVOOirK9aOZk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAyOCBTYWx0ZWRfX8aGeIAS4ks1e
 TvSZAICc6x/5jJ45rKhuyveU56Wj9GMLuq6Z3L+1LZ3t5dOexjvuH2O9NplhgY12JQPlahV7KKv
 5sopy6PAqhOwS4fnDtL+PiUUNadjbo5ndw69iNJen4k/NSEP4rtOWISNwfrkrwpTt9vHqCkmgKu
 Hhi7FvzmyiltF1EhV4AVoF2Wk8atIfasId/yfptXOvtIHUnBuaCcbg4Q8RWjNqeeoHQ8y0dQSOZ
 uwStQROLySsyQgXnJvl37jMguEMBmgfSMePfXSipbIgBC2jPxdwG94wGO3U6dBrKRTsuYmUSWUf
 9egoXyWfBF1fdMOKYZfXRN083xBHI4KUJpn8bvfMFoams27vdX4RpUXIn50sWFbNHKtOKuOFjfi
 ddn1MtmOsINg7Y4rRISlBTpCyw2jcMr1mS8eYd0qCN9i/ZFQLsj2sWIyRRbWPxGY4NIRQnQ7+UR
 8mA2U0j9lcYYrAmV2Lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200028

On 10/19/26 4:12 PM, Dmitry Baryshkov wrote:
> MSM8998 has an interconnect provider driver, but the SoC device tree
> describes none of the NoC devices it binds to, so no bus bandwidth or
> NoC clock scaling is possible and every consumer that wants to vote is
> left without a provider.
> 
> Add the eight NoC nodes.  The AHB MMSS NoC shares its register space
> with the MMSS NoC and is described as its child.  The A1NoC and A2NoC
> register ranges are shrunk compared to the downstream ones, which
> overlap the SMMU and the MMSS NoC respectively.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
