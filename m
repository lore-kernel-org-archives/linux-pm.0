Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680C03E0245
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781248293; cv=none; b=p9u+fQKPZ5msy/ZsFK9Kka9uNJ+N/JybQGEEp0L3IT2FTTR5FIeTLtklKYr9DBTKC5KVNpZJrIFAHV9CehaatTrY2kmbxKD9VNtUBmD3cVff0n4veeESkmNaW8QXjzIFTBGFdyHpJC85+JOq92Dx1wGUk++k7AitzdLxTZJe3eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781248293; c=relaxed/simple;
	bh=F+L6o6Tr4+wSTemLWchDyR6SdCI9Noc5GlbpDkNWfpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCdmbP4S540KANjmseGUkyR/sFCuvjuv+q1UkTvyA6uj3n5KYFGE2qWiAJmOKCMLuJNV0yQjdi2f+jM3a6WM7erxU1o//D9+XV/T3ijF5zS1KfuwwBhG1kemZnVBlmNNuVPatQ7GJSrnthlur57KHQDtRWv7WT9mXWlXIxY05nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TGu8hlJ4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hyIkT550; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TGu8hlJ4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hyIkT550"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C3BteQ2451851
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 07:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sgRxjNUG7aBzL0yQw8/6avKR
	8LOtMiVPpCqbd9rfu0U=; b=TGu8hlJ4+AWlsPwF81/bDqSYT853ut/uuVsNkDtE
	TAy54zGaPsO5NajMyiDFuAiKir1W1NvYXyh9M5Xd8kOZ0A/wyoszzbDt82RVBoMi
	KNj5ZAYIxIxV19PwHIgMmuOVS8P8xzc/JUWL+89UpS0Z13AiAI3Jed/3WLW7NQHJ
	QxEJBGQhRAUwoafFhqOcCvdC2vgvshSR7KdEzZTXi9jGzWamyhBs06o7F6+rnz2p
	NGvi5XKF8echIbhMQnw6xUyIvnFRARFGI7eEnEJ639SjbPddeVXLMLQwaKBXFqT2
	dJt7nNxArsabCQNuRvPiBFnrWkmnAi7oW8SvudxMhRNjyg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1xcj977-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 07:11:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-517dadd84f8so12804111cf.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 00:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781248287; x=1781853087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sgRxjNUG7aBzL0yQw8/6avKR8LOtMiVPpCqbd9rfu0U=;
        b=hyIkT550VkgTNR0z58SzqTCwVGcX7z1UM3bkgtR9uki/wVXLuZ/aEfDryHd6Y26Eyi
         /JJ4mjjfzfcF67FyfetgOy/dnoKyY6bb8bqO03QWp9g8IA2mTXKH6tSQxYCsYXsKnTOh
         ROwLTrNyKGZLc6XLkE5LJ7EbbdLiV3RfljmqSLku6p2Km9cuSKfWuAf6H1J+CHo2QIq6
         UHeWm6O2PzhfNpmXLMyj/zx3a8hDxKrSpoFSV6GF3jZli0z14idclQk5MrPwlA1fabWI
         zO7lGETZb2qxqkh1PuF4pC4m8mZmGJSFwZEXEL5SRs9L3uC8VE5Mn/qH9n3068Mw/r7U
         E3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781248287; x=1781853087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgRxjNUG7aBzL0yQw8/6avKR8LOtMiVPpCqbd9rfu0U=;
        b=I/wfkkelfidFloAuBpAWdXYK15Pk7l1itcl1rqdq/WchbbUggVVRif7rvf4m0hWR6E
         QF6yjRTOsxZdHfhlOkIk4MG7wQcaBuBqMWoEFzruEGDDGnvMseCqj7qeVBi3CdWdGypQ
         5UNBDUxU9la3ZhmQ9IpKmsbzHnJzA1opLz4Ao7HB8ZrYhth+Br7zeC8ADNNAIRNe+WQv
         UofxFqOOhkf732+n8T9nQmX+jkPRrp+PkgAasVSlDL4RAENRTyMdTmSkBT3J4GE1Kcmc
         BruL/+q4eD56zazEnb8Uk4oJ9LUJRgcQUG/4wykDAD401kZKPvE+ob8t+2z7wP3ZR4Dj
         2bPg==
X-Forwarded-Encrypted: i=1; AFNElJ+gGLloq2pDNXbcLVwMEghRftrprL9aV7+u6SktA6y1/Of25CCAFmRf5OjiGX70YMUr321u/a0P2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzB1IVKgSwL60StZqc9j/l2NMnAMAZVvJLfF+cq3MfKctQ1uFhF
	5tGmhGzlUPfQw/u5K/fZEhi7A6PC8pPXEiYtbmdmXm8IJAu74Hl2gwfvFtx7CehZdYRis0ZvQ4F
	F7WsSXgK/jEdMyQEJy8fJnIsY7keN6AYxJqSQzEMaMvQJeoHkoDKIgqVNWfsn0Q==
X-Gm-Gg: Acq92OF7ijg2wDcvEUvjCKEMKy/JZx28byDEi6us2pdg8QEwGrKU6ldFBsZ+kXLfUB5
	DwT7eDVbysdGKVAQjCpDcWmR4VFXzzjgHbXsaZeSHxmH7LX0u+ArIHYEc5TBpWHiedBVs6r3TNX
	h6BlNl2VY9eEXCAQA05d4xYNhVCzG1/m6SvcshgIcuOYMfjLgo+UISSEiH43LIPFoKXo1Qs3koY
	0EUge1SWjI0N7YgzwB+nN2rHniyW7n5Q2JVL4+Pq9xaGHG397r4iFYINaoeT2h3GTz5+5Toba0u
	VafgcXZxn0bo8SCIoYMq3CFb94mgMNPoKhxxW/rBAM/XE/LMWoGy1NIlA/JYEDkg6xMVXyQf4UB
	FQqDXY6/yXvaFl9tmMmv+qqfmpmlkG2PZa7qeOQPxcV9oUx8eVmxXiHepxS1asGASatU59xl1K1
	zb+vOebDAQshFd97kVHtRcmz1HhJWnHmPYZ6E=
X-Received: by 2002:a05:622a:1191:b0:517:5b2c:6aae with SMTP id d75a77b69052e-517fe1de684mr18947771cf.13.1781248287482;
        Fri, 12 Jun 2026 00:11:27 -0700 (PDT)
X-Received: by 2002:a05:622a:1191:b0:517:5b2c:6aae with SMTP id d75a77b69052e-517fe1de684mr18947451cf.13.1781248287053;
        Fri, 12 Jun 2026 00:11:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1a7333sm281464e87.52.2026.06.12.00.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:11:25 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:11:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/2] thermal/drivers/qcom/tsens: Add support for
 ipq9650 tsens
Message-ID: <yi5jzdqmmynosrfdkdwz2btesbkyv2vwpkwvpf3yyp3exavipb@2z2gvgg6p5p6>
References: <20260610081241.1468507-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260610081241.1468507-3-varadarajan.narayanan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610081241.1468507-3-varadarajan.narayanan@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA2MyBTYWx0ZWRfX6eTGZSK+Fk2/
 cM04RvnZgMpsYin8XV4VIFTeNp8R5o2PDXaeNSYjM6VZ05LUBcWqThokFmNJrgJgHvgP8p5lIDo
 WAKdYTLYnTQ7NBKkTbIFZRYB1vz3RiYFltFqMy+HZvhQVXDyHdquavoi1xOgJTfd0jZ8qoHQys3
 UgF8ymCUJX5/eHhT4Hvs154lR54LrxkK+ffgF/SFgmwOWx1NqlO0Pz7OWlkbwwIDSKijBSVcTW1
 MF9eIznHIXAAbUGQMuXw96zu0o/3bbCXCv8BYlMAVEtdF9Tbqmp4u+e2qtH2xITQ2wEv80gchNI
 gKhSnU+N4lxC7by7iB+HXM22GZvZJNt654T8nx7prli93vfBc0W4npc8YarP4G8JyBVJrALWQyM
 WGel4/mE1ryTVVS+9sU+e6mrFtD8sS1yFmlK9AO0zzTP2uKaAhyj/L9J22PL4/Jq4SKTJ9OdbQD
 4Q1hMx4+rqf5RDk0h+A==
X-Proofpoint-GUID: QNQpMSwWa7L1RZcqihe0pFH2B7-puS_q
X-Proofpoint-ORIG-GUID: QNQpMSwWa7L1RZcqihe0pFH2B7-puS_q
X-Authority-Analysis: v=2.4 cv=NZPWEWD4 c=1 sm=1 tr=0 ts=6a2bb120 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=Br5ujosB-dOo-FGV42YA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA2MyBTYWx0ZWRfX5CFGaONuCwF3
 8CJUyeH1P6zgsdXzDNpmZ2rjnaDAu+w959fGbMKxrefowfOypwhBm5CMv9Uvst7aEUsBe0hhEU0
 HzrB+hhiotJN0TPSAaKwHn3ULFjW8i4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120063

On Wed, Jun 10, 2026 at 01:42:41PM +0530, Varadarajan Narayanan wrote:
> ipq9650's tsens is similar to ipq5332 tsens but has different number of
> sensors. Re-use the ipq5332 data for ipq9650 and modify the sensor related
> information.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  drivers/thermal/qcom/tsens-v2.c | 8 ++++++++
>  drivers/thermal/qcom/tsens.c    | 3 +++
>  drivers/thermal/qcom/tsens.h    | 2 +-
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
