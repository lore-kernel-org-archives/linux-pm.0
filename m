Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54D94DB540
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647230; cv=none; b=Vji2ywNjBAGrkH7Z066v8s1PEAsHGMtZjRtJ3uUGSATGBQ7mfLGULEUouffsScjMPlYmkuq1toU4RgVFKz3JbManj5YzM/GW3UJITU1dOoRK6SrpNQ5VV5U7sYIfwxt6/iecCKryPm1ZcLuDX37bDfF3f9TxuiCdb7nDAq9H2fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647230; c=relaxed/simple;
	bh=486eVCkya9TWrogIHfCjEeC54OcY3YQKNUDGprYOjMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oiBnpvuxCTA8holeau6F2lqbwcsrHIm2Iu9eiZCG8tbN3s01PMDWczrhh1ILkgfOMOkgIBHmrBVv5fBVBvMKjePOCYxqB02AuRZ7N9ODKI/X+TkLHnk+g9HtxS84Cfw7yk5ieB5WRT/jNkoy6NHcVFJ/LPNBv4PnTiVLxZ56sZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ceBLTJ1K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EIjNvwLG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ceBLTJ1K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EIjNvwLG"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDfrkl2962587
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 15:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/OjcXqA5sfqMXr7N8m76tGZNflaC5D0xHgA4fme6+cs=; b=ceBLTJ1KTFdfdFCa
	cxobjgJr4SX1wnsQp58USMvuKXkOj9feIR7AFTHB/qZpe5UQ3BxQhYsBlP9QVcji
	SMTHnweFhyeq21EkmW8Th8ybRTJKsyAo84z1wHJPjVyN+vMjpCPx2ZyHtF9VMjbo
	/znXMW1T88XElerBLvtrqVtldX2FlXMBTIf8OJHlss7ultf55YAciSaeTfnSowI4
	bPrzMIoMgM/XchvZpQyi00Pilp5KEuHdn4nFUj/X8z7PtW8HPZSUMIroBTVld0Mo
	7WXVi00Ix8mvNTI50XEFvfpxOmisxGXho9VcMHNzyrIpMU0KxP2zWjQ0apheBdI2
	sWQygw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6nssgu6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 15:20:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c27616421so31677001cf.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784647227; x=1785252027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/OjcXqA5sfqMXr7N8m76tGZNflaC5D0xHgA4fme6+cs=;
        b=EIjNvwLGqXsUjth2O9y4xDN0DbpIwJBTVb6Jfnc7IQ0yO/010d6T5I7RFq1rqNkSys
         RJYgytMC2VQRxT1NwMs1F7G+HfmyGc3VRK9rRo0oh/wNxBE9W2zX9kDKxmAl/NyxSUvS
         NRzNtkVSyf8RPDr5yVVkyvekPVh8DvdE2oos3RokSkVbaoix/HBoN6irx1jaroei5f4g
         o/mvZGGAasBTK0la2CD/3jlmpBEZ0yw0iS5VcqcuMXtRKjvxuSlQq1wziI4Na2VzFia+
         Tm5s62oniDD9/udAKN/QVUiX//BzR99AsO39szOEsbitiJo+KpuDzCeg+TnbSC85SECE
         gXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784647227; x=1785252027;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/OjcXqA5sfqMXr7N8m76tGZNflaC5D0xHgA4fme6+cs=;
        b=U5PxameafUg1A4N91r/jIx5bgv2MEZQj8RNuK10Fbf/OxFVz8O/okKWCY9wr1KA+vw
         M1XYvhpL+Ixc2lCo3OY0Spy9LDavMgEsAX0xAnpc6P0AobbSNiqABuVzrBeISIJE2CU2
         /rcweMpzPju6m1eUlLg6PeqcxXOTLKDIVLfDkGuw15dhEegmhvXC+Twx1+LDDWYXX3bO
         9MDejVU+vk8YxlJ6LxHGjukaBoyWRCiu9DENmgdSSgc1zlffS1IHeQshCCTBdc5eErtd
         M69oCcFbgRTIM2ye7xrXwQSoI/2pVWxlF0pD/1XiZtSmrWtSY+SvgrZe2v0NQIY4Df4+
         rhiA==
X-Forwarded-Encrypted: i=1; AHgh+Rqi8Ip1E+L5QcFVW3L+fq/RreUias499Cm2yCLH27rrrhdUZIHhCKbNVKJZvL4+0Yv2RPdX+fJ43A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZjLmmHWhkuffZcCYQT784j2oP/6F6xB22xU1sI6q8oZRXgvyg
	NVuX85swJ5FU0ICXTDt3GepMSylhH2rabB0pv/zxrMeNSKvDCXvJRSFZrBCBnn20pnxfAgzAtir
	YzP+c4Vt3qJDZ/5o67E+OP9JvV3PjJsUM3anOoH3BYZrDdGIZ0y7kXT+/Lac3RQ==
X-Gm-Gg: AfdE7ckmGzvFxumfAicBEJf5/5uF4LHdTqQqqdqdF4309/+w11dsS39Y7UtniiL5DMW
	+JQHfZ2y+KTStUPvNl8zS3MwasgKUoayJueLmCLL0K+9kR51adh4g5UMQ3q3tNq8KQOqatMEAXd
	2+ir2DQ9v4xUvt9jF1vexsE/HQGwXfuEacMgITHWaJlD8ylJC742bevo2EkdXlclnqGvNO7q7lZ
	bKBuovBdhNSGj1INz4qmH5YtOrxf//zWThBvfeYEjcHQdxr2n6Db5848W8Ba++w7AMp33pVonp9
	b8iydBzzf6SeNpSsUDT8FtKMkw+R3o4vcX7VvvgJ48NC8EMvUl1rFXQaQH2eIKYrwpOulAH04NU
	YfWvwvnKBTfQ7Mgvfhiw4OBru
X-Received: by 2002:ac8:5f47:0:b0:51b:e991:92bd with SMTP id d75a77b69052e-52674e0c561mr29261061cf.7.1784647226955;
        Tue, 21 Jul 2026 08:20:26 -0700 (PDT)
X-Received: by 2002:ac8:5f47:0:b0:51b:e991:92bd with SMTP id d75a77b69052e-52674e0c561mr29260731cf.7.1784647226547;
        Tue, 21 Jul 2026 08:20:26 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c17009ae04bsm605787466b.8.2026.07.21.08.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 08:20:25 -0700 (PDT)
Message-ID: <925e848c-7265-4beb-8d51-de542d682a0d@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 17:20:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ARM/arm64: defconfig: Drop redundant Qualcomm
 interconnect entries
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260720-interconnect-qcom-clean-arm64-v3-0-942e8ee7ebda@oss.qualcomm.com>
 <20260720-interconnect-qcom-clean-arm64-v3-3-942e8ee7ebda@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260720-interconnect-qcom-clean-arm64-v3-3-942e8ee7ebda@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yxTTT17pyvqjhyqxUMGpcC-S4h718Xko
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2MiBTYWx0ZWRfX+DeoO8G5bgle
 vSGMAFHI7oC3Y8rOfLKpCKLe34ZYdnGvtnec7c5GUyhe1rSWokX35x7FOeI/t8u+hNbzjD1y8LE
 Ckfy/Caz60ovdP5osHYgeO0dSCunE6U=
X-Authority-Analysis: v=2.4 cv=ZJjnX37b c=1 sm=1 tr=0 ts=6a5f8e3b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Q_J6LHpempm3BuxY28QA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: yxTTT17pyvqjhyqxUMGpcC-S4h718Xko
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2MiBTYWx0ZWRfX7Izg4SUSnKTG
 JOIpnTlDsGlrLU8XaxoDzgRidxe31nc+C1h0L/d4B7OdcM4KlHLmECE4iFrgzLVrMCeImjne/Dq
 YFMQDInumjqBQYh+e9ip6fmLk+zFx9NfUD2rPn/fEfrCGZlprcLgw+jewYYQ5tiwXwDIpMmx8bu
 zDtbru75qTolcVxPnXrDGueggkaxXbOnTwqohcD1sgMd3kT+kdexIjmb+k+nvJR397ZJWvZXjrA
 2r3TdXUZxZRbCAwsDwDCtF08GEKPsdQ5ZDAVb2U0+iXIEOn/obKavF+g2dDTq2ckZAG5s2qJM8w
 NF7v+7vClZ/oNBOpjhMcEmIAbTJuA3QgsZUaPV7qbAaP8DJIFmEobg4sI7FRgPh2BpbXdb9K5Ie
 e69nQyCOoPaTHVZfRFDMuchfK7WSL53y2YKndldvvGXAE/YyDPHh+9PMj+PB51MBokjySqOtvEQ
 pY6XF/Xb3RIuYse71sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210162

On 7/20/26 9:03 PM, Krzysztof Kozlowski wrote:
> Drop all drivers from defconfig which have defaults in Kconfig.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
