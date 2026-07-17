Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D763D8128
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784290159; cv=pass; b=Iln8FBwKsccY0/WRVC6TaROga0jN8p76VvllD9ahWm1mIxLBz/F8IaUbgfNRcEm0GjOYpodlaFDjpQP7xdiZAo24AX+48s/0dxPTZBUhNrXZF+H9YtK1+thDTo5UXmKjox6bzZH91X8QxPGBOCf8KTIJOtDNMbSfR0ps1kN+ccU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784290159; c=relaxed/simple;
	bh=JFhxfoWZ41qGseBSrI4vNsc3Qi5fsUGY/JOCboLXeWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlU73ZL+erRp0wIpEKcuJ0cf71UtrFSzMJqFQEpjrbEyEGHtkoSyyZBq0c40u52cujgLNoLQZpxa2c23ao+gEOwdBal0LQCXUxQwBKqNY3cVN2MaA1uRlrJ9EMdSsja/EspM8lWroA3hve/kF3/8xj84tDfq1UinorD9xDvjqBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ESn/dzw6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F9IPey/p; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ESn/dzw6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F9IPey/p"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HASvlX1615776
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 12:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JFhxfoWZ41qGseBSrI4vNsc3Qi5fsUGY/JOCboLXeWo=; b=ESn/dzw6Tu/DGb31
	GMFdKR9ixOgsJ7TLR1d5GDSvHhoLiLcoTIFznCyIm+fwhw2C0dmlvP30h8K5UB7N
	2r59nqtWV2aFGNYexRpsbaXm0pVymKVnn9R7jmw4GG+5PBbZTuvxqm5kCXqObpPM
	pIixkD7jCb2q9VCs2AsLaNN4QSJZ8XHT3FoRj+7Eq8hhsdClXXgYriM0JZIRM3U5
	4PP/CmbWTZBGxU8cvk/+/gdtwtlh2GmujysEeTvnCn01NYE8apO4KdIWx/vSpcX9
	np7q+mbObmngvg8xRgKFMWkWQd9j2awYywjphNbqNFXDJlh1B50p1D1tM/1jvVug
	//s4yg==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffhpfgjup-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 12:09:17 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81e8577d187so182525657b3.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 05:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784290157; cv=none;
        d=google.com; s=arc-20260327;
        b=C5wo8fJzWV3F6WUpgEg5BUi4E9Ex1yFicTEOy9h7pGP4xW6/7fPglppOBJAce3BYVF
         VhtjU23UR9PXzPNXaH8JHXk0TQigbE/AkJKuZ3rh18TeYmzTqcTK9kN5WgV75vIf5NO+
         mVnKbVdUOSonawJSQP8IDcsRtHKfBxcG4a+aBcNqbZwyvzvwK3TRfcGQ/ZocR1bI0lOA
         aCnWFRzh6xxMZfsItalVu3w04GLWfIXdryDNtME+6ekDALLRRE9pRpsyQlS2InQDacMR
         /05Qdv96MK3r/k1JdahxoJt95u0sN/JSR9xWypfWA8El8517Hd7e3lgFuWqQ2MivZTDW
         ZNxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JFhxfoWZ41qGseBSrI4vNsc3Qi5fsUGY/JOCboLXeWo=;
        fh=B3ZXgHEm59k/zZFxHa91usNGVW+yqB6SwgtinqJr+nE=;
        b=GUpxcxSg21E4L5CGHM2/eJP1laY/jPaf+DeX1JmS1L3bd312R74TR9+cWF8ryFF5ms
         2gIdQkJlFy1o2zdM+yP8d9fNzrOcR2CzGTfKsHqh3Kw//i2AfhgPircCowJymf0KFeEK
         W/ZjJr1NrzCJA7eUjIXfg6XrVGcS0DoyNls97QeMd8AOOZpHi7qH6jxYMqbdYTlRIESy
         IH5zkonStfpF2W1yJlA2056SYq6u3386t8gVCUXX3IX6bxjNc6DDP25gbYwL7I2hniVM
         6etqE2jWauB7FJJm/kTiD2qFjtujHjh/5EMVtt04qp4xIZWdupp/a4cFwLJqKLsTo7ho
         Ffcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784290157; x=1784894957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JFhxfoWZ41qGseBSrI4vNsc3Qi5fsUGY/JOCboLXeWo=;
        b=F9IPey/pjMR8dZEU89mvL6XiWe2n0wI72KxplpT8ul3bdveDhWqHpBzY8JJtaSJxlL
         s1EVS0IFYc1ouq2uIodLbTxmkDLusVhhrcDtkK67v5BJ8TsOAD98my5WdsiSVnMRjADd
         Asfs8ivjYrXHUpzAXX17mI1/iTNyGM5fm5ZiOqss0OR7djjqEI5Ige8hxWEF70b4STAt
         LDlcG44u+PceWGdg6k4g02t1+H1h/0ogj6jiwGONLfxlwoQb+q+n8LADjqw2FcTg4hxx
         V81FKkVA547IrN3IIfPePGHXp+Gz9KRVSFzsAecIqPGdWGgI9XX3BewPKnv5P1L4hbi0
         iPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784290157; x=1784894957;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JFhxfoWZ41qGseBSrI4vNsc3Qi5fsUGY/JOCboLXeWo=;
        b=PkqVBvb9PmhjeZmI1QH1OYGFucCb4I1PK+4ewlNFfghYyCZnGApAudhkzWslF/ae+g
         CvcX/PYYzaiZ2nN86B8YvrZUM0UxyEs+PfFCHaBNFpWm4eeAReW0d4N/VVMrueQFOOVm
         +yY8Hpy/gBkYaBT3+tceKVbgyPfnQvAm3ckIFrlJyp8Ipm+8sLLYMgVhPk6rjBtaE+F4
         RhLpEPuzMo0mbmgSy++ekUEIZ4B2pwsLk+MTAOjq7LiAGaQ1d1V6Pd0qRytb7vo1v+NE
         biYxmbs8nVlfsKdWAvkpZ9q6BGWBAMpHxmRXoAcZgKosSXHIU6RWWDAUDnpHlTstu9KP
         ojng==
X-Forwarded-Encrypted: i=1; AHgh+RokBzw1fA+NU/6ZQ91K3QX1G0HKs0+WnY5Rs4xPgoh8jOAUZ2l/789pM4+xHkl7nnCxf/BH4xOhxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsoFwJQA5/6ReRr3bHTXOghoWfAVt7c5xKgzxU42pjbQr04ipl
	0uCjo6rV8V0Hv8im48xuwGoxZDPZbJ/ajMFoyCOOCUM1Ly2Liy3wMuNqhE1WOJMWi67YlgVB7ix
	B6YkBjJ6ULx8SC5v+3tvhzUrrL2BQ8HG9Ov+XqoMYETtPh+5Y8FEKxhd9dQkb3nn/+EvnJdTq61
	AoHBLjReNy3qqiwuQUkTTXTFahMgMdpWfjW7gg
X-Gm-Gg: AfdE7ckctq6p6i/blVv3r1g0sSBs5s13etoHljQXaj3sBc9ZRQI9bDcgSO7cqXow3XH
	FnfE+t9wFdQylBqA1yzLuQ/9H3Q5EfNrEE1pbee3EwqnOBNJQeZ1Hnv7Js+iQC5y7o/5Pk7H9Gs
	UZrRj25nnl9QEhlL/w3EkiHa3tI9FTMiSZeIXtoyPrwbYkEo2fgxbxUu0xsg==
X-Received: by 2002:a05:690c:6607:b0:81e:d032:f3c8 with SMTP id 00721157ae682-81ef26a5baemr7605427b3.37.1784290156861;
        Fri, 17 Jul 2026 05:09:16 -0700 (PDT)
X-Received: by 2002:a05:690c:6607:b0:81e:d032:f3c8 with SMTP id
 00721157ae682-81ef26a5baemr7605217b3.37.1784290156328; Fri, 17 Jul 2026
 05:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716092252.251107-1-panchuang@vivo.com> <CAPx+jO8OLyX5YYrXQALQ0r7pJFXuPRwWGuLAt6bJOQZ=tiADcA@mail.gmail.com>
In-Reply-To: <CAPx+jO8OLyX5YYrXQALQ0r7pJFXuPRwWGuLAt6bJOQZ=tiADcA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 14:09:04 +0200
X-Gm-Features: AUfX_myUiTLqwqJ0wTAzeD__ApKca4G2agSk54tL9b77XvEOiH7p81DHCqse2DQ
Message-ID: <CAPx+jO_qAfpjf0s3x55tsW_V-g2FYqcFeOGjKai5ZNGJsY90fg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: starfive: Remove redundant dev_err()
To: Pan Chuang <panchuang@vivo.com>
Cc: Walker Chen <walker.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Ulf Hansson <ulfh@kernel.org>,
        "open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEyMyBTYWx0ZWRfX1J5ZA2GtIHhN
 pXfof+ynANpFTynxAnCenigsbc2hAYwGxb7zM2ExaZh56EDC3qjj6w5Sm/+CjdFX4IcDm48BISk
 tKo7TS9A34eK0CwSNox9Vy2++F8LcdoDreV9B13OSPw/3NaCelVwt+yvaP+SavUGYyWGWBktLFV
 xUja3Rl/kzq2WmhsC5+fsN1CGVV8xUu8Uo0EUehUl2d54OvYLxrQ8QMBi1DPVH+3lgl3VRXc71S
 gxdyrgyqy/j41CdNXERUzlEr82CErHq7uYeeOsK18SM+kUSuqkSMqPga/aKwLVUT22+VJrrlo/n
 iZ59b5j/k2eSvUJ/xH8DW0Qtj2UnMYYMQxv0Z8N+tueabdcsdb8zg4Hk9Uas5dBexwor2TMeyMa
 4QEGE8sgdvbrAofrD6ABhO5ocyauRjdrVA2fywRbuy2WgHrv/ZCcltsEaoUuXnZRC15uBtI7Agd
 0ICJ4vtiCRFEqZGoilQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEyMyBTYWx0ZWRfX/oNUnZWcotgT
 KK5Swv4IPMI7+491e56kxQaMSlurxerx4gYI4g+xr3OzWogKqP+gIrvg0rlzocB8d1pZIoGbgBj
 B9RZVNw74Uc5Fm1Dd1iCV5a2DCF2k3w=
X-Authority-Analysis: v=2.4 cv=YeWNIQRf c=1 sm=1 tr=0 ts=6a5a1b6d cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=1WtWmnkvAAAA:8
 a=Zi5EcjUMjuF59xIqHb0A:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-GUID: 52YBX8yAQmbyD6nkRTSRIeG8zGi0EOxV
X-Proofpoint-ORIG-GUID: 52YBX8yAQmbyD6nkRTSRIeG8zGi0EOxV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170123

On Thu, Jul 16, 2026 at 2:29=E2=80=AFPM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:
>
> On Thu, Jul 16, 2026 at 11:23=E2=80=AFAM Pan Chuang <panchuang@vivo.com> =
wrote:
> >
> > Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> > devm_request_*_irq()"), devm_request_irq() automatically logs
> > detailed error messages on failure. Remove the now-redundant
> > driver-specific dev_err() calls.
> >
> > Signed-off-by: Pan Chuang <panchuang@vivo.com>
>
> Applied for next, thanks!

As this causes a build warning, I have dropped the $subject patch from
my next branch.

[...]

Kind regards
Uffe
