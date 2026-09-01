Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D5B43553D
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276966; cv=pass; b=Om+rTBkHZ7UaY9bZHrOBsnFp8/qn8b1MBtq9wEbfT8tZ9BCoovADnhCb806kSSWOnzmk261uDjSxvhQtfVhUiUPW91VxO7bZdBdgWiedrGwq9rGmf8xun8ocL4cF363RWtjpG+FxdP8eHTOWrJz4mJQm4bNPxdDGon6A6jWE2Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276966; c=relaxed/simple;
	bh=c2tUgg4wBDmD4/wcjlpaTarOSXX4ze+3IyNN+IvUeMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QT75V0yqB2I9o9tDWWWBxhObUadhkC/OcbuGpXYjFxL1rxrIdyvL1dAfTY3WYq7BCqH4t61bZflfzVq1EOaTujdkemzODRe+wQrGp4eTRl6AEsVUqS36sFfZevL87ok9Z+XeHZbvjwK0ZtE4A7WnMEiy8fsyqARaI34siFq6fsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o1Z/ZsVc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zy0Gpp+r; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o1Z/ZsVc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zy0Gpp+r"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E9Upa1638789
	for <linux-pm@vger.kernel.org>; Tue, 1 Sep 2026 15:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4u/g4Jdpz5fo7H42LeN3bQZ/ypc7+I4ptu77t3pGsP0=; b=o1Z/ZsVc8EwHXYoL
	N/X3jHclM9iGocpfX0fLEQm7rWjghERgVeEDRL2JdObPCQonTMvGo2VJNqRfmXz1
	zVmx0uD54G8lm6Kpbmlp26Ddp8whLa2aOM4/zdOUtSTw5GgDhdIMkXXCGajKUYe3
	YLp1WWYJOjx2XHEireOVzIBvS89PF/VIVXg3i7Ek3edaqx/BrGTxSnfuAABglWbn
	T9HxxiOv661pkDs9rfa55PMvrk4kljk258zvuHsylr8MDLwCw1JR+XT+L7oNQG7O
	JLNCR/EanM3qciuNT928O1/MN1b9RQZKyOegz59DaqtBhZhVUtVMdUCC7nEO836d
	x/2NmA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdrcsjphu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 15:36:03 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1c1cc5206so1170231a12.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 08:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788276963; cv=none;
        d=google.com; s=arc-20260327;
        b=WUF6MUql85oXuv7VTAaXeCEOFT7Uu2P6ktH1Lf4EhxUFYSPeDrYz9BSLG63SYTaIGQ
         00WaP4/zTHH6G4Wt2+wcoA10BkGvvT6qlIaRGR0+rhFoRZQem/9FSylXYDPj9FoXl81L
         ceYih4OqRGkQL5daGddYqxpTzl3GKzJd8eVYz6KKAM7w3sZf1uBv2LoVHrkNRz9iZJaZ
         HdwGUWzAXCXmmjcf599YRPy36+Fe2otOlmOxRDYLgjcWyyMP2VGoIGnX3EES8ZLIOL56
         ZiV/1feMVNsaRIBNRIi4aV3jQKxcybHXN76hX6D2h2iaUZqCetLB2+W7IIV/18FK+NB4
         9Rfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4u/g4Jdpz5fo7H42LeN3bQZ/ypc7+I4ptu77t3pGsP0=;
        fh=vDpA+gTJvJzlp3wNIIYkqzYxRiyMMXts7cch6uZm2ZY=;
        b=SGJf9zU3lTzCFWuP7vB+5VvuV4PDhrmvGrgO6U1L/gBGoTc5WJ+aR4M3a9D37DcJ3O
         eVWIYSkzWffjhpL7ug6GpvmP9JzuYIJZOG6T6GjgCQVtEPiZODY5Wh7kxen82Rb01+Ub
         sIdHcO+kWTNYjL/rduTwzDfY3UiVMxEwSG2iKeyubUPQ3wCxl2P3nkKAUB2rAouNSpD7
         AHo+gKCXPEDMnqDuJke+jH7OLeZey12+uTT52u0IYVCqYDEQQgDtNy+6Bf0cwGqnc7P3
         CRPcEuIjRZyeq5U+k1xThb2jc6wmAf+QZn1xX7cmsmG0NVwTlRGuhbz+HQf+l2a2WgsT
         0Dmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788276963; x=1788881763; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4u/g4Jdpz5fo7H42LeN3bQZ/ypc7+I4ptu77t3pGsP0=;
        b=Zy0Gpp+r4x7Ao+n22LT2+fxV2ToWveFfT//WUr6up15GO7qyDc1a/sRXMhSpZBnHrq
         sBEVhSHYPs7Pn/SQG1XCwMugL7cKD6m0BufJj/r0BlmgqLrOLuQsCI1EkUp6xx8jr+y8
         2Dj/yCA+52M/G4fr97LA8h9enyNPtKhGXQTHki6SosD5tOQytoIOTu5P0eoapavBJyjd
         2HH/aIWOiO9CrTw6+AGMWG70z1WodxtC0/bX6k1TpcH+GTg93HJrM1EheGUEROr76BAO
         ttcHwqxFVs9dkEq6ZKU54DgkWU4LTKE4Nbh53OHvrYGYiMMW7fp2kUXUxfh4ywojbqO2
         6Uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788276963; x=1788881763;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4u/g4Jdpz5fo7H42LeN3bQZ/ypc7+I4ptu77t3pGsP0=;
        b=MDqj/MGiN0+DXSgcfGHZZKtGj18KgKDOVP1Uaa74IAmBAIYYKi3rNKEatpYF7fYFBp
         m61g87petbsdN3oyQGcRl4zHAhaySCMAcVrSP6LM7M/UyYHrGff8CLsxG0Zgl2g+oCiO
         N5tIDGFvICjfk57wgiy5rdhrjXr5E9utwQ5O8i3Gw4m+9jKHRbrzLSxafcP2pI6aS/Kx
         lAJhtsSQUtl8D+Jf1LNEqJkepl9YYnKkVUD+YxCBgNIPSCsrH3JggKpeILwB6oftKLal
         rKteIkoudvZcYQNOHcVlormBFWL8g2mjbMsGJpj5GX4hVcursdqysUcuh2tw1+3623Fq
         j85A==
X-Forwarded-Encrypted: i=1; AKwUvBzb8CiFGH0t775e8EE35dmjxBLRWqw00o8R0pPqxzc2fgDCl3TPkvfbFUahXz9FdLsgSzmrWratdw==@vger.kernel.org
X-Gm-Message-State: AFuF++miPHdaFC1+i4XXqmtOCT6Pm0og8E54bQCEIxfT8tgMGhAdjOx6
	o9FL75BsEHGc9JdAeXK2qpBGTuvlZ7Vo0Om2m4HS9cPESn98uih1dTL7pKB9QXnWPKg9gY8yf8r
	GeuNPH7L9qtMB34nHB5OIVSrU5VtBsa2uX7ah81mnDtiHHUg42HYJM8tOAjiazh1bt6FxzJVwuz
	3OQVx2HplV29V7soAXNob2nw0Gw1+GyWvw3qMx
X-Gm-Gg: AYBFou0jV8ponqPqIIFr8H+OqsH4DAoOR2eyRy3j0MVdlIS1Ol8nHi34cvmO5u6ft2f
	+z3C85nZ7RHwLle6TLesirQsFV9o76MtjiFOkDLfPgtdoGVHhvHHrnaMZ+d/sylQdQXrWz5ivNK
	l9fCjRzqQiYmoFBMTrvyueCuB5UequkCcXSjkwZHHjXRHUvq7k++8Nbo3TzQ==
X-Received: by 2002:a17:90b:3c8c:b0:38f:efed:5448 with SMTP id 98e67ed59e1d1-396d0e7255bmr53079244a91.8.1788276963066;
        Tue, 01 Sep 2026 08:36:03 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8c:b0:38f:efed:5448 with SMTP id
 98e67ed59e1d1-396d0e7255bmr53079149a91.8.1788276962567; Tue, 01 Sep 2026
 08:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com> <178822856270.1835959.15842744749902984423.b4-ty@kernel.org>
In-Reply-To: <178822856270.1835959.15842744749902984423.b4-ty@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 17:35:50 +0200
X-Gm-Features: AcwNN1XR_ENRcLXIDuE31pwfkZ-t4Y_ZQM0rZSm5dxDSS2r51n9kmCfdHTv7uZI
Message-ID: <CAPx+jO9ijNO7R=oOXs+yd-LaNaVAPwF1Rhh-xVGr-s1K1Fuw6w@mail.gmail.com>
Subject: Re: (subset) [PATCH v5 00/15] Add initial support for Qualcomm Kuno SoC
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEzNyBTYWx0ZWRfX3qcd919GFASn
 TVEa7+4PND10cqsiClN9yZhgq1MkN48Gp7bcitl/rrwXNVsuI5JGzAQhMVD8glRrFUnERuvit4D
 g72gt6idXTsjFsZRBqHYgGL3tYqqKYo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEzNyBTYWx0ZWRfX2f9dOTvZr8pW
 R5YBMW+YThxmsC9BJjlu0laWnmRbtSftT9dSSNPHeCukqXYhltUZytYQ75ahmt5MmYBfWXC3hmv
 NlDQgXI2skdEoV3OgKestLTZ7baneev5x9BYQtNGYYLlePBDSLjbdnI8R90mFDgpwppcvQlRPHT
 Sa/PktZdm6Q9DUveOM9elFeoK6l92QAP9VSHsWB/chis4uhZOXLZAaZF6mEidgsIyv9WaTCft6x
 sJup6HSirwxZK7pOevksCqahthvI158KE8urrIkN3+d0UA7q4lWKK4gitVfpHFtAHTS68MpS/PM
 g7+yzmlOhT6goTR239gYn/M/Ir9UPOy2s3sqw2mpUdKjgOsdKY3BMghcz6ofOlyCcMQoaaJAq6n
 FHbY5vLJHn5BYzHxp+4N8/Dmd5nz819UV6O5OduDu8mdD+AqBqYw9DenrfyaJlBYRJUGcoGljbE
 T+Z77EfCZrFIP6xd4xA==
X-Proofpoint-GUID: w_UNYY596F0EegUeRWVlja7yJsB7GPiW
X-Proofpoint-ORIG-GUID: w_UNYY596F0EegUeRWVlja7yJsB7GPiW
X-Authority-Analysis: v=2.4 cv=QsNuG1yd c=1 sm=1 tr=0 ts=6a96f0e3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=elWi3GNyyhLokhY1Yp8A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010137

On Tue, Sep 1, 2026 at 4:09=E2=80=AFAM Bjorn Andersson <andersson@kernel.or=
g> wrote:
>
>
> On Thu, 27 Aug 2026 23:21:03 +0530, Hardeep Sharma wrote:
> > This series adds initial support for the Qualcomm Kuno SoC and the Kuno
> > IDP reference board.
> >
> > Kuno is a 32-bit ARM (Cortex-A7) Qualcomm platform. This series brings =
up
> > the essential SoC infrastructure required to boot to a serial console:
> >
> >   - Global Clock Controller (GCC) and RPMh clock controller
> >   - RPMh power domains
> >   - Interconnect (NoC) provider
> >   - TLMM pin controller
> >   - PDC interrupt controller and SCM firmware interface
> >   - Devicetree for the SoC and the Kuno IDP board
> >
> > [...]
>
> Applied, thanks!
>
> [04/15] dt-bindings: clock: qcom,rpmhcc: Add Kuno RPMh clock controller
>         commit: e304e8919043712191462224ce9d40bb5f5a6bc1
> [05/15] clk: qcom: clk-rpmh: Add support for Kuno RPMh clocks
>         commit: 12918d595ac96b819b9c3ba0df4c6a4bf50c43a9
> [11/15] clk: qcom: Add Global Clock Controller driver for Kuno
>         commit: 7db06b5f624b583fa2206f98de8437819acada9b
>
> Best regards,
> --
> Bjorn Andersson <andersson@kernel.org>

Bjorn, looks like patch1 is ready for you to pick as well.

Kind regards
Uffe
