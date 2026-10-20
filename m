Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792472650;
	b=DC+1zGwOfEECRlXjWZyg1BmScu0XXa75El0YHlbppUk2onrLHNYolSFGq6oqlAQSfire
	 DLs78t78B4L+fX/wMNLtLu4hUmUHvXpjroibU7SZG0T98UW9l6+S9nYUK24tMe+fkdlY5
	 QQu428Bd3IrZDNHs/mdP4CZLytPczBnOZ0UcB6br06Th+qErMGwOfZ+E/JWm7cs2eJi9+
	 4aahba01sS+9x4l2G24csLj6XmxRdlH95QhOt8TQaRi3j8yQVVKZ6Qa1s58i8mw6QoDCP
	 PfoFYkAqPfJNeKfflQyWQY03c8WkfELIYzRYuaIl69UazcU9BCbsLQpFNZiWjlvUx5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792472650;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=G5s338SO16XbpkdtMWpSdxzibIoHZLZutVSoQ9ZJFPQ=;
	b=YtRLHUNMjDtP2Z7AJwevEbQxeCV+fjamFO1kH48mf8r6oc5iw+3gEw9etbEe15ZgJdEe
	 zpGDmePSpG+aQ4qkpA7AiQbUGWvU9AjEdRLyd9WDek3FZY8PhZyZvoiLKlMZ+xFfnQSW0
	 teJK4vR/lx18G7BWKfme49u9varOWt/AU7SnYl42Gk0SjJfU0MgjglB44MLTyWHUMHsDZ
	 GTkX/dCFivN3F7VyUmtZcwEgxW8hK8BfMkhXGEwxmXxnOKrPt+qBWO0n0o00IW0JXM9hf
	 3SAq8xdjDpI/hGqBl82BVag/DAeDW1bXAAdmKPk0UJMYmd4EMYs4ajiSlxLaoRFraIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=drIpf4Wl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fWCdaXc4;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C2F606A321
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 05:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61C2F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=drIpf4Wl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fWCdaXc4
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K513tE666488
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 05:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G5s338SO16XbpkdtMWpSdxzibIoHZLZutVSoQ9ZJFPQ=; b=drIpf4WlXDGBT4gA
	mAh124NETYBhVg4Y1qRERE9CD4eTAMbt8lp5FVckVh9EQaSJYdaI4rV2HStJ+7yi
	lwyB3CYBMH+7xcFfdzQxJxwSVsZkJ3w/dwi66TUV9jJqaHhihssbfZY20lGtFWUz
	KZeQillWeqD5a5rQrrvNzsdJKGLGMuQgVlWvpdaAVu0sKwQgdx0do+PLvbiGAFGV
	ix/Agcz9PszTJf4zwHK7y3FEd8D7SgKgb7GBbdjrtGRQj2lbXSVEhzqW3bJUFa3N
	nLigHzQ0AijjEPWIsWV2LOFuFQk58ZiAmR/wgzQh7scHgZGrtC47Pj0cnifZ9scs
	8lbUSA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n0x5q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 05:04:08 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4ac5feaa4so1622531a12.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 22:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792472648; x=1793077448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G5s338SO16XbpkdtMWpSdxzibIoHZLZutVSoQ9ZJFPQ=;
        b=fWCdaXc4i1vsjdaMBuJdA37yx5QiDOw4KERamGTI7FjBAo0YtHAPneCNCAnGJ4G3Rd
         3iWgUY5UNiuEkP4PSDVC3+m0Zr+vp3e//cvaxthjgosIlgY+/mYyChVJA8LIfG85LOGT
         /UAvVrVHOClA+CpWQqXcojYIgKXFwGeVN5oVM2MZWTl42qWIWQgnU2MzUvzsKe51xY/G
         edLIquUx710Wf7yv2Wpqm/YLXzjaXgesSCreN6p4MePVR0RYYiZjpZyXz3J8OGUXSSwb
         86M39ch4+Lv0mN4KHJN+QDQkW0kqvS34iSQj5g6AobaLPC5rUHXG4F/91vYPxaa7T3Rt
         3+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792472648; x=1793077448;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G5s338SO16XbpkdtMWpSdxzibIoHZLZutVSoQ9ZJFPQ=;
        b=YmgeBnizaiRmDtnN9elVYngZBZrbUAvTd6AgxZiLV9uiUAh1DoFFHJn/wIzRA1tPPJ
         gx1/hbXe72KDjijlDpenW0IHelxKmBd65vviCU84qcKBQ03s+HzJGpiReURbYFFwwScW
         7MtUXhuQhooIdUk3a13Ky1G7/eJN3aVI5slVV9HPeDD45XpFE994RcX7Q2/hq47Azan4
         xb2//vFYZJ0yd1E1WFwvnGOvXHyMaQ/SrocXR4R52lupqWqp+5rKMzPMHDI7ODPh51Gn
         RPOl2aXfOBZERxIeb0ZfzvIuhgp3m2i3WtBwfnHw4G14Yemypnmf+rDqPDdtEcqqOu6S
         qK/g==
X-Gm-Message-State: AFq9FYJc7u9g7QDeYer33RCxi/0bHotNC/g2SbYBT5CcnUvkq6f10/dU
	OL2bwX4IVULyOk/kMqQJHNzCwD2ZFeZw9OVhyNv2VwbQv+DFcoZS/BgmCxO4L0kNlgeveVZhltj
	h9YVn0Ydtdxn6R964vYT51iUgolN3a7P7oy1BcX8tKW7v6S+axDvmJe4EDEOk9g==
X-Gm-Gg: AYBFou0bYf7Cs59Mw4GlM1JK5U1AqvuLlLSaCTZhq0mWQ7ekEmKrjSICMKNXKjk71Wl
	Hb2oKXWDjgbl+wQAKTqzw9GmDRGjnHrJRF8/GOJAthWBnRhXfAWUL6pwCfhSIOlUXZdit9CjRrg
	+Gr+CNRn0T5Q5ZzSc06djcXUDMV1qGlaBsMBYA4+zJkFnMwV3/+AsNK8cYh4JnwZeyrXZuC+nmG
	zudosxiLz35c4a1q/YqZ+azXTjS8ur5GGxyhZyl/8KM8VMR7vZCgaoOEqPcC8/i6e4mfXC4z2r3
	vykzDZYGE7nwKuqroa6oA+w/PzxqQSSptoZEsmIp0zOh9wNfpq5gwE+RAc6/sfKs7CiRgWLAEWc
	b6icCDAd1IUVAF3S1cLT+6eS79DcujTFDmCwMK6RSy84KuDrgFzr2O+hiwxvxHryfV4TsDVA=
X-Received: by 2002:a05:6a21:b89:b0:3e1:29b:bb35 with SMTP id adf61e73a8af0-3e2260dacb7mr6998465637.88.1792472647526;
        Mon, 19 Oct 2026 22:04:07 -0700 (PDT)
X-Received: by 2002:a05:6a21:b89:b0:3e1:29b:bb35 with SMTP id adf61e73a8af0-3e2260dacb7mr6998415637.88.1792472646111;
        Mon, 19 Oct 2026 22:04:06 -0700 (PDT)
Received: from [10.133.33.81] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a05e2e9c4dsm2257653b3a.19.2026.10.19.22.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 22:04:05 -0700 (PDT)
Message-ID: <0f38aae3-7e14-45cf-81c4-7647e96722c7@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 13:04:02 +0800
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
Subject: Re: [PATCH] cpufreq: longrun: fix kernel-doc warning
To: Manuel Ebner <manuelebnerli@mailbox.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20261019182946.1450406-2-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261019182946.1450406-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6fxDlN_CCaMRbGIpwszuVbxIJB0Tfbqj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAxOSBTYWx0ZWRfXzly5J01m+CeV
 pGFGiz/kqwHfo66r1uLhFxxOQeJRhzkF2/t57tE76pPxrXuOkuF6ZDRXsZcaT9HldZXR/r6eql+
 8V+wbKEzLsULWJyf9hJcBe6+exelTm0=
X-Proofpoint-ORIG-GUID: 6fxDlN_CCaMRbGIpwszuVbxIJB0Tfbqj
X-Authority-Analysis: v=2.4 cv=A5z5rKWG c=1 sm=1 tr=0 ts=6ad6f648 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=b3CbU_ItAAAA:8 a=4doGTLPSjtl--4LUb4sA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAxOSBTYWx0ZWRfXz2a9W5/Q5q7f
 4RWhH8pqt66imlmTnsosEHrsXO/pC6STv7W6hhg+I4SJq7+NDxfP7jmpsTEieLKGaQK+e2220Ui
 8rViRRmG8V3veST52miKTmNcX1vIINyCJegRFfOW1mnAMk685aAEBNSh+9K5YAhQSI7Yb3s9qeJ
 4PF8vYT3gxImheo6gp/BkyQhS/+5vvW83FlWWmoPPAq9g3KIBfpSDY1wJVHg9Lm6qTqPUgnkX86
 jkSHYGdJQiPLTkIaMqElddtYXHaE7joPyFffCOLeaywSmbhp3hLbtDbU7vq+3hz1sijeQM+NFys
 aptQm7viypkZLa5qOXPO67wJxnhTItAjApJ0Mk/PvE9rPU2ZBYMFGRk3IUgM3u29T1jhSEbxl93
 GngvwKkzxK6jTOk1rFYUMy/2DDCulfuid9Eabvf/+qPnAnlJYp51zVOTcPVFxG5xtvhIp8ddrqE
 W0MLIM9j8ooN7donIvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200019

Hi Manuel,

On 10/20/2026 2:29 AM, Manuel Ebner wrote:
> Replace kernel-doc comment with normal multi-line comment thereby fixing:
> 
>    $ ./scripts/kernel-doc -none drivers/cpufreq/longrun.c
>    Warning: drivers/cpufreq/longrun.c:21 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
>     * longrun_{low,high}_freq is needed for the conversion of cpufreq kHz
> 
> Suggested by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

The tag should be Suggested-by (hyphen), with that fixed,

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   drivers/cpufreq/longrun.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/longrun.c b/drivers/cpufreq/longrun.c
> index 7d4146d6c..c1df9014a 100644
> --- a/drivers/cpufreq/longrun.c
> +++ b/drivers/cpufreq/longrun.c
> @@ -18,7 +18,7 @@
>   
>   static struct cpufreq_driver	longrun_driver;
>   
> -/**
> +/*
>    * longrun_{low,high}_freq is needed for the conversion of cpufreq kHz
>    * values into per cent values. In TMTA microcode, the following is valid:
>    * performance_pctg = (current_freq - low_freq)/(high_freq - low_freq)


-- 
Thx and BRs,
Zhongqiu Han
