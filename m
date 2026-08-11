Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4604334B7
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443053; cv=none; b=mG9ebw2sFF+5xTU61W0BhaNQ4idqYWpei0cuhr+v9MYYHMyo7M83rRoU2zQOvx+3/8p+mxqL7ql0FQYJXQvZ+ye09And+PCpn6meHa24ilJDgLT+AErZ/tZU5T+OA14/j6K7ejpPlpP1g1qHO7/VKACK8I9PYBe/QJKk3DcwKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443053; c=relaxed/simple;
	bh=qzsgQoGlolnQX8sk+zXqO5Wa2vWoPFRlcHWEZlEafxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6M9aLj5LF7PHss8KkWnPi7/bUmU787sFOJSAkAUG6Uhyi4pYn7CPXOIU2rd59S0HSYrjdfmzdal7iKX7jVnRgTysRtvHizY6YX55KrCCnED2Seh9qKgI3hboRPwFy6TKWfBgADUQOFEx7W97myZYV1Fd69iEjYp8DNwJO/LiNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bcl5jUi0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LTNw/u9b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bcl5jUi0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LTNw/u9b"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B79etZ3552835
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3XSayfHIr9uwvVv0jql/GXkp
	sohPutp78kowPFMk6F0=; b=bcl5jUi0sHfWOBWeYKoNeXrxFHkQTX6j3zoGqURN
	t5fsmVwjYaI+gUnKfnF7ZUt5qqpBdxq47ExjBY97GRy1J1rezfnUrWocBFVtS7Cg
	t9dIn3Aw5E1x0+8EZeLn7LgVFIq2X3ULktjYcYn+AaYZvMQC/OvQ5dFEyTQzqoMF
	83T04FY5h16+g/O4HXtdxqxnjVMjT16tLA2TwNlzkVGsbgaqjRo3ZayH/OYB3vpJ
	7gnQ+XXDoPuQuU4PHR89E5kuYiaPQz59kSH1tFisfqj19iXgIDWy/82LNvb6QI/D
	E2W7MJSBQFA1mpWwutVZTyjh9JNs1b6EY7ffDQQWrmlz4Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyqmk28fq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:10:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c07f25de2so2807511cf.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 03:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786443041; x=1787047841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3XSayfHIr9uwvVv0jql/GXkpsohPutp78kowPFMk6F0=;
        b=LTNw/u9bfUXMjPILR6TDFw2OQPVLvjvdbr2Flxq46SUX+tAXeH++FUgSgONpCmpHcj
         IIhLQ0Q93s/Ajq25FQlTGEXhkQZ6IUjTzr6zbv0ryC1aFSJoBIEXsHFok8tl3ymzsHvB
         mX0DFwXDdt0QzUu0pGiJfoSDBDTlHfch7ez6545XWUZkcMG2MY/3/lcyP3zosAdljWBm
         ixCuAP+/ETIhOzw3TesQK0ZSnBzBgR8k6kU6lucRQx5+PRfBz86IW8y5onEXmLFj9AIN
         jlnRBUbxEz60NJOTxXUn735ceshZ1ojhfpkrvJTVpwY5hy86MjvqbkLqSHuGgZcWpwYu
         zhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786443041; x=1787047841;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3XSayfHIr9uwvVv0jql/GXkpsohPutp78kowPFMk6F0=;
        b=VukQsSPGsS45sTFc+28PKFib+xXTU4vbPGlCi8eTN9DUElM+nNESDOIjxS5nmoN7V1
         DV9UuxmJLZ0xBxjRo3h7uIRvDcbyRcFnWDYJC7I9CaJkMq3r8JMyZp7Qj4h4PkGh7cMx
         STCoxzdOpijHe4j2V3qH0XFtS3+OS8O73vQmQgJ5fsqrIJ0bSNyd45yrjCgcBlpwR9fh
         1IJAcvDNNCN/Cvf7wyTI7lihFNWYDXg7QAXCNpHyeJvxT5ql1rJiT9mw1R6Z0K+a0tHU
         aFQRYZqNbqG0s6U9h0OszfLA4G2SAtUtG0EnjO5c8JJpE7simr1vjqUazMdXExkZNrdd
         44tQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrvtxfm6C6C35bGMqkZpNR4rtL0K6oobPaPGmFcac9JOJ413JRmAxD/Q3DVfRp8ypMC+Px2Q4B7UQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsL1OSkds0VoI5/wtk3KNC6b8pX8czj8KQCxB1slIhMKFYt8hb
	MLJM1i54YHszxDwFwydzZOlvvJBhXnZmvTadKM0ywUXQO68912Dz2YU96+vfMMT9HhbQ4CZ8Clk
	lUFcFAB+NHLsEL80p7K4PWTz5jGkfKSkro5Dhjg1xMGu5T6fDh3ocySERuAYvLv/HJgRNig==
X-Gm-Gg: AR+sD10tFGYhNXfawIu6nFwMqBl7XNl93pu9RPmFBMK6vPUlj0WGp7Guxtt5+Fnwpoo
	ZbFF2AQxn96fk5ZyFLSK2MRufieMQ/JnC3VFd9NJbvJImjttqSkWOBqugPUmT5rxMJu4sVU6tkF
	YJjgABP04n6HlAJKEF8UDOX9DAHZ0cgzHFq1kWYLsUPoQfoeksSsY4LpvjAMnaOsLL37Yti79Ds
	JZVYbSAy/l+X1AukHKktD3scDDPKNVDqX9G9us+Om+iMLRUpQp/Mp1uVNVk6NnFE2cly9ToaOXn
	mM+QIf2631wYY3BdQrdXi/T1vjhax7QwrtgkhFG4A4FE0F78wTgoCOv3bgXRUsmoWwOMoL3S/4P
	4NCmAwrVFRXNWpSGxxEPI/tljdIixB2M/2/y08xS/OPbuFIqX3OI0cQI6KvzMHYuB+YAP3xoDHY
	lSnaBjH8btVzd/iQ==
X-Received: by 2002:a05:622a:2cb:b0:528:399a:8f81 with SMTP id d75a77b69052e-52d585d80cemr15213641cf.23.1786443041055;
        Tue, 11 Aug 2026 03:10:41 -0700 (PDT)
X-Received: by 2002:a05:622a:2cb:b0:528:399a:8f81 with SMTP id d75a77b69052e-52d585d80cemr15213401cf.23.1786443040623;
        Tue, 11 Aug 2026 03:10:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b44873760fsm183795e87.79.2026.08.11.03.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 03:10:38 -0700 (PDT)
Date: Tue, 11 Aug 2026 13:10:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: ipq9650: add interconnect-cells to
 GCC node
Message-ID: <wpby6bzzieic6fhikaf2x5odtofh4xxygszsazeorcgzspmy4w@fl64yjfoklr2>
References: <20260519-ipq9650_icc-v1-0-4d3554c94257@oss.qualcomm.com>
 <20260519-ipq9650_icc-v1-3-4d3554c94257@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-ipq9650_icc-v1-3-4d3554c94257@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA4MyBTYWx0ZWRfX/g/+0W0lchjb
 JZSoXRDJILuo+lKbuL6g3qFNRacpwaOv/ojYsbb1dAX5XabsflQ1i3gRWgYz88KKfRO82xiIaTS
 fShkzaSX9GUFhNsTQDAXK2qaU7WEjtkRU+7ShARopYTP+O4XknGhzRmZINmiu/zLR/R3hJV2tgJ
 8Um0Vt/yxK89h3ie/DvOpowr5iKpOQu03P8gRWp6AU7EaCU7VGQ22+9OZEQwL38/3KV1iwhp+U9
 rpcwPBCwjJnJl5OZtOkS0jgPjVtIs+HV9ghXkavwwL9k06i2kRjRKTTfb8NpitQhbrWF6ydbs12
 YCeg+fNQiCtB9egpJzxZT8tRjXzVsFnZJCcIduJ+e6jVMMD/zKILKmn/z+noA6ksQ8lcS6nBIiT
 sYxLLxWfIJ2FVsALhNTkYcqy90qjpa2WMeMGbnOX9ZYu+7KtSVY+XVKtGqx7uUeQyIPclwzFu36
 HMdJbCyTbWHEAiLPetQ==
X-Authority-Analysis: v=2.4 cv=O4YJeh9W c=1 sm=1 tr=0 ts=6a7af522 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=29JQEVyTs8Jp2i393pEA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA4MyBTYWx0ZWRfX9tzNvlmkUNCR
 dJGAd+cp6zZ3mYuOM/BahKA7sUi/C2zJ/pNKQJVxG395hzXihpRujN8tygYa4V8lpStN2t2EeQP
 BkVPCGKuBY1XuRgQsEjhoLcGzKf3WU0=
X-Proofpoint-GUID: wQzThV1JZLkiXfM-sf_vnonmfpQoYGxZ
X-Proofpoint-ORIG-GUID: wQzThV1JZLkiXfM-sf_vnonmfpQoYGxZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110083

On Tue, May 19, 2026 at 02:17:07PM +0530, Kathiravan Thirumoorthy wrote:
> Add the '#interconnect-cells' property to the GCC clock controller node
> to allow NOC-related clocks to be managed via the icc-clk framework.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9650.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
