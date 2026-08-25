Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4562B3DFC8F
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647355; cv=none; b=IEyXRn6ehKwnUAm6lFkTk/kVj9MG2W62bgfk9v5d93gMHHOI4cRd+XFoCSRHLzAGGSWg7wx24FeVBSIBdDssE8RZZpa/jbh01kO63Yfr9s7g1zchsKIWc188smnXhWDJeu3Us6ZeaIyTE8VmoWgsBFlIg9WEJpt2+soYA85/W1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647355; c=relaxed/simple;
	bh=ayRTa2nQVP7hszy2MsPoyKk+f6EPiComELT6oUW1tjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjbGqC6S/PurtpH7h84/+fmLvMiJoxHRETooXhkLEx7QLTYXKTOSkX80oEc5P83DW+unSd+xlQ5lw2NOTjlr4Ow3iu2Xq0MJHOKKiDdCdHa7+EFs5U4CN3JYe9HpKAi4pmNXAlRLzKljSmkwOhG3ylvz9S9L37OB6MqSy1Uh3FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dPPeeGAQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jbLBr9Fo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dPPeeGAQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jbLBr9Fo"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P8951N878114
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 08:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3lp+DUWM8yXhcm4IeP7nLZRH08qIolnoMgoT1U63h4E=; b=dPPeeGAQ6s2sr0Z8
	JGDhyBC9yVMI3iaPlTbnd3eYCo7OwmQaoJq9QZY1YF8Y1TNF+Nb4ocdc1IVqbKiI
	zFTUQ9aaLn/Tjbw8AVTD1bznvCMpVP/gsWzd1OTpJtGf4bsU+bNvPio19ft39YTD
	zfXhPe4eybxwGDfg3yDXzQ6/K37DZId1wlfoX/d3CEBMHWhrO/GChrzIkFnTnCWC
	UajP7ArieznSTQGrjQZ3NdvNIfyHg0wePvtp1gCs6KcbgMnmCCpuohgGcC48/Tmh
	LZ+Z/ngwr+L04CW2CQqqQKqEs4l25RfCGCf9oxzH6/z2p77Vao5S/vXdD5tf7wXq
	pfkJRg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8rqukfd4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 08:42:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93495488976so82399185a.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 01:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787647350; x=1788252150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3lp+DUWM8yXhcm4IeP7nLZRH08qIolnoMgoT1U63h4E=;
        b=jbLBr9FoqXMufGonR/UhRLnoii64cstNgVK4eLt1ZJWvvT3bve8MTIFf8rP+F81Njl
         GRxydYTq++zGpm/0jTF2aFwpNVaUFPqCTmAv4G3AR0BBRaqum/3w2ou8FYCRC7uWVDoK
         9tDgBJuPJdhZQzIpc724z/42NmNThGXcEhwKuM9gvEPToLyztryGJWDHH+qxECydaDdd
         S/K/STZ1qdusJ/qmHumaBhJ+QuaphbnCVjs51j9IZYeI8nbmOFptt5pKsqHFPimdwH84
         NXRNTdg8ASEv8o3aIrkC0gIV9A1O9HUtJybtLiWFSB0T8+R5m7NBJKHBLI5B3h7LPfaL
         ZM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787647350; x=1788252150;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3lp+DUWM8yXhcm4IeP7nLZRH08qIolnoMgoT1U63h4E=;
        b=lptcGKhR56eDunyUdB7+M0uzAi5twft7nHHhnBpvBD0O9Fbs/EOVm3kn5TRfzHH8re
         jHWECb5FGh4GuGsmTeKja0ga0V/lGJo6yFbVCxtDe0DBgF7/3x2meULaAjsYvikaVrCS
         5k9PneaM4h9TIpD1YCGXJCXZGea30sRYvbfOMWYykOtrQ631kK4NYyGu9tPX9tvEIPlU
         w17Jtei6EzcXneVOP6xAJWmYMi/5DFFanVcqN7YegI97oqdBAgM2rm/rBJUz+j8yBdYP
         jw7J9bdQCcuDv9JuY4D3DaHcKf+xRowqcbhuyH08xu/gW9m4/vZNzaKMXrOSQD+ufXDb
         GzwQ==
X-Forwarded-Encrypted: i=1; AHgh+RrQxk8ZJ5T+Nc+0B0hFbEUckX8wkX8dKZi8RtauRj0R8B/Ply82PDaJ8duTzJkA8BThBUKBYpcYyA==@vger.kernel.org
X-Gm-Message-State: AFuF++mY7gAXMpTs2Y5GD2ffD2GC4cmHlWeMLmVyGleVW9QFm6+K6NST
	lm8LmTFFxeof0vIfHG6RA8Is08N+7Ak7PWi6sISBENx12Ke5qYf0k6dxgNP8jQCTRzvVuv9quKD
	oMhYqGHkzDNe9hClLJPbxau6S+4tvd7OBN4pogZUMFm+baw+HavkEC1Jt7u3p0Q==
X-Gm-Gg: AR+sD12VRkH5yLOqxRGnDk+zhHMiLUeRzmgeNEjKAKnpWZhrF9VNR9vvIuRieCjV5z2
	m7dzf8L5dESQf7bCR0A36cqp75O2na4sz5y4VbJMcAVyc/zVgmNWEAQy3y186xDSntRg+fPpk8Q
	fHpYdKLAWbPHQoX+F8Bffue7MnU4oLycihD0oH1z5zkSSZY+kNk7SDHEKqlCQoOc2cCWyQoKQsw
	En7oU1TnFRHzbKX12DO4SKs/2v1RevY/g+hkDbphNArW9oRQIV+jD6RUwZZ2UYBGKMtchAUHNT9
	4LsLuj4GAvBdiCEpLtbks11Z5o5AvoAwB4+Kyqd5QakGxDI1xnAumd2Z2ZoKoHdZXqkLNcv39Uk
	F4N+mptpYmWztQJN2UWUV/FxT
X-Received: by 2002:a05:620a:2806:b0:92e:6485:f640 with SMTP id af79cd13be357-937395ae7ecmr2164411285a.4.1787647350231;
        Tue, 25 Aug 2026 01:42:30 -0700 (PDT)
X-Received: by 2002:a05:620a:2806:b0:92e:6485:f640 with SMTP id af79cd13be357-937395ae7ecmr2164408685a.4.1787647349855;
        Tue, 25 Aug 2026 01:42:29 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b683sm1807087766b.5.2026.08.25.01.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 01:42:28 -0700 (PDT)
Message-ID: <26e39629-04d3-4fdb-8768-c93252bcc004@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 10:42:27 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/3] power: supply: qcom_battmgr: add Xiaomi taoyao
 support
To: Stanislav Zaikin <zstaseg@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260821123711.1579539-1-zstaseg@gmail.com>
 <20260821123711.1579539-3-zstaseg@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260821123711.1579539-3-zstaseg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: F1nsOloc1tVHKHtfpb1x-pCtkQgodyXL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3MyBTYWx0ZWRfX4hocDIrrvmbz
 YmowaLrZnW3wQzKh/8jA6KmJIrjlwBCLZatPAZbUJd8uoHE2t6OI1bAWyrEKhMfzquFl7oYQG5d
 bzYM9U5LrjNpX/PkbJA0/7kP0WoxA2c=
X-Authority-Analysis: v=2.4 cv=CbQ4Irrl c=1 sm=1 tr=0 ts=6a8d5577 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=-Zqg0uhZhYSPuZ5HblIA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: F1nsOloc1tVHKHtfpb1x-pCtkQgodyXL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3MyBTYWx0ZWRfX+9lIV637cbGO
 Vq2n38yIHchJeSNH4i1muND6P93dCPQvrvpD6qJSCz+ySe2B1qwZtF7v4ep1dryVHAak3Lm+R5z
 Ikz+q7XxcMx6vVMTTqvcSs4ZpOsQfuAKIUStTJmVzLoZhk6iOaIiUkmuWX0XJOh0el+V97GvowE
 nW7CPg24PGVRPYVac2Ygv95V2BsUoNuh/blaziaX279sXjPSq1QyJS7APhHguaYoc1o8RiDjzOp
 gir64nuNlZcD4cRxpHuCehVsDBSbMh9mBIsiGtaHaEVGIT9NERkSNXTnZFA9L+9qCYPe9/WctPW
 HOfYAj+hzdFYvN9hUu3ZJr4DWGBxYFnZtEnCJ2pWuR2ZnVos+Tx4J/2coonvP9DwTqvGmbYDLAF
 jyvK9R+6inH0J7nT0J3ZljxYeZl2Ib+S0mxAvXjLnYGTLewzELSZN7n1w5lq5DDp3JkzXnjite2
 mQj1RwXEyiFJw9ZdK0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250073

On 8/21/26 2:37 PM, Stanislav Zaikin wrote:
> The Xiaomi taoyao firmware defines an additional BATT_CONSTANT_CURRENT
> property (ID 12) between BATT_CHG_CTRL_LIM_MAX and BATT_TEMP, shifting
> all higher battery property IDs by one.
> 
> Signed-off-by: Stanislav Zaikin <zstaseg@gmail.com>
> ---

With a certain amount of pain,

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
