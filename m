Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5E83FC5C1
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782727586; cv=none; b=p+TzBWrLFJBRWmGdGReGo//QGxG45rO6zReLgW0/xZGZCbkaU6nD+Re9l9kdFYp8Xbl9tPK76ssy+dI0rFXgmzlJoSRVuTDsb/6s2hIoX8IicM6vdtlORahmy2U5XUyNtngLKTeh6uGmNyAIK14YtOqzoXaYnOk/5z+l87PUV8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782727586; c=relaxed/simple;
	bh=eYrZuUDW54GVV8/zA+Zs7S0GCSgEOyJGq3UYJVTrPJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7ZsdQQXo7U1M+TMwAfNNeC+NuhlaFOSLyGndMVVBB1BCxZ9nedBuy/i9r5fKJSTEt8zq+lfL3EyFJkz8DBA7MIuV6xQrs/9iLjAy2zS+/mIapgtrYVd8rlBFTYdWN9Xh+JAnjQPcjNgLKAHyBEkz5/Y7/PsM6dVOb206Bc0IA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MqZ7xCHb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y4qv8cEW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MqZ7xCHb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y4qv8cEW"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8OOIn2349150
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 10:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lVt6Gi25NiYqcnkyDANHxTfSbL/4fUYAeYFJ+RUI7cE=; b=MqZ7xCHbU1O4tss5
	EMuW985nkiThlT3+GsjK3ceVrdJuznujEYmCOJYJlPcy2hDjSRSBLI0qofA8W3Df
	UHspn07PPrzMDWwOvJI5Qpn1m2PHQGN2TmD0kf9mA8JL2RyXxR44ndHznQPt+BMO
	VlMR23Efa7mhmgwVR/T3CJjflWI+LPBYyNyAcjgnFUcu6ZGX4sW+aVt31Cv1Aa+f
	7H2ZCGXJLwF8gCLP7f58JXPPd6UBVusZLffrQ5RxDjwIPfUZNmWa5Jjjkisz1SBv
	gEpeffsGZjxTM+UeDMDISujGXSAcdiWYJIHnne8FN3A9xH98a1KixsWEy7LKC1Jt
	ChXDMQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s0ept-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 10:06:24 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bea07880dso3929881cf.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 03:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782727584; x=1783332384; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lVt6Gi25NiYqcnkyDANHxTfSbL/4fUYAeYFJ+RUI7cE=;
        b=Y4qv8cEWHLW4hejr1zbmvCqTGdoN1vjGCznMYeHpKTXKTM2q+hH2rd3Tvh3fc+BWVc
         Kpvd1kX2UZAvPVocYP/Durbb0apevE8OUYv1zT2U2hL5cBPVLHTNG+RX08ZYzlakabwY
         APysXAdpKH5co08+QNoWQaHKiECRVaxJTL/u5bcNs7UHVU9IH5fz/ge4kIdS2m4mRzPo
         /QZQLyRAmbYOU5qbNBV8+GiF864Lo8cO+Zetd1lNHRvjXjdQn73g5lE9SFLd7I60xeXW
         EN1go0kkkJvXAx6xrfAbtdY+u9Oav0GM4kg/dHAUjlVBJ3zyh/CDJ6tuWkq6mv7xSPHB
         4aKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782727584; x=1783332384;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lVt6Gi25NiYqcnkyDANHxTfSbL/4fUYAeYFJ+RUI7cE=;
        b=m5cMggxPNuc0iJI70t5+I1Z7vuZj3Qa0bhm2PC2IfNDTN8JYASBMYt2lNTV8/PONzm
         iJSUeK35MOD0xtnmkoOESy0KTNUKLUGIomiUlk5p7VdQdGllYOadI0+mHSD0wxhjdIrP
         ij+MNP1Ijfd6A1wXjxvRbcXrSokJUsEJVRorhfCGlgmQfggtRF/8YUT0pInJFcYO66Zc
         sqxiuidl79jNFaPg2M1h4Xk1PuwZ6rEEZX9RwmnjaZYPFmRUGLnGE3AH0qtz5+eR7odC
         kGc2fPrluvRJKjqETRIu12ceZB2sd0xtNeRv+P52heH30OmwGJwQrjZEnyIDjg2JusQO
         OZXg==
X-Forwarded-Encrypted: i=1; AFNElJ9+n8P5dFu+YdSNYliIBRVBOJLIDoiUshBdWhfFRRkG/W0SmopvrfrXjjnEqJfjp+HwCaQpz8XXpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkARww5uUEG7VxGi3h4Q3B+EaUNLeofyLYNbGqS2uhqE9XAZek
	kNYO9BYXB1jCjYLUlVmwB6YlaF3qkhrxkhlLGS7CHMhF+jrPQBIX1xe8/OU25dJ/si5WyL/M+L8
	al/KPcaQknow9dqg6daIj6BJutBcP5VIBqa/+bX3qxJWGnaxdVJnTEJwpyEQIKg==
X-Gm-Gg: AfdE7cnhQn720xLGhV3CPsOYjbp9Ye2Jh1+iae56/QRsrYaKd2CgUIzwPvp7DkRW1VL
	FFVVIDh/WRSORpMrk2htFa2ftvHDO67wtKqOUD1lhx4voiDJV//5oH8fsoZUGod0I7BFi9aCt5I
	gK5HuPCwxVXd3aa2OUfLCbu9axwwbA42WfJVqJZeZjtlrxFNag5R/DEBPcoVpQ8wQggoyo23Z7L
	iEEfpEteEREpMd7USLa4qaNg0dhsWbVbPgnAcboRjF7aM6hk/LNV9mFLemVVjyVa0xjJQEGntn3
	e4w+hCIj+L8kL64CYaQvF3b20O5ARFtK4Xoo91LTMGE6GsUdbSh95SWzIkGgcqs5Zl42vKKHU34
	VpNiESlwY/5zhTD84Kxx4DIsSQ1QKY4UQFa4=
X-Received: by 2002:a05:622a:3d0:b0:51b:eab3:4ef1 with SMTP id d75a77b69052e-51beab3578cmr59352131cf.4.1782727583437;
        Mon, 29 Jun 2026 03:06:23 -0700 (PDT)
X-Received: by 2002:a05:622a:3d0:b0:51b:eab3:4ef1 with SMTP id d75a77b69052e-51beab3578cmr59351661cf.4.1782727582842;
        Mon, 29 Jun 2026 03:06:22 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbbe8125sm747959766b.19.2026.06.29.03.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 03:06:21 -0700 (PDT)
Message-ID: <bfacf381-8112-4c12-b87c-46cab7d7f284@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 12:06:19 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] clk: implement sync_state support
To: Brian Masney <bmasney@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Xuyang Dong <dongxuyang@eswincomputing.com>,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4MSBTYWx0ZWRfX7TSBgxJzV7Rm
 UNRkH7VuKv5EXaD9LAQ7vy48bjZ47E3Wjr4z5oTL0rKvnPJ2Fp5XV0fX32WSuhcbwdIfhsmZgYk
 itizaJK4ac8ZdOyqeurE6nzaMBTUK70=
X-Proofpoint-ORIG-GUID: QZrhBYsLU5iYZTpQOysNtk5xPQsK9osl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4MSBTYWx0ZWRfX8Gk7sW4ZufsY
 jRQbYMxYzfo8JKH+5C3QTt9itANiYgpoMtq4Q/9DAUfb9DA/f1083EvZG15GmKRGA7Mce8bVFqd
 AAYY9TWL3ZIhmhsMgRfl2/atJFWNSVwCPAD8Ya9qe8mA+KrDqUsgYp/PjaKav4ZZ+uTEG6eLxWY
 EkCr4d0qU+d4eSPb66XW8IR0dEESrMHXPJxBwf7S1cc66rN43USrBbc0zQcl4VMNaIvD6AY38ZQ
 5nMQ0D5QCX544fw961pG/BU8y5XJFP5XbZsLXCEruqdubwRlD4NcnWfqORmMCOywHfITnTwsu1z
 cL+zElOaYsCOLKfvi7h4t4qXtX4iAlIhLAWXU2Kd4PW1KZUqEv2TQgWntrwIHhTGM97I3F/qvEC
 lXXIqMn93BVXRc52LxUiIqLCk6x2LnNDlfup2zgOLgo2nvxDjY3h7O7SiT3KGVLlPr7InIjhkcf
 IgIkZBj1UPBZJfEIz0Q==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a4243a0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NDI1EqwwtgGkLGOeOxsA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: QZrhBYsLU5iYZTpQOysNtk5xPQsK9osl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290081

On 6/26/26 6:32 PM, Brian Masney wrote:
> The existing support for disabling unused clks runs in the late initcall
> stage, and it has been known for a long time that this is broken since
> it runs too early in the boot up process. It doesn't work for kernel
> modules, and it also doesn't work if all of the consumers haven't fully
> probed yet. Folks have long recommended to boot certain platforms with
> clk_ignore_unused to work around issues with disabling unused clks.
> 
> This series fixes this by adding support for sync_state to the clk
> subsystem.
> 
> Changes in v3:

The version tag is missing from the subjects of the patches you sent
By the trailers, it seems like you used b4.. did you play with
prep --force-revision by chance?

Konrad
