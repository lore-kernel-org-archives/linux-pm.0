Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D3F3C4169
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788506261; cv=pass; b=UL05b98uJVg+qPJ6fGFJzr5tPxInN9AQZl+42i5TDdwVw39dZFujgEdWX03xWJmK2en53li92sbM/yk1Rvzwm1ugLV21/uKMSNzQ4AzyrIbXl+4PsoGm8//1Wayc/jXX780FC5TSwCMBCibZ0WREPlFcEpJCo/kYy8dffUTAeVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788506261; c=relaxed/simple;
	bh=J8dsPnAWdboF1yFvJDLhBeE5gRfGXjP3682VM1Iqx2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfYOFFVcb5y2bu94WJxnsQrttYPpAu5cIhUfaQBWltdM+/afKsrZWo2YnZPCUXhO+g6tHHWPkcJj7hhMV8KqXSEonrDU4PFzzPtiiAAIfM0nvhMMiyFsdCg5j4O6lbCCLZQ0pbR4zqqoHKd/Ale+FRfJzMbvfSO5llKDLkxOqpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OI8FT8Wh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RBU6TwfX; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OI8FT8Wh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RBU6TwfX"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68462Q8O2750596
	for <linux-pm@vger.kernel.org>; Fri, 4 Sep 2026 07:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LB6s0B651lSSZ12Sdfk1hENNUEaAaUZ9od/XOsIo4uY=; b=OI8FT8WhAfwVk+ZZ
	8T5wxyqpe708tolnXc/VTkesfR67qqX1vGQ9RxJyEyTCl2T5XFfW8RIeogaCL5Zt
	4E/omkikXWrxxm+RLQRXjGY0OlJQ2lKWJX0g7LtAZgVjohNaB92hYZsfdUHcte/P
	SBndiqT6076Ry6JMFdRQyA+2Yf7A2Xx9N0ugFAnnXxcUTJ91+wZlVx8as/ZggFZl
	TmagoMORfsZZj+pAc6bU0p25PSM7HrrM0tq/Hyx/iBXiNcsc5oY0K9+La/nYnu39
	XHaTGr8kOkiuMF9F3RftxWTB2ENwvtQAqCyEA0/kgNGd5Ouwb+M10AzzU4CyC56j
	k3HbZQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfdyxjgkk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 07:17:39 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc21bc2923fso1113035a12.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 00:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788506259; cv=none;
        d=google.com; s=arc-20260327;
        b=m1FZGiOrKcW1wQhz36ISH4QiOPhlzrIIcfZuCOPiPCPyCu41WMO6A6+/fJjtK0Xo4z
         z10MzMVKEATmgUJ22tTbuFd2P9vMloFty45r8yONOaA4syOtDBRjDi6adNtS8/okvUib
         Yi5hS7mLPqBR/q5EvL3OegvjvNCdNQLqvOFAWX6KnfZI0WtFTdqQCOnwFFYsBPfh1Xsy
         1WA6FSDGuxHweWhmiQ54O8UdGF40kf10a0/Ck9DiX80tGaiThA0AKZDqMPiyjtHSx1d4
         abZiP6LvH1d3z1oiYLdd6xHHhivTijYYrKZVZpxqDxi3jGZ/A3WtURmOqlpOaJA7JpYy
         9jHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LB6s0B651lSSZ12Sdfk1hENNUEaAaUZ9od/XOsIo4uY=;
        fh=1Yj59syl4WL5te0WSMefXl9cZSkIodV1aw9N3ZWYueA=;
        b=kD3yGTp9n8uPiSY4QPgUD6QyvBrhzgnib0dUdPAdi7EkeXiJ1wSHXKGlRdgKBGwyIQ
         VajfdHFGnXHq2WRDL3T2yi4UQJDgPEj8CDZ5ey8yIWs2gV+9hSz/SpuvYWQf82O3jhbG
         7JX/EGXFXt3yvMYTD+dZtUaXXu+EGEIdGuJa/NICb30o7qLZ1E783jZH2iC2UNT9EbYT
         aOh+BcnzOURmfJ6TYJZZASSPJEy/Cq3KcQb1c+XE9Dwd3XlbHygELgDPXjhBOSQtmEZk
         JeM12AKU2DjbN9FYwMSmi5nJOPONtNG8HKsKBCrufPmXQfYt3cxXOk8HWYAbuJ694Kgh
         7NCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788506259; x=1789111059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LB6s0B651lSSZ12Sdfk1hENNUEaAaUZ9od/XOsIo4uY=;
        b=RBU6TwfXHXEf0ViP1/vW8nLVlhvd5ncNWxGvYvaloSHaaUQ86p7AbM/HkFV/cIe/Zp
         5CdCAc3IfDHvXFvj/T21hFdpkDDCjUIdL7nQXguS19kokTgxZuSdKKvHZTb4fAMPGRab
         4fRF9COHX8Q0l2UY2N52d4YJGPbJ42csIOFT0mKCFDMGD4pfX6m+3vuQJT2tzZCZiv4j
         /Av5uJgUmvJ5fppY4W12hTJYkYovF5tmOY6MmG+LWDO320zwJqOOP3vtZVNZ40Eu5S0b
         NYCiibzxZGT/2l7QxyTus6R//8GqL7/8K/NAEcp9vcNi8bMbdo4gcAs/1XXpdHkKUDEb
         GcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788506259; x=1789111059;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LB6s0B651lSSZ12Sdfk1hENNUEaAaUZ9od/XOsIo4uY=;
        b=iJwkbMN1N/4/+brmva3EvhsSLipZ+jEV+1wDK3IZ9bmGlox+x5QBYbuQLg06+mwmGK
         L21o32nmq9O1+MDXmOMccR0sH/VAPBG0ZZMqdQpABSj8hFPCwqu5LDs5kqGwKNXrssvu
         S4vmNlMIEu6X8SF12Ebvr6tBIZQNaFkpyNw9tkTuv4Wi9T5FzCitRmYjqQog+lsy0BID
         dAq9HPcPZS4NQ4pKO8D3vEIa3S95J+QcQcJ6EHleGMzH7Fd6876iCajtm7Zl/AYRNj/Q
         pLmq+HdI2nCJDB0iOrAHC6QzF5UT2mJoYyo4u+veVnMzhiqRmcpBTzGChamj5f+G3gJo
         ixVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsNgwlOf5tpmCxUlEx5A2aqva/SuSxCkizU5pJ4mBCjXdZts8wF8Zb5oRt3+lA1XW87xoHzZsAKQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nA7GWoxMyzXOtuC+ck+oCJyajtQ5d0s0+SdG1SmshtSsancK62
	k7GsXt2rWJ+yrfPyuAlnDa+da5x/7oNafKpeux2+gesLzOMmFcnCtBT4CQP5/PR0H01ikgF2JtY
	ORtLgH8hF9gjhVM3dmo9fgkgTsL6JUzlw8oyjkof9DNGo1jU3j2AgR9V3i1mmIpjrBQcE3vz7Ai
	J6nI5eZ74Ai4RSqQyjxaD8v3bBWPP7npjJi4ug
X-Gm-Gg: AYBFou3rPtmvkH3DzSswsvHNQXnTpzanWFgU3FDJJMprt5eSs5pTaGCbIMf2CaO0sv1
	QGPkKBt+vx+ZyqYyKR3txuuwgAP5balKwaDPoBmuCcRxhIV52HrlJksbnW4mO1+JydtMBJ5V36B
	CJaNlG530MXDZCilp91dpAR2BrU8AZ6vVabwfajuIMzHapci6jcY5UfG7uqQ==
X-Received: by 2002:a05:6a20:7290:b0:3cd:9f99:3381 with SMTP id adf61e73a8af0-3da39878551mr5927963637.0.1788506258765;
        Fri, 04 Sep 2026 00:17:38 -0700 (PDT)
X-Received: by 2002:a05:6a20:7290:b0:3cd:9f99:3381 with SMTP id
 adf61e73a8af0-3da39878551mr5927876637.0.1788506258295; Fri, 04 Sep 2026
 00:17:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
 <20260903160401.GV2133376@google.com>
In-Reply-To: <20260903160401.GV2133376@google.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 09:17:25 +0200
X-Gm-Features: AcwNN1XLgC_UnHcC1VgAAx4Zjez2ZZ2qUdiBHVeX_BYEXGU9Ghy4hb4yt4Luazs
Message-ID: <CAPx+jO9Hi2R_UnCEhsXLwf74c3RTb+RodaJ6SOVXbQX_eHt++A@mail.gmail.com>
Subject: Re: [PATCH v24 00/12] Implement PSCI reboot mode driver for PSCI resets
To: Lee Jones <lee@kernel.org>
Cc: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, mfd@lists.linux.dev,
        Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Song Xue <quic_songxue@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: FujQGZ_d31Qh4kSpqPWik3XEOWFbrDoV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA2NiBTYWx0ZWRfX7HX+7RYunt9s
 5pMIqLEoXxr6yFIaGHdsAAuR7aQowc9mnaHsZQGFVJ+UD3MdchDITVZ70S39TZpNYFtmxkRBY3P
 djyI1eeyXYJEh56Bckw7/XTxNCvt7GY=
X-Proofpoint-GUID: FujQGZ_d31Qh4kSpqPWik3XEOWFbrDoV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA2NiBTYWx0ZWRfX2O2BmXRjEvv2
 T5qSicI5bWoIkR03gfD/tWUkIG7VBF5yL+ORSli3kyr2FnoBUoVt88jytXW/poJj5Sn6FOgv0aQ
 JOyrc51b+PQVFuL8i5ccwVPM5upF+eecsThZ/qhWAvuk1SV3pPZkTSxHLUFyq36xKphjib2I08u
 AmUC1th0MxZaKun/Tm+AcTf4j8fvzVWI8HRZFcW68SVQbS6up4ERNYy39hsQbtkWtWjt8bX9I02
 Romk07NVpSACUB+rIMTyRTyubkawXccMuex8BnVK9pitGJg2aZF9noN6CcBYGEu07kHUdcouqvc
 Rbiedq9S5Bub1wN0KIEa/bhefJu9xgK7nryUKh7Tn60d94M+1JniWoLEAb/8ov8UqeMxnJA7JkO
 EyYNQl+EDgfSDWAviz6rPF6RyVWmm8HfNU/QFt5trdJka97zD+LYP2J2z4o4sQ46RMc6LPqYMZU
 Dy8eD7gGUUu0kOqOVgg==
X-Authority-Analysis: v=2.4 cv=X9Zi7mTe c=1 sm=1 tr=0 ts=6a9a7093 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=RfyTg-q-OfOJAL476ygA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040066

On Thu, Sep 3, 2026 at 6:04=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Mon, 03 Aug 2026, Shivendra Pratap wrote:
>
> > Userspace should be able to initiate device reboots using the various
> > PSCI SYSTEM_RESET and SYSTEM_RESET2 types defined by PSCI spec. This
> > patch series introduces psci-reboot-mode driver that will induce
> > command-based resets to psci driver for executing the device reset.
>
> The more I read through this submission, the more convinced I get that
> it does not belong in MFD.  This is a potentially nice "architectural
> workaround" if it a) didn't break some of MFD's fundamental "real
> devices only" rules, of which cpuidle and reboot-mode certainly are not
> and b) didn't require a massive expansion of what the MFD core is
> designed to do.  I am more that a little uncomfortable with the 150
> lines being added to MFD core support this workaround.
>
> My best suggestion so far would be to base these changes inside
> drivers/firmware/psci and use the aux bus to communicate with the
> various components.

We had some off list discussions about this as well and it seems like
we are in agreement. What you are suggesting makes perfect sense to
me.

Kind regards
Uffe
