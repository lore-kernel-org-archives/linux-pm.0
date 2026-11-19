Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795083823;
	b=JCDxwclcC9BpcrFNSzQPzmiDPczt14T5f0LC/iLRT7hwvEf+oItKEpuNpij8hvmg/fqA
	 yKVgo5T1iebEWZsqpsXn9+crCl/CQpiYQjlo/lJ4q4znGN9Y7hGp/RLL4ND2T/4WMN5ou
	 YkPuVk/ROUlZjZnkuhhOBiVhRO03S6lyS61oD6s1CUsIelYP9/dIyXZKNlxwCyQWFRNNB
	 QYgIf8hqUuxgSwmM4QQDwOnjXKra3KNAB6cepWb7cQrfvHXcFHimpigmsFad6Axm5VvZX
	 mZHrCYwXGqDBgXXmnohz3o2A4r6NOZPAtI4hQqf9vDiraGRbCPggfGltfjbP14N6iyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083823;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Z9wzeMh9irMYC60fEm/+/11KvCaec7jakGgh6z+vDXw=;
	b=adHNHHrgV06PuSBekL0J83SrqPEqCIgrq5RlQQRqsFp5lMmVxuDUc+PQ8DS4Vmhkp0Ke
	 6WUWL+TCypeKNWHltIQQE+6hdOEkQ+bFLaipGgMX//bsHAPinocYDzwpMm/DS1Z7X4wxz
	 nVpuaL9kKMEGiTVXeQDUSSXBEwL7Onm/hxDZPS5BsDH+HnhdStVz13U8G+Ebl0ctLsDPi
	 Q7CpxbOKaxMNy4cmbUGlQwTFxkW9+wBwYQNLW8CLAeot4YOIrI55Qpq+JHmF5NcoagNaA
	 S3qRL5PyCWJ+J1Rx2pjX354od5TkNwyafZQICT+1Ahg5nXeQZdbkE/8dxvrcnPcr02w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=beZQtvH3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EjIlDMfX;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77521606A325
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 10:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77521606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=beZQtvH3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EjIlDMfX
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ9IM6n2514136
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 10:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z9wzeMh9irMYC60fEm/+/11KvCaec7jakGgh6z+vDXw=; b=beZQtvH3sJoaN870
	1xzUQgkcLknbaAM6tOw9AaP+i+/AHWFt0eLB26Y+hikYIKmpxqw1fBJzlFPJenWH
	m6rcZ0X2TQYbGQR6FIm4r7S2mnRPcL3n6hU8RLW8AVP9MjAniLH0S2uz8vZbQJHT
	7D/7pxDYih3AHmOQ/U3GebGVN1+5moN/mTQzCJzezYHG7eGU2WigiGZaNjnj0nWe
	alcdIunbDmplTRqz3JK9LM/Y01ZhVVFGX5WOfxRo+7/mnA3dSrG4NzuqzuOYMZYq
	JDSdSnIldwBY0L1IoB+0Xjh5CXyupWMbSotwRtMalPbdZ3do5PBBhtDQf2W6qkjG
	UE5Fwg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xc6r9e7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 10:23:41 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd652c0385bso1558920a12.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 02:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795083821; x=1795688621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z9wzeMh9irMYC60fEm/+/11KvCaec7jakGgh6z+vDXw=;
        b=EjIlDMfXBKyH435iO54N4RfcqpKVHmKXOsJWJOZ/UcIVAjRbC3g1rRRCF44E6fClVu
         Kopr5XVaHM9hKAblC+lju+Fy3c0YvFSpTyIP5yxwtWqcmGRYoFvnsXraRKXT1pmxluFy
         6wGDXopmndV137rkue0vGuk+0pMDmIPM3v43QA5YXkx/HxHOzWq0DNn4BAuYSaOA4Rja
         4g/c3DZt3kmC/nT6YLHGhdjvTX1rNjvM4CLDr+waoArcHdWJkYwBTIr7RUpHJN/GE8mR
         TndUpQ/2GUr+pMLKow7TntZ2X/N9RsixvTY+f2tXIMTsryO/F2EFtOSsT7qFNdSKjnvE
         5GiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795083821; x=1795688621;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z9wzeMh9irMYC60fEm/+/11KvCaec7jakGgh6z+vDXw=;
        b=EUcO5fGm7ve40kmmK83teWWQoVEiU8ou1+G6Roz0mnS3rudVCtN2PlX5qrdKsi2P/B
         i/diDO/GTO9H78ZQZB9soIX8usGXJP4q38uWlN3tXcGuf8D+wbURaZfc5QlGEO0wbw1a
         DWUqyVBbkoVAxAi87XUa/o3DEvHcaHCodMhn7PyNdpfUDpXT7FoH0L89CMuGEK+gDan+
         v7obOLDAd9dBZIh+C2T4vBhEx09TOmax+D3kW0KGhYpzgxwK/kcBNArM2W58oz1g26se
         iLDF/2GbNBNlQxfYZD6H0kcWZY0hfHHd4Pdm4IQybXauw1l7Iyq0HnrdmS1Bgh9giUxO
         Wadw==
X-Forwarded-Encrypted: i=1; AL+hErFYJ4eFajEE70iRcMg9jB2ZG4FT9vrhfdB322apE+ldrEVeP1vkpUEraa65Ju7xkqHZWgxRpUFb8w==@vger.kernel.org
X-Gm-Message-State: APuU4Z+N7hLhZpWwhFobzm3jBERsLx760eeqEv1a6fww9t2tZu0fmNdg
	9MXqhUArhFT6GsA3G/qQxtD3iSH9gLkhN5Hk5KeLEpDRwJnY9QshfsNX98fVKZbwAfQY0p6Nj7C
	oMHP6N3pzNOpIfVb36/uWRXOEmAi6O4orRe309TFAgVp05yGP8sZWb+/VNKmNvw==
X-Gm-Gg: AYBFou1qdxbQZ8L6vboMkM/Ee5hFtRKDYc9kmCkQes0HaPEvG9KCBWYCrLezq0LgoJn
	XiHCzD7JvyOB0wwCXKnx+mKwjVhxSCwM+HX/nn6A8pY55/xvvPVsMFFZuAfxB61pDtA+CUVF291
	wiXZySAPGf8epQTlSt6+15gTGx+DRCgAH3znLvUzS3IQti/wvfgjl5Cu9AOk+UBwZBfZFBQtaTd
	T3mnn6KX1viTFdCu3aUNa28ZTD6D5wMs8/zMrC09wQoOH/bCWFM2hYFYTkgLmww5uPls0/ssETu
	j9pC+o/FN9sKn95IZR/1G3HLjArjoNTNr3/pbKTX0vSexS4nSI2ln2nCsVjNVqFp0D3/5qFKCdR
	NQYTAPHqrHQVDkucmVJvd2B0I3XTG3J90SZPWPy4jb32UEIOSZ5j3oam9NjKMCvzHfMgiEvTSXp
	lrwINSVgPL2uWrjN2OD/2IlWUjARRcQfF6w/B+vg8vNA==
X-Received: by 2002:a05:6a20:2590:b0:3e2:2c81:bc6a with SMTP id adf61e73a8af0-3fe8a218d9cmr5626912637.47.1795083820934;
        Thu, 19 Nov 2026 02:23:40 -0800 (PST)
X-Received: by 2002:a05:6a20:2590:b0:3e2:2c81:bc6a with SMTP id adf61e73a8af0-3fe8a218d9cmr5626893637.47.1795083820409;
        Thu, 19 Nov 2026 02:23:40 -0800 (PST)
Received: from [10.133.33.68] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde5336844asm1476471a12.4.2026.11.19.02.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 02:23:40 -0800 (PST)
Message-ID: <03531283-aedf-47ca-ba19-6756819d7b14@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 18:23:35 +0800
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
Subject: Re: [PATCH v2 0/2] cpufreq: mediatek-hw: Fix initialization resource
 leaks
To: Haoxiang Li <haoxiang_li2024@163.com>, viresh.kumar@linaro.org,
        rafael@kernel.org
Cc: hector.yuan@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261119052811.2877720-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261119052811.2877720-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ef+o7LEH c=1 sm=1 tr=0 ts=6afece2d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=yEmRr5OKUZuCAoPvvFgA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0MSBTYWx0ZWRfX/jKUgu40eaa7
 qalRRxE8nn8BNYeRb6eY8rltEk88OLq5MsdJgp/hSXtH58vM2srXj0UfbNfBeiL+LKNDVcOojCr
 4GT4rk5kSxMXgoNMX+EFCXpeXffjHKP/NHvJktaLwebvMS+jTcW+Hx4+XgkOPzYHtyPQI3zCDyb
 Xo9Al4oDqr4k+juMckE8bB2ek3GPRgtOfYtgVfIyDs0pt2JmY5460Yc9637kYcEYr0GRGuHgtvP
 P/hxH+V4yBefFgnqkiFKm/gHzUKuRa0bsIlm9UdT1yMb+zMu4v1QAa3gcCfyA0SRIXIVU0sW16e
 V29s28TBUND63l6Ncj1QT9K49kz8bUtEN4uCQTgQ2RpylMN52yQtAD1/X8n0k+L+w3tk183QKu2
 ldd2+3wYPTEmtY148O9WM3vgjSlix81fTB2BIwLqR8kZLIbxh2nPG4Thm+SLVqlpiBIIta93Cap
 9/4RY8P44t7p70SBOCA==
X-Proofpoint-ORIG-GUID: IyonCQHKzWdnxdgR0SNbLgs_y1mQm4Cj
X-Proofpoint-GUID: IyonCQHKzWdnxdgR0SNbLgs_y1mQm4Cj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0MSBTYWx0ZWRfX88tAfcF5978g
 ERf0cxQHRtrQ5YTe0aJkq6hJL0su24N1yj8lDdbXvVRJ8mJdP0I0iWmnc6CXPKCw97HfIy4TXha
 JXOalzb95c6F5dnRZXRwkgqbRXmnki0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190041

On 11/19/2026 1:28 PM, Haoxiang Li wrote:
> This series fixes two resource cleanup omissions introduced by commit
> d776790a5536 ("cpufreq: mediatek-hw: Fix double devm_remap in hotplug case").
> 
> Patch 1 releases the resources when the CPUFreq hardware fails to become
> enabled.
> 
> Following Zhongqiu's suggestion during review, patch 2 handles the
> additional failure path where mtk_cpu_create_freq_table() fails after
> the registers have been mapped and the memory region requested.
> Thanks to Zhongqiu for pointing out this omission and suggesting a
> separate fix.
> 
> Changes in v2:
> - Keep the original hardware enable failure fix unchanged as patch 1.
> - Add patch 2 to clean up on frequency table creation failure, using
>    the same Fixes tag.

Thanks for the update.

Side note on 1/2: if a domain's HW never comes up, subsequent CPUs of
that domain (and every CPU of it on later hotplug/resume) no longer
fail fast with -EBUSY at request_mem_region() in
mtk_cpu_resources_init(); each of them now waits for the full 300 ms
timeout. That said, HW failing to come up is already a broken platform
state, so the extra delay may not need special handling, unless
someone else sees a reason to. The code itself looks good to me.

For the series:

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> 
> Haoxiang Li (2):
>    cpufreq: mediatek-hw: Release resources when hardware enable fails
>    cpufreq: mediatek-hw: Clean up on frequency table creation failure
> 
>   drivers/cpufreq/mediatek-cpufreq-hw.c | 31 ++++++++++++++++-----------
>   1 file changed, 18 insertions(+), 13 deletions(-)
> 
> 
> base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4


-- 
Thx and BRs,
Zhongqiu Han
