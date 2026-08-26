Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AA9335066
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787734814; cv=none; b=TjANlvX9XL+9fpdAnyRm9Se2V6hiDhCnSbEOzUJGmM0nEz8XPazhuBH0DKna6gtC22LIc8YC/UDwpXMoniARVmZKwoEVIlJtwFu8UCF+bTYM8U5gBvReK5ctZ+orbN5tp67LqP4PsCDxB+uYSG3e8BLk8aFB8kqQQ2GZyfwm7h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787734814; c=relaxed/simple;
	bh=JJiOlF1x3irKYvIJ1pNjsSbsiPWX/mrHGNUxUyjiIIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZHEDk8b3jixN7kwdZBGivXbWeZkornM1M8Xeui7EvqaGDYTC9PDjeLd6/SPR12eAo+cOzQH7/J1s1ixjc3ci8X089MGmIEdWvGZuoRplOthS8Jp978ODYF94d7BW4lwQu25cTY3XErpZM4Frl9mcmRoISpTmCb44mdHvhY7QFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BpL7Xe3N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=isL5yxwI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BpL7Xe3N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="isL5yxwI"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6Rqb33210700
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 09:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2zhZU54kOx/DqOOM3ZV5yI/6
	ZCgYZzJQql12RB//sA8=; b=BpL7Xe3NYC7q9qFq/rMjTqwLQ74p6pJ5hox5Gq5A
	UKYEhPl3hcXhgT5MqJ7CBvp3Nn+Qh6bsl/gP9xxKcbtVur9InEgZVMEW6cLBJZbS
	HF5AYmU/KiWfwijIzMgqM+QVEWeMWTtfjSHSAbF7DobzdJJcd4AFm5VX94VjesgL
	vQoK7ka2aveLp1JO5kGErbxcLXUk91lQradb9KKoj8AczudDpcF7B4e+32wcp0IT
	C+7kgkv38jPNsJgL86npw7cV3UQhQsp5ctTXtfycK2THM1B+SJ4V6w5byV4PxAVW
	jDTmVPciJy0MT6XrwnZOHJfDk7qv6jJHYvWxTxdc+ynf7w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fgrb2u0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 09:00:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52dcf1bb6e9so16249731cf.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 02:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787734811; x=1788339611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2zhZU54kOx/DqOOM3ZV5yI/6ZCgYZzJQql12RB//sA8=;
        b=isL5yxwIa2gQXpgekpnY5vt56qQqDze1biFFmbCYuBm/su/6v7Hq0MKFJihnQS0lEe
         0i0yDxmjZ7e1Lm6MfBxLnGVveFbnJQ6aGZ8+BcYdf+9y96hZOScd/6W4xt+epbuLsMTJ
         KPYYUPCUHdOjQUztIIkW+Gf1cFunC/0/Rg3rtW+cQ8L3REw7vzlCBep9p40k6bq7HYWP
         9y4oh3jSR7HCJAU4WbcPpwTrACpUxzMAyzVJRv6dH/B4195uzaHtoegnJyjykdLTJ9zc
         JJfafSA7zhOWYk5eALskgBppBiydUzAGbIUyT9AM/GFWnXwdXuqmvh9m8h8I8555z6+S
         JyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787734811; x=1788339611;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2zhZU54kOx/DqOOM3ZV5yI/6ZCgYZzJQql12RB//sA8=;
        b=IOpPDfFreOFnXbS276PGINZsyMrWMDhuDuI1swumZJGDbF9oq1xL/FJt2FxVI/GGIF
         sqATMymtlnJsLgDJJbZkG6Sw1JeVK+eYj56FVBcNq+SspU8Qirjeim+f1hjUrPCzFjUw
         Fh2VYrVnxJbtTO3WUsU9lrashPX9kC1MqcrKPsahbYL0XkDmgac4C5OySZebXamFZyS5
         NVg3wj/cdpwTmmlaRa4gX5xcuE8YIqVkbQY3ckM3j5P1wQEyoqfVnBOH4tY3Xlq+aHkU
         n3uqqt6JJVI2i2sLfMYywIOjeZxIubDKdpCy8JO3lfPB/aKw9hPbSRkQZegYjmpaqFL9
         XxHg==
X-Forwarded-Encrypted: i=1; AHgh+RqI/tirPm43AeX1keov46WoS6/SGPDLriA3fOkQXPDPyTynSzad/K8EhPBcZDuV4Z0TmGcDgXuzVA==@vger.kernel.org
X-Gm-Message-State: AFuF++l/Iv2IOHlJnOck0m5N3iq2lib0DewnZC/cLpxIDXOFWxiPGUG4
	4omrMgfrgI/t/i8Ja1qTKJUZkQ07f9Zy3qX2owKsFkN4/Q8SDo7CKDCJwR5MTwzhau97lStS46R
	GxDK7Lg7etr8fS0OeSKiuDWuM++tG+05lDzqsKbTMKdlncxiRfNiZ9qwhaxyR2Q==
X-Gm-Gg: AR+sD12jhOpv0jAj4udNRnPfrzVdrrCCniRCJ8yfpVuWtE0xaJ0LsrZzFc1R0zXKyQr
	L/6A0z+566wr8fAeStnGEpYqdK0QSB9s6Ou/9HuJ8GCTYvmir0Pz/XVZD6EEHBxXKxH81XLpBdL
	7MN216pmIyQvATzTf0jyw0GRM4LlL8vJ8Isjnmlb9DC2C1zqMgNRnexDXiPEce5zcZOBi8F3dQw
	sVbedHmdiavTGiBAdx5EEScPbhnOmh665CfI1RH3MiiAyBIyyOEpeBUYK4yufsdkvdlJ4s2b1aU
	Uc2CFqb+9DGfX9Vsw3+Lovp10k1AibQpWrRMdw+NGdJL2PYcPC+krMWIR58ST/477VwwQq1D99C
	ujaeF7uOr2WHG
X-Received: by 2002:ac8:594b:0:b0:517:6fc2:4760 with SMTP id d75a77b69052e-52e2ec51d8emr120518861cf.9.1787734810538;
        Wed, 26 Aug 2026 02:00:10 -0700 (PDT)
X-Received: by 2002:ac8:594b:0:b0:517:6fc2:4760 with SMTP id d75a77b69052e-52e2ec51d8emr120517771cf.9.1787734809757;
        Wed, 26 Aug 2026 02:00:09 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5de8d1188sm3655807a12.7.2026.08.26.02.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 02:00:08 -0700 (PDT)
Date: Wed, 26 Aug 2026 12:00:06 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] cpuidle: psci: Fix support for probe deferral by
 dropping the faux device
Message-ID: <irfhmz2ago3suc3o3klfrztq4nhvrbdykuyqsg6pynnkr3naaw@rgnnsjk7ftd4>
References: <20260826084533.38960-1-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826084533.38960-1-ulf.hansson@oss.qualcomm.com>
X-Proofpoint-GUID: Ax_rG9pPtrxV-a18LY-je9eU8mCGfvEv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA3MyBTYWx0ZWRfX7GawbDmayzHX
 SboDxqGZj55/iA0c28EFaK3AAeFvcMvKZObGu8K95H+p5eYllASePxT6hdnalzl+BmZ7dYL+oFm
 38UJUIKCQxV9SCmOqxL1m3cMXo+AogjLwXggXLMx/NRz0ewmeoTK3F+S0moVtFR/RLo0nEPYrHW
 IoL9V9IGck0eBmWuooOKSapq4AthXB6ZKKpPwbeNpi19C/tkaMK5ZARsk5rrxX2aQWrwK51FoqY
 DS5W2+BxANChpcmAVguhC+rDf08RWzf/lLztcB/hrEOA7tugqev/yMvMQMz0aqyPG/u84XYcnMN
 x7zsbQ7eweoH+3tri8SKPyiT2hHUHlgiYe1m16XpACpy2m+udtIE5Vxg8UiNV1w7kh7HQfsTZbg
 3MNsneCdEOnuE/C/6WgjX0IFelvvYf+LdQNRznq7S+X5PnCjms9y2tbnQgoWsS/4AmvdAGzg6eA
 Ma3wb+EsrT6/ssJvxQQ==
X-Authority-Analysis: v=2.4 cv=d8LFDxjE c=1 sm=1 tr=0 ts=6a8eab1b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=clBUptZa5v5FR042Ey+sjA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Vx8LKYWbTLu2W_pKgo8A:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: Ax_rG9pPtrxV-a18LY-je9eU8mCGfvEv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA3MyBTYWx0ZWRfX/BdNKhAXB4GK
 hSET/iKDWdRRYaqAQ+6OVbLaPGEMaOPSTSHWiWPMDPInyEPGP2AucTRqHtbkKfNy/35FPnsCu2b
 5FxRWgQz6oM9W5wSscpcZg9OOgdF4Yc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260073

On 26-08-26 10:45:32, Ulf Hansson wrote:
> From: Ulf Hansson <ulfh@kernel.org>
> 
> At the conversion to the faux driver/device we broke the support for probe
> deferral. In hindsight, the move to the faux device seems questionable, as
> it simply makes the code more complicated and for no good reason.
> 
> To fix the support for the probe deferral let's therefore restore the old
> code and drop the faux device.
> 
> Fixes: af5376a77e87 ("cpuidle: psci: Transition to the faux device interface")
> Fixes: 5836ebeb4a2b ("cpuidle: psci: Avoid initializing faux device if no DT idle states are present")
> Fixes: 39cdf87a97fd ("cpuidle: psci: Fix uninitialized variable in dt_idle_state_present()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulfh@kernel.org>

LGTM.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
