Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A32547CC6F
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787841341; cv=none; b=V4oi74zewm1oPU/vlX+07jdlFIx6MZIxTeKMar77I2KmwfKBnMdAlTNMcYIoWLi5KwlqYqDotGPrke/oujW4Vun0vVq2CxD6kHr3v1R26l6MHObTeBgpfNPeyM2RDMvmILLExWLXShILL4N5vhyeOr03yJLX3mCFrrzFTosfzmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787841341; c=relaxed/simple;
	bh=YVogohUxhXYW+qro4eW5iR1NlUCYy5vSLjvkomWHDaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3TFVGlmxpA2UgLOieCAht0t4FYoZXhej1UDoKdP4hMgaq6wgpugXI+nmxDPgnoENqJKTcMfiRDp6AFmqqQ9fl7FdPn9Ki3sj/yaGmbTxBcC12M7njm+MRw4o9L8nVH4vyH4FkRvzyKcOrPuAhU25/yLc7rBk+vaHJLN347j7JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SykoalYu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dhiBbOn5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SykoalYu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dhiBbOn5"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RE7jqN083910
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 14:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cfkQPAK61rdM9CVGwbTeSOvH
	+QMdclpOh9TVNimhDYY=; b=SykoalYuWSS+3VTkMeSCeJe2+7W2Q0+HK+T5gi2k
	L8j0XebgvrJ6Zd8Umjq8EcPQHPmCDDKIAHdBEEcJHHEg5KmHyfaLbBs9EXl4bH6F
	AQ09EFxbhgvu6irrED5gFxYH8Gq1suXAIQ3GtIuSRhiNpGOHF4YKOr7+1nhT4sb8
	orXEfJ3i3d3PE0qbpSm55V1Nf/fnS2isx0+sYrnA79H/Bw+TClofPmzfThW5zDFf
	moYiRW/N0sehO/U201HY6Jii7rhYxgmqCgs0qR7tHt7sY13pQDnXoRCdHtylVH+c
	t75MWuzrWnoXNliPSA0tW0QOt0+ecv2pYXuxQFZU1SfUoA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4ecc6w3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 14:35:35 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b28d7ffab1so2081361b6e.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787841335; x=1788446135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cfkQPAK61rdM9CVGwbTeSOvH+QMdclpOh9TVNimhDYY=;
        b=dhiBbOn5Q2GZ0HR3DKE6dqp3t7wfiNogO4lO1F1Kf+eUPyOao0UmkdbbZlH+Ax8LQK
         QUFhjf2xa4By5t7Q/g3j4WnmJeSzVJhUAy/Fs9PZ26nY62uwboqGLnpi1OcTs9Pi2xuj
         Dkzr9NxYCycGNspo+rGMCClWey6slxP9yQMPtxSAaCi9Y5fCU0A/GwVuxCfZC+GaiKzS
         HxtbJgU6CXZOmvqlNTj+rbCrN6093NM/vDo1USzmcd7wRWJeuKlG9eKVcDqxLS/ofGQp
         FBCqgW99Ej4YU6gmJL32HSTfRxQs5OKyxzOKh2qY20v6gyevLbdg8amRrKHdxlEFA4Xc
         ku8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787841335; x=1788446135;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cfkQPAK61rdM9CVGwbTeSOvH+QMdclpOh9TVNimhDYY=;
        b=S/b0nFpq2x1UP8wIqPABG8Djg31oAQRTnH5QR/WFaDbSO7J+lFqBxpcpnfdvZnWm6p
         4ATZEp6AJ4wZjkNdW7MDghQhViaxKEiao4ao388Nw4FNKIAituCRI88W/StvcOjfv4H7
         QBP9MnXlLUysCtQrtbjIwsXzw8TPu4aDjbCtHc5jAp35JDWRjxo5eTOzQdiYEcHwYkR5
         ZxWxt3TBYRiBssfEvzDZthHSFsQE8dAXacKwDBFiRIHBsYc10w0iIeQMy8TS4EguAElr
         1/hgG9HusgpfK0roThLj2s0fVvdTgfEF1MFNpviAYvQR7pEB7aRz/Gup2e1R9nmo+Mon
         jPzA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1YkWXpgTUt8KuJzuDVsl2npcC5PHxaBJuEDZFuat8y8gJ2BiNfNYhxfVQX/8+dBTEKyU92BWyYA==@vger.kernel.org
X-Gm-Message-State: AFuF++mj4wIPtKZKJxLJYISBO3IVflFhVcr4TluFO3rbQ2uQ6/5UFmAM
	wpQUHv/AgtGhLU+BP1RnobZeD+Uyet+LhazUXHRzCgPxlT2T8CNoTT9AL6QhbA8oJSJEaQ4shMY
	1R+wFjXkIQiwrbngG4usSckeoHjtVNQJQ5/X3Y3eiWX4gV102vO244qYNvwfaTA==
X-Gm-Gg: AR+sD11/RmA06PQzCFU52Dl5Vci3NVviXm3mUlNOtczbbxpPusNSw/XJWwgrUsaBNLR
	whKQr7gA4BevxP3ps8nFNBttn2pWdPVQm5NDWluEUtmUYQiaJXhuAiSWrJVYkOP5oQr9aZhE8Ry
	mCnQoiGz3VKeADDZ8eQ8MpJYrlmX1oaqvgCSuP5Pe/QhE0xrmDYfw69f/86riToDNYbM5v5VqbV
	RcjV0DLqp65l5j0k+Sd4pbtxO5JSvvtSvkjd+lDkuhJCPqXxe9RzLWZiHGydyvcxYpFQtr7cbZO
	khiEz7fIM1CXTBYnq1K3fok/VueL9KPviqKB47GkVG7cgWwQK0dc1CWMLgjeoh0+71SmAv4Rp16
	jCAs2Q51Tn6MWUvA4eu9w35F5jlAplTPhdMlEgRpRaps=
X-Received: by 2002:a05:6808:c173:b0:492:c9a4:2104 with SMTP id 5614622812f47-4b37c999474mr5860673b6e.10.1787841334629;
        Thu, 27 Aug 2026 07:35:34 -0700 (PDT)
X-Received: by 2002:a05:6808:c173:b0:492:c9a4:2104 with SMTP id 5614622812f47-4b37c999474mr5860621b6e.10.1787841334243;
        Thu, 27 Aug 2026 07:35:34 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b38cc3e4fcsm786416b6e.15.2026.08.27.07.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 07:35:33 -0700 (PDT)
Date: Thu, 27 Aug 2026 22:35:27 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, Vinod Koul <vkoul@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal/drivers/qcom/spmi-mbg-tm: Import IIO_CONSUMER
 namespace
Message-ID: <apBLL4x0h2kUaz-n@QCOM-aGQu4IUr3Y>
References: <20260827103555.883018-1-shengchao.guo@oss.qualcomm.com>
 <apAzGkXpnMYHcnqJ@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apAzGkXpnMYHcnqJ@ashevche-desk.local>
X-Authority-Analysis: v=2.4 cv=KIBqylFo c=1 sm=1 tr=0 ts=6a904b37 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EsJU3W8_Wz0UbiPOGlkA:9 a=CjuIK1q_8ugA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: egGADdbQk42gwPCxQ4NiVpcGCmczuI40
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX+vFbpEWxpP9K
 XH16rLglKa3APnkhHDmwQ5TcRRNihvi01AeZsTgGEHBO2o98WaXdVnid6T8smMOtYqifZ3wsm1h
 NUsuAHIfXW0wMi9JMmyiLvHxZ1xHQoW37U4h2wO02VD4oMO4PfS2xt6xe/Ry4KMIoU9HrmvMVcE
 Xnf1g9aNqxJibm3gN3AYQ/WilQGgLB4dMWrEWXmSHwfkHKvMzCN2PzYinJDwllKDdreI7kgqP86
 VO9SagSgC3Zn0rYUO5qhFhHPAonDI+XbKsWDNEo47QqHCypusYHLY8Ck6s9nR+AzMGr/zVQ6kTt
 HYSWmc/qGPTBjWUooYVF7SJWilLzIKRRxDbqamX0YULuaRJBP++ix/JFjB/JDz5xBGETGkEJDjR
 LghrumZ/U6IlTUFFthfFlwlp1MHjz3uKmL/85SEpq5Qu0LQvkeAFCKD2F86oNaAqRqMW+fjC32u
 ewOO8e+sjZkw3rUDVkg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX+gDbvY7atfei
 fwjdJKRO8SjX/klsbT5KFm0qC0GU+9wnsh7O/1mvuu3h6PgDOPVaInayI+/cH9DfA74yencc3dO
 iTXE8kLBczWnntz0M96A9AkVh8GQdGU=
X-Proofpoint-GUID: egGADdbQk42gwPCxQ4NiVpcGCmczuI40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270122

On Thu, Aug 27, 2026 at 03:52:42PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 27, 2026 at 06:35:55PM +0800, Shawn Guo wrote:
> > The IIO consumer interface symbols moved into the IIO_CONSUMER namespace,
> > so consumers must import it explicitly.  Without it modpost fails on
> 
> > 'iio_read_channel_processed' and 'devm_iio_channel_get':
> 
> iio_read_channel_processed()
> devm_iio_channel_get()

Sure, will update.

> 
> >   ERROR: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module uses
> >   symbol 'iio_read_channel_processed' from namespace 'IIO_CONSUMER', but
> >   does not import it.
> 
> > Fixes: ebf1d03dab96 ("iio: inkern: Use namespaced exports")
> 
> Shouldn't this be backported to stable kernels?

The offending commit just landed on mainline during this merge window.
So there is no stable kernels concerned by this.

> 
> ...
> 
> Code wise looks good.

Thank you for the review!

Shawn
