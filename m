Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956639;
	b=YX/UWkb+Qae7q7ySCDXrip1ZsmSLQEdvUqQ1H3yT94pYhKxRwMUHjgSG2EFpEvefP3zK
	 VrebiGokcWKr+ElF2JOjq0mt8s9yC10MMgbgSOT9ZqPtGdN9idlSga4qd2YTDq8KfadCN
	 eeV0ywV6OoWwB+oRnD+o9S/2p5pmA2gs1LQGB7TAP9Eo7oOopt2PwfT5Kf7vjxf9aQQoO
	 yy8tdHw+LDy4xVoi06565GPWuTCOaAgVX6nBbYG9aTDN53YnddohDy/R857t/muNIdfsg
	 EiByfLMbqd+lj3X/yRBMgQOfGvZVHmYI/g/MVKtmkzOEBdYrR+R1ZKh/SIBIKhxMt5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956639;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QV5hhgwDtQTt5SAYfrerd7IkI7JI7kVQtItIdeKT6D4=;
	b=M5D9trqvBz8ubQ5TDU7FGMhcpbwQkPjgAfCYGzQC7M5F1ylXpMjgj8lNLWrrvTL1cne4
	 r+MHEzAH5+ZTs/cgwnxQONgxIcggowqiJ3Obkvzdz10eSHsfn7O3DJRKQgcEi/X0u+077
	 D80Fe0OL7B1YLwlfyWFsTerofuVl+2YEvMgCaOQn49HntgXB+2VZ4ui7oOBJ93PM7GyXm
	 hSeWHaVeIevxxFb2tG9hSz+M96pj7SyT99kPCjydCcyFfa856G22Fylj8qFa13ywKYS4h
	 JH7BqwbjzXuRTqppn6ux/LjQhALZoOItz8lsCLv65ut0Yfd1WGrN2tGGsgxktZcBAfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=edHJqB3a;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=chRZodAF;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B113606A32D
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 09:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B113606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=edHJqB3a;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=chRZodAF
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A67R6Vh129132
	for <linux-pm@vger.kernel.org>; Fri, 6 Nov 2026 09:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QV5hhgwDtQTt5SAYfrerd7Ik
	I7JI7kVQtItIdeKT6D4=; b=edHJqB3aL3fPedwRbjfz/LmF1f33hPVcRqgR6F3v
	cMqwNkwgetZYNJAoQA1H/6E5t7YcJZW+c49T7vw5m+khdhzRTCEn5bXJ9yK7BYLb
	oyiP0rMEtHtJGfEmA0Im5mN+N72Beyp+/2mInQoIahf6x/04P6tPS/jXmyv+UkEC
	m+uMECtgiQJ6Xn3cSivZ/c+Sn1JDIPXDAMe8HeQbyPrbxSg4CyIS95pYZhbsu8q4
	3ZgHze5AOq3O/NE2Zk0x53NbbTEDBYDMpPWPqDDZPNjS1G5XYvg02g5cX76MCA2g
	6O6vXAidFv91H9vwe28bHAkgFVO0gi1uhEnuNZ6Wapj2Og==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9t2wv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 09:17:17 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36d69ab3c2bso638894eec.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 01:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793956637; x=1794561437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QV5hhgwDtQTt5SAYfrerd7IkI7JI7kVQtItIdeKT6D4=;
        b=chRZodAFFY9zXiIlerVNoEEzK4VsdnIIHDuYWD9y2wBS9U0FdimmDwBbZpFtfQLQwE
         z0/KU5mAHptEUDz9MpBa1BQRiVWhRYqeudT5K425SvMAWIH/tYBhZwz+LOkjxjs8Rspg
         nA3O2MrnBznr13jP5ZPbA6WtSNdJA23Nwkqt9FkWmVRnqaJo7+xOrX/W62XarSEegIii
         254KlNd5l6CwkEyqk7YMDW7UxiPOCZgg/4LoUYU+ZBd1/rU3PGqAtsw4JH7MPXpkYO83
         sM7LMjB6wp2OC7Sp370OPM1MYvuMYA05kQPRzQR2cRgxVF1vwJtcfNLWK1ByLMm+l641
         QM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793956637; x=1794561437;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QV5hhgwDtQTt5SAYfrerd7IkI7JI7kVQtItIdeKT6D4=;
        b=U3P98BqvQQJVKGpy+RU+IF406Nyv7cS/azBS1XOB7nR5U/2TDB+bOAva/tDoh/Z1G9
         FTBiptMm0BgG9a4nkeWQZ4excMJA4usMMcMA2uI92jtV42UHt8UyZ48Cfhf1HLvCsV3m
         a9inIG+ILWyO/L8S/sBIIoaqgRIPfOZfWTsbxPDkgR/g8n7K9bylz6M0Okdj1pEyLda0
         XzxoF6SQbvYAIdoIsC/qMvtUCEFnMB6VU4XKp192W8knkRJGxH2SUXxKod5Ln/gVebQe
         OGtbx4ucyJWxR8AOwvXezHduoYlBu/nDAZZS9UOOfso/T8jQkafK9GYGWrzR0R+L8wkA
         Fz3A==
X-Forwarded-Encrypted: i=1; AKwUvBwD3a9IsbabaPNh+TYlpasMI44qk3NlGfi0Kq7SrXCSBIJeLzy5L99OWAIoydkv6mfS02IDJEnBww==@vger.kernel.org
X-Gm-Message-State: APuU4Z90LI5/S2CPxirbF+1B2dVbk0Fa5ZCT1QaOyEZwwurszbfhX5X5
	iwMD0Asoj8OWpqy+7JtwJJRwRY9fTA7SJ9CQHDZcmlCYpZ+JgBi1TOkHDuK9QhqDEMFecfABV3S
	JHa18lIgwVm1AniiKVIWHP4j9vYSeG6LYFBsiQJFGH5FX1xJvmaL+euN5jRhFkvK6/BItZA==
X-Gm-Gg: AYBFou0xPILzGEZEXVmLMvsVwwSNco70cYjmH25eNLD2kehK7qBv+5ipmx+Qu2AGOFW
	552/YuA+jMapVrg5EoRUjURGKcTWygNwFWW/+aRjTSrRQaaHYEjiaJp9jXGrvCR0O/nL/G1dHe/
	uL5gzEQ3YdJEhOg+gkbadqTm3HHRRkyZPmEFX23xtj3j63X3NFqfmdIfWa5PHaVqcv2Stssl9ZX
	S4vSsqAcIfgn7Tobq119UgRRig1rhFGztKyQUes4/6BYs+aWglIRNI4xLY/1gwxkoSHfKvqWvcI
	HUp0JPQSkVW/+mZQ9lCQk9aUXr+NSFtbFchUXvGzP/rNUc8hDL4ARlfX1lItq5U8vUOdb5cLibs
	OGSWLOx2Sj5+oJJ39zUq0FZy6TqAw30ZLELypK8SXn/1f9Ku9vopCjCX0e5WNuvrGZFaap7GYkJ
	L5MftdVvBR+ARDj0VRBgYeASL/fZFcGyH0f7b+1Ps81J2nI8Z5yZHlxMhbZKKDox3bA6wgfPLnG
	HHVuA==
X-Received: by 2002:a05:701b:2041:10b0:184:19ee:1fdd with SMTP id a92af1059eb24-1b25d28c0f3mr2485594c88.5.1793956637136;
        Fri, 06 Nov 2026 01:17:17 -0800 (PST)
X-Received: by 2002:a05:701b:2041:10b0:184:19ee:1fdd with SMTP id a92af1059eb24-1b25d28c0f3mr2485548c88.5.1793956636231;
        Fri, 06 Nov 2026 01:17:16 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e261962sm6603403c88.0.2026.11.06.01.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:17:15 -0800 (PST)
Date: Fri, 6 Nov 2026 14:47:09 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: qcom-cpufreq-nvmem: Simplify
 bindings
Message-ID: <au2bFZv+KW626iEs@hu-varada-blr.qualcomm.com>
References: <20261105194606.772346-2-krzysztof.kozlowski@oss.qualcomm.com>
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
In-Reply-To: <20261105194606.772346-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzNiBTYWx0ZWRfX4/Rvc4pN2quX
 E79OwDkeIPtsUa/LItiosiXE2LWvKCtbETep6NCdFvhxO6UtCawAF5/rAG7U226hmKSaUD+L5RA
 73uKOHWets1gxKEqO2sQ9k76GWEA2u8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzNiBTYWx0ZWRfX5lr1lOgsBEsm
 W3Jh/0GpPgjImxvwuEppTgn8NzMMEgrJkWiQS9LDY6I12HtFAYTGRPeClSx6HqkX/Lkmmqt9vMW
 wK2TPCvSQ/xz+8wCL04UasRqnWsBe17z9IO0VSA+5fVwGfRdI2R4IAfBO2oTonoJgV4o1yxKNhg
 vsbgrV77mWWbhSWFRoy3f6dcnuqVhEG8+S5J8OaHqO6tIg9Pb5owwOTx2yfVts9ivJGPHy3Pfe4
 CpN0Hr22WwXfY6SxkeQMivp8tKNO20s0EjzD1IQeoVDRK9MBa7zNe7Tt8/MTtZrn7PuOp6Exbbo
 C3llwzPW5uMfzUT6i1B31w01/NBT6yyjU4yhQJlXY+z7GRtd440wyB6p+pdif0coYAXIWfsY4Wv
 fSYGyQjKN1altri7UeqGElMk7oNLMhI9nzL3Xszr16Ai4oIZ7Y7IY/cWWV4SyI3lDozWcQZdq0u
 HVViMMjX/6e37sOnYvg==
X-Proofpoint-ORIG-GUID: JAuRAVYmsdzft2OVxzDf0JP53jCEldWt
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6aed9b1d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cSl9Pj24hSJcTmzJFjQA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: JAuRAVYmsdzft2OVxzDf0JP53jCEldWt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060036

On Thu, Nov 05, 2026 at 08:46:07PM +0100, Krzysztof Kozlowski wrote:
> This binding selects a few top-level compatible machines, but since
> commit 389de9c5a677 ("dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr
> bindings optional") only qcom,qcs404 is present in  "if:then:" clause
> which enforces specific OPP properties.
>
> For all other machines, this is a no-op, because there is no schema here
> enforcing a specific compatible for OPP nodes or any of OPP table
> properties: one can switch to standard OPP table (operating-points-v2)
> and this binding will not complain.
>
> OTOH, this binding has complicated "if:then:" blocks so is not easy to
> maintain and causes false positives when regular OPP table is
> encountered in matched machines.
>
> Drop all machines except QCS404 and move the subschema to top-level.
>
> Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Thanks. With this change don't get the [1] error.

-Varada

1 - https://lore.kernel.org/linux-arm-msm/athPyI5nvYG4vmfl@hu-varada-blr.qualcomm.com/

