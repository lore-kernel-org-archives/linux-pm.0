Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A83CFF51
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 06:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245571; cv=none; b=EJYZOL28k4+vunsaMG1HLvJJ2xVy4YYrUc/Sc71Aij4FzQlrGEP3FDO164efNMuzqriQVxOqMR/t3MHvT2CAaUcff9UHDXAwPZUyE1juWPYG1bWbY43egTDUWhCTSoRst6iG2meEND1YDzUfQMVXq/q77Vjy1hb0XQwaAN5f5dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245571; c=relaxed/simple;
	bh=WZdBj2Utl0fGY9kP0lz1w1dhYPCE9yOdhjFDYABMLyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWcJ/bstK5fImUWBDPu/mQEyROXgYAtK+9JDJPrgr9sBQwyZHSzUy3FnwJ/eqVVsZ02g4s0C3s8HkB9aGYMh4p7/m0h3uc3ohUd6YTV+P7pfUnn+V0gmf67kLRyDv8uB1mmhl6a8pV+JcKd9SOJ2r2qjDOMwf83TPjBCFMSpkmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ayk7pGLe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=euhrr7lP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ayk7pGLe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="euhrr7lP"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C39Sdx2502681
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 06:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wqI9RfMnlwiZjg6It5eA1jSZ
	sNj8SRwJHZwJ1QafMlY=; b=ayk7pGLeNvxrMJEdPQcUFePvhGbOR3PaDi95F+Dr
	P7mxCj0w1uFQQWIXPbWtgP0QKUkRlSFhl/oxVKVlC3LerJR5kd7fMxbklH2PrFya
	o9PFHflbVgcNDa485Fmzuc+pQf0+ONCd/CYnv80KeUDt7ol7cXYL0ppp2r6lkmZ2
	H1Gd2Q8ej/H4eX/YuyG4P/ex4c4WJ4t51WkVf/kPhLI9z/Xw7fz8lkhpmIMV6/+e
	NGeCfMci058vAnaaJIEZYjUMfbijnxpw0UTf8yhO3BAdHtKGNMvgvUMKpGvIVe0P
	AjuXY1I6Vd8aOYKGva3+ppkXboA288AfI0jAj6CUWnAiRw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er0xd2gbm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 06:26:09 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9661acbf65cso683751241.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 23:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781245568; x=1781850368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wqI9RfMnlwiZjg6It5eA1jSZsNj8SRwJHZwJ1QafMlY=;
        b=euhrr7lPsmq3VFojq4Ja9i2+/dgWIyV+0fXKt2fSi0cF/gb1nbHKqGIwvy3aD8qn+t
         QLn6RqO4iiqFlA3KISjQDW2trRxdP09yzZV385Zzv7yC4TAoLGJlN8dVp6rGoRWXqgbe
         FSGb2Su4+orZM5IdmQjr0VfdYJGMKPvbcs5W/9lCGctUM2+Buqes0TzdQC4P8ohIVOAA
         3ug8edaNuAbGSFWWPPccsf1m3tzb54x2C1mRVlS2QPbj6WHe8uW3TpGvnZUitlH/HcDU
         f1uBPduTXCKttWkGVsvG5dCWhumuMo94ftpYEiauVzyvdwJJ69BDHjXpXWTa+SLMmvHJ
         HPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781245568; x=1781850368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqI9RfMnlwiZjg6It5eA1jSZsNj8SRwJHZwJ1QafMlY=;
        b=qqMFbKz+lkxJhGfWTQeudL/q7p2kpRQhEn+y1OhuiP0izYzqAJ/bvhKC/FyXH0FXEe
         UvyseOdkHJGHvRuDfK3+XBRRJJXVpR1IRdb/xCLkZfuTlv2bWo2OPGeTkpf5iZxudpP6
         E44/gXKECSrI9XIL4aEo1QZItpheEFL6DmXkNWZH/LMLsbYC85Ms8kMYrvd9ylsrKaRs
         rqQCNBivFBw00C8wldUEq3tz0CkpGgMZplhenPsgkC8d4Qy08yTe/Vm6JjAHzVRjA5hr
         Pi9l2p+Zz9Xz0Xdf1xBf6EnKpI8p8BPmxuz3rNizq3GJexUcQxdiqB4jwubb83iituO5
         iR6Q==
X-Forwarded-Encrypted: i=1; AFNElJ++XlLwbPVCEU/fX0XLIb8JpZZTIouefMaqM3FuXIIXd5u6cCBGiUPPLHc/ipnuS6mX1wrUzv8gLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr5cylDRiVVIV1h2dZI8Vn0NzZGdxgoeKipmyESGuMg64184t3
	Z3lYF6yPgRpDXeLh7Lu2I1zeO0CAYqhcUR5cko5ybSmBrsPBftnBjIbcLzvg9B1eMvRCpoq2DIJ
	jfI9B7m/3VM68dVTtAaR+cfYB9zen7IuHexNp5ssjRMPGmoys7c78HM44F3vyEQ==
X-Gm-Gg: Acq92OFjKQIqdcrSHw9AmysZGXewh6btSNxHBSm5EiuG/Zf9OFtCP3P+LsHJU+eAFV6
	tcJKzwKCBKLYpT52scLpemJ4EF1iRbysQV6nmDrs2PcbpKGz7gSv3HUC9201IWg+CIYPZ8Mhh/6
	+zbJu/jwhnMa+qXQ7gLbpPdmdthJ07zrcfslyJOabF44lK8l+GjTT54QCkG1lftK2a4IykLckgZ
	I8EO62RQMyCFbf3vzAUpi8S6a4hy4q/yIG0GIgEOTeO3/VMzHGy0sTqnUVa3YDQ0RaoOr7epKD2
	sypDDIEnOpdqmOdftSmhlf9q8pAQ9u7yoTX5mObonHCHeVmR2mCl7vtoQ7bfz4GH1wExVBiFG4s
	I9InFvUO6cm5vNPq9uCc8dP/gRQGC6tuwQmll6+NarFijNnc60djqGk7t56SIF6W8DHh/XhBJxe
	CebHwJVHoOUCGWLNKTl3n9Pwuof19tbwAkLeA=
X-Received: by 2002:a05:6102:8099:b0:604:f155:9374 with SMTP id ada2fe7eead31-71e88c3d841mr627199137.15.1781245568136;
        Thu, 11 Jun 2026 23:26:08 -0700 (PDT)
X-Received: by 2002:a05:6102:8099:b0:604:f155:9374 with SMTP id ada2fe7eead31-71e88c3d841mr627192137.15.1781245567662;
        Thu, 11 Jun 2026 23:26:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39929c6ca51sm3590861fa.16.2026.06.11.23.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 23:26:05 -0700 (PDT)
Date: Fri, 12 Jun 2026 09:26:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: Sort table entries by index name
Message-ID: <pz4jbvlpjveayxclgd52oicl2al3c4mquyqoyj65cvcbhc42v7@obk4kfsyir4o>
References: <20260611085238.37666-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611085238.37666-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 4Mzz9YIjKnwKHUE9433rHk_mCblt25Bd
X-Proofpoint-GUID: 4Mzz9YIjKnwKHUE9433rHk_mCblt25Bd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA1NiBTYWx0ZWRfX5f4Yq8LGhe9t
 NfHQo8znFYnhaRiSnEkj+Lvx25ZfLgzxrSJtbZeIbDREUMsn4uoR/ACyEEqBlGOmt9Gmw4E8G1r
 4TTq/2p2SQXat5WIrGSvX0nBYHVarK2Ibu9aV0ij7dEx+78cRivUTBvmVRxxoRYfRV8ScJg+OSu
 zpWkwg8q0ZorgZW8tdTZlbJwabQ5gJQJxEH+QrVduDXBeaQH51HUm14cg09E7ZqUZkM6F7+oCxk
 PRq4o2HFjJEdfCsUqzLbyzpQJ/CYH3wQzzPm8n0GQs+vQ+Qugzos07I1hf/PaEZHSz6vy95WU9W
 wy6ZBnbLbTK1q0xi+hkG+/Uq5JriwNkM04B9k+sKp7Klco6DBTBK7USYUYuOO99Ys7yjZUjTfNU
 29POeY5YIchUkZRYS3JTQ3LxAI/kPiQAhWSA4t2dMqAW0UcKPqOphx04NacHTNLwy6tCVznoKrt
 DKhs/b7nF7PpOI+d/aQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA1NiBTYWx0ZWRfXxepqG97CmqA4
 kCTq9RX6hEdCkSRh+OkSY3aCk99EGEGZISiB3V5IbMjSz0+E7GJPTae2hWnXnNVpDB10KgBC0Yg
 IO9TQwaPOZhsHm8sIwNMsPv/4evz6Dc=
X-Authority-Analysis: v=2.4 cv=O6UJeh9W c=1 sm=1 tr=0 ts=6a2ba681 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=QMNFilipkfS31cSTYiYA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120056

On Thu, Jun 11, 2026 at 10:52:39AM +0200, Krzysztof Kozlowski wrote:
> List of power domains in arrays of 'struct rpmhpd' are sorted according
> to index name (the define, e.g. RPMHPD_MX), not by actual numerical
> value.  Fix few sorting mistakes, so comparing the tables between
> different devices will be easier.  No functional impact - same binary.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
