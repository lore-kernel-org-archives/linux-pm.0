Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0126D41A56D
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008534; cv=none; b=VX83hlxaSk6b+/SHoV8tdUq9msDFJXCqk5KdXCSSK4OYUu52Qtxprfjmu6unkL+yrMqO0ZOdMmIk9iVThufahaePQJA/Z6twrGx5c629SJLUREyklXq/Qec3CY8Bckb6uUmI4Xij1IvZmZzbBVevBmZADOs/GhwU/eynlJVh40g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008534; c=relaxed/simple;
	bh=G7mz0q0mAi1g2L0tt6r4DOwAc/YTdbeN5mjBQ0fVDec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYumR+fpNvjXbKsCx5dloEhDTjMawig4OHZaUCYBuJYMcXOEwC80rAzCehe4jkuAIleAQZeGsgCpYtDi0mWwH2tzLMz7DQs/jZoSs/2ORn15LKPtXTItE8AammdZ8pfKfp4Z9kJNbxfhQqr9ZOCWFprJE+JOIvjLLYDleeez8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d85jKkwl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RLguxbIf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d85jKkwl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RLguxbIf"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676946ZY1763676
	for <linux-pm@vger.kernel.org>; Thu, 6 Aug 2026 09:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cYQg9aDclHgt9drJn2G90Qwm
	T+I4UYiJA47ezYOii7Y=; b=d85jKkwlU2vzLE/EIHCmQeANQQenfy7rwq2GdVOB
	nwZ7/DPpLjOn4hNiLaWPyIUB6SBEJ1KCXdleVqtEU+iwIfuNA7pcYKIToThGt6yE
	Tbvh6JSDBd/sOguWF5woaLvDKnAm27EfpyqifvviNb+e58txyjMiM5esQ6NZD7TM
	Kanj9KY050hb3eo8NV8MM7xU6c8lUPvotmkre59Kzzvh+G+t6sxXRzSxRKS4HNGZ
	Qw4zcRvQo7v23w/bgOzvfHoddfq1yAHhpNMYqe4ldrKjzwMg3DG9Zpm/EFCqwWVA
	eBbl8wLJDksQXCz/2OnQ6HDPnBoZDntwv083s2KBsLYmuQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjud19c9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 09:28:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5283fa0656dso9614061cf.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 02:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786008531; x=1786613331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cYQg9aDclHgt9drJn2G90QwmT+I4UYiJA47ezYOii7Y=;
        b=RLguxbIfBcexKI2/FRVUV0fmPPggLM3QEYlDQ9bC9fLd9Ox/XmNUBcZd10l7GgsATd
         VIuzz9KVvowI6+vLT4T4PfZVwnGWlpdD9v9khOJOyuKCVQo8WdkJR97WltU4+OlVZGvi
         NBeoErp6WQHNoBFfZprRc6REloLyXdvvKF2+0LRHNXJegLY92kOzor4mOBsD3ZSJJCvc
         SNmFBj7Ha4x6TMq3IzioUKDnnc7pvDkvpDDXuxCFJivUcgZvQbnwhQTryvy9Frxj4xPq
         MlfXcsEobLFLz7q+sxi6d9+XJ9Vcu/ajZXHJ0S5/QJMeIY8x3P84FYaqn0pB7nS6MH69
         oqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786008531; x=1786613331;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cYQg9aDclHgt9drJn2G90QwmT+I4UYiJA47ezYOii7Y=;
        b=ccdjruz3ueMaGmHBPD7ulY/t9oqA4qAnWW7mlF15IAJfDtcbRFDnRvF91i1eW+vP3I
         BwXEoVHPYvlsdYq4hapz74ux2YGJAPJbDZ9teGcZ19CueV/UYIVZx3UdVhmzV/iRej47
         5jXBkvO3QsQIzU/G+V8fQmj565MpP98NcdX/6dwR2hIILyWeSZHKm1CYAi4tT7XT66r+
         bYAYiavOeoNvHbDhCGuKX86a8HkIMFLQokyrbXbw1aH34ug2yT+8+FNxwdvD03D3QrGa
         umfbT7PCPKjL9knq8HHN7TiA8/ZEbTD25d1CeZJraEmY6Fp6bb1sYSm+WojZkFiDtaWH
         uReg==
X-Forwarded-Encrypted: i=1; AHgh+RplzMwomzxfm3aItHQI4XaInED0V2OeN5GRQLV+gNVqETMfjEoXs1JMC6T5hi6Gf9G0BhuyExZ8NQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFJH/NcRQb3Vx18gGJX7bZ6Ig3OdNeaBq6wDPPQ5ytFPDJMu/g
	Wm+p5aD3rxNOB8wvJYgnyWxDv1ojW+VcBABKBeX8FSA773ePjotMQJ3AhBh0riZxaMs+cL5KXh1
	asLQlU1tkkGqOyRkjSubkO5WrTYjls+Z81PHREZVI5fYRX5xpA6OKI9twBie1Vw==
X-Gm-Gg: AR+sD11G6ETvo9BZDPo+DOSdvIRqpP8XRQtrQeJ7AIK/fXrfGu0w+IkkWIXT9S5uE6H
	VPfHTZuD5COX5HIsXCy2FxyaB5Ip5sxH/zWK2/FYAE7Ilu52fyNx4ucTL8uNgH7TKiMM4cXObZL
	abdLRKY1KElq6Yyj2nhkb5WN3JZXUZPEqRWCo8Oj8PNYAfnghp6krj/MvQ2VUZhWk2kNfxKLzWV
	eizRR/+STqiZj35vOvPEZnWVA/fLTGIQsMS9cpB4kiRGtBWi9t9O8B7V6wyCS8TYZ/HTwEuImSx
	W6kJbmjxyJWkmgoMc7VqO/Thxq9wEgqF97RYJUACX0KS6T+h7QqBTdCG0cDLYHqlp6gqIS1BFU/
	KXYinvOgjCFza93+PUKEp03jmF+3vHy/223kvDAJjFNUgXuxa/cTB9JWove78o3GcfyCsMqmCEP
	o4TuAb/xLOpQPWeA==
X-Received: by 2002:a05:622a:54e:b0:527:7756:3ee9 with SMTP id d75a77b69052e-52cfa9ae110mr53895881cf.0.1786008531201;
        Thu, 06 Aug 2026 02:28:51 -0700 (PDT)
X-Received: by 2002:a05:622a:54e:b0:527:7756:3ee9 with SMTP id d75a77b69052e-52cfa9ae110mr53895551cf.0.1786008530768;
        Thu, 06 Aug 2026 02:28:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2fa841e46sm532312e87.29.2026.08.06.02.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:28:49 -0700 (PDT)
Date: Thu, 6 Aug 2026 12:28:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, linux-arm-msm@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, kprateek.nayak@amd.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: allow cpuinfo max to decrease when boost is
 disabled
Message-ID: <35it74zycctxhpnbsuvp6a6aazrjavarhq43fqgruafjv7xkt2@recuceutrqrn>
References: <20260806044230.909961-1-sibi.sankar@oss.qualcomm.com>
 <20260806044230.909961-2-sibi.sankar@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806044230.909961-2-sibi.sankar@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA3MyBTYWx0ZWRfX1DK+9yHHhknM
 qQN+73r9TfW9nTzkd8F8jIfP6IaPUssEeGxYCiCMVvaTGZW5x+bGCDcnhZnHW3gsCELDvuNHNW6
 rEVeDdib6IDd060oiZBpJbipTcrFhU7G0wPLqGUczPzgIQH8W42GQuH/pdFIq5Mb8zDLGtqD7Hl
 gCOfh7EFfvdMyirjHGsBn7cATbd1K9QveefADOPc0gtR7mAFYwbThFPDKkPnZtLNQFx0s2EF19Z
 CwtZNJQ5hPocochpQG4NR8o5buM4PU/MhUgrbNafWhIY5xbdcO4oE1nm9PJESreGljIRlbeqJ6L
 x1SrvEzUZE08xtyL7HngN/rEV9FW6KYaGSgdgt0azO2/503CwqWBCi4miXaHj7RlD33fawbrOkf
 1AXE/YevYwhmrUfGKx/7mUSezWOIvJR9wzayPSz+FjfClz/OXYBaDus4BaanAAb1rAk/7+gVYiw
 rTHiVF1rH6LlHoxTjgg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA3MyBTYWx0ZWRfX8pQg0NEc8xnz
 DqKuicgXPvfmUiA+K1clVanhUZFlmXmxBbj+yjC2qIvPKDOGDIzTJvp/xKfpnTTEwx6pWq/Su/J
 JkIDhL6az6wHeZHFSmfJ76EjDZ1VOwQ=
X-Proofpoint-GUID: K6c5QGwL7zD2Y8DKm_OnOO_ioaXIwgu0
X-Proofpoint-ORIG-GUID: K6c5QGwL7zD2Y8DKm_OnOO_ioaXIwgu0
X-Authority-Analysis: v=2.4 cv=DeInbPtW c=1 sm=1 tr=0 ts=6a7453d3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=2pZFztAVUCvpMdXWLIQA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060073

On Thu, Aug 06, 2026 at 10:12:29AM +0530, Sibi Sankar wrote:
> From: Ananthu C V <ananthu.cv@oss.qualcomm.com>
> 
> Commit 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly
> if max boost is known") guarded cpuinfo max updates to only allow
> increases, preserving values set directly by drivers above the freq
> table maximum. This prevents cpuinfo max from decreasing on boost
> disable, leaving policy max pinned at the boost ceiling.

Why is this bad?

> 
> Remove the guard so cpuinfo max is always derived from the frequency
> table scan. Drivers that correctly flag boost entries are unaffected
> since the scan already excludes them when boost is off.
> 
> Fixes: 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly if max boost is known")
> Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> ---
>  drivers/cpufreq/freq_table.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 

-- 
With best wishes
Dmitry
