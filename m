Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA5A3BB687
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953512; cv=none; b=PGpE+PMDNvpJ58th+yBXZOpoyoS4Z3wK7WHGts6Tz/iT1ojFsKklqT3wQ068NFCflPJIcffjMKV5TUELRq7JGdwMAsjTgsDIMq5QTANunFw4fzQAv7+uP9stCMTj1a/r+OVeY1PbgJ/m+6xac9RxMhOMPkoL8fqF/SHVS0A65N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953512; c=relaxed/simple;
	bh=zbH6WoBICLoXC/BGcuKmdHg9SUeMHfF6bhR2aKbUpSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SY+P7WpG43rYceRe40xFNMKVJtEdj3MfPFTw3TX85PG06u1TrOebOOy2+9lz0Aj4I9P5brWd0UMSPc6ChJF0Z/J0SWZVVAzDq9S9DdPmbTyShfGRtxXmLohgpoDYblOFkWaJJx/2z0mONQfXIaevwzaEamvmrVbgipvGvptTcjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JFtjP9zf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DgNbXNl3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JFtjP9zf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DgNbXNl3"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67H70uvv663103
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 07:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7r4ebRw9mreTVg7HmrNMvV9tbZ2lFh0RTJUFTohstfk=; b=JFtjP9zfF33JzjVM
	pKx4kg1vMAdgieJg5Rr9CUSP2PaSxVC661mNV+2mY8l04wIn8r1hFfqjWdUFthWi
	0k/VDThilU0lrj6LVoptaJAN5+VNzhs1ge3UXIx4uSdifCS7IX8JUZwcr9HHoazV
	S/29eCZFWF2yD//igQEnBhOsQPUFOLhmoPyNBnJfuQrcds0ekRT3Ja2TyhZU6RL0
	fxFYWZ6leT7soSzXIqW0HBE13yGtr1U4zo8t8C6i+kTtkRJoYHLaWy98PRsoh8qP
	90bUBMsCvDxYJjRgDBNoWdr1OfZES1dEmW0IQO9SrsHutZ8vgyACOeesxCwGJWE8
	cfi3ng==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghnwxeq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 07:58:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e5e21552dso19829485a.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 00:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786953510; x=1787558310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7r4ebRw9mreTVg7HmrNMvV9tbZ2lFh0RTJUFTohstfk=;
        b=DgNbXNl35dQajbSn9MIkBn25J4VARkrvdvJgZbPI9VWosFWnRlvzYBfMaJkZMuEs42
         VemSZ7LZ6/NmZZSJFKMZUY0hVXb4GHhgmLEYMP/Kq7OWmXiov/Klh9lNRXByeObzyVHm
         pbFbmCZfLwwE9CC+bQ473zpTrWXE2L/xpXJgj8zYBsiumpzV3NE5T0GwZD30iHnIGxgB
         7SJWEHbhnpcU4m8DRkF9EC7J2ah1ZmugM0lIjYr1QUptG5AUb68i6zox8/mPQpsWoYnc
         6t5cU2Hz0u4IHWu0R8A5t0zn6XrMPPS/ZLnP1h+d3wJN+fH0rbXL3U6gKx2BdpFpT7eF
         l4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786953510; x=1787558310;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7r4ebRw9mreTVg7HmrNMvV9tbZ2lFh0RTJUFTohstfk=;
        b=fkJl3xqDQTqqE/QV1lreOHprIWxIJEP8uTgsYoJtdgzxNKxVuXz7ZcNWt6ba6MIPol
         fu4iNCFapXmTYvG3LR5yjpkS2ytCQne8EzHgkvSwjB1V/9YZbURVcMMVz7CzjrPEqmRm
         C6D4ub1pAkQgPjrHduxH2DaRKSvma1AoS/VWjLQOrm2wrtJPy+ydL/ofNjBE4fEgAMT+
         Mpe2bLSPjaXrnh9R/NpdXpgrEJzVxE2jRffVZTVvpUW7q3qLm+lqHFTpt37vRMVIKptO
         cPIPVnHzM5ZiLLcSYacyATQlRY1m/ppXsQhiCKAkP5GlqV+p2Eyvz30Q0NvUzo2qATaX
         fRWw==
X-Forwarded-Encrypted: i=1; AHgh+RpMFMe7c7bXV2fjHnQuAnupWxom14KdLr00ekGjvjzJEPfDMI4IA2LPuzdjqMLFD0xByiRFi/JDiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzL8fD8wXCEFXzDJ4T7KDVemaIX4x5e7VKaBuTaXtvOaHB9e+jK
	G4f+MaJ6rS+5ovyx1+HW/BPywrKLu2rOt0+qu86lt+auTXdxaF49XhgpSvXCamIdgcUEZd4PVFW
	mvRVBYuslaNDSnvebhI9ivvbXXK0kY3LONCKXyBVwApriGUAoH/Wx+qEzzs+XRw==
X-Gm-Gg: AR+sD10ByS6lBz9v6OaX9DD2Dk6biG8DfaSRXTbEc6VKUvD1WcC3EUUHOSQ1IQN/M+a
	rr0Hc3NOJ66vAi2QT1Y4jlr14yiiFHUUl2q3Wj81DsnNLtB2GjY6b7gzGG5if1yO3u/Bx6tgB7O
	cbm9+5eCoyv42EAlgjZgarGDCZFCLjRfj0HoGkRJU7xygQfjveB8Sv17i9FE8lQCh7anlp67NP+
	sNj6klrvkDsTLQLULm7m3yyHMa0EWxMf+G9GbZm7uXJMDYIs986ctaKUxjip6X0OeRS1KQr2OID
	AmycA+MDQ0W2dt/jxyugItCRowRxMvMbWUwGrKlvYtnn7qULi3d2zcGKn+ywCJHWfKhC2dvVmVr
	px2NL27fQZdUPEPKcDXHBU2HT
X-Received: by 2002:a05:620a:460a:b0:931:4c8:d8ca with SMTP id af79cd13be357-936d233ff1bmr1745612985a.1.1786953509684;
        Mon, 17 Aug 2026 00:58:29 -0700 (PDT)
X-Received: by 2002:a05:620a:460a:b0:931:4c8:d8ca with SMTP id af79cd13be357-936d233ff1bmr1745611685a.1.1786953509302;
        Mon, 17 Aug 2026 00:58:29 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d8596ce4sm289925a12.21.2026.08.17.00.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 00:58:27 -0700 (PDT)
Message-ID: <720083ed-a149-4872-98d5-c4157586d628@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 09:58:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: Constify struct qcom_icc_qosbox
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Georgi Djakov <djakov@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <f9d9ab49e961b3bf3f9bad39f22cf8b06afb2381.1786554463.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f9d9ab49e961b3bf3f9bad39f22cf8b06afb2381.1786554463.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1OCBTYWx0ZWRfX4UCp7XGpeP8y
 mqZ+/clJx3Y5DFdrB47CGSjtMVm8bSea2J6x1nyofg5ySWAlIgT0n2eYCHenBXrmPQuHvn08Cfg
 gkcaDt1BgQlAv8xYSSi9C2kALOJMuZrbcePOQCqzoLgnPw1mmFlkVexUIT18mMqAX+y1CsDeqKQ
 a7R2Ol5hj7dXV6FDTIqnwY05pt5/Sqvu8L6Dd44ZAj3FEoOZAly8Bq1os46ULHHJxd6rw7pnrh9
 u4xWkHfGB3L6berWZbIiaR2pvej9GG48+kUQ8QEfXtno6vcW4hGICwudZrmz9Q4xDqYTaXhCF4e
 iYv6YZ326IGj0swugLHL3SvrKFLUXEa/Y5AxWXuY8611N+JSy8TXXmvQsOgD90cwkU9X7u+3XVW
 5E9KlQhMyAoLSznVDSzWy6eq4xMNA80M4SBtocBal/AUodLXIddsH5dtBBVy3nnqwtzhl+chYts
 sMqqLdUu6LC8/tKWR1w==
X-Proofpoint-ORIG-GUID: K90-en3ASLvi9Puoo6je6F8neLRcpiDf
X-Authority-Analysis: v=2.4 cv=QN5YgALL c=1 sm=1 tr=0 ts=6a82bf26 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=DA585B7Y4R_hzP9QSM4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1OCBTYWx0ZWRfX0lYNcA+A8881
 FSTa4Ef8JdIDq+OGIXzCPX7Loc31C5Qh4wfGimFYTcfS8ZiRkovPuuB+n6AdN/x0ICrKpD8720T
 woPgVl6b2gXpe0w5ltIL3A5AisaBhbQ=
X-Proofpoint-GUID: K90-en3ASLvi9Puoo6je6F8neLRcpiDf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170058

On 8/12/26 7:08 PM, Christophe JAILLET wrote:
> 'struct qcom_icc_qosbox' are not modified in these drivers.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    7807	  18632	      0	  26439	   6747	drivers/interconnect/qcom/eliza.o
>   10027	  20176	      0	  30203	   75fb	drivers/interconnect/qcom/milos.o
>    8768	  22640	      0	  31408	   7ab0	drivers/interconnect/qcom/sm6350.o
>    7626	  22000	      0	  29626	   73ba	drivers/interconnect/qcom/sm8650.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>    8095	  18344	      0	  26439	   6747	drivers/interconnect/qcom/eliza.o
>   11079	  19120	      0	  30199	   75f7	drivers/interconnect/qcom/milos.o
>    9668	  21744	      0	  31412	   7ab4	drivers/interconnect/qcom/sm6350.o
>    8746	  20880	      0	  29626	   73ba	drivers/interconnect/qcom/sm8650.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Thanks!

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
