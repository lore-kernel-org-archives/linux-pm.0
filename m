Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6133B42B751
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481670; cv=pass; b=Y3noE9SLoLEXPfb0h+viZWyvvoo7XnEmc2xsCHJLQKLsYbbuzsulGdhsR4ys83eCIyAyPvaeq8uaO1GWAis9IBGnPBrJz6es7jrqM7KXi/lqxGkT2lQrYfSxLwAfpvDFi05Kbs/C/Bb0EuU70qeRvEINnLBH/0y5qQ/b7jiYmg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481670; c=relaxed/simple;
	bh=Jk9heZwOVqGxyGDtvVS1hW7MiNx1ERlOZdcIgUuajXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qc4JjXvATi9gDPq9Nr4ebGdlbnMj/yYTdSvfYqDIjc7SJQ/a7paiEfaxL43PSzYTyF+kplzQwbIIfqBp44j7v11XN3/9WOJWfbjRnemsx3cZt6FW+lvfViCYw/PgO3Ho6isOq8pXK0yfEUlZq16qL5vcdS+KhEqNxglenz6Ee1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ffAyZhc0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fM7/0QJq; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ffAyZhc0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fM7/0QJq"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536RZwd2076787
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 10:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uV+J6jqoEMAGseLw1HdCj1i8yDJLhJwR59yrgqq+0HI=; b=ffAyZhc0oZDXLZHI
	PBh9V5mRzbnzoqLOfggjyij/WxjXBfmx5SBgCK5pslCTfVwqfAXRIswIo1wN8djR
	Q1FsswYFtYmOKGMW565DTWwgv8PidsvVIILmCr/Ay7kvVZX8lSJoaI7+FQDyGJo6
	v3u9Xe1MuI426fiQx6zHalMtl3EnNShgMzTBP+8JBr9q71DtMl/MV9h9i+rlmgGb
	tb2cYkKDYRjXjeLM0QUigYEDDGtAmhMm0cmpveaWF5WQwDHYRBg8+G198eNl5hWE
	PKQH/vGxnW2NgSbU1Fn9BlKiyZOxZ0rTRjxmv/5kV6ecIfWOjxXDf/etLEj5ryKC
	pDxWVQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejev190x4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 10:14:28 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ccd51bc2f5so151224846d6.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 03:14:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780481668; cv=none;
        d=google.com; s=arc-20240605;
        b=SRj9fDZbf94coBmIO8hZSWKktlfTvXQW1RtxcspLC7ThzQDupyMnISPviKBwZ0XXmb
         ETtL9s3r++0cS5s3baB1D5Qw18qm33mMLmf8guKMn7y829fJP7YEizQqt2lSGnvQ/S/h
         3gJnS1jVIJoFKbY1eQClDJsUduQQ/eTKA9GiD/bf+uKZU0rNqqRfy9kAfQmE8GBXN6+X
         W9G5F8lhfE3J8wMUIusb7RqUubeyDpbEbTNsWwybQh0M0m/Jtw11PtTmmPnkrAbBULal
         A3YNjwHPKLknyy0rr3rDVNbnNa7Bxd6XkdmabHXGNwgfUOSEKlP2iA/JZq9akQyVf8HT
         RtQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uV+J6jqoEMAGseLw1HdCj1i8yDJLhJwR59yrgqq+0HI=;
        fh=C/xQBfZbrpTkUTW+/W5tBUisdeuWHr3VjgIvHDi6BOA=;
        b=BELlGnjERLSrPPuvEW4lYvcpScO/FdxXLpCjWPJWxNy7fPZp50dz9GTpMQqyhK7RVp
         oLdz6GjKqiJ2+qi5BGwAe0GRTGtl+/3+VA2WlnkR0rm+oy33TN/ifzZYCDW3kEdBzzOm
         OtSkx3pa0u6P52uZqVaK5l/0JNysAKWCssonG0jF74KxnlcsmR3yQ6sNY2rI6x+lv/0M
         Se+opB2dYeZrjgrt8ySThoElY2UtR9tcWwq12bCC71aPt6KD4ELSJX9wX/yTMcM0Ee5p
         +U9nkwJrByw6y4GKeDuDQTxkA/bZ4pAt4RTk9D1mReD+J1HPMQAEz4PMvhWvJDMaTzdW
         RuZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780481668; x=1781086468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uV+J6jqoEMAGseLw1HdCj1i8yDJLhJwR59yrgqq+0HI=;
        b=fM7/0QJqcxS5HSFCwhrpzjPjMY+iqm2Ugo6Qz4QRpIg30zxrRJuA/NJ7cR+BMjGx/T
         wVr5y/nhJFy2bxAQDqc/s7yXmUKTnjqzURu+vggrO1bGLGr+sPyuHIiWefR0ZyJA5GXE
         cPmUurtAWnjUbKEf1MAqE5/IYT8YtA1KxnCNSBQ8H6auAP531XIsoYe4Rn1F08R+nTgI
         qlWy6PeCztczHFoykQzxMt0++FGOW+avVEVjX2118x9TGyf+4/Bn5BZWbXxmWZajkZRz
         r9uqy2oe/ZAheMORA2LOJNFQj1Xk+RKiuNWZvlCuutEJjwBEdD7PwUmCa4c7iv9BNch8
         ZrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481668; x=1781086468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uV+J6jqoEMAGseLw1HdCj1i8yDJLhJwR59yrgqq+0HI=;
        b=AufjoLueOICHE7axMnsBTtWivo47l4sClNS/aHsXeyPTWzL7y+tFtYHgsNDDu2pL33
         UNeSzgqBYCaQ7OLT9v14KpoBm4PQDXFMOBHLDKwRdkFHL9+6x5D6MxmB5c1UqCnl2FGd
         rKewbGZIvE0kD4FayeUcH6x5Egs9RotaKL3aPqOmQ8aEFfpxE+mpGffQUbVg7yIKm0m9
         rWth/ehvcJSh11vNfrm448grl/4qs4/2kXDbEI6buCPC8rWcqhoapwfuPAfORrwS1TnS
         R62XVIQMgUKAe3rd9tdchQLtkeQlWvx+B7c0Cjj1b48/LKRx1c9OX4DTWovNaKNaD1LF
         Inig==
X-Forwarded-Encrypted: i=1; AFNElJ8VA9OzPFK176J8Ye1306omNHAJyaiP8ZcewRBfCOOHNvUwM8a/TwCBVqaTQUMRDMnkdzchdfGZVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YytmBWNDHpU+hlp26r6EZEKtHdduNvajzI87wliGg90ADqROy4f
	lUy327kiAmf1YsgCdnAEtl4k5yOtG7yxksipQkZtpbvA2y5yn6SFFdKCstAeuI8QvfxB7FwtAjK
	CnhdgGreYRX/xBO8rX5rKsb9yd7YAEjBx5B2O8ol0rfFn8KEaM36YBPYx9+UbB6myCbHXyK7ric
	Aus5yiEwfXN3lcJonNPoZsWEwRj9Gz4dprrsFc
X-Gm-Gg: Acq92OEQOSHTjO5zSI4VTDREaI/ueQWRVqTj5NuhYK9ituW7YBOhNf4zM7/lAQYR44o
	5bvHK2wcN1wQLW7Omolf0V91KJE7/rfXwAWcRfWDWEZDfs2R91F+G+Ng97YLQ/0qSRG5s31Sw8S
	r3Q2cbOZ7bZUefzIV+v5GlwaUCdoB0c5MfMS+fhDi7C8FStXC5vzdnuIMbb51cC7R/ryXk9mq5E
	plospKM0nB+niJJ
X-Received: by 2002:a05:6214:80d5:10b0:8ce:b2e9:a4c2 with SMTP id 6a1803df08f44-8cecdc3c53amr29190866d6.19.1780481667843;
        Wed, 03 Jun 2026 03:14:27 -0700 (PDT)
X-Received: by 2002:a05:6214:80d5:10b0:8ce:b2e9:a4c2 with SMTP id
 6a1803df08f44-8cecdc3c53amr29190546d6.19.1780481667501; Wed, 03 Jun 2026
 03:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414035909.652992-1-shengchao.guo@oss.qualcomm.com>
In-Reply-To: <20260414035909.652992-1-shengchao.guo@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 12:14:16 +0200
X-Gm-Features: AVHnY4JP4vFOFIbIAZX0F8fhDzCXCFpBg8ic4yZD31H6-IgYc0KmsNfVvQFDArk
Message-ID: <CAPx+jO-urBm+rTHwQaVYk1Qy7senTUrSZr0SvEi8bXsxz1budQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] pmdomain: qcom: rpmhpd: Add power domains for Nord SoC
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: jrLgvVzojtoBgL82QoN0YzWQqoxA1JHT
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a1ffe84 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=rNwRBFL3uO6c_JmZLCcA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: jrLgvVzojtoBgL82QoN0YzWQqoxA1JHT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5NyBTYWx0ZWRfX2CfLOB5k5VQr
 eFyomohcGlkj16amFAd33YVK2Sjxld7i3zPBOPeP4Z7FUfhMpqKma/YedCq/peIbLS+u7Bgn2Wf
 4Bsp22xK0IRB0Uu8Uq/IF6v24N5G+HaccvBpTY4bv0onu3rxFDL+85Oe1RO4SiVeh4FIR0DZDNW
 m5bIC6458Cp/GZ5mxpTIicuR5IcTmlZqqL/RVfOX4W6KuY8NG5KcQjALi9YAeDf5jFaEa0LaiFb
 Bk3PSlZ71ekWy61i3P82SrA6zhN7XYXBYCe5NcVNHYdC//Jr3AlOVVKZHcJAD47rr3LFff9Qyqs
 RIEiCqnxa+/EMz3D+zcQmJuudkPGE2jL571KZe8lNOozT0dar26AKMnXnaA6KOdc2ic+CH5tM/Y
 1JGhD97isyjmb6ta5obMubF4PcYl+Ie+vX6pQqh70k8PWEGxzXoyTcfNBzLZ1RzCclwF+ObEsz/
 LGuVsZ00l4dwEIKmVxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1011 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030097

On Tue, Apr 14, 2026 at 5:59=E2=80=AFAM Shawn Guo
<shengchao.guo@oss.qualcomm.com> wrote:
>
> This series adds RPMh power domain support for the Qualcomm Nord SoC.
>
> The Nord SoC introduces two new power domains beyond the existing set: GF=
X1
> for the second GFX subsystem and NSP3 for the fourth NSP subsystem.  Patc=
h 1
> is a preparatory cleanup that fixes inconsistent whitespace in the RPMHPD
> define block before the new entries are added.  Patches 2-3 add the DT
> bindings and driver support for Nord respectively.
>
> Kamal Wadhwa (2):
>   dt-bindings: power: qcom,rpmhpd: Add RPMh power domain for Nord SoC
>   pmdomain: qcom: rpmhpd: Add power domains for Nord SoC
>
> Shawn Guo (1):
>   dt-bindings: power: qcom,rpmhpd: Fix whitespace in RPMHPD defines
>
>  .../devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
>  drivers/pmdomain/qcom/rpmhpd.c                | 35 +++++++++++++++++++
>  include/dt-bindings/power/qcom,rpmhpd.h       | 18 +++++-----
>  3 files changed, 46 insertions(+), 8 deletions(-)
>
> --
> 2.43.0

The series applied for next, thanks!

Kind regards
Uffe
