Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332405012A3
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982359; cv=none; b=Mcf7w4Lo93MF0ce9eEQL4WU+BxY+W7zwLZp+1oxuIFY0QD7kgVs7ZzcDbG7l2UAY5J4cvHNa8JBh4zVdgETK3sctrmpDVpVr9Fw6vBpp1bZSsouZIr/uuRY1RBpvRiSYwsdbz4Kn8knWq/zbJlJFLZT8Ra4DVmT9fVBXgv/yPzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982359; c=relaxed/simple;
	bh=ggIJpFtBbGEOkh9+LAMjApcVH5QDsNsEeUnjHDyW24M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMOnDU5wh4lP0zmQ55Jg1ZCDP2yVXqnEjKqzbEeqgb3mAazZPGr4JFxrl97gJOxMOLQgxs+hK4uE3v4kY8TIs3YMXkUw3xbd1abEOYengcQOfraP23RhP8xnJiSgetU7Oodjw2U4t5Rv9s57yk2oyj6uB5KSDDNEaQaIcDGlH6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZIHBFsNf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UeTOiMRw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZIHBFsNf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UeTOiMRw"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E9eEmN3696497
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YoL13luJ5wOMcRgov2oFovA2g24ZYuiHZYrEI39rqsU=; b=ZIHBFsNfWR+rgZZE
	SSS/paEcFVjnSHJFVuKa8I4UXs44sJTgB/RoqL8DlGwmm/3R/PjrZm2Kr5ojHrti
	dWUBexYRKSW/kx7YPFoCa2m2IW3FVJR+dJ4QSAe8azX6xXO689NTWwqYgFtoQcDH
	MrbSJ5KEsHBtONGueI5V1QeIOMGtwLB72NzsaI/gZo4ttjNkY0beCTZjmAwQ27Tq
	LHKuTX7h1vFsU19joWqcF5jCTDzKKjE0flanw7LgAE0SOPvZ9cvqwz/LuPObKxkz
	UHpChVQir3idXbuTCmyIpD50LhPVlY7JjjTVzzshL3JfBuZqPhFEwbaRQs0pxQWW
	5A3D9A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha7aegqd6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:51:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93e629c7b16so63857085a.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 05:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791982313; x=1792587113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YoL13luJ5wOMcRgov2oFovA2g24ZYuiHZYrEI39rqsU=;
        b=UeTOiMRw04F41y0j5j8d8OI2BXRyc/sUXMYpV7PjhJ/GiU5JIeNqoFkMJZtr/yGxM5
         xFNL4tDf0gwn78nsOmUyHWP65NPbrPXIXeDts+eeCp09zDYl6Y58BS4D5ExMdYeZ43iC
         CURFEcKQdsgwJ93+Id17cPex5EmVpUX0fJynTivSxhpjVI7+T8QSX8zD1OcZM5Sgyucb
         0EAmkNu0S8/lHcvwcmqWpi2iOI8HLbMn37D3+PRFfdYaOm1p05BfyWAShxElImqAzHgq
         RI1hfvksMQ91EYh3H3KSram+CBC7zGeHWqrRg4pybYmbsiK0VjhCqFJcJG0h12P9sqBC
         bmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982313; x=1792587113;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YoL13luJ5wOMcRgov2oFovA2g24ZYuiHZYrEI39rqsU=;
        b=SMDWa144sn35yAg3Mw33IS9Rjkph9UpAdWuo2sq315dRAWBEiNf0ckSKKMWnJRJv4y
         d/dHpsqLKUr+s5X8vzQGRNp+E0eELm841FDPViZUJCRP4FuJNFT3KndiR/6v8Bmgf5K2
         LPIWp9yFUqdmFpin7OFnPsvqneSNDctJt2E6SkQ+rQiFH8qsOw4ufpLP56OSULZ8X1TQ
         4/zQ0yBFXr2tQkwUBCjZsH6D7j8+OAVCB/v+GX1MA/VPiKyYxV1AjTnkz5gvHMS4hgGk
         mYMbq4aiyr2lzAl2Xg3ztYee2CALNHXtmTeWcEhneNX3/MZDKm6bh5YujHfyE+uAgVq6
         Tclw==
X-Forwarded-Encrypted: i=1; AKwUvBzSXdv/2zoMTmkBQu/k9U2M0NxKxjHvVbMTLIJDs44O2J4jjgBDuQztfAkZ6UHDMGQ1QhydUSC3TQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYK+1fGIQwiuDt7br0VFuIzp6UGgvjiNy1aMtOqr3VO//ryFUyE1
	cJYTI0Vwexg+z0iERZU5AJkfWXI5eqNiPAIl8F+ZRbG+wvCHsToyXECrqX/OAa77vzfrzouqDi+
	o1yLtbDHgG1QyJip9I/SJ9wzloh+Q37YnvntAQb5j1705RufDmPICpCzpsbEdWw==
X-Gm-Gg: AYBFou1abgzdoTO9XZUSTWsj1OgCdw1Mf/FFKn9oJxNVK2yN7x8JL3c2Zs7jVx65Wnl
	7051bPdoVBtI1KoTYPmVhqs/q6szePWt0VyasQTUvoe7hgXjzJ8HohKUk6/satiUbZGVrfunqHP
	vqQaxSbCpsmDlJHAC60KC55A7cRygOoTO30Ew8IJmMtaqLNXwF7Cz49/Wz45GIjnC5v3U+9Exrp
	7H9W8DT6C5GLGsD2buVHQwJcsYUGukVaqlIqm9Nopp2XzU/e/OoyqOODSHADErlV88tMZ+U+vnL
	pSBN7+hj2xhE8wLrboUqn6YoRtZmmFTNDhSqWssp78qRTrPL/sc1qooxxYvAsJh4v2xByht7xz2
	F+tJGgMd83s4HiTzd7uhEXQ==
X-Received: by 2002:a05:620a:29d4:b0:93f:977:5d9 with SMTP id af79cd13be357-93f097721f3mr132808685a.0.1791982313190;
        Wed, 14 Oct 2026 05:51:53 -0700 (PDT)
X-Received: by 2002:a05:620a:29d4:b0:93f:977:5d9 with SMTP id af79cd13be357-93f097721f3mr132805185a.0.1791982312668;
        Wed, 14 Oct 2026 05:51:52 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b203839764sm1094637a12.7.2026.10.14.05.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 05:51:51 -0700 (PDT)
Message-ID: <292be478-dd1b-4ad3-a5af-5df6e61bb89c@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 14:51:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: sm7325-xiaomi-taoyao: switch to
 device-specific pmic-glink compatible
To: Stanislav Zaikin <zstaseg@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20261005164303.1208127-1-zstaseg@gmail.com>
 <20261005164303.1208127-4-zstaseg@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261005164303.1208127-4-zstaseg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FZ8P9jha81AD0NCs0VFJWDEjgUXzD0UT
X-Proofpoint-GUID: FZ8P9jha81AD0NCs0VFJWDEjgUXzD0UT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MSBTYWx0ZWRfX1/feCzvty/WV
 6zKl3zM2BpL/cBA1W2ze+bF/togUZ8KuARDT6aATg7paaCkoVaZw9c2y/mKZPaVka8wT7BkGq4u
 Y/E63EDzDtYVO0dRevSCfAAmCmEzaW0=
X-Authority-Analysis: v=2.4 cv=NctzRGD4 c=1 sm=1 tr=0 ts=6acf7ae9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=EvRZl4TTolMPfV8XnZwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MSBTYWx0ZWRfX8DM+ZeEVGegr
 PwQYbtfJR05ZWXbPO147S7DW5rzgqgIqNt9KSsBCBIfyMefftlIzYFv5OPtrdn8yIgYpwrktEqO
 MqDn8J8HlDR+Hj18JaCg30m4DkpWMMhu35ooOIOnsvZgd/V276IiiLaoxT+2Sa1mjZ2bJ/BCD2L
 aw82sI56GM1W/4YTXqkEV8osbKsCOP4o+Qhn4XjdUBQyhSh+0zAf4lWjcO3xBc/+UkH7KLiGvKm
 HwQa9ydiORotditq0z+nRpufZgkOt8pKEGWJBUDvy6OwAtNkRZvklFCeyE6j9ywABOoieha2vnV
 eS3Srhp1STg9LKRtKB61HzhBN0cPElpP3NVwmPAlvfCpgiaPOLcJxh6H7NUJ/kBNNw6KevhNuyu
 HkbU5spDARbZwecm7mIenQzhGMmdLR0NMXag3J31RO9dlrIAn6eTjgsIg2TG3jRpWJsuB3e1mOq
 VZ9wDSrh3MVUHQRGLNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140051

On 10/5/26 6:43 PM, Stanislav Zaikin wrote:
> Switch taoyao to "xiaomi,taoyao-pmic-glink" compatible so
> qcom_battmgr can identify the device and apply its taoyao-specific
> battery property mapping, required because its firmware shifts
> battery property IDs relative to the generic sm7325-pmic-glink
> firmware.
> 
> Signed-off-by: Stanislav Zaikin <zstaseg@gmail.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
