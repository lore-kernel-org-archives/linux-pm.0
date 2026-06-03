Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D470F355F5F
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481742; cv=pass; b=nhr7bHGsJr5gDqPSsUHnR3baSiJjd2KCJo+JAlDOpWIEu8YswW5m0rtsWGxNZPJFxC/XUuWtokD0SL77ZCUv119tUtXgNpisevGN1TyGbIOvlwGQXLvwLrkFep5eOQ/Jf8gPbysD/o7eiuICXvT2MsQQUmHTooxc8D6YZFliSGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481742; c=relaxed/simple;
	bh=wUkh0oXvBTOvNa1Z2LNjjV+ZPJCisVW7rSzyWPpb8dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2pBADvucXVFyHPjaONKSiyT6PfdZmLu8EL5rJ/3kVRm02u9euG2wLTnuidCi5G1JZf3jxu10v665zoxlbbkYVTkCMHk5w/LOcZ1Jl7BvYQ22QLYt7fjjqa0RsmyMoDugjTtYX45IyHbcI0PhktcEI7IAacKxRHkPh/yDER9eS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o54k4gsX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ajn4Eg8Z; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o54k4gsX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ajn4Eg8Z"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536RJ6O380230
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 10:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NSrIKtBce3EFR3hNVAccem09Es16mAoJgo2hKBQnq08=; b=o54k4gsXh69KXQXH
	D0AOIywx54NrVljTRshnXnlEzblmnmRJ9/ksQErW0IHJXwb4YQLTsKUaPMA3NF40
	uNEtUIjGIK9DJeLaktHfyyvHQJw7s8wKOgeAdgi0bICDne8RNkjeqB/T8pIULMTv
	gGEiAt81G4gyr1uoVZFdx0TaXU4RpLod9/LZxNZ2BGxnG63IDxXTbTHZemtUojU7
	ttPLrbf7XMMxnxzvDE+y5Oc/mdmzCevwI0VPi12VG+mh1KH9grGGQ95fOVwz6VW3
	PuJJ6WcUBFoKnsH+qVNmCn0BmdFVGE9S9zD6pxtebaMUs0C+8n3f5fBjA24p9edK
	FhJIxw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejewhryne-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 10:15:40 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8cce2b4c290so121668156d6.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 03:15:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780481739; cv=none;
        d=google.com; s=arc-20240605;
        b=EN6VGsoxT6JVnpLpzEOkmPV979yZWtKeK4fA4hkqnF9zpYYKMcIdyOZWZgIwypWOxc
         +g4ieoTJGnLxgvILpH9YdWdfrPEOif4d56f5MJrLCktBpGZsK717h0ytkvKvQRgG7De+
         WI7pI2QtB+3xr6oE4jsONYloA/nF62hG+INOPxs21y2yfsG+1QqujspoiJHp2g2ilekI
         JD3lr0vUEGNurJD+T1EYSq7q1ai2JJvvIx2km+TYxJcBACBlVNRT+jgMD+bM1A54nXqG
         Kd6owM6sGbuTp+Q5JPx/8PHvNqnOiWtd0EIqLacsUEasbifdO/pw+xBCgjH3Z9HYHYRk
         GljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NSrIKtBce3EFR3hNVAccem09Es16mAoJgo2hKBQnq08=;
        fh=dbIK1zbdrfg9T9TTatPeDAlmh/5I6oeakvkWZSzZNlo=;
        b=Y248JqgjEjgoG1pv6z3Et1cG6dQsbzkD5mGAITB3ffgXqm7CYjNSF8a26pEkzfO8xO
         NBIHg2rnMnDU/5A1f7L/cPoFpPbN7CPrZTOXMZOxnA4DNtJtLHyiLU4NbFn0ZwKl9ZLZ
         fb52smkdUJBuRUZpTJdpkd5x0/XD/Lx2rBt6YEFrzI9CS6JRvUkxolPYCAZcwCebaI7l
         nXuUDOO9tDXtpaLoFVr1aCFBUNrWATewqnQNrGbfQs+G4L8k6nA2ykmTcTgD5HTF1hbf
         623ok49qt5r72PBPlCWzB4L44o1AYqjAcsjwYJJ70Uz3nSaWAk5jmvxtH5gpy+OCp1u4
         qOTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780481739; x=1781086539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSrIKtBce3EFR3hNVAccem09Es16mAoJgo2hKBQnq08=;
        b=ajn4Eg8ZqfLzaMsW3dGX1hC9gSAqeWgAFA0vwqidWPPV3TqjlphWonbEiSzxX8f8Lf
         3XXolPDK3V8XPjqaLEqVTXQbaANBWzBcIQiwAIxLAhwQ1LBU9pvI14NtrAtXovDg7g6g
         XNDtfhVqBr2+jTLSbPAAea5V7F9eSLq4ib2KdOy0mTLJ09votkdZk47pc5yo7m4Dm702
         ne9HrEMkmaRWrnuX8H6tQLgZvm7YthlqA5COH+MwZeuX9PHR4A40iNzjZz/AWSVpVijf
         Y1dyzuU7bWsCCtUcfoNJ22NpRTH4FimaaUBO3VDgO6o1otfP4b+rZyXLx6cTxeowyhlt
         Mcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481739; x=1781086539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NSrIKtBce3EFR3hNVAccem09Es16mAoJgo2hKBQnq08=;
        b=sLhZPA9WmrXe2HMtrtOnjQJsasN6/4OHydsbzrB1MUIVoIUi1SthJg8Hx1862q0p/v
         3qSd4ZI2Y+8MVoKkogc+dcEL7SBe8W5aEmpQfUiuAWLBEfULkJHmGGNGg6iUgLJBBh9O
         7a2JiNMPeYTLgeJLsDyYnVKF/m1G1D90WcZMmhwDlMJ6ZZ+A5XxmUTxl2TPM/WH86473
         x6VJmwI+rR2l5rJ/R2X4r6DZupXxgG39ODpyb2X6QmkqMAdIHM5m6zKKcWU7lVyptNx3
         qKG7CUAxb6bEayUpbGFTFHjxICaW2DXRptxTi3XjG1ya2QUNdrbATMRSL6FQQyLRk7O6
         isOg==
X-Forwarded-Encrypted: i=1; AFNElJ8i6GHbfeh+/o0ARHulsM1qwCenRn+JvlFD6G1UnFe2bJeQoSdv4Q6WbLBaxU/hEg900yidY6uyhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Jle4IwZ7GCGgzdLknEGzmDgZtL2BrdnP5Oy1nMRWTimTq1Mp
	uUTrd+CEVO0T5YVpOzrAf2mA+F9HOZIbhE67SYS+LkBtsYrNrj4+zaoF/vG4QNrtlFERRtA+ezI
	qAINDTF/tjSC8YJL6sOGwihAW39ztvlPM527o/e7d5WyXHc4DEE8Rv/yUQ9DJhp3xAXcL+KNpuA
	P6iT4ucM6f5nYv2D4zzjFs83z/Zu9MHf9JMQSD
X-Gm-Gg: Acq92OG3juWY6ROomvUjV9L0Uxo7l7IQFYJETI7356TQVzG4fsTp8ZWewvzvuH7Il25
	p+O6nDt2YUaprgLbXIWAkijZrObNXN2w3/qUILhsNXeQiW9DsOYnxFys3ZgJ4+VNE0iF9f8Daoi
	jfZw0yLAaM4Dies/A5jLK+T7FLA6FfM/yrdYk471ibsyZdbZBVuZdLk2opV4It/Zzdrocw1zjV1
	YLNZgYVhm/4Rma9
X-Received: by 2002:a0c:f209:0:b0:8cc:e14:9594 with SMTP id 6a1803df08f44-8cecdcea7cdmr41693546d6.33.1780481738913;
        Wed, 03 Jun 2026 03:15:38 -0700 (PDT)
X-Received: by 2002:a0c:f209:0:b0:8cc:e14:9594 with SMTP id
 6a1803df08f44-8cecdcea7cdmr41693226d6.33.1780481738578; Wed, 03 Jun 2026
 03:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522-add_rpmpd_shikra-v3-0-632838e2428a@oss.qualcomm.com>
In-Reply-To: <20260522-add_rpmpd_shikra-v3-0-632838e2428a@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 12:15:27 +0200
X-Gm-Features: AVHnY4Jr4nBrFjxFV4K-KhuoZ9lxednOew8GGPZciKNsnUGX9qTs9junH_jQQoc
Message-ID: <CAPx+jO-OUCe_uOH4h-0Y=cLFNGuQcCMY+09TMiXf_ppcPjYc-g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] pmdomain: qcom: rpmpd: Add support for Shikra
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kamal.wadhwa@oss.qualcomm.com, jishnu.prakash@oss.qualcomm.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5NyBTYWx0ZWRfX2rQuYXpqzDjv
 B3QdfTlDlRWSGUEl5pqQB+4MubWnOr3jCUgc/j7axNpSE5eJF9XJVaWG9N82A37h9Y9jnaCrNPc
 DGe/rcthqB+1PYoL1cCMGo7V7Y3vI4qYJi8tWhxlt/CrBbG5DizTq0Wk1t1NJ4JHcelBGMe/bVE
 6azrbm+PPWX0NI2O8300GTrj9G1TRsm6cM05tghF0IkQlJuaLh3MxNA4qh1YMtYCyFIbYHIGinj
 dE7gkKiWbtp+Z00phzQcBoYKIMTAqaTh66D7tYeQt1b13kNqzY+IFeyHBtOrYbdTRLoO8mv+U14
 F13vXXs5CR9h6WbPIqoSlc8suZ+2R13t1F0z/OQriU3XJzGRdkMJPwtKLUo0uebImDkqOgjME4n
 YYV1I9m7OKy75cBC/lUqnLwBlihDhwTUORrPWu9SuxE2QPefSG61+hyP56b+TwXlDWR2xkOIlok
 KM2G3mUP6te0CikaL6g==
X-Authority-Analysis: v=2.4 cv=Zewt8MVA c=1 sm=1 tr=0 ts=6a1ffecc cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=6hheQPWejXNNWGPLShYA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: rqkr71AYylXxn66CZnMbFBtnTHyas3I2
X-Proofpoint-ORIG-GUID: rqkr71AYylXxn66CZnMbFBtnTHyas3I2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030097

On Fri, May 22, 2026 at 10:21=E2=80=AFAM Rakesh Kota
<rakesh.kota@oss.qualcomm.com> wrote:
>
> Add rpmpd support for shikra Platform including RPM power domains.
>
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v3:
> - Updated the subject for Cover-later and Patch2.
> - No changes in Patch1.
> - Link to v2: https://lore.kernel.org/r/20260514-add_rpmpd_shikra-v2-0-20=
bbd37592b0@oss.qualcomm.com
>
> Changes in v2:
> - Collected Reviewed-by tags.
> - reused SM6125 power domains as suggested by Konrad Dybcio.
> - Link to v1: https://lore.kernel.org/r/20260429-add_rpmpd_shikra-v1-0-fd=
ba28564380@oss.qualcomm.com
>
> ---
> Rakesh Kota (2):
>       dt-bindings: power: qcom,rpmpd: document the Shikra RPM Power Domai=
ns
>       pmdomain: qcom: rpmpd: Add Shikra RPM Power Domains
>
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  drivers/pmdomain/qcom/rpmpd.c                           | 7 +++++++
>  2 files changed, 8 insertions(+)
> ---
> base-commit: 0787c45ea08a13b5482e701fabc741877cf681f6
> change-id: 20260429-add_rpmpd_shikra-f57873b2fa7c
>
> Best regards,
> --
> Rakesh Kota <rakesh.kota@oss.qualcomm.com>
