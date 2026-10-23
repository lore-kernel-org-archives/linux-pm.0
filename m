Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763761;
	b=pvYZxQuQKymbzVmWwfgfXdgRz1axcFJs1Jir/AE0qp0sGM2BhQpnvhhoixhLR2hgbg4H
	 OV8h6OHc00gMpigjdrHVYOywkPShR9MFI5E1aF03WPS7ZEUdROyv7SDQg34OYchA5yC8M
	 EolkdG7lAY0any6uCn5fMqh2fEW7Oo/5tXA1nh60kgnFx01wOxS69jBXc/sFso/UtJ7Ct
	 twLSXonYJ9vAFyC2ke1715+FBteqkNT+OCgVmTi8RaSfzfeyNyOd7ZRXrfd1yW3ky9ICf
	 RDqccQyOE1/iiflGBCkdpbh1u5WN//F1Hze7Y3R3MViMNaWADqeNamXMwrg7lNZzv2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763761;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=UnZpFa86nCr1M8BImjz0Hpmt+fGiTnpfeQhENkxH/VE=;
	b=W1AGKpcrdzoKULIMt9IqLv2szcj2iT8/JYPpMEANngvQSieJ6+Ub0CkYt3DY71CTtnR6
	 FB49glJL/3Vqm3GFph9j6zA8f6Jp/InZxs7gYqo/tKQtcH9OQNaptdByqwuNwRxJMJWiA
	 /teyHOv3d6nGZz6CjYwdip+3XVcrRAtdKGU3Bva5a5U2bHR+M0cpxf7ewhJ6rlyeBJwQP
	 MKg3tzXHxdjkGaOJDHddJhRaC54sZuXPCYMw9f46f9fsxcfzobdaykfvdXPpDvTyRtfu1
	 xj2w1JeUvykQiFvoWw4eNTzXEyHb7LWWiwRqBPAo1i6PmSiR0xYomXwQbqE4FtNz47g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="e/Q4b6cz";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RcUAb8gL;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A57C606A31B
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 13:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A57C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e/Q4b6cz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RcUAb8gL
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAAEKT1597339
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 13:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UnZpFa86nCr1M8BImjz0Hpmt+fGiTnpfeQhENkxH/VE=; b=e/Q4b6cz/nvqDd1w
	fjCXcfgSF2EKGM5S6UwZ/dvsgoxzrLr5klVFwHaVKMRrDEBgiwYJyf5h7lZOtowv
	EWA6ggYc51bkhDA7FOf6vnyZ+KXicl9MX2dSwtMHzGDTryM1LGs7/0Lp1HNhIaot
	DAwW5BDR+3GA5psh66MD4/imdtqZVrBNMzSo/PtcEM0kOEXtAsmwCy1hRhMrDNB1
	6EDgfogK4ND4h2ERoId3VQJk2KQCV7RQXmFqceSoQRsMIWbsDwgATJGX5jv6jKnq
	annILs4IVhU8K/l6rEFsdmxkvlvf+vviprfj1F3s4mqP6+v2WKG5RLERLG4YoWNZ
	kppO4w==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms3xh4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 13:55:59 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7cc450e6e1aso46098137.2
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 06:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792763759; x=1793368559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UnZpFa86nCr1M8BImjz0Hpmt+fGiTnpfeQhENkxH/VE=;
        b=RcUAb8gLAo/DVE6kwyP48U6JXZTmQNaqtJSIe4yyyjbwI+cao+Jq2VpA2xHEOEMMUG
         oh2cC9iG5Gx1tuiyGj45TeXP1yU4hA0lxmthWKnFpHk82ZTUil+6CWuKYXylV9E8+Wny
         zjSckd26nSLjeCLfnBQmau42/2ojD5sA3LmqXsHdWfcPgBN1x/lyuPLG68f/fYlZfPUW
         RSbvl2bP5w7X5SDArmisuJBhEiwoJl2yGYrHl3xMoRlNkS2i3sAmgephuxh7VoIb7tT9
         9uRv5W6RkQ+VFCOWuVs/dX9W+Noar4IBHlyxHfU2Bz3q5IfpxlrioqBjGtKlsAkqpp5J
         3mOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792763759; x=1793368559;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UnZpFa86nCr1M8BImjz0Hpmt+fGiTnpfeQhENkxH/VE=;
        b=mU7qr8DzNHDY9nivDAgezWJ51HSHwZxpaLptWOSFhsp91oKbsVxDugaYXG5RWw9CPn
         yzA2lQ8NyYuM5pxVBIANTPawdvNZ6YzapbJLe/GkOtz1dx/Skt64SMX9f6BBU8IWJ+yn
         8tUOSplP1CwQgQi7iwV2qUOEfvLg7DY+7qJxspnrSG9pqtzVY4JpUoQHDjMHvA2Sw2Fm
         Hbr3m+1IcSTDXGCrKPVVrxq6dnedMRL2eqEWPhH5W9r2F2IZwTTt7DC796Y7yOOPpFq8
         Y5yhONSqc0OBm6dLM1zHUOCzVV6Y24bDMR2Ur0WWyNwGRpOC5KpdU0SSErmAdm2TsDyr
         t94g==
X-Gm-Message-State: AFq9FYKNrUsccEBTEBDL8mSLaTgi1hmWaUMY+Tch2yh2m7S02SfCfSRh
	XjuLpzTqAZlgV2ZrgkQGs/k77vPybAyrFc4LoPuUz25ctwTR9xQMAK2eol9+zcit0gQP9NNA+c9
	wIsoR68NMKUKPnKXALFaDgqUNCkl83wGil+1PgHBmgJk+P2c456nefTzpdRmePQ==
X-Gm-Gg: AYBFou3uk4gn2uB2eaagz6oZuxrnKkRw0AxeWWNMiHQx8z9kv/lF/0lS9VnI3rg3b2z
	d8xtS+Xc4iS5NPLAC0HyCdlefyrttVgI+PaFLL+1F4ofzz7bFfEC/ez4pMrc0XtvoV+yMDcobzM
	7G8e0gOMdoTyvNVZ4NFiYo259sHyAduioF5V7GNlDdbYahRsVq2uKW0uQlrZjkK9wxAmH7Rc5Yz
	GLEV8v4ILQTQ1CvYz8eIjlGS6onTWy0h+Wj1YOuzCnV6aQ6VFEm32SwVmzEI5lUKHzyCV587FIF
	vmo2Qoc61RaNxIm2N2emqYOFvO3816mUmkheKA02H4m5xnomVEofACoKz9U7X+w6DkiMsv8Wnr/
	QoSuS+QZRQR+yvuzHLCylUg==
X-Received: by 2002:a05:6102:30d1:10b0:7cc:174b:f7ca with SMTP id ada2fe7eead31-7ccc2d92dedmr890639137.0.1792763758731;
        Fri, 23 Oct 2026 06:55:58 -0700 (PDT)
X-Received: by 2002:a05:6102:30d1:10b0:7cc:174b:f7ca with SMTP id ada2fe7eead31-7ccc2d92dedmr890631137.0.1792763758271;
        Fri, 23 Oct 2026 06:55:58 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b432c01274sm1156244a12.4.2026.10.23.06.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 06:55:56 -0700 (PDT)
Message-ID: <625f7af0-5977-41e3-a76d-fde8f998ed97@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 15:55:55 +0200
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: qcom_battmgr: do not report power_now on
 SM8750
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: linux-pm@vger.kernel.org, sre@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261013002124.332111-1-xiaqinghuan@mail.ustc.edu.cn>
 <5bf3636d-be7a-4800-9914-808d2fc5ebd9@oss.qualcomm.com>
 <179259054168.209323.8102186130128474174@mail.ustc.edu.cn>
 <52fc4222-508d-4acf-b38a-7b4e5aeff3cb@oss.qualcomm.com>
 <179274197125.1374502.18211548118625978753@mail.ustc.edu.cn>
 <63cf18bc-5c89-4a55-aa15-2550dc47c155@oss.qualcomm.com>
 <179276336012.97124.9436748752781883311@mail.ustc.edu.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <179276336012.97124.9436748752781883311@mail.ustc.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1NCBTYWx0ZWRfX68vS5Wu4nvDm
 owUC++dz4Mjxu9Vhj3+X/VNKnyBlIMM5n5HvMP/MpqyGcOpTKCSWP95k5bBy+B8W9jrTjyR21cz
 y9mkkmCl+gVUiTbWF+zCWys8z3ixVAA0Uvi/sow+I4xZL3P75mJsMkd9LmvJbqXFi6NVM7nRvl/
 J4RxzAwnWbBKzJrjn9txWlESFI+6Qp/jqR+JrAwfIggGemy6aLVzccJB5vJDFkTjUBtX0ibV5qS
 lrA3D3wVLclM1KTEnhd07pPwhOQ36NbaVlFaq2wpWHPr6euRs6x0x7mTuMuRnw9bpHHkQIdHXqA
 FvFIWVz8h+BSkx5IvocsMiUvXeDdSaSpZzrcxhgwNEKIr0aSFdooym5aw1XxLPb47z/vYI2WYC3
 37NB+LXjsH5t4+jCeqFi+4unmJlVOfR9wnK/sEmd54JsMkXPG0jLFFFI2qbQEdw/v484wHdrGva
 KoPtm/6O8lfpT43x4qw==
X-Proofpoint-GUID: nRkhp5p_55AAh75Q4TJsLdglqmTw0C8f
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1NCBTYWx0ZWRfX5qHWel+7bnhZ
 mpmuvB08t4+SNcVESjBiHKxAZfOR8FWA5TJ2saqs5Zd4VTn4FvqiykLNt9I7pN90Agola3HTJK8
 ywJBQ13YO3zscAI3ggwu16ZzFkaIs9Q=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adb676f cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=IP5-ssDr8azhespfttEA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: nRkhp5p_55AAh75Q4TJsLdglqmTw0C8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230054

On 10/23/26 3:49 PM, Qianhui Xu wrote:
> Hi Konrad,
> 
>> Did you try reaching out to the vendor?
> 
> No, and I want to be precise about why rather than hand-wave it:
> 
>   - This tablet (Lenovo Legion Y700 Gen4, TB322FC) has no vendor channel for
>     kernel sources. The public support surface is consumer warranty, not
>     engineering. We are an independent bring-up, not a customer of theirs.
>   - I also asked the person who is upstreaming the mainline DT for this same
>     board (separate thread, private) whether a downstream tree exists publicly.
>     There are partial downstream trees for sibling Lenovo tablets, but none that
>     covers this unit's QBG/battery path.
> 
> So "ask the vendor" is not available to us. What I could do instead, I did:
> boot the unit's own stock Android and compare it against mainline on the same
> battery.

I know you're independent. Vendors generally have an obligation to
release GPL2 source code and have channels to request it. Calling
customer support will probably get you nowhere though, as it's not
the correct place.

Konrad
