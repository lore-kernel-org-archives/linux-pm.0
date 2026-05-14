Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80E7385D7A
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755321; cv=none; b=QmnLKT42h4wEWH2dWmqiOiMNW9sbD6skAOMz987kY5fBPvROtZ7Otkp+YvL3feGWyOkVa6D9y0B7QsbCHxViVmnLuUcRDjs307tZ7jqCpi6Z03sB00IXbjzP0IOce59p1dqI2n6n4IXQxNrpYW1+UzUtYhxd+dnuXSTJU562hxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755321; c=relaxed/simple;
	bh=44VD0T0bpMhW57Rqa1pjNU+Tx+b/FPZuIa/q0GXt/no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZuIt7JRUNMCJajM/SZE1Pz6FozyXu9dsjIyKgYEoJaPr4sC96S1XKitHonkRH13bl/gl1B8AVVtTjTwPTLR7tLQ229yHJQotAK2j83bbwC7S/PqCRCPeK0jHb53aJdD3mCllcCCQ9JRL223Mr+3GNyl5T1K2DYUUVNiQgklOko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pzTSOTQv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E8fMiGDT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pzTSOTQv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E8fMiGDT"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E9k75v2796507
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 10:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iPKozL8Bn44pSJ9LJCFbqQRgLLCIqXXmM8frJNhG5ZQ=; b=pzTSOTQvm9eYi6Hh
	Sg4LiOWAdzFxxZPQZIcdOReqHklfHrQa1npxWi6468lTc+ScYA7hQ47SWrxpRfKC
	qOOrGyHf9Ej4UgIHAnXtVEM2sCDuKGKj3QQZmjJw8kDccD5ky1p+9yDernNzha20
	hjM+g8K0NMfKH7BvwmArmOl08pxmHGlNOQwytgj9aIhtUnlxkp0q35ZrxDxsvCZu
	UL7hrQG/ULKd0xkb6e/o9jtG0SBFkv+56KoWERP2iIYWRob/9MZ2TcHvaZhgT+kj
	8h5dIGqACrWEbm2yLuJDhqVEMXNkeUqaSE80W2PWgIhvKQG+hWJM1JSUFdzyBKsy
	goFgPA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5492srvu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 10:41:58 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-633dcda64cdso333412137.3
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 03:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778755318; x=1779360118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iPKozL8Bn44pSJ9LJCFbqQRgLLCIqXXmM8frJNhG5ZQ=;
        b=E8fMiGDT4qGGEeiBxPWmnDQEK38boKudAId8zAR4fQ7zM+rjGru3J+klovGgdraXZ2
         QcRiCuGazEnGOx+4DdiNtpE8L649lKUIZ2idaIPn8gAUdm9boQr0rBSnyT41tH65Vt4G
         g6ZXz7alvSg1p6H7d2rX/ZTcjTAtDPnu/2W4kBInvTkpigofY72lasp1bz7d4F6gHV3a
         OgQ5T1SohxNKZpIjAlePMDwd76G9dljO3LtxzwCtxw4cZBP30Hih3MbcpXylvXjOmG3P
         fLNw35/26/B+KQPBV7S6jmy9LJtqdlod+RSySNCBxCaKeiIp0e0lb571Okkkas3lhHdh
         cOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778755318; x=1779360118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPKozL8Bn44pSJ9LJCFbqQRgLLCIqXXmM8frJNhG5ZQ=;
        b=e2uvGG/p0n58GVfMIE44oT2cq39uo81SahKCXHX0WpDNo9Vww25jRLJwn9Sg1MB0J0
         btBsfdpJtKirWxhr4zPY1fe9+UZiu5gjQ9f+OJC63fSkRXg2abRdbJvm/t1KzzhPQQrj
         U+uKlCsHirKBu0AP1TE65rZ5+xdl05KCU2DH8xCLHNrDOLGOyjE1WKL7HMUB7WGDvoXY
         1YVfxCnwoVgw8texYQ6ryHJqiQEGPd07Bqd/f0nvbq1Z6D37XOgUmweei8gXpKp62Vwy
         6ITv77dy3iA4+X3NfjWfsvmaCtQhHFks+Ld5P/cuG0WmdyD5LRYidHSEUXStSQklzYhI
         izqA==
X-Forwarded-Encrypted: i=1; AFNElJ+D1Ja4ibJ8EpB4PiI0fSf/rAqjwusgb3otNfDadL6C0ZOAdeQXPkjr5RHs2TYDlb6ehhccM5gIoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr7T7+MK8VMiqF/U1eOJBthRk6uiT4sKJ1bN58HQ0mUzVozMsL
	ZdpFO6Sm+ygdbEAxWovZKhO6jE2AjjBBtU72bX7Bx4sNfoxOu/SRXURIXSQwQzwwDTGdPk0c3Uj
	cQHxuSW55BJfBdIB/8EWBNRJBRrlHGLg4mvfYSHC8A8fBJLbIvrp1Rfk0dYM1mg==
X-Gm-Gg: Acq92OGadBehL0hz6bNUj6j/yyHYTfgkDurL1F+xHo+FqJSEqmfHDXvcIJGDfCCMjkk
	PHx2Le4hvgl8oNYuWOoso6r0Y18XAnNbRt1cllbnJl22Iq1tn1qp8YmAc65qisxohoiUKWhyg+r
	yDZ5Myku2vtCXbPfNeCcI5Nh4lDdneXNo+jCAFO1g3W4T6qlUMj2urfhFs+fICo5Uqb/2x30IC0
	WM6FvP+Nj7K6rpRBO9ksK5yhqNts3DctVmzQiEPSLFoaYad+Jp3/Br4IIJTkZI6OSC4C2pnxHNQ
	DiKUUWsj/uQcPQtxlyRScHRw4JaExOMziFPVaudMrO79ALaVG+wAzO8kxqsB5n3N5bOFRCFv6ak
	h48SepuWpcoPOIimKGXHgTnat6mqIDGTt8+/1T7AZduYD32004UGqNCnamdvHpTJD2KNlW/xgnA
	KPwijlwgTRNsjMlQ==
X-Received: by 2002:a05:6102:2924:b0:60f:77ad:4bed with SMTP id ada2fe7eead31-637757febb2mr1344340137.7.1778755318340;
        Thu, 14 May 2026 03:41:58 -0700 (PDT)
X-Received: by 2002:a05:6102:2924:b0:60f:77ad:4bed with SMTP id ada2fe7eead31-637757febb2mr1344328137.7.1778755317984;
        Thu, 14 May 2026 03:41:57 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c3150dsm74825266b.24.2026.05.14.03.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 03:41:57 -0700 (PDT)
Message-ID: <38cf589d-002d-4e36-ab63-8f8366609e0c@oss.qualcomm.com>
Date: Thu, 14 May 2026 12:41:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] clk: qcom: ipq5210: Use icc-clk for enabling NoC
 related clocks
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20260514-icc-ipq5210-v1-0-b5070dfbe460@oss.qualcomm.com>
 <20260514-icc-ipq5210-v1-2-b5070dfbe460@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260514-icc-ipq5210-v1-2-b5070dfbe460@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jZ3NDKtjubqYBZWJVSFyVOUpGcakYmfB
X-Authority-Analysis: v=2.4 cv=R74z39RX c=1 sm=1 tr=0 ts=6a05a6f6 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=8eC56JA1x6P3gbDAbPwA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: jZ3NDKtjubqYBZWJVSFyVOUpGcakYmfB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEwNSBTYWx0ZWRfX8CnXDua5sB/S
 iuZTNWp31gHZxgJb/0F42DPSYBU5OTaSyAi0m7+7q9+D3OLPVbk4RuNZN+jyxh8hder7sZAjmWw
 3PUy1MRdxj8TpaI/u8N+zR3aJgfBOVTY+e3kforev722DjHaTXodRNDRIRRvg0/kRqzvyA0X2t9
 fGegMKa+OoiFw3k6OfTwnHgO5T3/v66TkA0WM3loEyp+2QQ7GHcrdl1xoeDAPEwNnqTzH3ZU3rs
 aXrT5UNbTifNQZp00fJdW7z6MAPmAZRgkFJkHCXFtzl4SrfGrzM+ECI/C9aSL9oHIteftE6iaKj
 W2Q8teD2da+yWCqHZJTmwHfCd+mSCiQWu4bSm7PbLNmKfH5V4HcC3wf3EP66nRepvgefqALCDzE
 5vT5HzKzahNcX8cKGyaXk/luNnqr9JtNakpoeNwiyIz8FJcfFr/6LWh+f7c4m1DE5yEmFmXr1GP
 eU1sDbYYMWVACF91VCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140105

On 5/14/26 6:05 AM, Varadarajan Narayanan wrote:
> Use the icc-clk framework to enable few clocks to be able to
> create paths and use the peripherals connected on those NoCs.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
