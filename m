Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F33B71CF
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854285; cv=pass; b=qimsk/91RwLd0QrNeDzLfexqeyGhXRu6jRBTuPvy7k7QLS23Lf3932Bv/m1P3e0fmpADmPgywzVEkAky9q4lgspi9aXR8/NGPIedRD6lJwm6vcC0zuxmuzhZBOumPtd79ofL5Oq9sygQF70ryGGozgqeWMTQ+NWItjTEtP0Lce0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854285; c=relaxed/simple;
	bh=jku38Es8CyiN0tME2o8xaTarqmox1Wkwl8kBhtxqFEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNr1EYsv5oAdciTMHcI1xVybDXprMQtymLu+/LETVEcw5YL8LbV6frqUlx6DKs0YRltUAUubM0T/ALXmvk03CEwFt0OTTL4CLNO1uTngqI8180DmVDhIrQTFaGvBz3p+u90yjezfjjlh+Uqu0sR3zMG2fb8XpL3WGAhCFDDUNGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=of8sOQp9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ACFJdZea; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="of8sOQp9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ACFJdZea"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CXM0H3829985
	for <linux-pm@vger.kernel.org>; Tue, 4 Aug 2026 14:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RBSOug13prxCCT+BAqmbK4GJruJOjABAt4v/5onpB8g=; b=of8sOQp9xUSfTu71
	IHMwC4jMPpavp12E+ekTQze2YGL05ivig4ZfN52E1ZLalg5gz3McVISQCUYoa5R8
	122GhAoYJvhNsWfxgBqKfKB46LEmC9gqrflOwl4QSG4j+bVHBIemZ+AquCwJ9oj3
	HWJjwrlVjKveGsR3Y0mTvtHHYqY0VuSaZKoKei075ReWkK0deKUQzR3cg2+qbrDg
	L2AHymVMoS43fM4uDIsOvMvq7BZ73Y37kzegg1uvEWooxdryIlgcn7WMwKCVyhPm
	E8EY8dw0UKfYsQW9dMassyHPtfGMAaArB/IE3pWDce7FmooGveCBPXBqS1jQ39N6
	QulxNQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fty5scr9t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 14:38:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e538afe65so455759585a.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 07:38:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785854282; cv=none;
        d=google.com; s=arc-20260327;
        b=hJUhCmViYNplcm0BhxKOtwvLLJFYczLodaO6eJV0NVY5hB07HBy0afu2k99g/Lnrx7
         dadsAfHYHiCsoKu0bpWMD4EDz65nShHbvtZd5KES5xvw/khx/g8ysffnon5syjC89NB9
         thAOhFW4owjMJCAz0FGDYsJnOoCKxhrpCGy+fbl6tLH+2w8nuUy7if6gYWeTnT6Tengo
         fdI+sZoVu0SymO+YBU6AbPybyAzmpJwCvJ7q94BZBzesuLawXhpoxer8iJbSAx1JlRi+
         WBhNAlshHgjr0NQEDNp4GiTvSfxAdYpDspfqRVmeCU6QEsuZi2WlwFHnPtZ/glTh7oNn
         om6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RBSOug13prxCCT+BAqmbK4GJruJOjABAt4v/5onpB8g=;
        fh=ZL8oV3dKS6+CmrMGjRKTxM1XifKL5/XNbR6C1hybCZc=;
        b=FRZHUFoVg5LArep8dth/96epmpwKajAzoeWchyFMtN83fABaoAZ0qjXRanxZxr/X0G
         Ovlscvle1OHI4HxKkAhHRW6V2/MGPAKU6/Zjk6I1W+T5/UoASb2kYsxrRcUI+ShtGJpw
         0MCsbtRIPLCjufEsJoIVYm+z7bZnhTdKZBmatUqRFmt2MippqbtcdUBH1Dt3ovwC6ZWW
         l/KNC5xq+SYIgd7k1TMQ9gqiAuwCAoADy8ar69YeEV88GBzHPEKzcZh4iEU1Mpeo1R6A
         KhewX8jATZGmLfTDvKZrTBULED6O2PdWoUxPp/TtAp9vo00uaYaiAM9gG3zMNpAhL/95
         TMmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785854282; x=1786459082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RBSOug13prxCCT+BAqmbK4GJruJOjABAt4v/5onpB8g=;
        b=ACFJdZeai7GnUFPlLjnexNtnThdq1eiSaVJ2JN/nnDPypVKe5kfKS798J8MnAEx6zQ
         rqug3e/ZQLQguN5apKeZGcpgHNYbeHxQsrd1ISWrM5030atjf6hk2c/ZgFW0P+8AQ4gl
         ZUAk4oa5xW4NESGSjEfW1lmZtiIG7sjOio9MSLSt0Do9PS/XjAL9MbK2qiAOxULbYllH
         5NJGZZxgjvw4HFA5GvQVRdokcnUrArLSYFBSmtgfxlNbnLzLPrZ7vh3MkCZJWahj3u7t
         du+DMqudliBCJfR1617tfBFyLbGtd48P1x9IH/Kq8bKg5dQ5srpeB9lC3RtoI15bdRge
         M8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785854282; x=1786459082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RBSOug13prxCCT+BAqmbK4GJruJOjABAt4v/5onpB8g=;
        b=X6xVFVNtJgaFBtk4klsJXmMOd5mtsUSG33uFoswvfGfy3X45a5jHVswMRoHR0KUVJN
         yGhtxhTd8oTj3RKxNDxvmhREeIWWRQP3E3JBKMmuGB0SSINMUCYkhsR2SfLzwmMlXaWG
         G0JelVyAYcnRL8TTeQcq8UhwoGeM2XqXBn7uGYHlB+9mIpYLlRW5CuagnEVkrCMXbMra
         WUOAi8ewajEl/6b2/y5dlRMTMdeb4WRAss5Iq+7me0GM2UiDzXM5LSqXiuYsLn1xZfor
         0lyd0zMyRk0Fe6p+3jtuJCDKqj8dvySZZ7+9LgS+2V9JMJFDDH0IEBpztrroZD6fUVLd
         Fzrg==
X-Forwarded-Encrypted: i=1; AHgh+Rqf7MT5b901lr5Z9FbnvAnyofYHXc/4sQwhweuIwfQ/poiF3RKbUsZXW4qP6Sd10a5GPA2JxU10OA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf8gu5eJP3D+oF4SQ+2HvCaIC2zG37cmtutNBP2fgAAHIh82H4
	TIkhNWplFZ31PIM9Hqb3K9xKDn8EGIpGmrHSfqWH8aBsN+mYrTYLPlDWsXWzXX+jxoF0PBudS1u
	6sZ3tN1VdrX6UH/FopxS1dD5ywbo8CVxx1g2T8ZUQkNezoAycxQw83RMLBIft8E2LhBWkaX65it
	AliB2nsvbJBpTD1X1wmTN/cjzV1mB0Nvv4QMIP
X-Gm-Gg: AR+sD13itCfyHFqEMF6EktQa4PC0S0xXqdOomINgx6w/ilCY49xSnuTmP/B2zta8n/R
	ts+WtJBENpQktC6nTuBPsdAlYDcKLHGeU1mvZxShVC9q9KuaK453tjk71zaAb7NaxqFRDw17yeL
	rDMN6TsdHoERX49H+IxT/YUKUMtcXhMGJFpCt4zunI74hOxJNjNnmmaAhuDw==
X-Received: by 2002:a05:620a:a407:10b0:92e:bc28:5479 with SMTP id af79cd13be357-934a07523e6mr2091178085a.2.1785854282352;
        Tue, 04 Aug 2026 07:38:02 -0700 (PDT)
X-Received: by 2002:a05:620a:a407:10b0:92e:bc28:5479 with SMTP id
 af79cd13be357-934a07523e6mr2091173285a.2.1785854281821; Tue, 04 Aug 2026
 07:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722-a9-pm-v1-0-1fe20a44bf2d@amlogic.com>
In-Reply-To: <20260722-a9-pm-v1-0-1fe20a44bf2d@amlogic.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 16:37:51 +0200
X-Gm-Features: AUfX_mxidf6ep2hrmZtMSZcppo4HDdyELeecQKKRS0CT2NESLqRaSdKaXo6bY6M
Message-ID: <CAPx+jO9RBvDJHSoCT3QVUCfGK3bLduhV1W7T7VuHipOvas1v+g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Power: Add power domain for A9
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulfh@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=SPJykuvH c=1 sm=1 tr=0 ts=6a71f94b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=BY5PBP3jAAAA:8
 a=stQ3y3mWCCOjWvy4rzMA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=gQW0MTutLl7eKD3OLfcZ:22
X-Proofpoint-ORIG-GUID: mD4QxGxcx6-CmeG8aFkg5gufIv2UeKZH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExOCBTYWx0ZWRfX82evnqH07+iV
 raqdKqiwV6MAylKF8QJU/XBhPyUHTMUmkRAN3JuwBq8fz/rfAy0o6JFsAYGUBdFLz5ZXVHPVJjg
 P+SP4MZEGHQg50DRntBc2Ncergm6ocubf9wf9jIgXCIg4uPktyyAOCwuMUBdxColdbV34M7PG7G
 EN35DRuICux3y070HGgHCHOVM3ERnYKWKOhmgl/1hUfRaUmEGN0b5/mMPxzdCgBQBw4p/FAKcH8
 j1DLTEmNKPRN5oFbeNS0ERFFCRxkog1QTqZMnleRAm30sZbtypPs/kqSl3/VEjPgzCeoq9Wj2df
 wtcS8nfEiTTdBM9Md9YfWd4Wtpy7on4pEyPKFOUBC4eVdeUEPgxQwoBikasdsKGUExnfJ507Qm1
 adnP4wNw8KhdD9HhDB3ah1wuCZljZqGGJCRXzAOQ8xQDSVLQmPU6gPOMvVy+/KxaTUCqNgsSc6G
 DM5GvQHIgSKJbo+1cDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExOCBTYWx0ZWRfX1fjslOCKCBNY
 hSQBdkTtiz0s8A3nHvTtZZmDUkCOZdTJD4F5bLucuJm8t5JpfzY0m/5DKuKQUNLfF0YN+urjbF5
 UdZh/iJr4uLUx+ynH3ijYYwNGk/YFbc=
X-Proofpoint-GUID: mD4QxGxcx6-CmeG8aFkg5gufIv2UeKZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040118

On Wed, Jul 22, 2026 at 10:39=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> Add power controller driver support for Amlogic A9 SoC.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> Xianwei Zhao (3):
>       dt-bindings: power: Add Amlogic A9 power domains
>       pmdomain: amlogic: Add support for A9 power domains controller
>       arm64: dts: amlogic: a9: Add power domain controller node
>
>  .../bindings/power/amlogic,meson-sec-pwrc.yaml     |  1 +
>  arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi        | 10 ++++
>  drivers/pmdomain/amlogic/meson-secure-pwrc.c       | 69 ++++++++++++++++=
++++++
>  include/dt-bindings/power/amlogic,a9-pwrc.h        | 61 ++++++++++++++++=
+++
>  4 files changed, 141 insertions(+)
> ---
> base-commit: 544455a3a844edd6107b15cd0ab0b657399f2d49
> change-id: 20260722-a9-pm-3efb3f2a4d72
>
> Best regards,
> --
> Xianwei Zhao <xianwei.zhao@amlogic.com>
>
>

Patch1 and patch2 applied for next, thanks!

Please note, patch1 (dt patch) is also available in the immutable dt
branch, for SoC maintainers to pull in if needed for patch3.

Kind regards
Uffe
