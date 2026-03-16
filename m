Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E13CE495
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691082; cv=none; b=V4CrUcKMs7RL7okGb83n3VEABYxohxqT8/+qDcPy9UHYOOCKE8DN042LqRHsE9Zm0DuU6m41T+v6C1g5LRvhcQDbqJ9Psp8DVUIcuJcZBo6ayZV093Ey8L1/s50u4ARqG0/0/A6CzCLbH9mxoofaeBrCT+/3kNr2Ylfak09WK00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691082; c=relaxed/simple;
	bh=A6js31Z1d6nsCbfs7ycR0dcTVA/JnXJPq1+0VSqpYUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmmJEU/FLiD8gCICcTz4neSAsr7L4hgUD8h8yy0Z5KPKb+2qgnwi394mE4KUsKWEo1ftWNQ7NHwlt5iiQovNi3MK8+bq+NeFdzbyFkcE+v62jp1EKUUP7qQv0dPL4kifOk4aMyeE1B3m9AGxhfyq9BPlh8MZdfak23WAovTfeX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Osz8bkEc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BIUpMS5P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Osz8bkEc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BIUpMS5P"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GGN84D3102502
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 19:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZcF89JA/zHwug4b4HxZGA6W10El1ATEw9RV+7MLjotg=; b=Osz8bkEcXtVFUMzs
	oiXQKBV6vRZ0Ly1HTEMmW5JOI5AXrvnRqlMH3s1yKQD6Sq5QYO5tXfNCvicdjRae
	qImMa+NIhp4msbZ70jUI6yRR9GnIyeAWg0MInQv5VbY4I6Cc8gaPPZTkA2MqHWld
	XE9ae+jicPN7cj49UoO7t58bV2W/Z9uR5hhbMogYDXX6qHDW7msNKsmGFs+bkN1J
	7n2+7O01Iin/L1uB7XetbIhc0Ww2dn6s9b/K1tYjf753jaku9pgconKs5H9BCczg
	xeRA3Zz7oUonpz5lfDt4pu/PCrPjG7PqYPeTAfJ6LoSDmvHqgmYoLyBCPeHd+2IB
	L4DShA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxnb78s11-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 19:58:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd7ea0bb20so2912465485a.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 12:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773691080; x=1774295880; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZcF89JA/zHwug4b4HxZGA6W10El1ATEw9RV+7MLjotg=;
        b=BIUpMS5P8c0VqPazEtLpLut6hV59BbmpyR+ZL8NxqKKF0ITKHpokzrZL3nVG8DXlNH
         3o0FPZHZk62JhN7tbrJBZdzAMavmp+MaPOeK12JMTKYszgpAANgSmRblmrM6+N87e4wO
         xti3vva1Ld06YElvaZe7YpEGNBbr2Q2vWisLYjSRGllIleBKBnmC+UMEk6g8ZKPHgcVm
         y66HZY9+phNaBQOgn69T+s9ZkrlT1+9GE6iNK/F+1x98GU8LYEYjNa5uQV67RaIoHsL3
         NE4/XaZY+LjK5IfOdHp6qPBDDLy6bpjBhuJ2LPFa+ZM+mJpIJT1d0y+dN4sWDtxDTPam
         rY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773691080; x=1774295880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcF89JA/zHwug4b4HxZGA6W10El1ATEw9RV+7MLjotg=;
        b=iiRFNGI4vGi+PTETsuLkTHfkYZslMbgpIgL/NzpOFtHzGSgOfTRT+NPdtpPxDz/3pF
         iT+0rvDoJ0XA2fz4/aWqyAGmdH7xtmIaqxdy4fruzDaJHS30tN36ZBlsxxVPW1BINuQc
         624nAJJnHFXfIO96gXocWDNT8mQiTiJKV4xu7Qz1nVl/xfefAg2cP53LNUVEsvgHd+0A
         W2cZT6UTHCfPQAWE4szjXIqZuSKOdXKSHaOgZerGlm5YghTbkDI7EI7aur3B1DFMfWrC
         MIinAYKeiSMxhhff5q21+eWqS83+aLycPPxceAYUjKIDU/jgdTElmCK+Ig+R3botqv40
         DSIg==
X-Forwarded-Encrypted: i=1; AJvYcCUoKS58zgqN4rsYpkJUkiTGJNiOgpalDks4HYatFNYKSTX0CQyjiRGMCFKjN1k5VhzeHlIVQs87bQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YydurDyTsEzpjqM4dCl+PlzsH0MuxB2id82GhLOTInipItovme5
	2b7eDSgpqLcvRWEsklb5+LZ0ZdVhFYNaFoXVkvBxawLN0Ubp4XfHrMcHdRN+6364KH9jIPgwAJk
	eNqcheq2IMuzrGNhSRFdsUHBoXVEYsSlEyw2uJGh1u1EAoIRjEerihlCEtqBnQRSqQNl7Mw==
X-Gm-Gg: ATEYQzxOTDyhYfmVxldp8Tkby0kEF0kyNtdsg/5v43cAOualH9l4CwQMulKIeFkb+t3
	FhKAa0acwXMvvik9GQNtftJsQ+CDLN9OSGbFQYmUhfd+86yFwBj1j7MWZ4/zG3Dwdg7vpEzJPgI
	l5xHo8TIbje2reaT/Xof34CdX+eYPQcavHo64yHd4SUjYn50uMfCa9Rk3+UTQkPG4r7eeW6KigY
	r1w1bzTbD9+gJYcu0drOGbNM1jCJYjsfL2wSy3i2pGHcNXou4iHAYZ5VpfU5y8UAIfmiSyOKD7t
	GGnPNHeJ4kF3KSGvXWQe8wjzxl0VGExPmBOAJc48y32eG184/JAZ6d7e15AehitqibGx7566Swj
	0FynYr643RFISNwwXSDV0CGyMqxPvC12e1YLMiJ/xOsg=
X-Received: by 2002:a05:620a:414a:b0:8cd:b317:b464 with SMTP id af79cd13be357-8cdb5bafd02mr1865249085a.61.1773691079899;
        Mon, 16 Mar 2026 12:57:59 -0700 (PDT)
X-Received: by 2002:a05:620a:414a:b0:8cd:b317:b464 with SMTP id af79cd13be357-8cdb5bafd02mr1865245785a.61.1773691079423;
        Mon, 16 Mar 2026 12:57:59 -0700 (PDT)
Received: from mai.linaro.org ([2a05:6e02:1041:c10:67fb:53f6:20ba:ff45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4855725572csm206186085e9.2.2026.03.16.12.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 12:57:58 -0700 (PDT)
Date: Mon, 16 Mar 2026 20:57:56 +0100
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        konradybcio@kernel.org, mani@kernel.org, casey.connolly@linaro.org,
        amit.kucheria@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v2 2/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
Message-ID: <abhgxF1RcAJD-cK9@mai.linaro.org>
References: <20260127155722.2797783-3-gaurav.kohli@oss.qualcomm.com>
 <20260128-whispering-caracal-of-respect-a26638@quoll>
 <36706481-2549-4716-8e6d-0e4db42591a2@oss.qualcomm.com>
 <546faeda-d896-403c-a449-5c9b0cd7159e@kernel.org>
 <17474333-bb82-49d7-bc04-45ab21095c38@oss.qualcomm.com>
 <ae4c1f7e-8f4c-4ce0-a6b8-bab29984e693@kernel.org>
 <c6136314-5bdf-466b-b19e-43062fb11150@oss.qualcomm.com>
 <e6679f94-2648-4d35-80cf-d3f823f9dad3@kernel.org>
 <4f815a0f-a815-4b77-a4cf-a4b18e776eab@oss.qualcomm.com>
 <95142608-b5b1-43a4-b8b6-38e658275f30@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95142608-b5b1-43a4-b8b6-38e658275f30@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE2MCBTYWx0ZWRfX6iFNZcHJet6O
 L3WnWUpaB+mXBgkSApqJee8j+VW9TBpMwMnDO85aSd+beyO1QhQJRmle9VhrcWckx6lygBW/dt2
 zIXr3rb7WLO/ZFzws656Qk/gRFSt9ectP6Hld72t3p84o4pmpXG/h+7K9sCilsWRSH7vZ188SyG
 5QCPKUm5NTjjVwdYR/f11w1SdAbX0E3HA/gPOg48c18xs8u+ScPWgSyy+lOdAECJ0AW2L3Ro9b4
 fF+2vxvA9LuJqChyas5ruIce084nvvL22MJj0JOJ+ACcpMKsa4vWI3zm80hcKNSnnzGa+ksuVur
 6ftK3N7gL3V92i5LcyLNRGpwh1NazUWyLNuEbfhTnu6vA5DfZ0qI8TGLXVd8OhdWHfN9bgeTObV
 06UE+MgP+KHsDcPCVmLSHZwJPzkSWOvpMsgQ9z9Yn5hIxw4QAiqr0wZ9oIhP3G/lwLtMMEXDkB8
 Q9bVxu/wgiG4C2scmfg==
X-Authority-Analysis: v=2.4 cv=D7pK6/Rj c=1 sm=1 tr=0 ts=69b860c8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=Otm6cmvd0WkZQvGKRdUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: nplf7gao8qbje3jRr40itre5TL8BZUch
X-Proofpoint-GUID: nplf7gao8qbje3jRr40itre5TL8BZUch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160160

On Tue, Feb 24, 2026 at 01:17:22PM +0100, Krzysztof Kozlowski wrote:
> On 24/02/2026 13:09, Gaurav Kohli wrote:

[ ... ]

> >>> As a result, each core requires its own cooling device, which must be
> >>> linked to its TSENS thermal zone. Because of this, we introduced
> >>> multiple child nodes—one for each cooling device.
> >>
> >> So you have one device with cooling cells=1+2, no?
> >>
> > 
> > This will be a bigger framework change which is not supported, i can see 
> 
> I don't think that changing open source frameworks is "not supported". I
> am pretty sure that changing is not only supported, but actually desired.

Yes, IMO it could make sense. There are the thermal zones with phandle
to a sensor and a sensor id. We can have the same with a phandle to a
cooling device and a cooling device id.

(... or several ids because the thermal sensor can also have multiple
ids ?)

May be an array of names corresponding to the TMD names at the 'id'
position ?

