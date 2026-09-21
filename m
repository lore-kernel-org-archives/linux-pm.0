Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370B944D031
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980988; cv=none; b=Hvua6mBGGE/3NU13iYd7CMNgPNqCcayjf5ckfb6ynx3fK1W9cQtzjC2c1xBePDkxO3sfTOqyL4yBO4vKSL7NAt8EcKqa68BKAnNkhvpDE4eRhe/PtV6wAEIAN0a1lzfT9tbTzyhxf96nh73u3YmcJ0ZjqNrGpW/HEkkWJfx7l1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980988; c=relaxed/simple;
	bh=7XZtEpVGtm0f+NlP7kgan9JKIMeO+tGJEksciTcdIak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n23/3PT7pWTjEEXmeeBC5oM11gcrt1x3utGKkwPrBqEA/RaAnMnAMp5jLlwoC6Jrzu/23I/CkfsSXDTqGUyw7FFszojJPZbcJu/yNpeQfnvqZR3PXUJBHGH5YZSbhV6U5gKGbRDCYRgBNKKjDckuyn/GqHYSMiTlYOihDAdWOow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Eug0UsD6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FhTom3N+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Eug0UsD6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FhTom3N+"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7A4or608070
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 08:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qIj4vi2FLq+WftfLVun+oqSNTJc6FU2XEuQk79/a7hM=; b=Eug0UsD6aF8mmSEI
	lGzCs/BJ5CwzaeqWXTm8P+m9Lf0/KN/MauSL4S3Ro6cMGSBKWtDTulzbHM9Kd5ez
	XI3bMCaUn67G0O/xUpSRRkkXcB7zf5LQt4Ls2HgO8nrEr03sWvJgPc557nfXaABd
	q17cKiMCWHCV9duhmpta4IIasRtasSkaHJz9s+faM2fj1Ueg/96/XghIWbNWOV9+
	rxZ8YrfBpJYeLuH7PYkWscYjIWUEPZYwjmpQNQgj1iPAakXp//WejaFPaZtv1KSK
	mYGYJJ2N5m/kPjZwOUqAxu/GJVnheNdUX9Ewt4YIovUyxWZc1lksFHGdI1c4QgmX
	xCkFPg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtu1eheen-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 08:56:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93102454272so92910985a.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 01:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789980985; x=1790585785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qIj4vi2FLq+WftfLVun+oqSNTJc6FU2XEuQk79/a7hM=;
        b=FhTom3N+Kaj5f5HFXTBK37X5W+OnAlSmlS4h3Ut1sNB66O6fRKPaDMdMmWogLVClhN
         d3J2/NDQmyYfDM7FRH6yxq69oPmE/Gd/Q8aiEP6pepkKw+zwSop3s27L+690n0P+gHyV
         y32VjYG91qGtK4p3NgujLu1rQP9yOUWc7Vk9o1U8zx9MLBm3ws+5N7oK2mZDQfMB3oxc
         8pDuhY9rxeqb0Sm4D4Oevs8SgwpAXzoq9vmpXX69acCEfoHcskgHW5+jP2xj2nkCzfu8
         aKEaTAltK+Ah1fplhI0ViOWITMnjEBIhPs6J9HA6uZLW7bBOToCLepXB/u1nZI3f+GzV
         4E+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789980985; x=1790585785;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qIj4vi2FLq+WftfLVun+oqSNTJc6FU2XEuQk79/a7hM=;
        b=EVA9/hd22yYzAqsuCRCgKcexVE+7mVHH1Sg2Foi8uV6rbvyQm+AZaKFAMP9TKTA4SA
         aWs+Q/RfG2M4ARj+NYkiiIwlML7fk+KuZsCjG+JVA34aZ3zB6eFylVTRFjXe1h8d/FIJ
         aC7w2ff3QdVX33PpKdTwDuF83piLuxVJ7XkHxPRtSS/Mw+9x83sdhanwy6OXiEO1Yhv/
         YVDCBmoakIeXzSop0+qOwCbwinJRE9JGU00sXELOqrKORAYuRIUkfJRmL+jcIMoOHKed
         kauetWg0AGSDpKdcaTDrFwIelM0FT/m2zNJryxadKh1B3TtJKAZE2yCRC07bFmk1+y3a
         1Ggw==
X-Gm-Message-State: AFuF++mcY7YBSIWYf4amdBHN2ppDX5vNHC+QvlQGpm7k5aDRzOSpsL9T
	JT2wmc2DoSASbbo9O2/lkmp+cH4AE+pC6b5yc8APpWwzcuTTq2gvZqEcD891EVIzk1AqSD7g/Yf
	NdA3ThvithPObgxwDZjayFspQsg4Y+k3lQOEhudyVuv9TauleDcMJarcIuV7kH/j3HSIkZw==
X-Gm-Gg: AYBFou29biCNIOGftAlDu4dkWq5IQOzxuj4TwSsCP9t7TnA3TApC0Cn3S9IUiQh7/TO
	DgWvejGlhPWy27eQN0lsvobuiRaZvkARXe+Bq0NwoytiD49MAGfsmYSzjG9R8DtbHy/Vv5lKA8M
	2OFvpNB93Z5kO9p85yzWUQqsBtI0iMX7LH+MawnXUouuyozIBd+F7/H5bIFNl0sp6ZdktHl+ghW
	g5sg/OhcZ1i4pOKPk3AGhlgtdJPMEXpmanszJkMVrEg7rN4gaQHVZNSZo38TUvOjZAoSEJtaNi4
	uS3c7KG/wFHS/5EYo18llpgPX8Vc84xFvTCidZ1X0bLpRIk/onCA4DUrNXovuKw1bLKDZ6MwJpy
	nMQcKgqGOzJCA29lnwiJxEQ==
X-Received: by 2002:a05:6214:8611:b0:912:1b54:a4df with SMTP id 6a1803df08f44-912a8065a95mr109634566d6.5.1789980985321;
        Mon, 21 Sep 2026 01:56:25 -0700 (PDT)
X-Received: by 2002:a05:6214:8611:b0:912:1b54:a4df with SMTP id 6a1803df08f44-912a8065a95mr109634336d6.5.1789980984943;
        Mon, 21 Sep 2026 01:56:24 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67dbaf0esm3980740a12.15.2026.09.21.01.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 01:56:24 -0700 (PDT)
Message-ID: <daa5e0d2-a12d-4eb2-95f0-54099e7c8334@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 10:56:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: qcom_battmgr: Report capacity on X1E80100
To: Liviu Nicoara <lnicoara@thinkoid.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260920193402.2402-1-lnicoara@thinkoid.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260920193402.2402-1-lnicoara@thinkoid.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyOCBTYWx0ZWRfX77FyXx/IYUYZ
 RYOdsMvjVhsraoRSTtkadnHKzW18pVEEWsy5X25ks1PHi++6Fnh2/I6mNBbeVx3SyqfGfY4c8MN
 wGaoly166OvlR2hbJ7vc4lP1U9QFjm4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyOCBTYWx0ZWRfX8D6SiNOcPpNE
 /PJZRzN/UmWj8Sa0PHacOjJB8ikmnkiRbOvl7tk8IqN0zveyHbeT/vZWAd967vttE6B3HcazMTu
 nCZ0lWXteeRUCJkV1th5OIqGAR1eUaEt6+4V8UF1HYgdRU7SHin7iKDQ32VempKu4RduWRle9Db
 X89+f8CzVQDWdLDodW6jrNh7TWjRQp9kl6k1u0L77paou8vUUt6MF1VE8BQYG/eiFnfMbcKTVI1
 1x+xncifHWGolQXnpy3UpvCFIIiSOBVrDb5lwAqidbRhsRVAaUqUupgUZzpaA62Brqew5Al2Yjx
 QseF9vNgtwaora1J9Zl0Uue1US9PQRvF/76OeBTLUo5ALvh0oszfr+/96EBPr2lBpEtkVqwRG3s
 arvZpv2soaBxil6Ey3HlquPKkaDTtG53fOeNz1HglzX6XQiVGDrRD7mcptBwkmxTuKXUmEgDH01
 BjICCVZ3djxgxocnJZA==
X-Proofpoint-ORIG-GUID: _15L3weIxuUA1zv4xKLjiPT_dO119V8q
X-Proofpoint-GUID: _15L3weIxuUA1zv4xKLjiPT_dO119V8q
X-Authority-Analysis: v=2.4 cv=A6r5rKWG c=1 sm=1 tr=0 ts=6ab0f13a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KOsBq0R2AAAA:8 a=EUspDBNiAAAA:8 a=9jRi0BA2Tx-rpvEMm28A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=p7IlednmDx7li90OXeev:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210128

On 9/20/26 9:34 PM, Liviu Nicoara wrote:
> Commit 3f87baacea4d ("power: supply: qcom_battmgr: Report battery
> capacity") added POWER_SUPPLY_PROP_CAPACITY to the SC8280XP battery
> properties, computed from the firmware's charge and last-full values.
> When commit cc3e883a0625 ("power: supply: qcom_battmgr: Add charge
> control support") later gave X1E80100 a property table of its own, the
> table was copied without the capacity property, so X1E80100 machines
> expose energy_now and energy_full but no capacity.
> 
> The percentage is already computed for this variant in the shared
> SC8280XP callback; only the property list is missing it. Add it, in the
> same place it sits in the SC8280XP table.
> 
> Tested on a Dell XPS 13 9345: capacity reads 94 with energy_now
> 52640000 and energy_full 55540000.
> 
> Fixes: cc3e883a0625 ("power: supply: qcom_battmgr: Add charge control support")
> Signed-off-by: Liviu Nicoara <lnicoara@thinkoid.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
