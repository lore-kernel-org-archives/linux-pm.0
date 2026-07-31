Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623C23DB303
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785499819; cv=none; b=g/+bcwamvLE/raPIHvUiUdDikYX311WGLFzj73MOc1m0755k9fpVwF4fDxe3J+nuI8EC+1dcBKrYPUT4gJfPb4SZQ2C7RTDF3LwbvKq6q4MMOed4vz3Jvhmo1QI2rvzVobxTZ+4i80vUeLuMl+FUIMjftPKDt/phOQDmPSP+wDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785499819; c=relaxed/simple;
	bh=7IWuEAa4jVDxyVRKrGSgG380LLSvUEDOpJ6jQFElz7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMm7wmyzbPfPmgL7kCanMh5O5uJtSSYYwq/LkQlvAXJExL6Lr+tD48F3PbOJ0LfHzFd4ZF8pu5nY8Dc9XaQhBDtWjHZW1bkbY/83D659ioIFCplhy/vmRxLNPneRZFH4PhHr4OK5F6nnyMQhZ8CeWUYQGpFGxhHJ0MKk0xoX58I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g9uS/lmB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cezhneEC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g9uS/lmB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cezhneEC"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBmB453905284
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 12:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KUM9tyOn7WaoLPUkUexhSBTqWwN8KFe+SDzVjpGtgug=; b=g9uS/lmBIGK12A2Y
	5ilVEZvFAAdBHqubtd3cq3HkGWzDaJi763PXQXrAMB62FCHBFUYepAQpHETTvbV0
	aVJGRyMHvGYdHfT9+gRMNfuGvnAyDDjbfYZvSbr0DkESTzV9fQyN7ZW+6Xa5iXTe
	vGQLP3L+cU1+zPmXg6xDGFkwimDgLbrHuA0ilOlUJJ5n0d/xBBu7XrM0q4ed/uC2
	3SfTxY0m4oxK9EqN88jZuGVaJOM69QJ6tZndQRyPHCQp2Gs2JtHpBEUu/WjsXcpi
	Yl0t5CjLSF/Xx2fNskvfN/NfJZRVEW+t4+FDNjzTtNWeTVDN1v5bwl5Kgj5qkllb
	i96emg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru5dg2v3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 12:10:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c21c01cf3so15697831cf.2
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785499816; x=1786104616; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KUM9tyOn7WaoLPUkUexhSBTqWwN8KFe+SDzVjpGtgug=;
        b=cezhneECbQx3kZV0jWivYzujplQs0KLADMAGhDvjjNc/Wd9QclGRCqtEew/S7Iw1hy
         y/IDWzvSUyheGKHyEjnpD5biM3BHykgD29KRncVvvZlYaeEUM7JZxHyocKoC9qiZXMWf
         5dR3QQy0qluQFeMSUXrwrmS+wbPvnwaEb9sejCD2I8pNyezfD5dJRAK7/XAYGVIxo6t+
         +X+RNZx/ybtDuBTWTy74PzGLtqLhTKaNO6WSyZdTXc0HJatW5PUPlKQQhO5mduakNIxz
         DUKw2BIOj+gG/wcEW930OHbxLoc5TkcXl0dPzz6ik4RWR31q51sl4DxCJqA2mG+dQTeU
         dTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785499816; x=1786104616;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KUM9tyOn7WaoLPUkUexhSBTqWwN8KFe+SDzVjpGtgug=;
        b=UeUidDFXSSzJ2lz+BmUuqgtyyynQGL8Nw7HOGuzfz/TdlGc/SbOa8JVcP6GOdCSfAJ
         cbjSJb5bKxabaq3hfv2h3O3EtOY3i9CYn2hPAoE0Y+OEek8kyvjePLqd34HoTxmdaXvd
         AqIkHxUpmASwPV7dnbNHND0X2GcgE33AL6G+TTw6vqBHJg8On3IuCcz01m7JnwmMgHNH
         Z2zwGAm02onf3Y5UXU8KkVMkMYpiUTaScg6TNe1216yODBqkKsxrxMofqZ2UtcSW4QH8
         349N8jN6Hwi8MUfBOFxetbjvggqvnpzqCcjzDG6teK3SCfUKN6O3OT3zmwcg1sj63zPC
         fhPg==
X-Forwarded-Encrypted: i=1; AHgh+RpPBbz1IgALmSTBfYqTiaeMWubdHJ2r4Jcx7NGEtXz+s17grTBlDM80KwMEKX0THnVHv7sKq5prag==@vger.kernel.org
X-Gm-Message-State: AOJu0YyR/RN34T1YBWRN7uuBR+VR7jCij6nZ5SzC2EvYUSbkRFoSOA8O
	Ok/hdx85fn1MxlxadGwJb2Xt9zt3SJfjG/eyH+t2fB2boTsyuMmdIwsWBDbCJPFUXhvgdZeL9kI
	KaNsE1Dx987UQn+kzZQgFSzM/fChyBlZoiU5+vxenCIPcogr4lR7SzzLztF3alg==
X-Gm-Gg: AR+sD13UdxXLhiQ6rUqUC+kbmZzimO4Q0oBQ/9qtjuU+GuE0c1pHan8IVCX0r/d5ksj
	pGz2yAQSU7s0VlUfPG68iR7R3xHN5c0sP/KxH8x0FQoLxujQEcf5yuhsq0uoBxj3DRnGROEfbBH
	oyGjXdN8JjqLmqUW9EPTmz6GH1h2eUYJbq7Bju+dAWhdUeKWAbNpfm55YuAs7xH8BQxao2OrYtp
	lxvl3+ka7KsZwrUOaZ5ucOCNsHxWnjCWFIepxqvxEcvm6bU9lHVhvASROmtGkf/M9s2rhdAJBdX
	izLFQL8b+p2WP724U1xiSDGZR26Lw/98tONEJ5HkG7Tc2Nic71e2yXmBR5WtMNLXaraRKEVh7cR
	KW/HOZ6dNcj7AKMQ=
X-Received: by 2002:ac8:5845:0:b0:51a:329:e802 with SMTP id d75a77b69052e-52b4b0fc268mr22999001cf.41.1785499816001;
        Fri, 31 Jul 2026 05:10:16 -0700 (PDT)
X-Received: by 2002:ac8:5845:0:b0:51a:329:e802 with SMTP id d75a77b69052e-52b4b0fc268mr22998181cf.41.1785499815368;
        Fri, 31 Jul 2026 05:10:15 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.163.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458b73asm3599966f8f.29.2026.07.31.05.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 05:10:13 -0700 (PDT)
Date: Fri, 31 Jul 2026 15:10:11 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: jaseg <git@jaseg.de>
Cc: Ulf Hansson <ulfh@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Jan Sebastian =?utf-8?B?R8O2dHRl?= <linux@jaseg.de>,
        stable@vger.kernel.org
Subject: Re: [PATCH] pmdomain: core: Wait for device link removals before
 dropping genpd->dev
Message-ID: <ivkwuomer5vsajf2lq6otpgxwqljkwooh3p7e5ne23j37pv22t@iluamo6gxmq3>
References: <20260731102147.127082-1-git@jaseg.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731102147.127082-1-git@jaseg.de>
X-Proofpoint-ORIG-GUID: qUrla3bvr5OcpKIycssDayUa7gaTwZq_
X-Proofpoint-GUID: qUrla3bvr5OcpKIycssDayUa7gaTwZq_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5MiBTYWx0ZWRfX5/oRgNq2B5cT
 5M4r0rdTDB3J0/ZmojHCqPhUqQ8xREWw9SYw4NKLNceN22e61pN43i7AhTJdmL9H7EVfukSwDUF
 3bSTHNpNWbbfxtc5PqpNyR1VOv7DNFc1FGSSxgE0LgY3fq38+WwavZ2J3oV9TZfDekQXYjaREgo
 Eu6H9Vy/Nk6ghUWCGK01BABM1IhgxYksYmFZSmunoLTcE6JfAHX+rlNmviKq7ewUgK+qTnmJ0xy
 56S40zqb5OFhHQKDQzUYYeT78+eBrXnMhJ3L4nq1cXRn8b5NQrbiTXPDpwtX5bDD1os8WIsurTC
 2vCfEDH2aKwAKPFVFNXwcWINquXgpOdyl97Edbjp+X+Z8w/oDmbmvw12qBw1ZWE9/FUG1eYhChR
 7SIk18sXVrixgg+c32HWqDP5R08w0s1ywnztCnjLbwWzDHApq3cIZKC4Xc0HRUH+ynzOxqTWOs5
 IKzs/Qxz2E8vNzhaEZQ==
X-Authority-Analysis: v=2.4 cv=SKZykuvH c=1 sm=1 tr=0 ts=6a6c90a9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=6dw9+iwJWV8PcCi9M4lOBg==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=LNI6Y7vA10jdH1asw2gA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5MiBTYWx0ZWRfX4hvKSUD9yM33
 Dmcv0jxdWKNQNRBw6WFbjfnXPc99BXKpYGsjQUoWQTU/FREZn9w3PO0L0VB5QXrCb5Ldi16QToR
 0eg8hRmJah4FBEqcSA1RK4l5SMq03c4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310092

On 26-07-31 12:21:47, jaseg wrote:
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
> 
> Assisted-by: Claude:claude-5-opus
> Fixes: 18a3a510ecfd ("pmdomain: core: Add the genpd->dev to the genpd provider bus")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>

Konrad beat me to it. But if you drop the last paragraph from commit
message, I think the rest looks OK, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
