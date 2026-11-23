Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439188;
	b=m6Nh8NIuu6JP4piUXSaKvAD/fyIZq6GKb1FrXSmdczt5rT6/FD/L8fhXcmSOH9NgCbzV
	 Q80dSP+WVdLHUm/v/e8DkJdhdooQ7gssQ0sgkOkAJdjdiw/xMd0RrCNivfPGM8JHLIjBY
	 fWioP/ezvN7vmYl00h5X2rZo5xeU1WexUN5J1zdHNlO/UgKV1TwUlzuw8/lMhkUx/ZMoo
	 5MEzL9rjXvBVed7j3Kftor8gDG9iDtrPJGn9LsuH+hk1zlUo79CE6uH/FPkE1RLR0qNp2
	 0nWU91dDM6HSAsLXkU/cFcbhOHJWRNofi2k0nR6xXcu4lFvEfqz6gsJ2lWH8xjJa5Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439188;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CYvomfEjy39LuVTvYKKSBWmOSbB1CxQU1hTSsCOWzQI=;
	b=y1YvjdrtzTDPhbm8Lu0uO3ffovsN0pmO6VgE+HsTHixYQFtByPrOR3m1+ltTAzA0SU8a
	 ZLL17FxcIVnnJ1VsodDUQkO5cTCMIKvs8s6GSAAlPZVRH9JNYGOZ5J/cGlXmrRkA2VTaE
	 oNqxVZxM+ap3wu5+/gBMneMlR7ONYoGv2UG9ImngILkic7KJlxTYD05v4oofxfuURiNhn
	 y6hbMutIHSZve21eHXkxljeU3UzS0i3MxpruRa/XqkADbctKG4rHJAAc+Iha0UsyNDbGR
	 VvT4z5oKc10USKUPQzMzBjZZQWH3Y+kO77uQPV9CVvOwFVSAPPRJKh8Gn58y01nA3pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mEIydQaC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I6XzR0nP;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B0E606A32A
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08B0E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mEIydQaC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I6XzR0nP
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCGrWf3888103
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=CYvomfEjy39LuVTvYKKSBWmO
	SbB1CxQU1hTSsCOWzQI=; b=mEIydQaCn0XOeUq26SvZH5rXZXsBnUtA86crINI3
	snB9cfnqZz4RfgGxGYq4Poscsyax+YyNHO5xdFGxn32s6EuXjwXX3Pd4298x9SRe
	ZvYiubIY4v+ozxCjCri5iJXj855ctOQJiNsspG+Z7Ir+U7ZeP6fn3c8oDaE2Zkp0
	rTDLlVzIFjHnEXtrKIj2E7200CXRM75WKB0cUaDl77xGecAysds7yOJfybEdl5P0
	X/p86r1LgtOjOVowX5l+S3VEUnI5FiedS9sKi+ScUyl92/bEsyORYUzzavHjkWL+
	UnhZD+SzRSRiLTP3VOmpXO0wY3svAF6k6U8u3c9283T+Bg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4evshpmp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:06:26 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-384c78aa0dbso4654807eec.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 05:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795439186; x=1796043986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CYvomfEjy39LuVTvYKKSBWmOSbB1CxQU1hTSsCOWzQI=;
        b=I6XzR0nP8Wvn+QBoOYKjqtSj1mbkb1jTdnF+/ukuIz5rCVQxKGSaFN4lJOANWAYR3/
         eRU8qfozUtc6UeY3oNwEni2VOdLz18b0RQX4B9bhBMq0O07qJLZyQIqy9qg1PS8G0HiB
         +fHfXTHlmsRsCixXTeH2D99nRfEVhTop210guW2Z+6plUmJHZ/NwEMXohRa7stUjMThC
         hrYOaa+49s2mQEQR39F+rPlh1bw1/E0rlZBjpQg7c5GXk8GFO6b21/uyIEJLQMQXNQ2I
         Qw+D9w3NbqDN/toztQwhmpaZCJwocY3u9hqRyWG79q/fcnxd/PylfcOKttCpThjCA/5z
         cGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795439186; x=1796043986;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CYvomfEjy39LuVTvYKKSBWmOSbB1CxQU1hTSsCOWzQI=;
        b=GHr4Rd5e8NLOHkNWTFhRPBpkAOXzeXxsS8S3Ak6ByeDBZhgqNGn7W8N9pSbXXigKoS
         5XsUiBB+zoqUD9IfUQiWt9vRLI4U6Moi90wyGM76NeFu1pw9SoZICUowLogisKIF3IX5
         bjLOSDOGTOtccY+ayBv4xvDUw6s+7vJ75Zm0aacwHL/ndohQacCMeQjwOS6HwGLhWXmN
         4u0qhPyEPGtLkR8SMKEBITlLvykj3zhSpSmI29JGeFlYVvW4U8bV3SUc2/rMJSM4vSBY
         qfWT7yhW+j56D4xyeG5/mlDhYi17+9gImf+69H6HLDTQoUTGHfNO7DGgJFMkL6ZccRis
         cQtw==
X-Forwarded-Encrypted: i=1; AL+hErEUpMIWq0Mm85SBZNByhPt47PF8WJTpvfaWrRFQBmBMu+X16x3OPHTbfOOCXxy+Y/xJYA7tDKWowg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8P4QGZOW2cYR3kV99yhcGYFtXzpytYgj1rDgB+uFqtztPGaNRg
	miogkJfV9X78R9F0z+MTXKm3erc2otEOO+/U+BKSdkbLjCPt/HmhXdgsEnIfTgIgneUS91iMuA8
	ENhLb2ae8A+17PMvhxo143XKSbY1IOrK9nfL19/0diY+lJ2Ku4Sq1B12y6Zy1KQ==
X-Gm-Gg: AZFdTZfch54pR0kQLtCJke/VyuaBQOLxmPJfNXuaP7/DExbn1cq17GGpXyq0leitGYU
	mnyKoqD8Fbsa39ffBTIhydw5eKwWxZRmOvF0fduvNduAjTdU4/WuaByoU0qyOm/ufiBBxMWSkkZ
	3RonMj/JTLwXirEAqqSPfFtpAsVdpbiDj8n3i4nB0QJ72+56vqc7Sdk9FO36l5pfVULtE3M/HzF
	yTMa1VKwy61MizaqTKQYUliBvh/hfOLOkJsnsphiFkYBfjgsDfNXNS2Ih152cT112WElADf8SNu
	FE+KfOlc1Ddr4glqWRiMxWKorwFwGloGb7KGv2L2OGgH5UqRxYL6x4YeCVqQFqP/JJQr3TnTSA7
	dycTuijs9GYWI8Qnon5uFXmLP8rtpiLklOgbLm1UBt+Vp3akbjB+lovkbcCQGTxk8EZyY6aXDVx
	MEMTGAAPNsAMZBEig=
X-Received: by 2002:a05:7301:4d18:b0:37d:bd4e:c378 with SMTP id 5a478bee46e88-3857181d8ddmr11688993eec.41.1795439185681;
        Mon, 23 Nov 2026 05:06:25 -0800 (PST)
X-Received: by 2002:a05:7301:4d18:b0:37d:bd4e:c378 with SMTP id 5a478bee46e88-3857181d8ddmr11688972eec.41.1795439185184;
        Mon, 23 Nov 2026 05:06:25 -0800 (PST)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd4efesm37649809eec.12.2026.11.23.05.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:06:24 -0800 (PST)
Date: Mon, 23 Nov 2026 21:06:17 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/2] soc: qcom: socinfo: Drop DT bindings with IDs
Message-ID: <awQ6SS1GVPz-QUYb@QCOM-aGQu4IUr3Y>
References: <20261122-qcom-socinfo-id-dt-bindings-v1-0-eeee0ffa25da@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122-qcom-socinfo-id-dt-bindings-v1-0-eeee0ffa25da@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=AL9GXjHq c=1 sm=1 tr=0 ts=6b043a52 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xlrlT0MJ9oWSHFZ2GFAA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: go4LpmQEsobmqJTltpMBRCrtrO3wgMdO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MiBTYWx0ZWRfX2M7nyiy0qp/q
 ahs0BSrgsfNWCEkQRs68gjJmKcJdLgv+n443F9LgIjGmnxqqQvJ57Jb9bv85BOylsMPrGwecYAk
 4rkAjLJ7mk7QqH1Oo+EIQzI9WpnjRSu5I6OFO+2d3A6QFcWUkb4np+0/viKrnHrS8Y6zDxTAsGu
 PZqMRDEHNNDLSPxrcjFHETZV/cSfd8nL1OcwZGtF+x0GAjaHv0NoFa4lE3iYzEuz1CJOm7oD9cA
 HR3IviM32urpFrKB7StWZUib+49xDFaElsEZxDOpEAu0DhKyBXGMXPMG+HtliGV4PitcWuhyKIh
 cwvuG5BcdzM9haxwSOoTyl0jrNmJN33+2IRNCniU2BKn9N09YGVH1HUw8xWq29eonwypZXqQ1my
 NDozZ3etaHDR7dw3fEH6fF1DYE0ehzb4gLZoPyrcCBRAx1UyfVNRQ1pFpOhRJTde6ZSDPCjJaKx
 1fpGRwXLnOSWTpEPaKQ==
X-Proofpoint-GUID: go4LpmQEsobmqJTltpMBRCrtrO3wgMdO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MiBTYWx0ZWRfX/1OMFbdQo+ZO
 BIiJ8nC0yMvIa/tDSD4eyp8IQbU9TmR/bxt4VfmZ6/SnhHELyRjWPPdXgLS9b+vqmz6lYa+tLNK
 3p0DambaN9zf6oTgiBcq4GUAs+0knsM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230052

On Sun, Nov 22, 2026 at 06:46:19PM +0100, Krzysztof Kozlowski wrote:
> It turns out that people add SoC IDs as Devicetree bindings, thus ABI,
> and then want to change them, for example because whatever
> renaming/marketing happened.  Well, that makes little sense - either
> this is ABI and cannot be changed, or is not an ABI and can be changed.

I like this cleanup. Keeping ABI as necessary as possible makes sense to
me.

Shawn

> 
> https://lore.kernel.org/all/9eda2209-d64a-4a1c-915d-4415ac47df45@kernel.org/
> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (2):
>       soc: qcom: socinfo: Copy new SoC IDs from bindings
>       dt-bindings: qcom: qcom,ids: Remove unneeded ID constants
> 
>  drivers/clk/qcom/apss-ipq6018.c      |  2 +-
>  drivers/cpufreq/qcom-cpufreq-nvmem.c |  1 +
>  include/dt-bindings/arm/qcom,ids.h   | 93 +----------------------------------
>  include/linux/soc/qcom/socinfo.h     | 94 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 97 insertions(+), 93 deletions(-)
> ---
> base-commit: 74ceacafec02465d922ad68dce9498c8f50e5f5d
> change-id: 20261122-qcom-socinfo-id-dt-bindings-e6fe815b4480
> 
> Best regards,
> --  
> Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> 
