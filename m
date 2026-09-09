Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369333939C1
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979048; cv=none; b=Q5SHquwkXnD+JpF0jTZGAbrPCAS0toqndy8RZWsCetZvE+voTW1njSHMQbFnxKb/YCnRCwH0wk943lFQZa2SVOFKwJ3bKxX/AQIqZT71qjg/7g+TWLduYViKJd5xvda0WVcQ40sceIJj1wnoFCW943LmuCLfTU3Rz/590n7mvjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979048; c=relaxed/simple;
	bh=CXlmz3Qrz+2s4K8YtyrdzhpAlduZURZcGsKuwFIC6As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2bE3d9BTgHrWSQsOuDa7iuOTbV1o/F8YaUE+CC07njMhFFlrTfdNikl3WhEhkTKTNk/dwdcvhX5Vxy9GxigvQp+LQ5uPVwvCYm1ZyXBggTSN9BdUW/nDYDoJxKOM1x8UsJIDKPgjuUtojYxNvmeuti1x8rmlig9Tk8OXbyT+/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FgYIW3k/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gx2Y1HrF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FgYIW3k/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gx2Y1HrF"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689H7VA52771741
	for <linux-pm@vger.kernel.org>; Wed, 9 Sep 2026 18:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=quHjMOAd0R0WYl3Mfy+0+cjO
	+Cogwa/gMhTd7XTRQYQ=; b=FgYIW3k/Po2qhpHCG60/8qq+u3kn+siHvlJfxmgR
	YwFS+ioUfPGFropHZGUhADSlIyDZOyBxJXbL8eAFOl1WMiwRQ75nO24TXzjA2482
	XwV6UkL4+8sGJcwDwWv9zfzyRXMDs55Y8FIR76ilacA39edRNCrefaQBVrlWCwe9
	EaGKN0yNowRVmPuCnvyLu+ZgGt8Qbmmawj3edF3opVu5c2tZjAX6UJXmMkSnucmR
	2yquqF2nLKkYMKvbqtfiUWcVjjgjKRHxHrZdLEcN17d7b3u3ggMcwIn57EHvMpG9
	6mV1iIeQps5cmQ5LG6Z+/s1Kx6pDjpCZK42SqgIm9fwVkA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk62xa4wq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 18:37:25 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-97e98448895so543633241.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 11:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788979045; x=1789583845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=quHjMOAd0R0WYl3Mfy+0+cjO+Cogwa/gMhTd7XTRQYQ=;
        b=gx2Y1HrFGSluhpdjxLwat45Bew1ZnJ3k+4tc99ixTYqJSm+z4eH3MXU+0hZRhS1LXo
         Ehwvuk3jN42x3W0dtDEWM4Mp1qoVy8z3JUHyBhfXunhkBPV4rI5F25RTA/Gu3dapmZZ+
         SvGkd17B5byWytL4YX1zqGQ6Po6aqv4i4mwJeharhOLw+PIPdYiaIKLqnGRKU1rBY/5N
         JkKCKkfpbE8JZV3fVz5fEgieReXkzWYfqIjRmhYoQ693T86HIAqNmFZKbRG+fqBPnDaJ
         By/xJaSmyh3ORdHuxyLOn6ntNOukARLXOXIkdIdV+d4HpO+XvopWFxR26SGfEr+7lJfw
         LDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788979045; x=1789583845;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=quHjMOAd0R0WYl3Mfy+0+cjO+Cogwa/gMhTd7XTRQYQ=;
        b=Z1Tq5P+D02CJnAsi3bNXhHw4OxK/vE9cQmTsE1c64FETWqR7TPl5TRJbKcpwZnFspW
         ar+PjqpZurgXc5ahK5XiUxkFpSc3Admv9aQwKKBZDeT3otzCEMz56EmR2trbs+bO0Ea/
         9QgNWu5HPTdqv/D8AR2OfetB+SF5OjGOsIBmek2fpXC5Ut/EbS2RjBjNS9zgwP+rkp6B
         uR3iCw9gKkG/jVCj/KY71JbXT4+hk3IaML3eMnS5PMijkZTEb/2RLxOcjTiqqI3OFaLv
         PEMA0iLlZ1K/1fwOwS7+yeUezrWs3NFRdPLkhd7RTpsYBqjp6Iy46IGlY+50kBhnb2P8
         KCcA==
X-Forwarded-Encrypted: i=1; AKwUvBzxQyTznrzpp1nLlYB2GBFVFLsClNpNW11RN+qjOBRx3Ox0M+3ptFMNBxuYP/mvJ9pXUQ7qcFfSVQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m0f1lcBBtqQ8fwBkU6Y2NkWqvWjbPDXnIHc7u4NceKFdZDSxiz
	rxLdIOueuiIVIqqvK6OLaBXD2kCA/rCA2T8xMF60Uch91Y1cOdk/ySDLjyYpS+fNkMBYNDz4Y9K
	0IIecuj6KW5/Kc/YT1sDTFaV+j/lRnCmgPwYgTOge7gxc6bT5beS3U371L7nLpA==
X-Gm-Gg: AYBFou3UY/1GL1jd99e+0gzSOlKSJHwKeHB4hUeqrWr9QKf3FtELqwbUmP7au1Xyyqs
	hyvcr6NpAR25tqGX0IlEAe+vTTzWW2fRdG18u4X+tW399CZiJT0AhXZ5+q8KMJE6K+j7mapaQV9
	Sil+aNuGvFf1GTiXa8K4GdcV6HzVBJff1y/ahnpD8XTOZK7nhIBTQAmj3v7wSAGs3wfjGOebN5d
	+0J2MveFyB56kuEEtJcCJjDv4stcnKAZ+NxEoP++6J5gvJowwlmCKW6DAr5N2nrYGvie6vlvmRF
	dw6FNmdyxj+YCg6n7QcysfGEW4CpVB4MuyKhPqzT+9EP3a0qZlW/SO06e/Mwr6gZp2oKCD0h1rd
	MTjCUQKfpX7J6CAVSaJ9D4bdyTFuud18mg0FVkDM1ZjLTpmnbOGDy1CQMd4cLjobJVSYt2u0pkS
	NlxnlNJPlRj8ZA
X-Received: by 2002:a05:6102:41a9:b0:784:4d38:ef58 with SMTP id ada2fe7eead31-78a4a57f683mr14834702137.0.1788979045161;
        Wed, 09 Sep 2026 11:37:25 -0700 (PDT)
X-Received: by 2002:a05:6102:41a9:b0:784:4d38:ef58 with SMTP id ada2fe7eead31-78a4a57f683mr14834676137.0.1788979044698;
        Wed, 09 Sep 2026 11:37:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b61670537esm3966734e87.66.2026.09.09.11.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:37:22 -0700 (PDT)
Date: Wed, 9 Sep 2026 21:37:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Evan Green <evgreen@chromium.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 1/6] interconnect: qcom: Move bcm_div() to common code
Message-ID: <v7rrdfpcj4wi2mjspxhmnrf466exjshj733osyv5szkiebznvw@qoex3pioyqtm>
References: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
 <20260909-topic-icc_rpm_smd_qol-v1-1-6dc5b5e97626@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-topic-icc_rpm_smd_qol-v1-1-6dc5b5e97626@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIwOCBTYWx0ZWRfX30JxKGpYsCx/
 qBGMWtxbJq2RMIZqtIAZ0A8/AvNjUmODrIOv4SKc0QYV2044+l7CdBK4yQoAJ6QlJstiIX3I5e3
 edyil1aH579O/0UHINb+Ykyi0xdZdMc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIwOCBTYWx0ZWRfX3BpEvSrsuSRs
 9nJ8nau144THwii0iy4TOmJuUDgguWl2fH20lQxuIYa70gFKcP2PsMvcix8JR3bL0UxmKjgosQ6
 RPaNNL+aiM7jvxT2Hv2NALbSEIQgvigZ5d+q1ocD5kiR4jd9UuffPD7EmJ/fPZ5ubrCr9iX44Wh
 KwIyFJv5z1ehEYpbP7mtsN3VNlDdi+ZDgwGemHZ6I+zLLriWMHj2JP318Fkk6qDg/rF/o0FwFLy
 bK69AENlcitCp7rNyzl/2+eDYk/tl52jN2PZOJk/8IRCwJ8yxdlNfxKHh3JCZL8YQbXPpbYjILL
 kxBtPvGgtGbh/Fo/mMQ0pRdc/97SyzWG1pjlC/AecC5n0YNBxzMl2HtjM8wnEaQIEzl5u8FD5nH
 H2I5JUcKbcBLqsq8xQ/jYkRmcvvVgriN/Ix5yhodei7t7mLwaXnPptXh9KlDTGz5UwcSka2HAM5
 ZXqzrVpY6uRsNI/RN5Q==
X-Authority-Analysis: v=2.4 cv=UeFhjqSN c=1 sm=1 tr=0 ts=6aa1a765 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=wiZ877acDUlgFteYXlMA:9 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: fQp_maEBfciIzwZIxsCBNZ1wFHQKuOPI
X-Proofpoint-GUID: fQp_maEBfciIzwZIxsCBNZ1wFHQKuOPI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090208

On Wed, Sep 09, 2026 at 06:41:54PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> This helper is useful for both SMD_RPM and RPMH code, extract it.
> 
> Assisted-by: LLM
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/bcm-voter.c  | 21 +++++----------------
>  drivers/interconnect/qcom/icc-common.h |  9 +++++++++
>  2 files changed, 14 insertions(+), 16 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry
