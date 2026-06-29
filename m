Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243A0400E0A
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736174; cv=none; b=WHXwbsByZnJt5dJY/fGIF9nV71ELjkLmizipZJyTAI5S828U780NLVkgtRaxGzV3SKxRRAS8UVSyymuZVjdr+nPecRWKjuJ27ZFNVdPFgkgVzOkYwHutuW4LdpE1ZigudCC0MhBzNB0+5RtT4rsOVtDHKtnZt4YEtL2LpKPSDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736174; c=relaxed/simple;
	bh=3wkaVyo8f9C10ckpDW8FQOs7mVt1PctZ4+KQwkKXBec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvsZM1CVqM+icyZLKXwpdKZM9vdcvNaiHYyclWJBTxfY4OfahbPYLXZ2xAFrrEacskeopFA/X1sKOj8DliEnuAnFBCV1Lqpq+9N4VzQXoT/dmHoC1weo+Tx/ZKM1sxYdC5av9/oPJlE9a4gFSU0KRbZQl5UNQ6F17WVvsPFpCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UAQbONyO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iYxDCdZd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UAQbONyO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iYxDCdZd"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TASpgd2601110
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 12:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g8QjTG+MobzU76SuZmdM098g+XPk+Q3XuBlOoWFGPaA=; b=UAQbONyOcBavg6Vv
	mnuHEm9D2HiR8cx0XlQWUEjb0sFuSGBvK1jTyCylrAezm/9/Cd32+aLQ0l1Eoe7b
	IP3s8NqUlmI4ZE9IjZjqzu+LAe+q4Z9fzzB0XyYJ1huwhw39cs9XLaFA6WbP4yuK
	55OvsWBWq0c8eztsDcQQsip8ZFFkFIKfuWPZzWfpIwJ7AnXk7c4VYy51p4IKHjQI
	H4QVZIMgmIOAZ3hW2hGmMguehm15WcgE8VnoXJASNAtdBwWprlErpiYZgVSOGm4/
	s6xLfmk1luW6ZvIdzQ501TEk1988Hz+1+ASQTDrcmTLh62PMj5q4oHEHxBrQwuB6
	CBqJfA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw8sse-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 12:29:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51a15cef334so2604091cf.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 05:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782736171; x=1783340971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g8QjTG+MobzU76SuZmdM098g+XPk+Q3XuBlOoWFGPaA=;
        b=iYxDCdZd60ZuFnZj3MgublrfAkYI17T++8LK+4yPuaQp4z0LP6WKdAisgymlXyQalO
         VnvMKx3t+8flF6/vZpV5R1/RqgkOZrmELPY+h48apNPJ1skEN3CPNHuBKZ7+h4+JQyRD
         Ecy96WTLC1uUhOr0O9gjfScu45ybOI9sl/tcBtuDOiVuDojia1StOBY2H2nH+x+3l8Hs
         JS9+ZXU9SPeQLK2OzyoprRHAW/a2UZxRoP77VKo8sNtlchVDVu4O/sc6VojVrxCx5kgK
         UvqOup0jP8TFM4ZASbJ4rzloResEjzw7jIPGpZk6smV3GH+s41NScu8DJFZpKwsp3BsJ
         Fyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782736171; x=1783340971;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g8QjTG+MobzU76SuZmdM098g+XPk+Q3XuBlOoWFGPaA=;
        b=lL3YhzSlrbQKax1ZVWnRiovP9PTm9LQml07am7YqBNdXiGC57XHuj041iRggsQCfx3
         sXUcUN6RRNdizELzWRfyicvrvY5ARA30wphwiVau/ulKT7SzyGEZaMBKyLjNQnOT0Ozw
         j+ev08cntKy4fwUwxjtlpAolR929+tmNlN4muLlv5GzWJeIWbw21T1gUrRBUwYepwIc+
         FHpJr8bCRySYHI2HOfh/tTuZ9rLIJiSnB0rVQwh52NxOC1KN5rQ+0s/CWzZNyS4cb84A
         3u2Oy9Slz1JVG1RxaxNiRcAXP2dirO0YfUXXrerou6UkpaHcWosJ5G32OdODeLpxK3K+
         W0bg==
X-Forwarded-Encrypted: i=1; AFNElJ9M5DP61i777WTF5QAGx5wkUhfaQLS9JZcgS3YBN+YJcikxUqMowQ2x/7cGGFwFV57i0a0fG+xxew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbL6SeUAemX8OtiYmxcan9tJWKxteNM4ifYnrwlWK/2cCgTlei
	Bu8Bd6O7AfQQY7e5eQI6eVayE30kkCGvxg4QQa22uFngoVACCcZ/I7hyihYZeCGHoVXIq4HEiWl
	CBpO0PR1sLg5V8w3ee4nzc4A3FkWO056N5zZbGXz/mpHZUD6tz9Q7hLZWdK491Q==
X-Gm-Gg: AfdE7cnTJGCDrueg1g2eC+juI5S7N6ODejljNPFuweutKepZr+1eJyWyAOv8WhpzJ9Z
	17d7FsoB+WwDoOuhGANpTPO6z1ZjnUX4HQUykHtaq7ia+Yi4MRxK45uuwJAq6k9qiXc9r8HpcUT
	M4UYJRgowy7I4ieCmqwLOKdxzKLi+wchRlCHNSR4eDWTG/0xmod0M7lxwwjXlyexFQ/GA8iheyc
	5NIFOq8FKWDwQdZdZcXwDoLAQpQloVlcqlMnj/4PjqmD3+eWv8OSM4MUWUDFtfTc5N7TEJNtCA0
	a9ybrO4HHQNmVQMXMkGUt5mG45z1JKygLA6jcYdpN4A2LyG4+9OaXGomSTcqYgdZxLGe01UGz3Y
	RBOQRaCV//Al7yAuKM18RKkRVKOWaKzkkJzc=
X-Received: by 2002:a05:622a:244:b0:51b:fe41:4764 with SMTP id d75a77b69052e-51bfe414b9bmr23414781cf.7.1782736171480;
        Mon, 29 Jun 2026 05:29:31 -0700 (PDT)
X-Received: by 2002:a05:622a:244:b0:51b:fe41:4764 with SMTP id d75a77b69052e-51bfe414b9bmr23413151cf.7.1782736168361;
        Mon, 29 Jun 2026 05:29:28 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b0a53a815sm8454541fa.21.2026.06.29.05.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 05:29:27 -0700 (PDT)
Message-ID: <ba7ca0e1-2e66-4355-a8f6-fcd65010b08c@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 14:29:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] pmdomain: core: migrate to dev_add_sync_state()
To: Brian Masney <bmasney@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Xuyang Dong <dongxuyang@eswincomputing.com>,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com>
 <20260626-clk-sync-state-v1-2-4156d8196dc8@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626-clk-sync-state-v1-2-4156d8196dc8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwMyBTYWx0ZWRfX+bMJqRHXFei4
 ujPJ/tiWYTOLCw0WXD2/Lijs3SK9dfZetc+7jHaABANyOvukWvlDegqYaT4xXclWBWRyUBhCw5I
 A3Em0E8LsNoB6gN1ShEBxKZIF3Vrsvo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwMyBTYWx0ZWRfXzAQNJbwSgLdJ
 SRhxsZv7CQbOplrSM+AaIg7epKnGeTrO5y/cGC5CSkBfFGnqjpgXkwnJdyCTi0gnuIanjmdmLsy
 f1Jbj7h3rxut2GgkZhmFTsgUfYViCReVIGukbzgqUbm2ZIgFL5dP+NKqiehfmlHqnvWEG1PLBSQ
 VW1HW9aVfqYwJsLZxC7/Nn240Q9CaTERPzNeOSBkxLbcLn+JvtN86ROij+Gk+BrDa9jZ4ZJpVn1
 KZBaJvNHLf8q2BJsUf7sb1Wf9OTJ6Tm6kd/zI6K3vW4BA1yV2d2HEJWFfEYbw0gu8+nsVDDEgXT
 8jdfDR2cy2MNqkVXSvRVAXjiTJWqaIYSg88N7sjzwDLOz+WmlhduUxijYlZ8fSMuGaZL1yo4syp
 4lpCEcvATx9ClUrPERPhSt+rU3Sy05SGHMPcnohYxTv9QSeBVgg7Ck+Zfw7m2ZbA38wsH+mtqEw
 RIru+oj9Kng7FBZ72FQ==
X-Proofpoint-GUID: p4pL3blwIAMF3dPi7tafqOuRJwpNXq9L
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a42652c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=fDt9MinM2cAR7eUiMvAA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: p4pL3blwIAMF3dPi7tafqOuRJwpNXq9L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290103

On 6/26/26 6:32 PM, Brian Masney wrote:
> We have cases where a device node represents a provider for multiple
> types of resources, like clocks, power-domains, resets, etc. Having just
> a single sync_state on the device is not sufficient since other
> frameworks will want to add their own sync_state callback.
> 
> Migrate the pmdomain core code from dev_set_drv_sync_state() to
> dev_add_sync_state() so that this works nicely with other frameworks
> that want to add their own sync_state callback.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
