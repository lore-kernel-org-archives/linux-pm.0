Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8030E3AA50B
	for <linux-pm@vger.kernel.org>; Sat,  6 Jun 2026 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749685; cv=none; b=czjkezOSx+sfhovcgvKx7YJBxf/Eb+PSuS8L70gtVnAimzQDtx2GBIo9XxWBn6xEbDw3Onr6M1opKkzzx9FNQYHZZgNRDEhtAs0G1xFDCNcoJS+kJDH+oxd8JaOoHo6UP5AJeaul2/NcrtZdEHWUt2n4IbG6pUqZ38bD7DX0zDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749685; c=relaxed/simple;
	bh=6uToLWIkhMVLVPs5bVfaOcvpcrTZrOqNSF1Bm7annfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dC9uMgUdDJxYAgvXqOxRalNFuVYx70BgRbdrKxzdXa+Ralih5Q1bO+zAr3CPXgSaNz7qf/cPC5eIlPT33/eClAdTXnVRHMjXZ3ToIkscHc7YGR/VHZMLXF2V5PW+AwEjV3NjqRirPioeTIjXmzfzE4R+rCk0e4Kpt/Tb0MpWoyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LIgNCPTK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TZjfWCs3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LIgNCPTK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TZjfWCs3"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656BDs7k1327476
	for <linux-pm@vger.kernel.org>; Sat, 6 Jun 2026 12:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ojRmqHVzAY9ubyxt9hMVCKPiSD0rZfJdWLUlBw5lSJc=; b=LIgNCPTKnlPTSgSb
	CvI34d80M5q9qq/2h9651kVdt5wnHzR0rDNvy6DnetFDXQY8eWXBEJVsHt/BgnET
	5jy5zUbvK0UlubLyrsTpfYvfBei4XD+mU84+FPBBYqi+KDo67EW95nDUjjd3NkMY
	Kx3LzU93ncEVqWcOQXiUmKZNYrlpzKVIfoJMFwDyFWf6BU4K4la5IlrPgeQciobN
	K9GW+Rlelrixv4iUWkyrHp/JHtqCNIgMoNOFRY9W9Vddzer3gr7xUJ77tmRMlWyz
	Hsblm+NLYR+NKitIMVBmQED37LGtcOEcP5mH9V5Kiss3JvPikr68MhrPjyZG51rH
	/anPgQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8rtyu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 06 Jun 2026 12:41:22 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-59ece6adf0cso2531370e0c.3
        for <linux-pm@vger.kernel.org>; Sat, 06 Jun 2026 05:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780749682; x=1781354482; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ojRmqHVzAY9ubyxt9hMVCKPiSD0rZfJdWLUlBw5lSJc=;
        b=TZjfWCs3taNBpam4vBTQoYmIK7d4q9QK2pIgl4/ccaFdxsGzr/L94NBTQj7S+R4/aH
         2XL4P17mYXMR03qpXrd5Hxt0KDs7kHMP4ao5m9+SUqEOwCU69G7F4XnDHxjeR5qDKp+6
         uVKx9IPT28eo04HlT7x5bfSyksF+LSqUsDkx+rv6AonwH6EOKx/LAyqszfOVYFI2tjO5
         vi3kE5hgpSf7/kMP0QJgXsA6qr/IBtXJLWkFHMItuoYX/Jr3kFEBsFpUGAKsbuUwliPV
         j/mcv0llWVy1YJWPTdSSwU7t/ZDx3AiEcgwy5uvSogbL333cITk+2M9GYILPkBYFRVlV
         +CYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780749682; x=1781354482;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojRmqHVzAY9ubyxt9hMVCKPiSD0rZfJdWLUlBw5lSJc=;
        b=VNWLJoHwERRfyu6ySNrfDGm7tkeQyGkXGHYzK8B1QXu5V5XqTJbLNqAF7sHtynZp65
         U3kZOwcBNHC4PsTorQmazm9egP9jHTN9jQ9O+k0P3/8F653irZ+LDBAtwTwAUFCs7dR0
         1dwakhtzgQoT5lg+ocpO6gIFV1kEjJvepH4/INfjS4gRJ1hxY0BnQuD9bG5gv1BkldmI
         2YnQr+C8FapI0jM3NP/QfeLDP6DbmY27g4dLgn2aca58xQozvY32DUo7ja3Gb1yXGy37
         fZ7pBYXl6MCsric+KzbxT2OarmbnVX8JHUy5Tsdq32DJFuwAU1b4bErVC08OMRuUd3T3
         1tCA==
X-Forwarded-Encrypted: i=1; AFNElJ/mCLNtNBnJdi6+l48JSlxFQ8NpMh6R29Lovs267gCiVBqvZb6Ifz3BVbraaDZFuu4/JL/uGDCLmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2wPRueTu9B50Jn29aNok5CYXoNZAOf/DL3mh1uNL++FEuXIIx
	eM+JbWBtDL7JAZFUcWdM175Hlp8IN4SHttT7TpipXI709i0wYFLXw0Ak6HdPMqA+85tzmu0tXCn
	fxKtfv7I5VQlZDLB6B6iyDpIhXzvb4wIQoTdNrTIE7funq90SXs6dmvRXZdwVng==
X-Gm-Gg: Acq92OE5vInRAGnTOZF/cn6qPUXSsLvEkDhoIYOdwGG2xB70d8ap9UZTyEqb2gDj6FU
	A0Gepazym/BZou5eXB69Y5n6VyCjYsij2toFdIHSaPNWrXd2QoZE5FlckCG5fF3cZqMvzhTr1Ar
	+Mkxrq+Gd2uU9ZY9swXXudVetoYeY4DASK/XlMXqcqyq1w+2bU6agjeblX2cmzVLpiNCKdkq51Z
	58uBnLuUAcIEKatUnUsUUjQwfs5UKwnOM/ie2VKsVlhUjTrQcKPi9USbRtkyI7XJKli4ME9uX6Z
	yhunYfDmt1SG24iFbtK0G4ABkQeDMySTYIEi897Tezk8cfGi0kqKfzxtt6Vb18AND683vLhkVWo
	yLUeWBNF7J8lN/CVTR2+5R8mbSqh4vPZTSbLbu2S0rLJ4cxx40qlxtfjP+NIAluuOjZMq2z7LLc
	/qkLHwQP/eUD+m22subsNyc67gfhxTjIkfPIFsz2MDNJ/Pfw==
X-Received: by 2002:a05:6102:3ec8:b0:6e7:5c89:3fb3 with SMTP id ada2fe7eead31-6feef48d3b0mr3910656137.3.1780749681749;
        Sat, 06 Jun 2026 05:41:21 -0700 (PDT)
X-Received: by 2002:a05:6102:3ec8:b0:6e7:5c89:3fb3 with SMTP id ada2fe7eead31-6feef48d3b0mr3910636137.3.1780749681305;
        Sat, 06 Jun 2026 05:41:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed74asm2416158e87.13.2026.06.06.05.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:41:20 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:41:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Subject: Re: [PATCH v3 09/10] arm64: dts: qcom: shikra: Enable TSENS and
 thermal zones
Message-ID: <nescd2gwgx6msrzsawljoktwaxtmyo4xdi5s4csy2na6pebcsy@ldzwnj6fxl7c>
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
 <20260601-shikra-dt-m1-v3-9-0fe3f8d9ec48@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260601-shikra-dt-m1-v3-9-0fe3f8d9ec48@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: wsOXb3pCK_vqrjYTueq3WtcvYvM82Wla
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a241572 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=6o-Bo2YM3VKyGZF6QcIA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyNyBTYWx0ZWRfX/yPPjz1cFN8/
 pAgoJUa5+kL1zQfR/ezxYIwbR1nxct6JQeYIfSgzvLGLovE8q+8RhNvb8NBK/qmc+22471UFYxu
 h1FDkLD1Rbhl0+kObay8DYIVopjKSbAurktg7KLgKvDkSOhq9iQl18tthyXAoOMt1W13SD+eGt/
 w/gCZOlsS/uHqLWXQ+rA49SMYkaCXxZOwUj5pLZNuLNEwPAxVnAjZ/WH/IAykrMlYJFAGP4I3K4
 IPE/VnnnCCB+JLax3K1CPISth+ayIDZVHUPhjpUeGOhxWtu+mA/ymcXe/IkAoA3E9pM8933UPgf
 Lx6ok/zgbDV5GC5wTg5zMR/sKik34Np9FM5kY7+RWjPgif1KokrhdnH/LJxujNLFF+MLR60eJIS
 ZOAArV0LIwUdT75BBCtwfUAQrfOFNeoXE5dssAYWN8X5532VXv8C4hYndJaqqPEqV+HdM2cVwke
 7KnRsOQSb7umKQ2hjjQ==
X-Proofpoint-GUID: wsOXb3pCK_vqrjYTueq3WtcvYvM82Wla
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060127

On Mon, Jun 01, 2026 at 06:25:11PM +0530, Komal Bajaj wrote:
> From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> 
> The shikra includes one TSENS instance, with a total of 14 thermal
> sensors distributed across various locations on the SoC.
> 
> The TSENS max/reset threshold is configured to 120°C in the hardware.
> Enable all TSENS instances, and define the thermal zones with a hot trip
> at 110°C and critical trip at 115°C.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 267 +++++++++++++++++++++++++++++++++++
>  1 file changed, 267 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
