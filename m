Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3142236E0
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773485329; cv=none; b=tcpS07cvxdimrSD93r1rGfHBBrRMbj7OvI9DeO/muaEB6S3KGU72O7kfVWaZzAnZPhDgBiFTSsu57sUlE5k/zZ64e4tm/C5CRwc3zEf8Gvb4t4vGuUmsGSqdE4JzWHJPiGlyaCSRLW8TH76qBl+MUiLuNRkkW+HriUpYpC4Qr1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773485329; c=relaxed/simple;
	bh=UU+Fk+LIz19C2sjVgLxC3vNwueUmo1RiLU1QC8Vzblo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsYKP1ARurr4Y10d4u1FBFojg0A8NAiLWO45sfe3bA1EgQXaR5U+g/D5RZJiKPPhdeFFK9T8EjBoAaLk9qEs1vrgvB446Cz7ARr061a5gJWgT35eAWBAg4Wb8LYlUBvnkcaVN6uTIwYJPLG+HoVhBalb0QAcxQ6+H6mGA//1O9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=amEU/cCl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GC8dBc1M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="amEU/cCl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GC8dBc1M"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62E3nmZg2907795
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 10:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pDtL87DqH7BrxP6ZgmJlaG+UCwDN9tzI17C/xvRn3vI=; b=amEU/cClOnmDAxEW
	RdvghEnKId1h199EJJYl5MXbc2aQVYiL+4q39NQQcbQtUKLg8bZ4FEXRBshGN8Sy
	GVt+HNTWb874zeMSMfbnUwUEOSlZml6MFlCGOOu17nkfcAHP0NmnNjSgvm7Anjtn
	Zos7YjGCiJ0N3LnFDuQX1ce1MSwimsoh39FU0jkVoSHJZ4gRQYszilPyiulZX6Wk
	XmfTKsKY4+2MgJEeOEk/dRwL8Bueg/tpUhCTPQ140gOq27c1NJUnSFQHSCerkEoO
	Y19HPKh2scTQ4NGjoH2eMB2yo5sMgMb/jAPrsL6ql0UpN5wsG4DoEFApS7oIn0/H
	qe2IWw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw043gky1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 10:48:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd7d66afceso2048219185a.3
        for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 03:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773485327; x=1774090127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pDtL87DqH7BrxP6ZgmJlaG+UCwDN9tzI17C/xvRn3vI=;
        b=GC8dBc1MGaEV823bIKFqLiZ136+slWJsS2+k7UIcWoDegtRZ3l4i69GWBcz8Z+aQdO
         Nm5PUPEQF7gjdxfwxlpfm/D2S2e75CCGMh2WqoaioYOWQ1H4DSrbx2osev1GEqni48V3
         eHck48Yf1shRiwujWQmyalwQ7gCDHEGVW1TB5i1QpBqOsv6Ws0Fn370pvpPaI1M3SJ2f
         kznQXQkRebr/sD9/wE7TubUOScKioH3Wuna51JsEstm33UDz6Ekznch8Nv0HI9opojqp
         M9sMxi17XgH8pQ5nM7TmOQqCMJGiMkcGWDguAUOQYzac82vpJxHqCV6FU97el2ZDV6UC
         +fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773485327; x=1774090127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pDtL87DqH7BrxP6ZgmJlaG+UCwDN9tzI17C/xvRn3vI=;
        b=Q/Wae+n7Jb9DOev0uW5a9WaY7IYtgGQQ62TCT9nSjwsetjsdIYEK6eV7zkHWpyniMS
         APqJANMae5Hip/kC1oW5ypIpQHDNEP6t+Z01lirzlTaH/tfPOg39GX9ey5Umshy7DpQO
         PYVxZ4ULRqKeIQ5XFV1zmTOps8rcIdbq1jZJP5NCAhfGvw/snzzrhZ7fTpzrHUHaKcnZ
         EvRGCrqpBsZicujCn5caztzJhybFOzYNiVimbCVNsLrz+ydOe2UYXYmSbHvJFqeAb4/j
         6mvbRFqJ5CssWGTGpMU1I3NBuHtbbYLU406QcoLbHfVShzxKHyOAYeF5TdbedMOkad5p
         5PFA==
X-Gm-Message-State: AOJu0Ywzu8ig/L5AdA7nAHVaabdq+KJrvc1+6VF86JTABQSUu0ARVjPd
	M+K5c+YRYsCaz/hQOhR0vZjgF9efNtzzNFJEoGGaejU1C/8BuDIAysITXZMdAjZlIH0MNu85avl
	H/Lv/yXBRdwuekiNoA1zfDKTaj0SM3X6ShW8rFdIbP6oAY0rEHu40kPO2JD5slA==
X-Gm-Gg: ATEYQzys7bHJkbA0kOVkxhR/e+0gR4NMwXChhYcWwFO80V9FCm8XiSZLz0kk03ehmCf
	VfXzljkqW7McNjCPH4d95bhi3sGpgtBMqArttNwvBMZnoToWfQjlpZ8tKhKordHioPapjAZffvW
	Xapld+PWLN9UU0ANYl6XQeGfoKuPl0EUpF4kzUJ4xMDi2DMyZRX8DuOqcSnMhHBnaTwkbzeqKrc
	Cd+vQ2QKuOmqRILxAdn58/RGlnEEyxmz6hPQE926EPfc9KslQulqNnkCUwEEi9giDRtHdajYLnC
	LeglzoYR41vsAEI9M37BqM/3e1UjmoSqNNhrPb5q1/Rv2FHxkajLVcB7xT3fL47SVNLyL9hNE6O
	khitYlTvBa6YB8sfiy3MbqNseSOodNUYXalYINHRzaKqGS5xVBBBe5tTYU6nxV2lrJ2eHmybtt4
	umfi8aIw==
X-Received: by 2002:a05:620a:4008:b0:8cd:9aba:f5fa with SMTP id af79cd13be357-8cdb5b2486emr846095385a.42.1773485326646;
        Sat, 14 Mar 2026 03:48:46 -0700 (PDT)
X-Received: by 2002:a05:620a:4008:b0:8cd:9aba:f5fa with SMTP id af79cd13be357-8cdb5b2486emr846093085a.42.1773485326161;
        Sat, 14 Mar 2026 03:48:46 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:136f:df3:89d9:875c? ([2a05:6e02:1041:c10:136f:df3:89d9:875c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a0b2e2c71sm9406766f8f.22.2026.03.14.03.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 03:48:45 -0700 (PDT)
Message-ID: <192b7bf9-3ca8-4ad1-a62a-1031a2afc9dd@oss.qualcomm.com>
Date: Sat, 14 Mar 2026 11:48:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] thermal: sprd: Use min instead of clamp in
 sprd_thm_temp_to_rawdata
To: Thorsten Blum <thorsten.blum@linux.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260314011305.710278-3-thorsten.blum@linux.dev>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260314011305.710278-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDA4MyBTYWx0ZWRfX9YdSR/yKWK4g
 fYTIyTE4YftBx88iUX8eZbd0mgkcgszj/Yh25n6uE4R42rDomFNLWnetYTwTRCYB2sr9ocmeAwk
 Xod9p/slyBkE/4sRRtNh4YptuEQ2SLVGZ/qIZPeFTm5s4pYkQqhBjB7Euxk/V6ZBGK8/j1iuMHn
 Fy8ZJtwHzMo+hv/DY/vx+2LP6qXsNtnstZZ8nMhUET9aJSDpKgPZ8RbNikDbVXtLI6DjLO5AY4X
 XC9GthJ4MYje95cKFvnZjqFsFrt7wTPegIrG5yecGdpcSWFot8rSR43DDTSRdlN5S/XftpW+OAv
 e/yVtUVKIgasl4J8KqmYHVNzFXCcpVskaC8OZTTL37w0jAvztSD8yIlZmORvhuY7Z4KWZpD3blw
 rl4LwKyBv3LMMvh8eQweJKCbdDHNM6NbFO6/ZPjPIayveo/ouT/CXSgVeaCgz+E6m3iE6PxPKDA
 YSeWc915QKhOCpKuZlA==
X-Proofpoint-GUID: 1yqK5HjyxgYPdbAh1W2Og3tSbnDcFUDj
X-Authority-Analysis: v=2.4 cv=fLs0HJae c=1 sm=1 tr=0 ts=69b53d0f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=SRrdq9N9AAAA:8 a=7CQSdrXTAAAA:8 a=wIpeOW6K-m9DRuqkSnAA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: 1yqK5HjyxgYPdbAh1W2Og3tSbnDcFUDj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603140083

On 3/14/26 02:13, Thorsten Blum wrote:
> Clamping 'val' to itself is unnecessary and the expression can be
> simplified by using min() instead. Casting SPRD_THM_RAW_DATA_HIGH to u32
> is also redundant and can be removed.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---

You can stop resending, it is already applied :)

https://lore.kernel.org/all/75b4dbdd-6fb4-4dc9-a791-8c8a0e8ef9cf@oss.qualcomm.com/

