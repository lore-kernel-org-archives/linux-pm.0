Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C983806C4
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941479; cv=none; b=AMfgB/LSrd+No2n7OJswl93bswcmWdyBUFSHHxZDmR9Z0LgqKqyx48Yh7r4B1VqKaDkaVqVWv2SlE8Hg63xj97YeGFVnlhR7+wSGn8suX1lBz7GKFB0twDKlm8K8DIFh49nWSk0MjGtWxacdHj+dZOWfqR3VredxrwiWPejdmt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941479; c=relaxed/simple;
	bh=cIvHu94OlK/VxJqhDMuNfUW0Ajkc5iyIvjAm7xvvlPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHoIbj8sWacGo4tEoHnuIZXPjFYtv6rMnUN6cTYjc2qjC+YFLTjIJuOcrBWEKxN4661EJaJy6uzVa0VimSE85nSzfT7Y9enftB4IXf7B+UscSXWGEs9b7/NHvb/mxf2elDTfiMyJCpxB8gysxp2vKLt7+gBnKsUSlaAHhr2zOlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GjM+Kzcc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B9CfQrJf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GjM+Kzcc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B9CfQrJf"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N94inx2319344
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 10:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w83ZZ3NDs84zER8XEdkG1ZCAzD0K73Rh1Eh1mwK1mlw=; b=GjM+Kzcc+f0QPt/M
	2zjgkr1R7mcPqniR3cY+PVff8FpphOstoJtdSgV9GjvrJ1XndZg1sCdzlUYWdJ/7
	EJmRE3eZmjuCEaAPEIFMbQxD6IdAGxikRAArYEd6BVPLJIC+olOq4XHDnxmiBmAT
	LMKSBlYp1JTYPEejRl/Q+XZbUUN3F+lQPp0Ix7C0oSZTTVQi/p5TtuarQdQtT/sP
	SgQgh/iyZ+80awSw7F7p3kJngWZuJlLQoTAUdB4pci1V59aPmcbOWXDtz9Qm8ND0
	5oV24vVtPq7KL1pjGXTb6mTi5QaEmWUWrgfT83dHX02uvA121SmNDo9+vmDxEMHX
	LKdmFA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqgfsrd3a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 10:51:17 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5073ed1ec6fso19384641cf.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 03:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776941476; x=1777546276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w83ZZ3NDs84zER8XEdkG1ZCAzD0K73Rh1Eh1mwK1mlw=;
        b=B9CfQrJfcy39F8nxIOp3LueP4vBWeXJfn/HePRLrvEaOXr8r2WIqTBskfmjjKbOiqV
         h3Byy10jXVR10I4RFnuVqyAKFJ5n/XLiJ/2h3l80Bn9L18MSHTxGxlz2sDTRIwHjs+n9
         keRSk0dnPgmAuasvKwGzcOotjTbJD9RmI/i4gKVnXTMjyILa/JFTIDCKOhiI8Ek2XKyt
         DYIs0ZCk/HVaxAwBT5cMAcPFaOmRfCC7gUG0FSEkqQyHpv4egAtzCeBxT4M6hzgGanLV
         ZEtnoZPLFfrxXX95oCLZkZ0PfaJhVop1ApbJjWdsRVEGYN1TiHIzQdvOMEdghxi65O2n
         OSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776941476; x=1777546276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w83ZZ3NDs84zER8XEdkG1ZCAzD0K73Rh1Eh1mwK1mlw=;
        b=YaqOlQf7m2YFWKyisurjDLxG/mrd9eGjg86iHgHR+oiUyGduj7bGqk98QwgYr1nrT4
         aROEC3tfcm8gKj7AwAWzepJJYsInmlxdfWr6pr1EXkHz1eSM0wCyWKhzq5TRPxEDeS9Z
         s3rbarT5nCGalSwRx0MVFqSXu4JncWbnK3dxpb6r0N/wGtqBnLot1PCBWrzgqTez5VZK
         FDCx5/4scVYurJSMSlgoclf6wm1/TlwxJFo6/LyKBA28SiNihYuDgLUKVY2T8+VkWiEC
         r4bYLkAIHFY5Ch/1mzS3nTMAlYeL5JdPx8hUWYWsIAGkKunnUxZkBrOtVpcGaM0oCXT2
         vkfQ==
X-Forwarded-Encrypted: i=1; AFNElJ9aZuMzKzoMVlLrp2fgqIpSgFjFqGnM+o/dmrJU+mCHAEYaurqKoVt0it16CncRBpHi7WAXA/9qJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjrq0TmaJHB4G4zbMPczCWYDdT0xq8zXAecJUD0W+aWZsel/db
	S8tqBXAL/MU3RtLH0Z9zMj1aCj7MSJVwf3o59xL/itifCUTPM/E96k7naIgJqQx4Ic/P25m9nb2
	K4lI41HiR+fpJ3tJgaHUoUt/HitamIkRviSWVj2aOnNI301LMS8Ih1iAqKRevHA==
X-Gm-Gg: AeBDieusZNyq7ITYamxMfETMDs+Qv2RYzDXkQ1h0+YuEGguKvbqc1xXShlwIx0hRvuV
	xlB5N08v83tnpL/ENhhkenhABl54rjoX7JfEdbNpMcW2TsaFM/NwSe7SnXEnVdAF5W5nZ7Hm4N0
	eV6Sv6sm8OxIGR5IKbIcgYWAxK/4WK/mLv6JmHIEQV5EEPpZCxXa9fOEZG/LP/XVpnyibMameuq
	7PZkGmOHhXpk8rVBURn+VC4zg2yjy39daRlJXkeX3b9FoHB4vl3xMYpCOIcEew/9Jb160Hjxtf1
	4CuZsYzzb2UTOoXm/pe3/aUbV/7eLhNzdgCNiMSD5Lc8V6uVsifrjdfCrfGYrY3gE8alHwKl12H
	ULrkPOqSTvx/oJDE7sKwdoTOr9ykTaetXb0kXVku19MFJ0ANOZJhjLizyZB2crRudRsV5Wd/U3h
	AX7GsZ7+uZ53Bpvw==
X-Received: by 2002:a05:622a:a06:b0:50e:5cc3:6f59 with SMTP id d75a77b69052e-50fad4a0f81mr146970351cf.5.1776941476352;
        Thu, 23 Apr 2026 03:51:16 -0700 (PDT)
X-Received: by 2002:a05:622a:a06:b0:50e:5cc3:6f59 with SMTP id d75a77b69052e-50fad4a0f81mr146970031cf.5.1776941475940;
        Thu, 23 Apr 2026 03:51:15 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba53297b1acsm573805066b.53.2026.04.23.03.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 03:51:15 -0700 (PDT)
Message-ID: <be874611-4318-405a-886c-4a7e434b3d67@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 12:51:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: x1e80100: Add clocks for QoS
 configuration
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260422-x1e80100_qos-v1-0-bcc2afe4cc78@oss.qualcomm.com>
 <20260422-x1e80100_qos-v1-3-bcc2afe4cc78@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260422-x1e80100_qos-v1-3-bcc2afe4cc78@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nZhuNThQEckctFlhoo4ehlH4mtskBUFc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEwNSBTYWx0ZWRfX8IwgR+q+8rKa
 AjuqlEoFhWyGqmTO/aq9eXh8ThHSHnOmY4q+yoLLnzpxWb0gceAnF/x77vrMJgIVn/S/R/02iN2
 LuF0hgGtk3GIqKnaeacsIUh4c0EEEDE3GOjf3E0SukozEsRzMmsLGCtUo4vEvuzDxDM24CriKDe
 8qfVVbdC+2ZcALT4+LZkWIxbRjThNCeuukAD/D15LeRVsonh+9gFNMEHZmJucMqV7uRZe9onImH
 bInQsdJA+/6MmzoNJSN4UYyxSXV34ytaySkCCofbR5E8c7m9epov8yGyMGMwUhIzb65tT4JfgQt
 11VIhfqZHIPix2TmPNxz+r5bVi3borMS4Ni3IDCQSSped3LW3ueZAGvQNLECjnZfVZPyH8z06v8
 LU67QADM0pnKFSdHUeem0O0MuewlhDD9GCNKcvkiNLYQ2rpfkFKLFK9QjZ5lZsEkblUzhpI/y+F
 ssjHKUpT0wLerzX2H1g==
X-Authority-Analysis: v=2.4 cv=AvbeGu9P c=1 sm=1 tr=0 ts=69e9f9a5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=tiNWlLPGnZEfyRn2lfcA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: nZhuNThQEckctFlhoo4ehlH4mtskBUFc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230105

On 4/22/26 4:05 AM, Raviteja Laggyshetty wrote:
> Add clocks which need to be enabled for configuring QoS on
> x1e80100 SoC.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

