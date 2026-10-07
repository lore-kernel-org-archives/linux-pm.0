Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689DD3BE645
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 07:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791356833; cv=none; b=ErqlWmLdTGTmqV1HI20ze3IjL/TgKYax5hGQHUUoLQwA3KHM7seMs5WXhvtPDp4KBqLiayxNs1QNju80A7PVfx37qS+hWMacDNNp8eynkb7OBY9u8kxkJhyN0l++T4R0h90UgKoQFx4oufTpqozpRxNMGk+2E2yh7b804sQN5Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791356833; c=relaxed/simple;
	bh=2xu3ydqR25irKH3DwztwsUkt8vMa+0pAkoN6XvXyQ4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpQfala//Wk2Pqc/zmET5k0lRLJtwF93ufQ3eXH5qpP8gSXy6I/y3oIML8W2b8oDfpkCEuLal5tzTcCjJrC2n18mAgQZcXQfs6+nZBnBvKAhuMXQbw8SWdXA3xYCY+jaOAkF/nMc8OawKcPFVmLWXc2PfWj7CkkK/7dIpbc6D+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NaSViDn8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WsDSRQ8z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NaSViDn8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WsDSRQ8z"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6974U87s1895357
	for <linux-pm@vger.kernel.org>; Wed, 7 Oct 2026 07:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=REdsKXMdkmNBVolsHOiGFdM1
	vrJDGL8kKYoVEdCkWkk=; b=NaSViDn8yT7Lltx4kDek7qbhz+RVHl3A2ZJBFGmY
	vArKbx2G6mtlQH9axzXPfM5xnTDS9v1VVGoijvbxtN/dM6LmFFCN5EOSxWmid560
	vsUo3obpJZbZwKYi8d7/p7buR+KrOjV4mUO1c2WlJtKGIqpyoD+1jXIZ9rPFBfqb
	qmft/OExaoeycsGeWIIxSSkDoo4OnieAr0+iBs8EAk5zV5WnhoBzSKQfr5kQe9lO
	oUjGdFqf6D1dyjFxc2g9jM9bU/dMZq7/2OfIZ5QB6OINxAdUqWaJSafuP1Ka4UyH
	02BfMTWB1LdLkJ6gYs1e6XwChaux9/FxiIuslEOC+70Hhg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h53ask9xg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 07:07:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-936aa34873bso728896585a.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 00:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791356830; x=1791961630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=REdsKXMdkmNBVolsHOiGFdM1vrJDGL8kKYoVEdCkWkk=;
        b=WsDSRQ8zCViz70bI2bs1M5bEUfXhk3g8COU6fqMiPBe0Z46z9QLdGi3EfhaSKx1OQ8
         BVkKv9MGkR1Iw0d+VgzHtNnikrnz4trcOoZj4yU3FKQlj6gVkwZAxad5BOs6HMm/mqDG
         eA55dUHd3IHmc0dP5djgk3PN3hPcs5Rirn7KVfs8Cd3mJJIK+pv85vR1NN3y6zTzLVKn
         9f3xt0RWy3u2ooSOgB/Ct33GcCBJoN0g2VC7UEYplNUYgcmBdajeEqMKhOl1kL274EbR
         BZ+hc4XvzXe2elnKfXoapsES6N4MojbxHZ5FlfmX8STjy/juxzfF8D269oKRC7mY0MsT
         +CSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791356830; x=1791961630;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=REdsKXMdkmNBVolsHOiGFdM1vrJDGL8kKYoVEdCkWkk=;
        b=en8B7mnT1wtHDLVcuNbiF41sP1goRo0sQ6vDI31c7PMMXtrbhu4dzYyCAGlLgCbgzu
         YJMmyeBiHC5B/M3ycNwKKJHC+kA8bY1xKTJrJhL6c0J6IHtyN0OTAFThsI2SMkHVOfrT
         Vhh8hOFBrws1Pi8afo2PuHZV9E1So+GhL56TdIHvO9oekpE8uyaNQE2EFL2ylifxSUK9
         MCJPy+QaV3P3n5H6SsdgapR8IuY8KYCpxxJy4WGWwiibnm9tuR9YPUelyNtOOrVWlbnX
         ppiaUAvhofae4IH5uAl3uWf577gukcjX1cqkFhw2nrzwEMfdh1xBBeKi3cPHojC5R7Pd
         E0hA==
X-Forwarded-Encrypted: i=1; AKwUvByDQeD6BLCGpuJQ+xO5Pf6fZaiSRmQVZ8vd/gW1zMfU8tS07mwaQ+BWAdBs6GZhT0+BefwAMasbDg==@vger.kernel.org
X-Gm-Message-State: AFuF++nJ1gm6IDt5m92W7E7uaIVywkKtZik57fr0VbOpRV155c6VIiWV
	+wr4wnR80wEwP8o9W1EYuWSC0tgurH/CDIHKq8dLOE5qVmYVvLx/VAj358N6StldzdHa7aqTXMi
	q6GkfX3ep23xamxwcGYeLi47gFeHNJzbEw9U7JB4QmllQBdhnlbSrAXkVN5hhzA==
X-Gm-Gg: AYBFou3tRj10UzH2BbcP3fBixr69v9J1/84ZLT4MwFM9z8EzgEVoFEEFMl5+wVxK7dH
	ZmoibUXlbQ52X0D5L5IfftkmWndAi+1LN9hnlmT8NUUOC0hZx6/l8b4Ep9Qv8BMLmx5UfdjK+U4
	Ju1j0Vqm7Rj9w9YY9V6wAZy9DEmtT7dPchNFeeYop04+3LdziN3v3YJL1Sl56JyxkNYIvHedP4t
	OKcUbHMduCfKz8+c7UoEwhVq+LvAecjWgx27B61OM8Rq1jyagUphn/Ykf6GziBlKdOHr/9coCMG
	l7SWMMFHLruZHBPh8iuBzUA4553+s0ZKBHXXAIZH+D2b5PzOhvR/jppfmzk37WViQBlG1+UG2LE
	kJcm2u/R7agQPS9kMxzT1GfgWlChDyE5OykpICr8JdufkJ66JPlSVo+Zul3d+a2IsYG8DUoPv6o
	sc2KAnZP1L7UUy
X-Received: by 2002:a05:620a:29c7:b0:93b:beb3:5898 with SMTP id af79cd13be357-93e9b807709mr253454085a.49.1791356830367;
        Wed, 07 Oct 2026 00:07:10 -0700 (PDT)
X-Received: by 2002:a05:620a:29c7:b0:93b:beb3:5898 with SMTP id af79cd13be357-93e9b807709mr253450985a.49.1791356829790;
        Wed, 07 Oct 2026 00:07:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bccfdb892bsm440897e87.12.2026.10.07.00.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 00:07:07 -0700 (PDT)
Date: Wed, 7 Oct 2026 10:07:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Ilia Lin <ilia.lin@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-nvmem: Add IPQ9650 support
Message-ID: <tnmm2misly3wct7out4gybimrql42si47trcoygaquan2gm2w7@rzqqkefwdmvh>
References: <20261007-ipq9650_cpufreq-v1-1-bb808da4ab2c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007-ipq9650_cpufreq-v1-1-bb808da4ab2c@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: lprWr76Oou4DuagiEM_BtIbYuPzT8oE-
X-Proofpoint-GUID: lprWr76Oou4DuagiEM_BtIbYuPzT8oE-
X-Authority-Analysis: v=2.4 cv=Xt5vqlF9 c=1 sm=1 tr=0 ts=6ac5ef9f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=kH__5QHoUz9KciXxkXMA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyOCBTYWx0ZWRfX3HMIHsWud3FH
 foi3qSJPXT4fN9ntFb/BckWxoZK4Kgahv1OSZih6tMAZKBUmZz5wDbU/0BybSYGWALxsk8EmMO4
 B7xh1BEM4Kfy3I4Gv4iAxSk2HiaLaEU7vpX6YYc7RMKmRg3xRHLfYI0WBbXIzSjJY0a8GeYVKI9
 doMaqAhLbmjkWf5RxkSa2mWws1Pq46mhCbk06k0ZJT/ewZbtwW7IyXouRHTKLZgk8qrbctEN0pI
 pw/ToOBA1W88NNp+JvCPfh0bTot79v5KKW+6XdGjv0I5jAD21miBeGM2yYlaa4Gff0i7aCm4lDx
 K2akBPb/OZqbxYchd2BXzmB7U0CsxEWpzBk9KwA6aa6RaVANHeyeP5kwqITyRbKwPEwMv0n8BAQ
 Z1CrbMxex09C6B8ZfYxer5W6giiquBaQbz6ljCOk7+WBQTNPGDURceL9S3hVmrhwGLeKve6h33A
 qP1WI5BL3RIbdUpDsyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyOCBTYWx0ZWRfX1QHh9stPTZA7
 QAlHyf62FZERm+MnL6r2XXYiLQnVsRslNXNeNGBokq280SDF6GM/w6TaickXpI5Sbhb4VHRhKcj
 b+RBAqjginSaDCmMLyPEltyeaoU/bx4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070028

On Wed, Oct 07, 2026 at 12:31:56PM +0530, Kathiravan Thirumoorthy wrote:
> Add IPQ9650 support to the Qualcomm NVMEM cpufreq driver so the supported
> OPP can be selected at runtime using the eFuse value and the
> opp-supported-hw OPP property. Also block the generic cpufreq-dt platform
> device for IPQ9650 so the NVMEM-based driver is used.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
