Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C123E3DAF
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497748; cv=none; b=jr9XBJG4z1teLwfuiiQt4uqz5too1DYIbNgMypk1FsriX4oLDeyXOrJbvd075lNreJ/LtfNQjjT4SRPeWfnVJ4Rsc39gbljG5eBn0pt5crSM8YEQ5gDvsgch4dr62YQN1aGUCF9c6dpxPObeCGECyOdc9gIR0HyJG2V5Q/FE90g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497748; c=relaxed/simple;
	bh=plfZ4FsucgnFmYB+WLfqiTzRuqQ1f/GHyVysSGWQv6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfubkOfcIfwxUPi4K8nA03y8Yi3s+cTvv1D72zYU+RTDZUa8mc5xk4aIYPcIlZ7UXtpvXIFjlH5YeO+uUl9Oq2LFxeIik4K3a/QMXQ8AvUKA9RankkiteuLOAg1qsRxmjpE2o0sYJEHCibmRj8xgekKZGLXXLlASG4ZHIoSA5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kxrN1WAD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SjyigWmW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kxrN1WAD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SjyigWmW"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBMFuI145710
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 11:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SntzIFPR+4FwE76k9egHNUQnO0nVT2pXTp/Kx+qC7ww=; b=kxrN1WADw9DCh02h
	SQ5T1fm+EggEMTO0j14VZTvKWSZnDbMroGMOUD7c7xWRPqbPFFyQ81tGnFoIQps2
	9Kx2MCNHisvGxAozCoWt8gcLsscBornjTPHFspVsU3oYOgJbS1rlrTL8aZNaznHQ
	Nky6SDLbN3YFUdT7DzyF4jMDBZoWRI9VgmrsFhL7Z8QsxnkLX5jI/yBK++NhDN/H
	0DyH0Iuw4a8UnAQDv71eSAEFWN6krXrotYlDRv66eDLXr6fd5Ss+CL959fks1Mah
	Rh0e1TaWWNpPaiwoU0vJnpoMiob2U0oHNNlHA7SwBzQLbQ1Mr+BVHanKQOpx1XD7
	NlSLLQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frt3t06y1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 11:35:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bfa45b280so1365121cf.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 04:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785497741; x=1786102541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SntzIFPR+4FwE76k9egHNUQnO0nVT2pXTp/Kx+qC7ww=;
        b=SjyigWmWGA5cFtSY1uZaf2AysLmzLSaGEBGx5qZtx8oZBlv96/QXdS+AzzkP+hh+Lp
         4SELrDpm0JjfUbavF9pvGWixLuiu1+1anemdD1gC/4OdgVvG/lpxpuavmBqoy29IUsxH
         Gxmvkb2JxNvY+8vta8wgM7v55BdzJ0nNcgvAlkG3jJZ58aNawLC/PCKeaWNskGL9GcO5
         mPj7YVTwFpgB1pM5qWQpsk6OB6vEWaGjvcHAWPsKyaSNZPXgjY6h5GVlXse0fjsB1ysy
         985y4go7UyDGnLT/4X56R+e30qx4vBXLeIpuhjX/jHF2Ry7FuUi9gralOxP44jbV08KT
         Iz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497741; x=1786102541;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SntzIFPR+4FwE76k9egHNUQnO0nVT2pXTp/Kx+qC7ww=;
        b=m2pUP42weejq79h3O2EFlacr71p443ymP8fxSqj5pmlRdnjth9jh4u3GI4KdysTC34
         GMhKitwZSgE0+OTfS2ZLZgQFy45/L2yAyLSKxjqx43OWpjcs8bD0KAEaag9HBvl/tIGs
         3WjDOtU779s8BfAe4VRgnx0xiIYxfST2JLzahD0b+xS4Up5F8aPYe7XTBez4j0G7uQ7k
         Y8Lfasp8HPSoLaDGDrybr26qRY8+Dik4ZBRYn5Tvn6oAxlgdfHyIEzx3+4TVPBB4oqtw
         nKhnXAyHxQeHg4R+F3LjWgyqD3m2s1xyAcZ1lE3vsZ1aDxM2Waq7nhP2QxzPYDZHTrDi
         GLWw==
X-Gm-Message-State: AOJu0YzO6nr9LOon31Y3DaVjmdArjVuZX+iNUgjw0AImhe7USC3YadHE
	XpAgy6lnOx9i0bB01eaEZQDTPhGdMTz6Poh7uw0eVfrqvWKdhh9rJxH2/rL88o3D3+lbD5vsQmg
	8kw/GzcxrZZpt9CVOhfCov5OqZvC3YEOGDhdVu7HgCv5JlUPQtJpx/uS4MAX0lw==
X-Gm-Gg: AR+sD13SmctmqHjAkT8ALtJ5M7Tdh61Xd/QPrmGEdt7gaYydTAt1w/oQIz+kTz5OAKf
	JMc+2eJKGu+nzmx2/Kjo07Hmk1/0yqnz4+hI2K5YGCSHAXxjfg9KXGZ4+JoQaUi6smgGGIlrcan
	Q9pw/9AzsC2Vx9F+nR+yJdB6GNCVvCW98SGWm80RNuZv5BBjP7psDeidgTdUGliv9YeSzw6jLhQ
	AHGFyq7W3h8nF2Hahmd6ow15qU0+UHyahbaJZnjsLQXKq8wPeLRMGBTfeXaucXRkZF/PoUsJdl7
	6TJmHNzDYUJ68coj2a3MTvwcDxvu/0CBujHNXQatTuDrVDk8VuHI1rd55qnIIG2Z8VoDVfv78qy
	DKpyOcUQTmQumEunqwO4vKbrG
X-Received: by 2002:a05:622a:6bd0:20b0:51c:2324:666 with SMTP id d75a77b69052e-52b4b164ab7mr15392151cf.3.1785497740976;
        Fri, 31 Jul 2026 04:35:40 -0700 (PDT)
X-Received: by 2002:a05:622a:6bd0:20b0:51c:2324:666 with SMTP id d75a77b69052e-52b4b164ab7mr15391851cf.3.1785497740570;
        Fri, 31 Jul 2026 04:35:40 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c664713sm1227143a12.30.2026.07.31.04.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 04:35:39 -0700 (PDT)
Message-ID: <c5a3a4e3-d78c-46ea-a638-2b6e37d7efbf@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 13:35:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: core: Wait for device link removals before
 dropping genpd->dev
To: jaseg <git@jaseg.de>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?=
 <linux@jaseg.de>,
        stable@vger.kernel.org
References: <20260731102147.127082-1-git@jaseg.de>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260731102147.127082-1-git@jaseg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dNKWXuZb c=1 sm=1 tr=0 ts=6a6c8892 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=LNI6Y7vA10jdH1asw2gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 3X9UaX_tTU672f7ERqdjs1pVXM73e-4W
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA4NyBTYWx0ZWRfX5ndBINPBxsje
 ih9kVi9DfoNzjiALlkY7pytCMeJlFc3LxOjsbr0ji/vNTK0iWsBnEYBK8OqndqiuqkjHuvELBAN
 wgLPyBuTyBH9r0CP00gygn/qGUply1M=
X-Proofpoint-ORIG-GUID: 3X9UaX_tTU672f7ERqdjs1pVXM73e-4W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA4NyBTYWx0ZWRfXwYmln1BpuoIA
 CNMbEou2RWVDp696mOWYjFOoVST1jB24KIXIXIVSLKITCbNDK9OipmgdcED0xmUkznxFBUVl8su
 N01N5hz+eeCoo7YlcO0Pz3rc6aRBsMSjoZWaw+ymtoos3819Yi9blkxpGA/zVd25tgIlC3iWjAO
 wDIsvsEQ7kCZREcKxXPJ0yDdi2/BokLsubVzctsoT4cLOgFkDvOmoxgiH3egNDExqw8dWvGztAf
 DBeqKm3ha5XG+/oDb1ZbIp/mDRMly5Ao/X6G6MtewVzfhz28mLFGF6fZfB4KDJpekv8RtWdAovq
 z9YDzr5rveFQH1wsrjNlXZ0MP2nMTKBijlMM7ncwfWfb3qDg22Hxq6Vry681nb1ftaClkrDMMvt
 D/pVAbIrlZFXxbHFTPycNBVH/c+tSGIdSKng/Ge2BhJiCT82eksuHB3OcTkCqKEMHIeiVpYMCpJ
 qenE9q+atzcLUqlqKzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310087

On 7/31/26 12:21 PM, jaseg wrote:
> From: Jan Sebastian Götte <linux@jaseg.de>
> 
> genpd->dev is embedded in struct generic_pm_domain and its release
> function is empty, so providers free the containing genpd with a plain
> kfree() once of_genpd_remove_last() returns, ignoring its refcount.
> 
> Since genpd->dev is registered on the genpd provider bus, fw_devlink
> creates device links to it, and those are torn down asynchronously.
> Nothing made genpd_remove() wait for those teardowns, so the provider
> could free the memory backing genpd->dev while the queued workers still
> used it.
> 
> This is reachable at boot on qrb2210, where the firmware rejects PC mode
> and psci_cpuidle_domain_probe() removes all the CPU PM domains before
> returning -EPROBE_DEFER. The bug is asymptomatic on defconfig, but shows
> up when enabling KASAN or INIT_ON_FREE_DEFAULT_ON. In some builds, it
> causes the kernel to crash a few hundred ms into the boot.
> 
> Call device_link_wait_removal() before dropping the final reference. All
> link removal work is queued from device_del(), via
> device_links_driver_cleanup() and device_links_purge(), which precedes
> genpd_free_data(), and flush_workqueue() waits for it to complete.
> 
> Note: This patch was LLM-assisted. I reproduced the issue and tested
> this patch on hardware, and I did my best to verify it by hand. However,
> I'm far from an expert in pmdomain, so YMMV.

Thanks for the submission!

I'm not an expert in pmdomain either, but it seems to make sense


For future contributions, it's best to keep things that you wouldn't
necessarily want to preserve in the git log under the --- line (so that
it still shows up in the patch but it's removed during `git am`)

Also, your sender identity doesn't match the patch author (i.e. your
full name shows up in the From: header of the patch but not in the
email), but that's just cosmetic

Konrad
