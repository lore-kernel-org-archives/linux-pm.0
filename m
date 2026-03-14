Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5327182D0
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773452551; cv=none; b=Wu538Yo7i+kWwdAVBQJPM48hncib4i+iGJJdyEBk4kGh/lR6125jZnncL3tB7pcM/dPsMEmuJqv58S7O/f1L1OaOsAab8VyBjrkw/XEzJxRl4uOXeT90H2ZzQOZYMqQDvKp9ceG8W3H3UGjJTdtC4MPeErkgUt/0uv5HcfaN3js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773452551; c=relaxed/simple;
	bh=36js7P4EDgXjSd5WKGAFDE5TiYa6s9ZyxFvT9jGbqRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WN3f0OCr0fFylkXtoDFAu/VdQE3zx7TAgqvZs7AytLAVvK9LIIcJArPiFaB5ERoigKbKdUSRyXfglUXzdlNUfCFCDAGJKeihwngDGE11AQrT6iN+3xVYCeFhMbAL5WNlcELhkmOROsbyPJF6JKo3PwikYNqCLKUN+y4IAjMclZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LiYCor0b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qq8UUB9q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LiYCor0b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qq8UUB9q"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DIseI1525821
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 01:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dxoSV/2rDE6WRGUecrEbFLSj
	R1a4x9YNBijPolO5Lx4=; b=LiYCor0bSzIfq9ypzW1I/BriGHPZZkGXtcOwXHra
	gDRlQqzQVsEuIGtmXi5N/MGjNNEhN+3LajWcEbRduwvWnE6R6JMyC738X32Oq4Ja
	0bQ92wku7pdJe3kdFskQ/3B5WA4rDjY/r9BsTq2nR4I6j134wJLBSZ1VbMiDZAOd
	sYqNXtcTSfW/z225w+ZJzKmNbp7rBeUHU7iiJWIg6Vm1DmSjF8+x8H9eWs45cUc6
	kMbM3muFdRdzV0Uf/I0mOLv60DY9/iQuJAKE7bBQsVIzzkUSMbWY48mkP0eRuQwx
	aJc9jlzS/GodW+fzzHx0j6eN1BbEjBRcHA37RGy29OV6XA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvh84tjuq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 01:42:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50923a9bec8so46485811cf.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 18:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773452547; x=1774057347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dxoSV/2rDE6WRGUecrEbFLSjR1a4x9YNBijPolO5Lx4=;
        b=Qq8UUB9qZeuiAC+HWtNGSTw5Hq/3/0GMnRotGT5FKf1iyZep4OIF0N8IJvUbx8cdap
         RepWBz8cTaeMkfpUQbQFFcGLEUL0GSB07BrhY4XM1aoE0/9oSKsSaQB2DGUTtksp0WlU
         0+k556N2m58QeT8nhGO56ZnodqZ0Hk+MLt/3zFLWgPuI4RONT76aV91sC4hrlhAegJrr
         9aFmpy30xi3HSxIRL9hBj5Y1LrnidV0rmPf8urNU6eOUPN7y9kZFrU+aJttizEUIT9L0
         eMbDT4P+JtVL+jz3t8h4N4exchLUslcyjXWTpSIZHtyvb/D7OqzJGfSIT5PeENriCzCa
         WrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773452547; x=1774057347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxoSV/2rDE6WRGUecrEbFLSjR1a4x9YNBijPolO5Lx4=;
        b=cHPdfeRjC40n/PGYKhurxg9qhakCu4l5HdxG+sGGkhmEkcxLj8EO6nEp8HB/xvfzEr
         as7QmDlgWzCosjYbI/BXuMl5vTqf09LP6j/wkBL/cUy+8I4F5c5tksnlcF9pIC+lkCI5
         dJpBmJfq95iIF4cQYM8dp2ww9LlS+98ArIT7i+JMC1m0UR/3hBkMU0THpeknPXidvlrp
         8r1YDvYf3f2htYMGqO/ymGHEhv55IajRhySdEqGd5Q5/AmowOSLB97afGRbKKw/HXI40
         rOJ8U2pCW/b1WuhuRpoUiJ50S94OiPEzcsM8rZ6SKoEDl/K3rT3mzhFYjKDjYJUUQFT2
         SUvw==
X-Forwarded-Encrypted: i=1; AJvYcCWW3S8QhC9CWl6pOTsKXHn0qInmRUf1UpJta26SZyDFXQ0/bUlMcUIUQxWDH8nWQpibdDA4SumvkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWL/m48mQBOyaRtc4euHKn8GMiTCjXPCELpKZrm5VUkj8WZtAa
	f5wcPy3GPRnVNkTaoWfDDi+7IUCTXV78Q6mXTB1OdSX4Y53J11go4hOh6xlPa/siZQYJKut5zA2
	DDYMTheQPnCPROZYtoccsAT3J906/UcOdFPqy1r4f6YjNtd/zqgo4D2ZQmZOKCMz0GHxsLA==
X-Gm-Gg: ATEYQzwlg2quLjEom9rGrvjR8PCrfdqlDOqib1jdwdmTYG42W0AAA5AbpYT7mFwgVKk
	ctq26ZUWIViYVsNw0TkyZQto9WNCdvGBzvoTYyIZeAIHqV1bjKXMmk7E+2h55IU6D9Y9lTFtyBb
	AKEOePP+n6ENjAtBkvf3MV+yXvGYywc4obXzB15sNBRkK6DlOTpeWCv3i/Cwsm9BU+hjEeHbrw3
	NrDH0p9oVade9onvT0nslAfqr+cphWpUG4nL60h3KmHbyZmTt8t5ih9RdNjnCuYT1mAD0VIs7uc
	055eS03DmGhMtzaDDryLZUR/PXNwct8K0feSZpAPY/qNZWM4bUb8M9AZ7m5mp1R/ro2l5vY3CDh
	DSDfK62qzWdafMX6gYFQDCrbrhgex2AQvTtf6mfIQEsT0vXJPn4J2EBIcXWJCEYNbVSVpPRBbSu
	pYEcKUluFBars9UlF7rsnLZh35bB/jHMuOOq8=
X-Received: by 2002:ac8:580e:0:b0:509:277c:a28a with SMTP id d75a77b69052e-50957d1623bmr75849391cf.24.1773452547054;
        Fri, 13 Mar 2026 18:42:27 -0700 (PDT)
X-Received: by 2002:ac8:580e:0:b0:509:277c:a28a with SMTP id d75a77b69052e-50957d1623bmr75849201cf.24.1773452546496;
        Fri, 13 Mar 2026 18:42:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a15981e963sm1448727e87.64.2026.03.13.18.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 18:42:24 -0700 (PDT)
Date: Sat, 14 Mar 2026 03:42:22 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: sm8450: Fix NULL pointer dereference
 in icc_link_nodes()
Message-ID: <xsc47isjkoozsyip3jfk7byyywi3iq5gp3ldmrvuolthzfegbf@qz7cmcro532m>
References: <20260314012933.350644-1-vladimir.zapolskiy@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314012933.350644-1-vladimir.zapolskiy@linaro.org>
X-Authority-Analysis: v=2.4 cv=OMoqHCaB c=1 sm=1 tr=0 ts=69b4bd03 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=dC--IIKdycn-tNnL_gkA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAxMSBTYWx0ZWRfX8PwkshzVG8WK
 zfuANgZD8tzGIX6atBLccY5Hemg5P0cqQsrimuZT9ulLo6s/TSz8nOaPCYXfsa8iHSnF6K1lHRK
 ZVaNvYQVwg6rQPcGW412LlcXTvnNX4lb3N0SZLk4UkD9LSPoBu5KwFOoNGhZJzavENOvwIrI44C
 ff2v9mjNdQDnGUBRMVpw1KD7HyTX5S/7TQj5NxlPntwGxtu8Xvciiyk04gQwbHpnccskhZlJGiA
 2vV9siSZPQMetx2yaOrpYmflqK+AFfvI9s3Cgv7+a5XA3GBT9KMPUgTWfANoz2xPhwSQf9gJJaO
 1G8JN7ENiX9JeLRkUkjWaYR2EKCqEiYEQ6/2L24pnIA32jknx/rn0/3UyF8IaAz0LM8tO3xnu2F
 9Y5p70Xd9BIhKQkPAYgbZERXLS98xLpNTtP8RIVxqskdM+JO1OZNdO9glObKkmHvuIfob5N9+sI
 oYCaiMRnKY8HrvOf6QQ==
X-Proofpoint-ORIG-GUID: HdWRYx_EauwjCA62piaddhiLv_ajwnLI
X-Proofpoint-GUID: HdWRYx_EauwjCA62piaddhiLv_ajwnLI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140011

On Sat, Mar 14, 2026 at 03:29:33AM +0200, Vladimir Zapolskiy wrote:
> The change to dynamic IDs for SM8450 platform interconnects left two links
> unconverted, fix it to avoid the NULL pointer dereference in runtime,
> when a pointer to a destination interconnect is not valid:
> 
>     Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
>     <...>
>     Call trace:
>       icc_link_nodes+0x3c/0x100 (P)
>       qcom_icc_rpmh_probe+0x1b4/0x528
>       platform_probe+0x64/0xc0
>       really_probe+0xc4/0x2a8
>       __driver_probe_device+0x80/0x140
>       driver_probe_device+0x48/0x170
>       __device_attach_driver+0xc0/0x148
>       bus_for_each_drv+0x88/0xf0
>       __device_attach+0xb0/0x1c0
>       device_initial_probe+0x58/0x68
>       bus_probe_device+0x40/0xb8
>       deferred_probe_work_func+0x90/0xd0
>       process_one_work+0x15c/0x3c0
>       worker_thread+0x2e8/0x400
>       kthread+0x150/0x208
>       ret_from_fork+0x10/0x20
>      Code: 900310f4 911d6294 91008280 94176078 (f94002a0)
>      ---[ end trace 0000000000000000 ]---
>      Kernel panic - not syncing: Oops: Fatal exception

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
