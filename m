Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7530640314F
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737022; cv=none; b=RQHzCH8tD0/b6mGTBFgH+XjSxyP/YbTOLL0LruD+XxRIY6Oy3krGea6ykvwO6lgWVyCxM6jpDLGypTQgV3MAPk2fTPfU3+8Ti2BX+0yxsGJnETga6KDo6wHpFx1+KmRcBQYH/7W9y04SaBhFTIue13dUu7e5LfdKuzz7wg2tKKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737022; c=relaxed/simple;
	bh=iL8eQCnQSbG2ojygIK5P3cXtGszj1MWC/yVH3lFhswM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ue+xPKFxcEgsUmpydJbPlPv5XRpYcen8f87xvJ9BZKXdWncEKk1oUTsqGU5Z84RPBdulr9zfnWKRSG5kaTuWSydDiQY9cAR6mXgRkyo/orW618Rq5tq2pqvXzNTTzNR1pg7BBcSCWTN+q/YICRfbmOzCs6irUI/3dU68GqNddWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NMdpH6YD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZWBBhSBp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NMdpH6YD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZWBBhSBp"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TATJEx2642203
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 12:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CpHcwEms8mZxbI2w+Md5BrpKxIEKLFyT45Gg2vM0YiY=; b=NMdpH6YDeqCM6Ng2
	6l+u1JT4xPqzvjoTIliP40I8uS1vyj+L87A0s/qye2JFugwtFubIXUyRV7TGDunu
	R6AT7ytIJgsoT9qLUDl4wVFliJkW4IuqsH8CbCK3KeaS2RCkVYPYUJb3E2XmVf/n
	n3hDCcBxNJlzKeVUAMJaWhtjvocMm4xmBllzsNmFZBHpLfh9MoNKpAQANg8pAcNm
	TXF0zOy0GX+9LwYTaSDruBciQSlEcjcnL39ePRYOwyzIFsHATrj9EfyXaS+7TQfj
	LXtLZZhSE0HawuL0/q6HT7LO9lTXKMaK7kYXAJnJbjWc2xRjybwKZ0RF9NkF8Rk6
	8fCEwA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s10b6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 12:43:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-37e4045395cso3804920a91.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 05:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782737019; x=1783341819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CpHcwEms8mZxbI2w+Md5BrpKxIEKLFyT45Gg2vM0YiY=;
        b=ZWBBhSBpkN7U1a4i9A+0lyZi37P59NHUTaHRxPctYZd7M5PKOhhxHhsrbRHlyXSPaA
         7g2pTDiUT2cMwStL6aFYlTt9xcXUfjFg6PZm5M5A08PV+ZQczYWLkl3msHBYC6pcA+I/
         xeBlQHDX37KX/jltvdN/s6XCJWMH7mio4NbpE4Oszi90X2bmxyZ4jvTriu9et3RJXb4b
         dq/GtcOY/W4kwIz9Oee0eg1jZfqMkEWl+CoyAUIeO54TRy4aReXE6b9EAdkZXkK0FsQZ
         oVdtRw+Kfe0GzbER2JtWZG0NcZBAHeFE4T36yW1KOWu+n1fZmsWkmVbdQ0gNI3z7MrEv
         /aeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782737019; x=1783341819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpHcwEms8mZxbI2w+Md5BrpKxIEKLFyT45Gg2vM0YiY=;
        b=pcqzsw9oDXiOMfeYM5N6wH6VF4IlQ8F3DTgpCmRT6b7Q2qWyOBTgUd5/IFxg6J+v3M
         NhkC7y7xEp7bwGRLq7O6+JxKtx13PFUJd6zlxxmRtFdFCcYXkvl8sCmMJqC/1Iaojpl2
         fQH+rxCeSQazvkXLDiIrrCDeIONlDhGK6lrktHzjrmYbWTD7+N/ZziqsHG795rXha5Gx
         LkgfDoXLGUcgniIeJMWIL8gBgSmaljfihs4zW1YrxwbAsQdPYX5vUy4b5HhLnkTjjw0t
         a+xRGO5nCD2HxD3K84dVXp/OMmxiBT1FJMGKDWVaVkjclaBzxgNJMhRAQuoZwJKgYU0w
         RTZA==
X-Forwarded-Encrypted: i=1; AHgh+RrnutQqvlviKb4DilDi0suUM7d55v6I0gVoY5fBplWLIm3rhRAMJTL2Dg9lrFn9D7aVBI4Bqh+2Ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEEMRA/GQO9Sz5blVWSwIshAsnTSouW4eUGfdW5IbP0AlC1xls
	nyiXVt4Vxl+h+TO9TUTQusi5vAVU0OdjAc3tFlD3QDEa/wi1sOPf6rapoGdzOSYhWzcZCT9viVu
	tCu98TXreVQZBgyk77cJR4bzjn47lujFCasQ0ZRbc8OIdhg2x5tcHSiMSfbFGow==
X-Gm-Gg: AfdE7clkMEVwK+LLUZFbTv0+eDIY34wUPDAF5n0+u6ir/FnG0xgcW85MFOVh3MwZMAg
	9CRi0AxxTePtpLQthoGt+jSn/aMZh2KzvNeVPwFVQfKrjH0BMKFNL9G3giMIGAwgdjFITYZqVci
	0ZaUJFX67m1ckiFfqJol176K9FKsQuBeW9UbL64HFru03i/Kxr8F/VNC+XOyFYaoKT8qfZ1QlnT
	eyMjjvamjos/ej1Uov08zpJVUUiDgTWgpbu1+k7opkWYeekGyN33FMzjY0UMN3aHhxNEfp8x6sn
	QGTTnAch2lwGfEQab57wmAUdKLUOuUpxCLNgBaPCfti7oYc7mJAnL6F0xhjDIxXdq9rTWMfSv+x
	8wdgb3g7DqY4UXZrk9EU7aAcDdDbpoZzCwdi4aSiW0MroQm0JV+/3LrLUztFtQF9SNrd04Y/MW2
	FJpvc1Bg==
X-Received: by 2002:a17:90b:4ecd:b0:37f:9ce1:cdb0 with SMTP id 98e67ed59e1d1-37f9ce2229dmr7491033a91.30.1782737019084;
        Mon, 29 Jun 2026 05:43:39 -0700 (PDT)
X-Received: by 2002:a17:90b:4ecd:b0:37f:9ce1:cdb0 with SMTP id 98e67ed59e1d1-37f9ce2229dmr7491002a91.30.1782737018606;
        Mon, 29 Jun 2026 05:43:38 -0700 (PDT)
Received: from [10.133.33.246] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37eaff87f61sm5602580a91.17.2026.06.29.05.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 05:43:38 -0700 (PDT)
Message-ID: <f0ed588a-6cfb-4079-a2fe-7c14f1b42727@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 20:43:25 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] cpufreq: rcpufreq_dt: use vertical import style
To: Guru Das Srinagesh <linux@gurudas.dev>, Miguel Ojeda <ojeda@kernel.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
        Abdiel Janulgue <abdiel.janulgue@gmail.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andreas Hindborg
 <a.hindborg@kernel.org>,
        Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
        Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
        Alexandre Courbot
 <acourbot@nvidia.com>,
        =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
        Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>, driver-core@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, nova-gpu@lists.linux.dev,
        dri-devel@lists.freedesktop.org, zhongqiu.han@oss.qualcomm.com
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwNSBTYWx0ZWRfX6bkXt5ESz1xe
 brrcUVvXKsMlAtZxEAKRs9VSnGv7pXt73LdhCCUo4ecdyb5oAva8pk1XEGv3EREbzlwihQ4wVsf
 tUNKJvPekj/ULYjt1hhoA/zEEtu8mnU=
X-Proofpoint-ORIG-GUID: cruOO-jrtghbMXbWNETUnLsVmloP36uW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwNSBTYWx0ZWRfX2MI2fs2hIXVy
 A6+LtJUQHghxvhdwDZfCgHwNpXCE7oweO1f7h6nEVkqPzLJUKacOFqhk32RwNPD2bJwfLlyQSvx
 sL05w4vSMlTVHKDZhtpPtOuOxbyNa9au9+dTO9Io8d7YExYA2xVeoiBktv88D9luSk0xjmhFHag
 f391sWPCEtejxXhifpC4Isi1KUNwu82+5rPeaKYUcOiNNo6ydKcUOILDo72Hgo50Ci3goLgBdaF
 V/cux7miHoU0rZlghGVkauJ46AF5nxnYMz/o75OH2KrNp+fcPXK8KDtS9x40Fbh1cujKNXs/N7k
 C6R/dWAGYWpLV0CiuYka5unFlsaMJjGGX1wJ2cthaBF2IzIMzmrBjuw0J41G553jhXJwcSXvDKi
 O/90hDwmkWRg5RSrsaWBNNLoZmk6th83NKCm+H2ESjc4s/liUV/t44egr9ct7aUU/mGegstoaTv
 RX8RDB9UIju5EiXKiQQ==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a42687b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=ecjbvcZnrCEMvoAzKiMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: cruOO-jrtghbMXbWNETUnLsVmloP36uW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290105

On 6/29/2026 11:38 AM, Guru Das Srinagesh wrote:
> Convert `use` imports to vertical layout for better readability and
> maintainability.
> 
> Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
> ---
>   drivers/cpufreq/rcpufreq_dt.rs | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 

Hi Guru Das,

> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
> index 10106fa13095..6f83cf8955a6 100644
> --- a/drivers/cpufreq/rcpufreq_dt.rs
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> @@ -6,7 +6,10 @@
>       clk::Clk,
>       cpu, cpufreq,

The change seems reasonable according to the Rust coding guidelines:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/tree/Documentation/rust/coding-guidelines.rst#n44

     "each item goes into its own line, and braces are used as soon as
      there is more than one item in a list."

If the preferred style is to place each imported item on its own line,
shouldn't imports such as

     cpu, cpufreq,

be formatted similarly as well? Have you run: "make LLVM=1 rustfmtcheck" 
on this change?

>       cpumask::CpumaskVar,
> -    device::{Core, Device},
> +    device::{
> +        Core,
> +        Device, //
> +    },
>       error::code::*,
>       macros::vtable,
>       module_platform_driver, of, opp, platform,

Likewise?

> 


-- 
Thx and BRs,
Zhongqiu Han
