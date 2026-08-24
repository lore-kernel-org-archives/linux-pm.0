Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814DE36B924
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787556936; cv=none; b=O6Ooozfy2X9K6PuPlSUjJdbsNoiSjxSnJYQppHCksvYJR8vcpkYsr6OkogIiY4eBF0oa4cyS5ZNw93uOPcYmWrO1qoS+M1A2KmxRukmKULBbj4I8yHOdO2ALuNxRYerei4omt3/mMYiMOjugy7qom9Aw6WfRbufr9ur8wiRP/dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787556936; c=relaxed/simple;
	bh=H23EPF9TloG7E+nJQa0m5YdhatplJC/fjVYUa2krlm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkcPPkC7/1nDPytnGtoSlToZYZrPcaqWRt3xassil+alA3eNRsOAqonTmGu2TvjTN9p7DBehZ+nw5csEEu/bUOdS23q+UeJTPSyPWDzPoNr0kbwNpkyYmMWNfMWUyivp5lX6yicx1bZGZDMKXP0TfKv9zzKJ6XxYz/qAiJplX2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HA6mQ0KB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CizU29mZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HA6mQ0KB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CizU29mZ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5R8kt2041427
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=muDUavDcDlBy4ZbTVMUoVju/
	k+VRokt86WTsDGHl080=; b=HA6mQ0KBd7ljWr/2TIBM+xy1yGFsJe8Lh8SQMFoG
	E5sLaMPICUUQ8qiJ1SjrUOooXXg7E+toPke3s6/qd5XgLC7zaPIMKWeRK43MslCO
	6TcTobX+3VfnwLof9rTcs0JL0mQ2ATeTuzZfHCAXXX5XqggynGCE4W+PTdbF7VPK
	VKShZFkgAEZr9qVkyglI9CcI7+KYWpYeQWQqmPNfPrKMCrZfVEAt/Mq6w6R9e5vu
	bbGIGKX6+dfR1KGjQYJkVWzqMFA4LffTjDzSqUsO3YHHUboYPaqPDoX9+EwciOQZ
	wju2m2xc0+Y9QsBZLAkI3h9H9Jyaz71fRYUHlSLyL3eYfA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88k7hey6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:35:33 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-744e7c36621so1134994137.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 00:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787556932; x=1788161732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=muDUavDcDlBy4ZbTVMUoVju/k+VRokt86WTsDGHl080=;
        b=CizU29mZgduu8SUepYWO6YCQQb/t8lhIsJRXiOtdFkfijWWQYmOSWRNK2pclGCA12a
         n9i24tXITR3N/HKQBQV4U+e1jqUIR0PPlol9qd7bARIKTugKmRAc9nfe7NznqIimzNqi
         mV4BAQSqv1PQN3iguiwmKzkrs71XnUAYCFwAUW3Do2Clgd+7Q482rBj2I1z0sVw7Lp28
         iKS0u9/+I2Z0NyY6fimfZ3NA7nbElo1Y+j0+ItN0FVwKlfs8jNB+PREEyhKNzJRhYbs2
         ryij+FGXs55V3xQQoj7k46gdP3d8KCsPH43PvrWtO2OLSnAvpWV9jvezmcqtqGNxlYAB
         oXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787556932; x=1788161732;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=muDUavDcDlBy4ZbTVMUoVju/k+VRokt86WTsDGHl080=;
        b=dw/EfR5TqBhuCHpwG/O7hRBLG6/v1k9XBROH7VXowB8sJvlq1c1Vae6gTiDsmaQtyv
         n2mYGwwah+1AGQ28W3LZaTVB0D7f7SLfC3AYjvaRN7Lzqr1atY9FyJ9n4s3dKGW1x2Es
         d8R4Ak7/cznL6e3MIK702pqi/a0yBlPFA2S5n69jjCP5YkDS2JRuL5pnef3wvS5EP6Ek
         04mIzEJAqbFoxEkfMfnlL9ZU/jptmjrOxQrVrRpSYNNwaOsWkCcScUUC5cX720msuGTN
         gRWJRP0mnoP2bOKDoUv9ceVyM6+d5oGXx96BYuNmpMyedagHgHb8kQ2WxXZ96VWi0rBW
         6/DQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZwvyJYWMnhrP9CskrGBr7DwBXfP9pO9F2U4fM1tnNoOYf3wPj1XNnrwHTyzDtOSirUTd2P2fOcg==@vger.kernel.org
X-Gm-Message-State: AFuF++mgdgXmk9HHAJQaPB1v5tlMTxZsnLZI4AkKE9uEuui9xkaYb4f/
	4+aigZw5Q/zh47OnyKvD/h6s5p0W0WkZ61AhDrpwD+kiPng3WsF43unCNWfCDnaqDht1uiXv3LF
	ZffHWH5ZZmFb1L/kDkU7yxSsWFa6EJAr6lkhVta8rdzLa1jfNfEXcypmp9Dr9rA==
X-Gm-Gg: AR+sD109jhu12WlZJLui9n0OuQi1S8dwK4T6DMPi0fk5WudeQqaHFGPFq6bARIvDhjM
	1X+KvpBmi9++WaVkFCPGTurSolHwFtprY88TfKJsV3tZJTGmSbDVo+2ljMRJWtoS/jGbeYOl+jW
	5zBvJyi39g7EQSsC1VLPz5WUeMypB2XeF7L4JldiLfakRLs5NsYhr5YTOlGC0lk53g7VqJvb0tr
	gaDuNIzBNdhpkKREJvP5DzHFfaMBvJsjHoHSOXyBjEAFWpsU47ERNp5LNsn0OoSXsZ8f5ZMbzXq
	L1j5vXRkxF3nrkaf2Ra7ACc+s4aGJGE6nt73h3MN9DThILNoW1S0UqNEDn0wLNrCuS6w/7HIpeb
	N5U2o5pYE0W93gPs=
X-Received: by 2002:a05:6102:4429:b0:779:dc0d:2b2d with SMTP id ada2fe7eead31-77bd12cdff2mr4903379137.8.1787556932190;
        Mon, 24 Aug 2026 00:35:32 -0700 (PDT)
X-Received: by 2002:a05:6102:4429:b0:779:dc0d:2b2d with SMTP id ada2fe7eead31-77bd12cdff2mr4903372137.8.1787556931643;
        Mon, 24 Aug 2026 00:35:31 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e001095sm7651782a12.6.2026.08.24.00.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 00:35:30 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:35:29 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] powercap: intel_rapl: Fix kernel panic during PMU
 unbind
Message-ID: <bytk4rnkmttixn5y23fhgg64hvgtg3qkurk364h5swf4ufyul6@dd4k3suk67w7>
References: <20260822094657.12489-1-sumeet4linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822094657.12489-1-sumeet4linux@gmail.com>
X-Authority-Analysis: v=2.4 cv=b4iCJNGx c=1 sm=1 tr=0 ts=6a8bf445 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=i8cLoBpGy9Ai0TrjoSUA:9 a=CjuIK1q_8ugA:10
 a=zgiPjhLxNE0A:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA2NSBTYWx0ZWRfX8+4+vpCOiDgx
 hkmyuSny3XTDy/L2PzVkzebCKzXom+3C2wVXHhZ8+4ZJYTQkKYJ7retixcKqrJ6Pk5yCwE+MI66
 d24Kv0wOaDzYEvNWPydrm/yqJDAZgCY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA2NSBTYWx0ZWRfX7hkwb/ABVGlR
 kr3BrI5FXwrgwNDOd7TqzX/ckeGLhNuI+LT4FWStt3f7y2kXk3N7/HYU9OJFg71p1vDSMgPKeg3
 ofUWf37Q9dpcEyE/vpHnu5wcGwto15kP5Vp4wHeZgqsQVaWAdqfLao4R8VxAal0W192sJrEuzu3
 0oyv258RYEHKUiniU4V5pZXJoWA2d3eF9L9hHyNXi8pEqXZqUhxPAwBeUwAu8Gxv2fJAiZtMCvP
 /S8B7oqDjRjml3MOHC8EjF6pkyJM5LZRCJekCNI2ihkrabmWVb9RfuM4r4RLgWEGSm/zDSNAU0U
 Jzktqt9lEiXYX1kJ6TBlBk5zIFB9BXQYsrtNaSD596N30fc91hvCytUBOaJSdwtvuAvBcJ5FCHQ
 dNYYtoN7LWvJeCTp+FtjPlSx6xPLJ7E886R1yr3u7GaK36hs8HXZpPhjamf3gsu3gpJUt+jT88l
 SX+cJtxWLsrWpUio3vQ==
X-Proofpoint-ORIG-GUID: ZHS7rf6QR4IJ-KRq3jZG6ZFLVprWoXBx
X-Proofpoint-GUID: ZHS7rf6QR4IJ-KRq3jZG6ZFLVprWoXBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240065

On 26-08-22 15:16:57, Sumeet Pawnikar wrote:
> From: Sumeet Pawnikar <sumeet4linux@gmail.com>
> 
> rapl_package_add_pmu() fails internally at perf_pmu_register(),
> and rapl_pmu_update() leaves the global rapl_pmu.pmu structure
> zero-initialized via memset and returns an error. But any
> previously probed packages retain has_pmu = true.
> 
> When the driver is subsequently unbound or removed,
> rapl_package_remove_pmu_locked() sees has_pmu == true and
> unconditionally calls perf_pmu_unregister(&rapl_pmu.pmu) on the
> zeroed-out structure. This attempts a list_del_rcu() on a NULL
> list head, immediately causing a kernel panic.
> 
> Fix this by checking if the PMU is actually registered before
> attempting to unregister it.
> 
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>

Looks OK to me, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
