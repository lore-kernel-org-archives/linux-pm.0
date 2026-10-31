Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793483333;
	b=CF6jM2rAVCc/8qzRLABZXHQL4pmsWNHRwkAo3tdnq9Sovwr/AI8VZRCrKliopQXsQ+Dg
	 +p2AyhIBJ9kh8MKQzzsOg2MMfeNj4d+asZrhtFVnhk9B783JkcHFM/UBTc1Wp08yXbj6v
	 3l+HXRAeuOaXZ9YDFLs5ImyLD1GH2KnVixguWb4MN2PEq0gYJsgFK6zCDHfoh8iZFWAI3
	 qcGEzH6IeXTTds47iwpgTU9CPjPyCfy0uPjzgUk2Pf+H8rSCfOvh0zKuBD4ik0ZmPR4Gp
	 Bw+HD1iUHdQ7E91VMyZo1CRtySihZ2UHeG+VBkIYURkm9sZ/FMA9RbQtA7U0t2Oo3Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483333;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+Lhjmp7pZXEoSu7S8VjkEKvSY0g4l0O/7K8WaJ0F8JY=;
	b=eC8g5YOsNuYw8HMjR+DNR2f8AOnaHjBU90ABjylWC1bXH2HM5/xYxNLNHV1G7fkrJsKH
	 2gBCUDLfkK+Gtpa+q2obUgR9FWLdFUkdNVbkLAn/mhWOzRkgThE7EEqQeJCvbFpFXyb+o
	 iN4DcSXOxrz6EM31gbaA59f30I5PcX6O1EVdQHsZErwE7Q0KGfFDPLDDJIXV1AbGVNvjE
	 63fp7WteOOz5fMZocbUyzZfoE9RucREUYpIGR1E2xkuoZpiYlc/Gc0j6lAOkD4DTatSpl
	 kOcOW+3pDqN9e03pRkbyWGcViKwhWOepF2PuGLqDkA19VxGc49QWSkJtrHFqKJWLCDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZUG10rbO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VC5xRwEN;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2AA606A31D
	for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 21:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD2AA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZUG10rbO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VC5xRwEN
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VJFHaB1890345
	for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 21:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+Lhjmp7pZXEoSu7S8VjkEKvS
	Y0g4l0O/7K8WaJ0F8JY=; b=ZUG10rbO1FpoTeNiOmCzs8M9cp+V4F7Kt9yOHcOK
	eyxrWHZY6Cm5oI9tudJT25wC+RPH3fVrJeXxiDrB9ZRAfcEt6r8xfh5UyfzJR4iC
	x7tf3RMbDGL/PGxKKNvC0ySFsjwtZJkG8173nYLK8KH21dEMlthhzc/8ypjk43Vo
	dvjr/kpXgLLleTiHgMRX/f4qzh7RfZBEHSjP3b0nYlaNT/fgtDNnjnnnGzHEHjSv
	I7f13wQiXGRaM/ANEXB+/A5eyto+2ZjMUOL0JWqnsOQmtwmVIsFDGVy1N4TCxn48
	VY8XAN9b5zSLK0XEJRTlyXYrU81rgB0t/xz5dRzhtD0ndg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8q7t2uh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 21:48:51 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91becce058aso39105736d6.0
        for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 14:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793483331; x=1794088131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Lhjmp7pZXEoSu7S8VjkEKvSY0g4l0O/7K8WaJ0F8JY=;
        b=VC5xRwEN9dJF+v0bQoqtw6h1aQYnrjoXNjuxvamOOLwJQHGTkCey6RYucq/J7n+es3
         GPR7uuW/3iRwOWBm/ZqoOix/cXE+N5r+JBrIZsdNyPOv6IucMe0b2JaSFoMEs5ZmJMBo
         XxlbpsuVUeejzVfdHZ8UkjcmQoGvrvQBt56Q68xnKKbF7T4AlY1/TDv94UAPIPy4z2Op
         YWr3IM1YQmTieTI9SYkEqcKd1UWWMHAHZNh5XP+S6ChNrgbMUNzkkCcFvcmyl27PbNFz
         mELxTNYxvN9zWJj7dtZt3zaHJ5+HVw8JWOoxzwuu/T4OtMnZZNVJlaEHHtnuLL2/riWY
         wEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793483331; x=1794088131;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Lhjmp7pZXEoSu7S8VjkEKvSY0g4l0O/7K8WaJ0F8JY=;
        b=tcouu/pSW1n1RB2ocMBUDf4wiDeFeZ8opBldDhTptmhonAwljtSU+XouZvFDSLxipp
         uc0oWfYJ01EX/9tFQabAAZaoaimzpbjNRveEd7dSfYsr/4K69QXDdASyVVB9ffd+N66D
         rPUrrB6KQD0IHKtyvJ/9PFeKbMxBvgmtdd4oSEOekC4i/MVydvicolXB+fSj39mxNvdt
         NGMt9T7eO7wB5lhIPJVFQZ5SBbGdbTEbEW4n2EyI2yd1V4HUhe7Ib4S9+11Huf20VtVu
         uezl8cSNhNU66sZndkb52Gbdv0Q+nhD9pIZkractdRTZ66cZRz4DHFpPe8TCMuHuQ4Uu
         5IVg==
X-Forwarded-Encrypted: i=1; AKwUvBxvZwEyR0H90R6neZ9wZU0P6ksR1rMMwwAi6RV9pebNYxxHXVDJIqX4evZIPu2sP26mEnxQnGbLFg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLm1+GztIlxPLP1MOfk5I4mxhydYZiIv7MlqWzir4cFV2/48EHr
	etbOybJE9pybWiE9uBMSYuFF7EM0/5GTmyvPKmo88SFpb/70VppwA57u05F3qYR0P+PWaieErhV
	77C3zFpu6gT3bRWnYZK9qxh9BuuFKq1FzyZk9CWMSbWYMyZtETNRNBih8Md4GVA==
X-Gm-Gg: AYBFou3sJGqqsK0koFpHogrOislD8AoOBb1DHhyYYAg3zSEGXWlfmK2DYBJf/m8aeHG
	OQrj9isBndMqlT5fDV3lNwtiy15Ni03OOfTRa5TMjkjPsGIrluQY+AgpkHWAvEMbAbrudLugT0u
	qN4NvMcDOHrzOLV/lyJcsu61VI8J5EdNrimL7D4P+sW5GZ2CCWHWayFj8rTzUyBMRoHwGITwSAJ
	R6iPvEGKgWND3mdUSYTIPF7jquHKwgFDUzCYnOgPu+NqI9ww2YD1XMVTl6TKRMZAXaj2qYrFGER
	iIDNYrpUsIffJJCOwLqTWoSg/dCApc8g50cHOGoDTMAcR3LYNKPSoAOGE3zHDxEi3PSOq5A+Bad
	kv2FpTpJvOgJ+tLJGinZgDgx2/P6vBcriVILErns5gpJQahEVLrQZRAymX3RRzAyNq2b9D/e15E
	Qt+9Dgnb4mwk/jfjJ3Z89X+Ae0PnOXq3Sgcl8/4p1yxEYEO1DH+g4e2PgNRkCddA==
X-Received: by 2002:ad4:596d:0:b0:91c:5fd1:b334 with SMTP id 6a1803df08f44-91ca4ba268cmr99988456d6.54.1793483331069;
        Sat, 31 Oct 2026 14:48:51 -0700 (PDT)
X-Received: by 2002:ad4:596d:0:b0:91c:5fd1:b334 with SMTP id 6a1803df08f44-91ca4ba268cmr99988266d6.54.1793483330659;
        Sat, 31 Oct 2026 14:48:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acbbee0094sm13744921fa.20.2026.10.31.14.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 14:48:49 -0700 (PDT)
Date: Sat, 31 Oct 2026 23:48:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ishu Brar <patches@brar.si>
Cc: djakov@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, konradybcio@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] interconnect: qcom: Add SM7250 interconnect
 provider driver
Message-ID: <ms272llmwo6na3e3i3qxv72zvxedblxdisxfb3lswmjrbobbej@zq3hh6srj3fw>
References: <20261027-icc-sm7250-v4-0-f9bdaa3c1c7b@brar.si>
 <010601a17d62222c-befdb9b3-ce1d-469d-a6d3-00511529579f-000000@ap-northeast-1.amazonses.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010601a17d62222c-befdb9b3-ce1d-469d-a6d3-00511529579f-000000@ap-northeast-1.amazonses.com>
X-Proofpoint-ORIG-GUID: jUJwCVVxqifTw2BxIU4naq-BFeGNGCCB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA4NiBTYWx0ZWRfXxODV8aD4bI0y
 zOZ7h83tt8sZ0Z3JlnMhjPcP48BQBh5XxkH1C1ayWVmA7PTX/veF/KJ0lGpbHeSHzopH/VcZqUQ
 SSNbJuYvuvSXPYJK3fAhYV0WVYZvwQc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA4NiBTYWx0ZWRfX21mOeKVQjEZB
 prk5tcJCC1YFj5LpE3lgRlow5OKg7cUDeiyu1OM+49d8ChW/brQdD6nWM7UMTKrM2ktXHcqUUv7
 9qq9YsMnGSDV/EbcsxOzZwPRqZ/C2A4n4v62sDapquPyM7KJ+M0wjZdAaIJsiIVIXXc6uOC358t
 1usFX1TcqEls7y+Q7/0FR3giP6uMt0YNkbdu37KmA8xvGcAgIhvNuhAE1WFuTcTVBarGZ/58F2P
 67NC5sI4Air0979QwACwFObXMcp/jF9g1y1rWOpfiFHg3WFP+636kDoSEMZJPuoLIg5FQP/6wlm
 6Oyb5Hns1tOTifdjLxIIQc8o7x5DAUN3e/KUiV7a5/MPnb7ohSgLitl1ZX1KJo7lURsWh0Oc1bt
 874kx9kb0I9EWlJzAxVxaWSW7uiKnlYKTSUNideBIkEd54yVM7KGK+vGu6tJfF3ANT9N0JGnexz
 fy+6M1GMCCeT+JOiayQ==
X-Proofpoint-GUID: jUJwCVVxqifTw2BxIU4naq-BFeGNGCCB
X-Authority-Analysis: v=2.4 cv=PucG/AM3 c=1 sm=1 tr=0 ts=6ae66243 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=rbLHc7TusOZuPl1584oA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310086

On Tue, Oct 27, 2026 at 12:42:25PM +0000, Ishu Brar wrote:
> Add a driver for the Network-On-Chip interconnect providers of the
> Qualcomm SM7250 SoC (Snapdragon 765/765G/768G). It follows the layout of
> the other RPMh based providers: the nodes and the Bus Clock Managers
> come from the downstream interconnect description of the platform.
> 
> Tested on a OnePlus Nord: all providers probe, and the UFS, USB,
> display, I2C, serial and camera ISP devices get their paths without
> errors.
> 
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---
>  drivers/interconnect/qcom/Kconfig  |   14 +
>  drivers/interconnect/qcom/Makefile |    2 +
>  drivers/interconnect/qcom/sm7250.c | 1489 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 1505 insertions(+)
> 
> 

-- 
With best wishes
Dmitry
