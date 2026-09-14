Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF923CF21E
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 07:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370840; cv=none; b=ZX5p3LLysWcDBODt0HOiZ6/02KipZlKmEmLJsOW3pF8x2xctqTn5f/9H0yg1EY8P1TuMBAnh1BdVlm11ZCuxaArWm1fCI2qJkLC7nsUY/Ce0dsiPJuZKOF38RQC7JzM3Pxu3sSlEb2GhyRRn7G21Ci14je/LSBSLOFhdcszafcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370840; c=relaxed/simple;
	bh=V5Dlx1nlvt++uL2ub5ha29Rk/aGXPojGG+uLSQB441c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqvFosFrIR9Cd4WJ1FtVyQ14559odu23casUyrE8sO6oX+gu0i7KjZUxMfW8jRlwKUvFCAaOBm+re9WfR/fqhR1asTX18STYwdWS32EYgs+gQCBDCDX8cj5QN5X5lHvBhDIVaiDDHK801qgq7b+fZWGvTzYRPqJ+aWGHRzKx6DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=njmSBss9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YgJOhatc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="njmSBss9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YgJOhatc"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E5j1Ws2627352
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 07:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fJ4Oc7j95+LQNFUW/xFLEiJEnd5Yfp4R31ZWpZ38Oqw=; b=njmSBss9mQdpN8+5
	uFR8BoGPPJxVz/hd409Mbtm/+ncp2PTlmt5CyIB5N55s5titvKiYI2X1c88/zOSH
	LevU8IQq0CKeN1IxVA/w+Fo2HA48n11Ejc5ZTHwF4wnAeYyyHjMxPJaAdFJm1ghK
	dpHKpaJeDSAXfUGKSqU1hBRrA07kJ7RZJQBskyx+PNMs7XCh4Nv/LXJVQCXCpL9w
	9zLOozG2pWUJQPg4QsjWlTcQ5+UMwpdyS403purz2E6/jJx6/B9oUrzEnuykkva2
	IUobcpcpZkVLgaE8FpypgAvxzFyokoktiJDDPclrLapQQI4gUxDt0mr/Pu45bBgQ
	HOWN0Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmywh5cjt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 07:27:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a0312937eso177435685a.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 00:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789370833; x=1789975633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fJ4Oc7j95+LQNFUW/xFLEiJEnd5Yfp4R31ZWpZ38Oqw=;
        b=YgJOhatc+0J8kLGz5GJe0gDOxDy5uuX5Nr043EQTbV6NQ4h/Mqyw25sIbwBkBSUFlY
         m10NLncUjU2cKW/WqdN9J76rNzceUnZPww4QzaXHBu3u7+QV/PwsO9icqBnyn0E/Mh99
         DgzZKxEZVGXmyADV0haCSsu/aMjTN4kaYh7X6V8FuMJtGHXGCDFXU2F97hZEtOHtUhsC
         dKHvxia+MkB9QCDt6yqQU0vQU82sFMB4oWfBymSPGn7cR12OgeORr6NdLr+/tF1N30D/
         khTpoRlxvVem8sJGOXnRGxTy9ziVlu8l1p4PDIy6QwpInjM25W/81Q4K/JxhNnqOrkS9
         hzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789370833; x=1789975633;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fJ4Oc7j95+LQNFUW/xFLEiJEnd5Yfp4R31ZWpZ38Oqw=;
        b=R/izvfdqga0FbsF7rr0UFcz68s391iSt6yOoZuDsmeQYYf37u2Qy3Wdk7zsnCks656
         ypdFUoZfD8RoXPESQO/pRyu0o4OPcUhb4CT/3m8qfuw8LxDVN5bZCFNIyV2rNGaE+wyg
         Hd9LTiAU8uTkJ4XJskzCW+luOWjUCgGKmrH1GoVvrs/9fqFhxmu7HZ6Ne9M+sdo6GGc4
         E0QjFPK7JOSRPnCMlJomY5u4BEj/ZmqHymKJT+mGjf4Vv1ZKiaA4l72+DET3x2b/OyB0
         cKcr1m0LUvDNVsIv1jJPEz3WxlGdyiN0ei6KwLEIUq/DQjjcNJoXY1eB9yXX+K00mV/l
         9tOQ==
X-Gm-Message-State: AFuF++l+LM9hfgBuY149uHAIVoD6RpdbVyOXyQH/2c2Xl8JskkXf8p1n
	pwWYQKYg0exkeQMAT7XK0eWHgBGhijabTnMuqSbmPtTI5If//XHQx1z9IL+hy0bztWGLwDEKGke
	iQEee3i9A8XX9HUcypOe7Wfch1c0Ffrdf0qnpqNZJmxUm8VgPgS9RtdpKsvz/fg==
X-Gm-Gg: AYBFou1zczsf7DSli71/eguLBAW133SBhbpziN33Qk5LevdYxvd/MHeQcYHaN9WIpk9
	rQxRJBXCsqUmxWx5YOQm/6xhvgvzMAXy+GB3obsz5tMOIOrNM76RtxEO6/QTmI/zw5iLIqmJaaq
	5WsnKY1h37aBsgZUWcu1wbk0QOnJwwnKZTQi46ryKTVjrK87B9zQc7wCJfSCvh3EPnmcRk2wPep
	A+3gxVAFiRiykBnudb7Z1i5fg6O/HT88CEvhByVUxGiugIzldz5Wen7Z+U14ks72Zy3NWqYhA5G
	4lYb0ipI362V/LepjTwjvqv7JEj+PqxzKg3WYhvIocNcHql5S2O47LxWoksF169L7jF5cb9LvJJ
	gk+tuUyvRtngL+UenfU/sw7cjSH0=
X-Received: by 2002:a05:620a:6892:b0:93a:1c96:67e4 with SMTP id af79cd13be357-93a297e5d16mr166231885a.5.1789370833252;
        Mon, 14 Sep 2026 00:27:13 -0700 (PDT)
X-Received: by 2002:a05:620a:6892:b0:93a:1c96:67e4 with SMTP id af79cd13be357-93a297e5d16mr166229085a.5.1789370832658;
        Mon, 14 Sep 2026 00:27:12 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:e83a:fc27:4d39:43d7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35bd1esm24585661f8f.31.2026.09.14.00.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:27:11 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, sashiko-bot <sashiko-bot@kernel.org>
Subject: Re: (subset) [PATCH v2 0/4] power: sequencing: add kunit test cases
Date: Mon, 14 Sep 2026 09:27:09 +0200
Message-ID: <178937080432.4599.13347166604445263760.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260909-pwrseq-kunit-v2-0-ef496afc89d2@oss.qualcomm.com>
References: <20260909-pwrseq-kunit-v2-0-ef496afc89d2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WhGlgyVBucns-cUcZlzhzAshFxmsHZGX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDEwNCBTYWx0ZWRfXzL0j8+731+wt
 /9tCgabuetK4/TUtAWjNQOSx24GCgPduYwEuMzVwC5F/+5ibdrjjevBzTRO6kcviK1XvC3tm8Qk
 YQqajONvYKsIabwA/7obtKv23yX4/GiE3zwifi/OLD/GsP8msnuHD5JkmjSaaAcimHAtL7UNEWv
 NK29VTA36ajo4qNHWPJcZMi1X+FfjF+DlxcO1YtZRaLmLxfDy4c5JK+YR2S/O6UyxYn+tPQ3bEg
 isvkdvj7ht/qBcyp2pdhFxwVEygSIY4S+CD2j5Yu+jK0bdRrdkBF8x9XrSbJznzh3Opyuq4r3HR
 fHaGq6ylca0pYDD6u5y3frdHjXmrfK6XVQQPANeEZeMx9iZme+UPqu/UPqaRJmC/1r8WgZbFuMH
 Wybo9ZCUmqlYFfg/hYlm81yJ0ebt7iuzU4rc0w21JEkewuNdTrO2oOGk6sBYYIQvI+zeCNdtswQ
 M1IFpw9LxNU/ICeiYGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDEwNCBTYWx0ZWRfX2tEtAmyYTXBz
 wN2K9ywJosm3aD/N62D0YECby4gos3egobmjyLbE08Lb19foFylEbegepHtKr0+W7QB51Rs40a9
 HIAG3qw7vx2Bo06HcyhgU8+qFlFm/8s=
X-Proofpoint-ORIG-GUID: WhGlgyVBucns-cUcZlzhzAshFxmsHZGX
X-Authority-Analysis: v=2.4 cv=PsUG/AM3 c=1 sm=1 tr=0 ts=6aa7a1d2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=6CFNrt-8cbJvt-LAfKoA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140104


On Wed, 09 Sep 2026 14:37:06 +0200, Bartosz Golaszewski wrote:
> Add a set of kunit test cases for the power sequencing subsystem. Also
> fix issues noticed when writing the tests.
> 
> 

I'm queueing these for fixes, kunit tests will be queued separately for v7.4.

[1/4] power: sequencing: don't call .post_enable() if pwrseq_unit_enable() failed
      https://git.kernel.org/brgl/c/5f90f85eae4e9d2e9628b2019870994ba830b533
[2/4] power: sequencing: fix NULL-pointer dereference in pwrseq_unit_new()
      https://git.kernel.org/brgl/c/115b303e8e093d964089ec6f3c40d984d77b33d0
[3/4] power: sequencing: fix NULL-pointer dereference in pwrseq_device_register()
      https://git.kernel.org/brgl/c/242da4318d97380741516b595af3920207b2f0f1

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
