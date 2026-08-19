Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD430567D
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160499; cv=none; b=lfm+KriwE/qQsoqywFGpqedv2xCKwRaNGXHI+YRB9SRjvuU3HfURzMNbiBCDG4+5E3Wjar+tnV9AHsU4kw7bKTOEcDQcGB+O6TRL8E9SUMM4NXW9nJRo4ng8RrFx4snqgTqbSWKD8SbiVeeBta7S4vFoTz66lbG7tXIDnLBlFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160499; c=relaxed/simple;
	bh=oEsnR0G+4/8gIcOwa57R735mddWJ+fim5ceAKyw44iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvxtrZ07LoqKBGx+VRtU0CYzl6yJL7zp866RNPi36wi3guNz+2GQJ1v0LD+cDr1OopMjqb5ufvSnaF1KXkvPTcs3Dn9tAUPw76uBturDmsiJtCPa31WwoXphT8rebMNXKuHAnv3odp7K7z5FaElxni56ZuBqODrc8dq8ymfiqx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZKEqko4V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aEqBGGkb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZKEqko4V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aEqBGGkb"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF1CYN3869735
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 17:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=M2pAeNwqMk7inVBKAPe3gHMS
	5sA5VsbVnsdoFXfCKzw=; b=ZKEqko4VHwPNqY2TzYy64NcRz3/ndXCZmLbX1Tbm
	2+ktKgqXv0rwKFaGg2id2pmp2oCapx2xuIVm2VuqvYmdKB6/7xg2b1WB2vD8gOMj
	cwoaJqKZ4iuTE8JsCl3u9dT7O34iRH4TERx4GFCL62EXAXbMVe2UKCoRMaz4t+Ii
	iIiqR8u66fyHrBCWw/tfrcm45ZlwqxFdHpOu2gvJfd42LTmmX2NxrDlVn3LHGznM
	aIcPm7czkqRcB/jfSPGnNK2W6UTi6X4lU59Q8q+bdBi5/qLnkggbX/h+imRLoFVg
	UgtkAkXd2to4zb/n12lyiZ6xhguvfrv9uQyun/ReajPguQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5ervgsr9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 17:28:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9309af14fd7so152272485a.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 10:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787160496; x=1787765296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M2pAeNwqMk7inVBKAPe3gHMS5sA5VsbVnsdoFXfCKzw=;
        b=aEqBGGkbjc9tvXcnt63DglSnFvqgWXOGfZNsPkkijYTUcynap/lNb2h95efQaXpE0B
         MUVqmU4n9MGpjCbtz8uY0eq+bwIrIV+x4JXFfvzH/QBMUpwcGSM39Zk1rroMzjxb7bH3
         KS/i+ei0gVkUlgCyI7j1lyw/mrNq9HPyW8wvoSjU44XyQCU1FFfn0ToGSFqTb52tBmPW
         MIZsrb6eOG8h6L2tYNzH3EGa8RXWPieVsa3cBA51UfM10vKoAACYPPjI5hOIpdIWCyGy
         DjKcjpwCgL8f7Sykqgy0kvgp4iVKqKfXSrgYEhQ/w9377ANmK1nCLPpExMAA5wPOCAo8
         RkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787160496; x=1787765296;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M2pAeNwqMk7inVBKAPe3gHMS5sA5VsbVnsdoFXfCKzw=;
        b=OkLBPQ+42e/PVVcSrqxdxt0+a/qPboLqu9hqdUhkXJsSSC3PT8nvTEJhOhGwUcgXey
         QFy6+PQCUE35OGlxR9DUmHYo30S7qZOCpCIPhwsk/Bk85BRx8Nwud8eTFC2G8aAY/q4b
         SqfsQhfGMnJ56i6zmf/JoELDRr68rNL3CDy0WjRbiOzEls3M2hPHZr4eLIy4ZoHxRpcF
         Gd6MExB0loedRxc91NvVzupK2zSeOKra93Pseoqq7V1kdDPlTWb701IrS/1Tswp/mmMJ
         +qSosSnBbSTbQX6NEhInKp79TyS/+t43iaL4B3GIlmBWIHWFLvVC5dOJPsdXfIq1eiCe
         ep3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rop9DZH6uNYWE/fJDBsO94F0EW71So6YUSw9Vwe1lDy5w9B65kr3U9AxEeTvpTg7ZYyJ1Xv7XfDbw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo2M8Hj2nbs4jMauwEFcHUKv0zvX7Llo17a3HMXIDvEY1u8JDH
	cHRvwLXdvm+yqOs/Do8sQ9Bh1UGmNzNQiOzD3+x1vkXPmXbwJASuCJCZ6MZqrudv4q0xowSLMTT
	VtTg1nKiVvGe2eihqzlkG1b772H6Vk+d+xCMbXj/64H2ScfsQfvhqKCcINUrsJ1y6y3Ar3GA4Lb
	Y=
X-Gm-Gg: AR+sD118DVCvfzQBrkFtBKLyx2NVis30QYo+uhIrRs9ovNQFQdG2y/DMaSQdNGOzVtn
	WbWGQT5g7OoNhgaD013bYV1hrmpO/67bHiU9VKxqVe7OppiR5sxambNJuv489zuox0PHG18P78a
	ozgjf3EPmbrHwIUDtlPigOC1dbzmSmjX42R7b6N43TT4xQU/GIBVQ0h7pJ1IX6sHI14Vt/6OSVq
	V+zBT07HoB+/sI6Vgy51bSc4ICz4Sn0yNxXix9DygPvEDTfQvSZwE7ULlRfNieeRmfj7iN2uF9X
	H4cZmXDnbooAcG9PJ1Fll50MkreMkSCAA7iGr1JvguYGvgX8PLWt2baOL0O1807VDfiXEx3ZlZS
	kXWl1imJmyL827Zo=
X-Received: by 2002:a05:620a:28d3:b0:92e:4bc9:6ea9 with SMTP id af79cd13be357-9371e11093bmr538428385a.0.1787160496178;
        Wed, 19 Aug 2026 10:28:16 -0700 (PDT)
X-Received: by 2002:a05:620a:28d3:b0:92e:4bc9:6ea9 with SMTP id af79cd13be357-9371e11093bmr538423585a.0.1787160495573;
        Wed, 19 Aug 2026 10:28:15 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa1755b2sm73953235e9.11.2026.08.19.10.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 10:28:14 -0700 (PDT)
Date: Wed, 19 Aug 2026 20:28:13 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] pmdomain: add support system-wide resume latency
 constraints
Message-ID: <5valvqsyholhrainifuxwdih6ljhg7nzdszw4wqi64mdjts4jv@v5iq65l6tkuw>
References: <20260819-topic-lpm-pmdomain-device-constraints-v4-0-7ceb095f5474@baylibre.com>
 <20260819-topic-lpm-pmdomain-device-constraints-v4-4-7ceb095f5474@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-topic-lpm-pmdomain-device-constraints-v4-4-7ceb095f5474@baylibre.com>
X-Proofpoint-GUID: yacWyGhc4OxoRcYEeXXPiEoL_fy8YZOE
X-Authority-Analysis: v=2.4 cv=VZ3H+lp9 c=1 sm=1 tr=0 ts=6a85e7b1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=o42MjlPNU9PXQ6s_XnkA:9 a=CjuIK1q_8ugA:10
 a=zgiPjhLxNE0A:10 a=PEH46H7Ffwr30OY-TuGO:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzNSBTYWx0ZWRfX1hv/4W/KKPLE
 Bk/Xd3xwwT4N8DIxoLjjsumVshKo009CQRWrW9vLmFPHf0bqxeV1G4ljFNIgyW173XclJ4rpUAf
 AYbyJqX985ritj6r2C03Lqrr/EnXG7Ade344/c7VxA5YRh6tfzpzYD8u3r2vxOjavTujOuNPLaY
 X9qltULVuXORpR9wlQDURZQG9j1YyPD8s47wzuQ3k+7AxUoAr/VenneDf81JfebXefV8z2dpisz
 i+vpDoDFFc1ceRyBEN73C7VFtkfkjIStLAYU5rERvZltk7iD+SAP06D4SAHt7544EFqamwq8uqV
 tpja8cUfZSnw1ChEYeaoXnYRMGUVwgexBSS14DvyxOG5iXnin/KHQObGZ+Sc59Btf6Y8hIAD9u6
 aJkQf03jgsyPRELfikJ6FKC80TT53v0Fhq9qAAOIs928AhVpIsm1/K8XBdJsnh+AzsxFsP1pQM4
 DeeVtUqAv08DOXK+iVA==
X-Proofpoint-ORIG-GUID: yacWyGhc4OxoRcYEeXXPiEoL_fy8YZOE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzNSBTYWx0ZWRfX4Iv/lA6s/cRM
 79Vx2xhuci1GFcqrvNjchVlnVUqn/7HVDWzr/2xHMqN5uSpwknArSrRgUs3Y9NuvUnDQErhVhmG
 9UUw+c0uiqydccUc10S7NyQ794DTr+o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190135

On 26-08-19 10:08:39, Kevin Hilman (TI) wrote:
> In addition to checking for CPU latency constraints when checking if
> OK to power down a domain, also check for QoS latency constraints in
> all devices of a domain and use that in determining the final latency
> constraint to use for the domain.
> 
> Since cpu_system_power_down_ok() is used for system-wide suspend, the
> per-device constratints are only relevant if the LATENCY_SYS QoS flag
> is set.
> 
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
