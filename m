Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C3D33859C
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299518; cv=pass; b=IBqVzPnJjpf5nvM6IK4ZQ2Q0DtrHB4o1rDJSI8S7cGqEX0ldHQiIxiVJZBlXH1QbQyIWQXiZxURC18B8lIRvQnbH8e5HDrdM5V2UZBDcOIdK5vkHssIgYzBBw6rYFfizYG7Sx5XioxQEojC9NuzlBoT/0KhK7QkSfE9fLdoJ5Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299518; c=relaxed/simple;
	bh=FNzsOpMvx2fOI919kTiNEIxpFwaZQjVvzDd/rPsGLQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENZPn98163nfUILJzpJRaCz/mzDzxRQ+0eQkqmX99WgeLzJ1mqSRAqTL4rTEvA6gzqz0na2m1NrCLNIlrq/Icx3EnemphtD+utK9GdnoiGEVrSx6ijccRqN5Qvl0IchlKi2dFg/NZ9PPjmpTr4dixyuCf0L/delElV1SwzoSE9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LgURRFqr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KejCnJ5I; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LgURRFqr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KejCnJ5I"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HE7flU3123201
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 14:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FNzsOpMvx2fOI919kTiNEIxpFwaZQjVvzDd/rPsGLQc=; b=LgURRFqrlyVMT+rN
	DOONXjUOuinpRQGIpUDcZfiDuF0qiWwRCHIJMhp4rmAHIIm+LPtl/yHwWBfv0OGv
	4ubsLPL/cMwo4MeQny3CEs/OfKd6V3c3H8dHjWXXTAJSK4w3v5oNLS6B1T0AjjRH
	hehaqU+4YcUg2NEh4TD2fLrzEItb9woYQ2O4cRddbgFJRhioqfE1WBY5buPNd0KC
	s24Vppribf8S2/UxeDXp8C4EwtkL6jfglBPs8yhrwysfm0wgJFYOT/CtR3+h6iv/
	XzOo9yOHLMjkkdIOKotPJfbrlMKPc/N0aZJAb44l8ptFUuxXIEjQPxPu9Kxw4d7B
	jmgf/Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u6m7e6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 14:45:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-930b571432fso208301685a.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 07:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784299515; cv=none;
        d=google.com; s=arc-20260327;
        b=W7SmULkdsIozTsGalT0Ly0fMM0iaZAFV2peNIxJjKTXlsFqBBI4oJ91Rh1K/VwwQjt
         yZVMIS93aGMs1fJXLqDXC/AUduzT7TpiW9lx5QQeoYYWD+f+68xqSiqOLVc+1Kz3YhrB
         u/SuVJsxRVw+r2Tvfht+YMucC8C3UHvV+ks4LN8151+fpbWuOALQ9fQBL+AGiXQA2Eqv
         W2DR1ii0pXpgh2DwPfcfR+0+x3UrtU3UeFHD7i8t2th1hqN8YNaWxWmZwNzXqg/HbksO
         r/+ZM1nOMwjH0b5riV/u8fEZWomrMnxA2X59HODbKn8UCtUOqge692e6dQvGP74qjIRh
         avEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FNzsOpMvx2fOI919kTiNEIxpFwaZQjVvzDd/rPsGLQc=;
        fh=l0CsuIiRyXaufGgJxtwaLzDUYA9QhdifTPXxepHYWIA=;
        b=bBX9qBK55JWnmKctUhEFWwDJbNI6AxTxciUu221TMkODo78FopY9dzP1MeV/uemGrC
         hfB+0OeAVUgsM2qCFuyWhBiSdKWE+N7NrtsaDVQL5R9dK4bCeYhSlJCiOsDJmbiABHTe
         qhkJusAndmMlfkRfmbcVR/qZyk7yEq/0bhQZpc2eqmnSzxfHFgepXIZf2O+0rri92cOw
         Jb9O2bkdWuh8Ekyd73hz2PAQdK4MV/uIESbbOfbR08JzoXFux/Vwy/jW5OfcNhuW+A/D
         V5m2iTz4HYaW3z1xfGhnpjBH456Nis+8eRuv37LPS6vpedU1kDC8bouPlUdVdtjMsYYG
         QnRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784299515; x=1784904315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FNzsOpMvx2fOI919kTiNEIxpFwaZQjVvzDd/rPsGLQc=;
        b=KejCnJ5I5VTqLehL2ukgvHgUbRdGaGdByysbiaeyD9JfmTkcJvZ4v6ut+yzq7wkrqS
         I8iCbj0dzXsRzOFIkD6sl5sRWMfVdjKbWymF0uGiBADTCco1a42w5frd4IOKi6UDqlM6
         6jvOu3/gLrLjKRvvqSuqWyLfB8wagOtQG8cx7evIq8M32uUoNrt1rLTNYV8rALn8XYwQ
         e3FdKfEezpURv265WE04HsygtdNRXnKd1jeyXyDM4/higDszrf4glfZShoQmDWWT8pxq
         GwwS5V49aIuTjqrLFiK3D7NmQhbsuGlvj2wyx8FJR/B47Ccfk6n20mUvTnRiJW++5PKG
         9P9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299515; x=1784904315;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNzsOpMvx2fOI919kTiNEIxpFwaZQjVvzDd/rPsGLQc=;
        b=Rl5tRl1A1sqyEHzQh66LDXCc8IYgznhXNu6Sl7hH8BCVG7hWTSajC2EI2Bi8a2ISok
         IXpx/S75g2WauIGScad8xFPmToj+NDBW5tsgz9lR9OcqOJd0ajGLCfRyjlh+gT2k1x6i
         2p723CecHY0vdh3X8nAOiIkuACruuoFLhHcHGADLx8sjXe0kpoLj20MVFY/oWDJpL67j
         /5DvrIt3SpdzydzDkVlZW7tR93WItWP8ojV1TgXUGcjdTX6sPpeb2+KhJ7f49XeUzDG2
         AFa3Mfl+MJQ/qAL04ogkgKtltgY/KksIBSbk6tzS+ZwANLCMW5HtFXo37yJeon2OKRJ2
         JUgw==
X-Forwarded-Encrypted: i=1; AHgh+Rr3kP3e58Pn4Rc1Mk3mcBwWEZFZHCqyCKABe6mFht+niN2jqGYzk/Yp1lpy2yC0o5IncAiE4sHTGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YydBAK9mPhLHrYxLTbHu7+R0nL3am/ctek2ECOzoHsNuNsUTCHs
	mERkDWrYoxwhUlaQ8hpR/6MJjWO4jHXSS520tPpcG5QhYpRj8d40aL+v/1yiCUkp8Xc2ZsIziZ5
	4KvC4qaFRhMto5G7k9XL0CH2poAR8ta8YFmnRH5SQEeBXQ23rqW1MnHjvhdWXKHm10v3Vg71d5d
	kIZOP+d+7g7n1lXn50xRWssua0qgwdbDUouuDx
X-Gm-Gg: AfdE7ck4lX1p4QZLEgxcpSbkOnEzeJFhRgRGSkde2GRQqOGZGzaA16ru/9o7U3/vJYH
	9g+X1nG7WWeZr0Zg1FfkyXlOc+8lr55BEom22IJkZqJR/k8zorEY88cT1gVEi4/eErH8llFeVsQ
	BWeUUZaN0+kBTew1N2fx1SAMUXFB+EXXXZBR60s6fyyTI/CAZLL0fOdBBz0kcPMRRa2YhMXgjtc
	OJAot6vboqUCmk2RCspd9RGA3m6QuA7KBshxnL7/WYVQSkniyJNOFyRbQMhUM3SPa3Hn2VFy0Ga
X-Received: by 2002:a05:620a:6914:b0:927:efb0:3ad1 with SMTP id af79cd13be357-930b4929a49mr284935685a.26.1784299515011;
        Fri, 17 Jul 2026 07:45:15 -0700 (PDT)
X-Received: by 2002:a05:620a:6914:b0:927:efb0:3ad1 with SMTP id
 af79cd13be357-930b4929a49mr284915985a.26.1784299513132; Fri, 17 Jul 2026
 07:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
 <20260716-monza-wireless-v4-3-9b02e6f549d7@oss.qualcomm.com> <CAMRc=Md8mLgYRsLd-KhwVV8X9AcYbHf--RB_pf0xFBP_P_DvCQ@mail.gmail.com>
In-Reply-To: <CAMRc=Md8mLgYRsLd-KhwVV8X9AcYbHf--RB_pf0xFBP_P_DvCQ@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 16:45:00 +0200
X-Gm-Features: AUfX_mxmtgHrdkc082wiMIxBxijXxJxzFJEhJ2gZz60O6dCpV0Wr6tzd5_cVl7k
Message-ID: <CAFEp6-2pbYXFTuozcg51+dQ_mKin05o-GqThyJLBjquFs91RQg@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] power: sequencing: Add pwrseq_is_controllable() API
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfX1VsZ3U7CSST4
 kvdZ/9BLS3sXMfRSxp1C/Nejf0BlsMo7phl0fJp5BVB9UAZtAA6LjPHa8w/PIafOnPJLpsW15J0
 MbghbgUDIDUe1N2U2m+kcE0B4M9qtdlAfrT8dqQFqpnbmNsNZ5ZbSdGxj6xz6Epoz71MZGyI4a8
 We8EzNgV5sIs8e4UZItNfpdnZ992xMfOwEcBm7/kyOWbYtPEwLyEBU7q/uyE8OIZdeBxbivRLoh
 22T1OJdoAWVUXUok37IzzgPqZb8TipfZkFvDFC7ujgA5F9t83An8DXI3lLhWm5nLINKCfwfGbft
 BAn90EtUFA8kazzA3H9Sr49HuxE4bvM0DHa63/pTA2Rvj5kgVO1/r0nooliTrMX8gLASJ+Pw/nD
 pTs7phsXZR86ZMejqOAwYiZISGjYK6ZtE6p3mm/ptlqkoqplGC148ocsiUwgDHVQEaMj5ydD37W
 PAiMUkq4kzZ8kYI147g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfX1nJEqYjHq/cv
 8e5QuwKizL0SwvTArC6qGyPnyVughV30ICh+MHWtK0kX0aS5AZQHd7ew1McOEXgIhlVKeRZRtco
 ScIJmiTmu7x9HwCOcCLW4A4eZq7/Z5s=
X-Authority-Analysis: v=2.4 cv=DYMnbPtW c=1 sm=1 tr=0 ts=6a5a3ffc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=LMDkYzAWLNq1XrXRUzQA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 5I-usWh0Yfui2aVHsvewVlHCL8_VNF-O
X-Proofpoint-ORIG-GUID: 5I-usWh0Yfui2aVHsvewVlHCL8_VNF-O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170150

Hi Bartosz,

On Fri, Jul 17, 2026 at 11:29=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
>
> On Thu, 16 Jul 2026 18:18:20 +0200, Loic Poulain
> <loic.poulain@oss.qualcomm.com> said:
> > On some boards a power sequencing target has no host-controllable enabl=
e
> > for its function, for instance when the enable line is not wired up to =
a
> > GPIO and is hardwired to an always-on level. The pcie-m2 "uart" target =
is
> > one such example: when the M.2 connector does not route the W_DISABLE2#
> > signal to a host GPIO, its enable/disable are no-ops and the consumer
> > cannot gate the Bluetooth function at all or exclusively.
> >
> > Add a generic pwrseq_is_controllable() helper. It reports whether the
> > target's final unit provides a host-controllable dedicated power actuat=
or.
> > The target can implement a new optional is_controllable() callback,
> > reporting whether that actuator is effective on this target (for exampl=
e
> > depending on GPIO presence). If the target does not provide the callbac=
k,
> > it is assumed to be controllable.
> >
> > Note this only describes the target's own enable actuator. It does not
> > imply that a power-off reaches an electrical OFF state, since a target =
may
> > have multiple consumers. It also does not mean that power is uncontroll=
ed
> > for the target's dependencies: those may still be gated on their own. A=
nd
> > it does not restrict consumers from calling pwrseq_power_off() either,
> > which remains valid to drop this consumer's vote on the (possibly share=
d)
> > resources and dependencies of the target.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
>
> Thanks, this looks good to me now. This series is a bit all over the plac=
e,
> what is the merge strategy?

Since the entire series ultimately depends/touch on the pwrseq topic,
the simplest approach may be to take it all through your pwrseq
branch, with the possible exception of the DTS patches (through
Bjorn)?

Regards,
Loic
