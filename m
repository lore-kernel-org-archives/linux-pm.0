Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F103909BF
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030261; cv=none; b=MGtRBdnQDj2palAPuV7Kgfd1BC55PqNaFkB9JsKm0fWFXypTIxWd2U7RTAs7Y9ZYMrlQANubjdESsksidePbWNDffqY0Gj3aqG576hCrkZUiflQsmBb6nO2vNkTljw49VKOn3MS0sGXBB9kG5RVBltmhWOflk/qFATsyY72Bg2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030261; c=relaxed/simple;
	bh=Z7ELx0xxpT8iAxlgwr0qNRiApowBB2/et1oBr4QiLBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssc5iCEsh2F/b7C4fHYwq4KI9NPqYAflOATAVieNFdJ2eV5rg1gf42uowXqsFB5a7UACGcOO4celgTKw6WwofaBvy5npIApjPNBxO9EPyZR1E1Eut+H0Gyf/eJSPpBHffoKcRtoHL4w/JI80bPqOx69amWd/+hTlZzzmenZ8MII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VM8ajfHf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GqNctLaC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VM8ajfHf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GqNctLaC"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5H1CZ4142925
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 08:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YRdmCeGYdKolSM2/nA+SELTr
	KQJjw5qoJh5MBPg7W/A=; b=VM8ajfHfL5l18upf4TQXxZk9S9vC7wDi/ZzjRUHq
	V29wXTJeud59Q0AFU2ezSIWhFDXe1FsGxquyrQ5PMT5+fhyjAt2wRPdbYJ6rFeRT
	GTto1LbyT7uEFFJAF5dBBoPW3RCmEASnLGIxOdsZOkGc+HGParF9cPK07hgkZLhh
	ivIPN/IW9Y1F/fk26P3D/T6Yr7ERNkURvj3309DbPqTkwEqYbtvox7G1bqjvv0aS
	4OTP4XK2XesVgvSHx4VjwrISc8dt8eo/rR5WN61mfIBJxmpcvXGLnH5fqGgu8Cl4
	S4i8iu6KmHNlxX4Tx0WgIUOUdTj71mswaPVVhyiVuZ6Ujw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyd2wsd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 08:50:53 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so11105689a91.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789030252; x=1789635052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YRdmCeGYdKolSM2/nA+SELTrKQJjw5qoJh5MBPg7W/A=;
        b=GqNctLaCLS/g5AJp+djkdJWhj7w98OFSUejK3qWLa6vRBvPT3VeDNCLrLl1meMCG6l
         Q2m7WfzLAuhiwtiJ3Rk/CsuM0HSMUxzjEWgHF8JOxzNnn+oOHVgOpvEAGc0qYLm6NzFm
         jwLyo4+DOBRWOnOriEUND28sTtmxY3bDhlyQDLepK8jqHua2LsnZzJNxhIIhuYJf6voi
         2xQ4WD48ZuWg2eMMk4L1pjQ2DKmwqvlRyRtPHrAzb2LxKHgL8nqYh7ilMHGsduYsPDaj
         Cl1pc+XRCJTQT8YxF+B0jVx5xy+SRRb/ZAT3fx/ENDflVt/oMZSa/dxgOY0OWxygtXsX
         TtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789030252; x=1789635052;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YRdmCeGYdKolSM2/nA+SELTrKQJjw5qoJh5MBPg7W/A=;
        b=hkt5fdq/97Tz7p65ltRkS/3bRPkZ19XAd9e83YOb9udcnSo7AnyPKxnBVdQWnfeWhU
         sSEwOoPc3dpHoDmAhCjHR8MnGB4Qbqr9kMQooaWE34kpZz7yB4Sf0OXhIuaNFBGKL3Tw
         I3nuldP2Ui1pBuQQRHRAo/5cqJlkTVL0pHcfZIGwg2JNA5IXtPb0yVNM91cNgLRnjy9t
         HQKSgtHnwADDUXfnOiWG2T7oK5GoCKkZ8JgIaHjDDWHpb9j9TCPXXNoDs63nSPzrzlwR
         s8Poqa5O51o9ed6GqN4bWRTSs6z9VD3lf5SPQmj/m+ZKL1o0OaJOQla1OpIvYgD5nHLb
         ndbw==
X-Forwarded-Encrypted: i=1; AKwUvBzAJfnlL8mceiX7jWmvvfvkdib4JY28xKD/X5LKy2zPMZzDwBMAGUjnD9Vp0gVhPjJDVWKIqoZ6EQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kedE02JL5wSIzDl0NlD1cIH21nUx/lK4CTeIbLkkZ2yjZVxgt7
	9enjsfseDW7kjU7GOS4rB9yX3Tplgb7chZ1ENaY+e/KA0AC2JOlV2o1g1ravU9o/232oVHbnztZ
	g6zs1yjJUlhtu43N9guWrNoPtcmeqMmQvIAspmCNK8L+uK+S7tKUANkJZWVcEXQ==
X-Gm-Gg: AYBFou3qgGhop5qumKkYMRmyoX0lPaLZjcpt4zCAfo0jjVAJtfHd3pBf3FGY06OrptG
	QZ/So/kB3yIAdAZWBX63zpTgsPmGFjjnJ7q09LenxU5Z3XtezLZYoZqqQukV+NJWowki+lORo6b
	RfR1UFuu4ki3By0Dldhpj+1cdYVkZvTVXJkULuCjYIjw6BiDsp+WlTjPxJbox8woeUgU2kIqapQ
	XpP+69MuLkEK2A/0o+fl71HaogK1cGeDifLrFD0FL5tp2sQeLtIhEm8u6NSKe1Z8GJIeBk8QNFC
	b3IqIuFbkUVj9EIYWWdR5ov0Sic5TWQ1ofg5vf5sH8duXH/QWhLHDLyx8KT/pTDc/hQ4dvHHlSu
	L284Ne/q4F5MJXH8xy09IOtZTvE8=
X-Received: by 2002:a17:90b:5292:b0:398:e969:87ef with SMTP id 98e67ed59e1d1-39d70b7d864mr8751287a91.24.1789030252476;
        Thu, 10 Sep 2026 01:50:52 -0700 (PDT)
X-Received: by 2002:a17:90b:5292:b0:398:e969:87ef with SMTP id 98e67ed59e1d1-39d70b7d864mr8751196a91.24.1789030251843;
        Thu, 10 Sep 2026 01:50:51 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3397d6d1becsm12817627eec.22.2026.09.10.01.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 01:50:51 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:20:45 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] interconnect: qcom: Some defconfig/defaults
 cleanups and improvements
Message-ID: <20260910085045.eargbxuwmeyhlhrw@hu-mojha-hyd.qualcomm.com>
References: <20260720-interconnect-qcom-clean-arm64-v3-0-942e8ee7ebda@oss.qualcomm.com>
 <20260814073334.7orbdongswfxgc42@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814073334.7orbdongswfxgc42@hu-mojha-hyd.qualcomm.com>
X-Proofpoint-GUID: Abti941YHApTjoKC1e8tYzZEoNQvP1po
X-Authority-Analysis: v=2.4 cv=ef+o7LEH c=1 sm=1 tr=0 ts=6aa26f6d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=OV78iIIr6_8e9roN0uYA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: Abti941YHApTjoKC1e8tYzZEoNQvP1po
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA5OCBTYWx0ZWRfXx9AxAyFVasyV
 HReHKpX18ZhRgXwl9KNnJHrtBhUgb0hIAoK3/rzG2LHqN6gmiZk6utda/LAF+xE38BgXHt1IR5j
 sYip3vC2Qo3N9ef9iHSIq7qoKn66G7o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA5OCBTYWx0ZWRfX3vSWUE2yOQCB
 pCSru0AujpwjqZ9m8JxifEY24uWoJNWXvelTcfCryrP/K/s14mE+GRgsmyeYIw7qt7Ofy+8z+Et
 VWBvNWV1AZUYZfMM7DP2U6my1PQesFChmS2xsZi8b9zyodR0bNyzDjih4ys81Js1Gib+0CEFhTb
 xoDFCUOepAjkzqI0sm94w7eqJ86MQz+kI48qmRN3GXtxHsdhPRxnYS+nFkTRyobo9XzORPPq3b8
 RIqxmidTZy4+rjIcsi38KznVjw9k+jV+65p2XnaUYnM2nbErSNEqY/JtoNHjPF+KPwj4LTC7nXQ
 VTVChktlOQ34Ssk1Hm5lJ6Cw5kql2mgQgNoxYZ4Xs6j23ndlhEdjSkcQ6xI48W/G6UVkvo9e67Y
 /D/Z4g5XOfIRxt6UE3KnFFpQlgiu6T3EpB2Rk9n2Gl7L9mazm/qaFfSE64jy5A89HFFfLZoG9xF
 wNGZyEaKpTX2f1mEu6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100098

On Fri, Aug 14, 2026 at 01:03:34PM +0530, Mukesh Ojha wrote:
> On Mon, Jul 20, 2026 at 09:03:26PM +0200, Krzysztof Kozlowski wrote:
> > Merging:
> > 1. First two patches via interconnect tree.
> > 2. Defconfig a release later via qcom soc tree (dependency to avoid
> >    surprises).
> > 
> > Changes in v3:
> > - Update also Nord and Hawi
> > - Split defconfig to separate patch #3.
> > - Add new patch #2 for arm64 dependency for Hawi, Nord, Shikra and Maili.
> > - Link to v2: https://patch.msgid.link/20260515-interconnect-qcom-clean-arm64-v2-0-adeebc73596d@oss.qualcomm.com
> > 
> > Changes in v2:
> > - Patch #3: Switch to built-in for everything, with explanation in
> >   commit msg.
> > - Tags
> > - Link to v1: https://patch.msgid.link/20260428-interconnect-qcom-clean-arm64-v1-0-e6bc3f7832db@oss.qualcomm.com
> > 
> > Similarly to clocks and pinctrl, interconnects should not be a user
> > visible choice.
> 
> 
> Looks like this got missed in this merge.
> 
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

All this while, I was replying on v2, this does not apply on
next.

-- 
-Mukesh Ojha
