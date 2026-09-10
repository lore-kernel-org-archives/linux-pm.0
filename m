Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A4E3A254D
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025503; cv=none; b=GjGv5wSXiB1ZCOUdQ8+EF2szvKgmn8nkY/vuIuMNMKV//S9FNUYluMMqKI2IQVnoY2wJ2TyOBgvEhSmtpk+wAuVz4q8I5BtsE/iAb3CC1xE0Yxj1DkR4Ey7gtlPPEHbzgWdoRzc/W2K9ERJcMNV232lu7rz8Jy4vYjPfVt6dt4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025503; c=relaxed/simple;
	bh=Zn+Uzhi/j2vF5DFJqXH0N4ZBNMY4utcDCtgBbqStyGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjTz4GG7JUtAqcpe63YHqhgXY9nC/8l2lnfxnJZTeFspM744AtQ+RdpVeCMnSubqSwDVJIJidZ7KlT02SanybCj25BQuyNNvbiyChZHIjx4M8kkaMI30ZSzK+cVA/uKHhZa4UXEoiOYjKe4IpCIWPcbQqNDIpJ5IGcY8FExc8fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GTrWvSZg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EOTOXbvb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GTrWvSZg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EOTOXbvb"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5Gw5e319473
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hklCZ9GNU8o98OBsdb7gZIJS
	dTreZ28T59haFWN6/Ek=; b=GTrWvSZga35TcpEgGTjZgPIOZPuWBXll1tN5hXU1
	6RMcTzL1hgvUNdx3HM57YvdNxe05/eZbxRieJ+g2dNyfFxm+yefUwfCiswhPzmt7
	4RxKYmRBKhaZxhCWH5fQmCuRM5rNGZKPk6ZeJCpjVIimv7PwPgwJS9iArH6CcTjs
	IJWJwXzxD11E7Fe6UYAkfJTE3vuKqWsdIXVll6Pw/vys6FiPy0OBjrMG7quVvO9f
	SrfADFMsti2oaUVv6niG0f3z4ZWDjr8npp2G1pHea+1QbEeSw/Jsa45Z5Yg7Uu8l
	ZdSqvShZ1gl21oRN4DURDaeFST30fGgf4HN5Te5PuFFD7g==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyg2n7f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:31:41 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c8323b8464so1306609e0c.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 00:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789025501; x=1789630301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hklCZ9GNU8o98OBsdb7gZIJSdTreZ28T59haFWN6/Ek=;
        b=EOTOXbvbNSogSa1eBkjMoiGV89ICaW5FLYLWs0FkdYlOlhMUb1pEyDvOhoVjC6Ithr
         qnBtYiGKWEVY45gIDYmX24LpLELROFvLPnNpNJAmbNDTYIdIf2rhnuoW1HYO43CWHcSu
         LY4XVsD2rAK3k9AUfQa4641faQGaJlL+6iyCUzKJQI6WFzPEQCuoDU7vkxGG/J5WpAbw
         oAu9IM7C5iaow5QDE32PqT3poDhyQb5w1BkVncem6zb7GEOcN/TmrBLdwNl7ARZhxIgz
         uUmb6L5Q+xLRahOMZO+tr7B1+vHGvPJrXcfTl/6B1DGIOGryJeIDrLXmuNkcUxChNXAt
         suIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789025501; x=1789630301;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hklCZ9GNU8o98OBsdb7gZIJSdTreZ28T59haFWN6/Ek=;
        b=J/qP0tQR5WnIEyRZtjOVVRkkaewmxaIvc7BeD4+NEHTPJtlC1+4ngQxtuQ/bgRFOjW
         wxWI5ZfzzxkY13uVEkDn8Y5dBnij1/pcTVnC5fiwR8C2lypXwD5dK9UqJ2cmqS9JMopK
         Km4LxSjbRCtRpM1CB6dji/tYvcJrX4q474+uYfEJNgTP0UK/VAh5Dq6SX9cL89TZKdUG
         wN1cQv7EkA8P8tOkr9LI0qsoggtB2bpJlVJ89ddDuCBlCiQnYNzGRU1+d5UTdQsIqIsD
         n6H9uzkP/vlmBBOOR4Gsb6dp+bgX2/WdSqaVcLurTgV/vqmUQMgOQIqtZdJ5x0svTPQi
         Fe0Q==
X-Forwarded-Encrypted: i=1; AKwUvByUKkGGUjLTBvhzGHTUH35W+flYzFlCfcssdcjmcze8O0yIuwuOPbpmryzICT2sMooE7F2gxXGH5Q==@vger.kernel.org
X-Gm-Message-State: AFuF++laEicyqZs8adM1kHs1q6WkuB6/6eMx53SAKCuRtr9uvEMi96QL
	4o8OMOhnkezVjARnY7c3BTWJVqmYy2xvORIAOnM4NIfldTcC/4WQpwV7sasNBKPJrMeR54Wf8Ja
	SJ4wY0DgubCvPyxPNPb3++0VX0uGwHSvWzwkgaYneodDoxhhBcaFkelBKYlGBSw==
X-Gm-Gg: AYBFou3QIPorEZe6m97tOFj7WxiCbNfwcEv0+fpOYzoPupkWQJdybdmQm4cBj6Gax7F
	LAoh4mQkiqJ91qVM2D3AMouOCFDQGTxPSpI782uanlSoXtTMrfKHPm5OowOAn6yHWtTq1XaCOKr
	pG/SReFpxGQn/Ktsva3BagQE+asDBK+QbrQ5a6TFvYlvOYVh2xq1pNQ3iP132UxUt9i5k23e/ro
	tdZ8zNuaCNhPZfqNd1pe0ZMDak/G+xM2JHhz1oOMsEeKaOK2uQLJ4QbkyAghlMjrx5mkxHajsYk
	jen4eoV85jCbJWrjFmw6Z+OCdCfjji4svbKJyb1ZOUE4g+JFCoSOIqow+NJQB92wqahwa35KWN8
	C/T9y4TcYRgw=
X-Received: by 2002:a05:6122:8f8b:b0:5c2:b01f:e503 with SMTP id 71dfb90a1353d-5c7ed81a500mr158560e0c.7.1789025500855;
        Thu, 10 Sep 2026 00:31:40 -0700 (PDT)
X-Received: by 2002:a05:6122:8f8b:b0:5c2:b01f:e503 with SMTP id 71dfb90a1353d-5c7ed81a500mr158506e0c.7.1789025499938;
        Thu, 10 Sep 2026 00:31:39 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.7.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c06f04sm56091475e9.13.2026.09.10.00.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:31:38 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:31:37 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Evan Green <evgreen@chromium.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 4/6] interconnect: qcom: icc-rpm: Program SMD RPM
 auxiliary QoS ports
Message-ID: <6xhje5yh7yqfabg565uhcch3vyyisvn3y6ylhfhocgh4gi6noi@of4g2ekj74pj>
References: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
 <20260909-topic-icc_rpm_smd_qol-v1-4-6dc5b5e97626@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-topic-icc_rpm_smd_qol-v1-4-6dc5b5e97626@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=YZYodARf c=1 sm=1 tr=0 ts=6aa25cdd cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=dePp4Gl7O00gmbwhyVsZwA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=qOZR5Tkgscv2fS1d6PEA:9 a=CjuIK1q_8ugA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4MCBTYWx0ZWRfX0vGKI/Tuq/Jg
 4tJ8+gTYe+nILN5uDoHn0aoH4MtMd9w83SQzFWNB7dCu4e+KekBWqYCxwA9eTlYn763rvjqzzOs
 mwkNdbHn7pKWT/LeMZmVJcBdcvZ5PTg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4MCBTYWx0ZWRfX8Ra3xX8o8eU4
 M9UNxQYEeiLyJP3KjMkREoLT1EvFXoYU5Aos/X7sDdRSo3ddgWRkwWElLN0L1mL6QvIBmxTUEFs
 M9jCkeFlqZcKkZP8i1b2Y4zdLqA0L2FabbLDgT5GqkY3dFK5Hrt3C3mV3AELFpk11zdWNjZxziK
 zhGeHxODIE3DEeABO4VixSrGVCD9BoyZRk7ih6blyTUChdPwSHs9jUuOFjqqJjYINiS0DMI1yx+
 9cFLJPcleF40imUUuk+MpG26DNk0CMLjn6HFr2xyPeQnQ6IchuMjLI5lMVVXKenZH2TwHyLQ39Y
 gZ4NZSOrA8Mlg3egaq66BPloAKQSMF8EYeDQajkcZUi+WonDP/jS77ZVAZQ9of79KaA7fBi2R4h
 +Uj7xOyEwydc0WBn+k+adYrNmEwF18apseMYcjxM99Y3v28Xka5t8XKhD8pbqZ2/AU7ILmUCVy/
 rmCQZpviLuzHr8YG1SA==
X-Proofpoint-GUID: J7PgXKa_oOxeqB_4mEPCxnMyAvLCKA3Z
X-Proofpoint-ORIG-GUID: J7PgXKa_oOxeqB_4mEPCxnMyAvLCKA3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100080

On 26-09-09 18:41:57, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Some SMD RPM interconnect nodes own two QoS ports. Currently, the code
> only takes care of one, leaving some endpoints partially unconfigured.
> 
> Keep qos_port as the primary port and describe the optional second port
> with aux_qos_port.
> 
> Assisted-by: LLM
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
