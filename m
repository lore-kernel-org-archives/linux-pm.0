Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795693893;
	b=xcZLi5QOwCWA2HTnh6KPSqumHGLpgH/bwvYsBhS1BB5h661PCc4TejfufMWI/DH9hvui
	 B9Su2uO02iB1yGQw806Xg7ZjgWjnZiEnNxqeuznvvSbo8Fp08hhb5PfdOtjt3uCMlWb6P
	 jBcewh+DKMOqvxAS0JGMYJMe9lRBrmY+sWKLeQmRPx3ryAUlTuyUvlJzJJyVs1Wz3XpLl
	 SpJRV3MR/p14eYLoG/vuvyIY5NoDmqLFtnRXRct4E4IJEcR21H1Ktquc57XEK8CpMH89R
	 HQBsvyZ+qZxNZ6v70o7V+/27akeD5iHfGlA3lpn4y5xo9YVp8X5uCaE7hjSqgg1GtRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693893;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=DRfn2MkwLmsrutJ2u/53/Djj55REg7Q6Juoy0BfIWc4=;
	b=re8RZEMRUakFkyw2yyn0mLp/WV/lDpb85XIjWVTFIUTiI8ULNpYkqwNPnT5xArlS/JrD
	 kY5Tycvg3bka6TnLsn7AYJE0+S7tZz3V9GVlCJQSoxfclcw5pFu38im19KIu6+y3n41er
	 tLC75Ji2wQhUcwbzoym98TZOYGZi+tBmttYZoHaS60YwPf1TMCpuBKzJaFsha0RmQEdHk
	 QUtiLzx+/TEeZJxyCFmwhUC5rBokfPEUs/L2cRsdJbFeQ2JvqaPH6KtMdqggLlprITFJn
	 /Jirqr42YzN1wTdDZDO/QrisgXH79SqPppxdHiUrIYBOTRivaUlAyfh+NYmJEk7hiJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="b/Ezn4ih";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hyegx2lr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D27606A31E
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6D27606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b/Ezn4ih;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hyegx2lr
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBVTaR2911750
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DRfn2MkwLmsrutJ2u/53/Djj55REg7Q6Juoy0BfIWc4=; b=b/Ezn4ihmX1Kmhfy
	EOIxXbsIia50tD8zpZFYejZjnrGzSnoP7tt4l41CejT+0E/IKBESiaHQ9URU9dFn
	CcnvCOkRSuiUy/vAshsrn1MUvKzR5x2HxqwgWCHW3woosSI2TVCtBSgvQHnTXV32
	l+Rhwsln1IXxYnvH4oYL2lGEiFeujJy/5i9TCc6rbGVhqUobOtmMcBoY4P8jEsQG
	qlygIWKJ7K+H8oHLZzdMsvmoWj8ELGcPabZhhnO97RmaTYLNeDpTVhJeB7WrzXTG
	FIAgl6BDD3NSKgkd04MdspdVk4GO/n5elTqD3h0e7cXEHvjJxRSVJlK2QiT0SoEk
	ncmgfA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ak024p8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:51:31 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b41333cb47so5850697a91.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 03:51:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795693890; cv=none;
        d=google.com; s=arc-20260327;
        b=U62XaME+U5E28Ye9cSs79TGBdrQgXrtCcAVFiiyumScHMBBH4DPMDAKaKAM33W0uIl
         +MbNTBEQLrm9Y7BX+ESvz4s91qxGETPtHPr9dfubh2p4cbGPBbbYJpqzmXke5Y4sVKfH
         wMoBmvWFqTIYKYml2SXN7E66kLvTHtMrz0h0mPOys/ul2tisCwTZFSoLuBud0sjl7zQC
         ucaSmoJc7yr3Tjx0lf9FJLtxF8ert/ls0bfC12N1U+gycRPO8t/iNTNx+Ru1BdJWUAII
         pWPNkLYoTgFHzEX0HNysId2Bt6My3ceZDrZ0xPGhCB9giWKuaqj0Kc9TTPWYfU/1Wnc/
         GYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DRfn2MkwLmsrutJ2u/53/Djj55REg7Q6Juoy0BfIWc4=;
        fh=44BouVJQ4psyHsRW0QXddT0in/wfU/bSjEUm41tADCs=;
        b=pGcsYq2BBJshNMbPG0fyd2KpiotSVV49AnkHAbp4kebS0+2yb3YX/cPR4mRsuRdGIJ
         KEFnGMX6G5Ul7tqm82Kgh2wP4STMt5r4azuwUiMcSNqzuOdhuVWCk9EPNfLzVydy7Rnj
         tFIQQeHgI408zD5lEihgnbbzdbsWpkP9bB3TRrLA7XhMlhd2DLG+tIg96jdV6n36Nda9
         +x7d8bXM8ig31nDnrGQfWQ2AlFOo3hVoqyCchd6vObkiiOL36h4uFAEXW07vHZbZFTgo
         6seak/MT5U4PaYHDitZohIuQHgtSSSwJMYMjDEFdC9n9/Bh3ZhYQneRx2itpvfI+RKvO
         ZmiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795693890; x=1796298690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DRfn2MkwLmsrutJ2u/53/Djj55REg7Q6Juoy0BfIWc4=;
        b=Hyegx2lrSPdrq6Jeequjf2UZOEQPIiwFhAJe43lh7MjzExca0aD5y3BHaa0ZOeglgZ
         O2KqYFrmWWfnDIvzQD9bjd7B751Dibt3zMWqoPiklfFMx7Fx/8fyoEnFORHFZ2sYwX/i
         uwiUG4fFXNqdT9PWpJvIXY+3U+FbPMRZN1WfcHuXOw73RjEn2QrK+xEMaYXgT6ppgv9O
         KdMD/2/+yD1llk8H5V5T3KqqIVgWTN0uz5xN8ljaGH5qtloWlbmi9Y7lU7JHpiBOXc6c
         MsyDF5czF7kaYiyiuUDWdLcEgl2EJoG3chKXz9xBYCfWOecEPxFVhAj9bg01rofaHuLC
         T2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795693890; x=1796298690;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DRfn2MkwLmsrutJ2u/53/Djj55REg7Q6Juoy0BfIWc4=;
        b=qpSDlI1fUETdEnTQGvMLMDFH68E5hE1QZ30YwU+PXpNcnDd16+ymAKba/FpeIaZkLl
         ayXEc2LmQKk/kkiKt5u8QAS/q6mXNEOCMrJjJFb63PLmlZ/7y0x9dBCRNroLPfzGF1/m
         YK25H+OVtNnJGEVcpl4V5IpFBdhMN9FIpv/oF308PGKyaDSFzigMyKcROtpb++x2Butk
         ZeN474UfAPUP/U6ptYlwVzV33c1KtqAhshgmYz/S0Ftw/3ozxH/Ams9E+Uh940DtUoov
         Vd5HDuQ26IWWMy5DqPI8tG/rAH2QVkihgZHK9IJMMR9IwZoE4HPvYdx1PDUZ/GEuGZWK
         3k+g==
X-Gm-Message-State: APuU4Z9iaQHp/x8Xz4CGurz9xVMq7b3rGeX+IrbCN+ANtQ5AcQoTp9Dt
	magCgievwg8URLjTos5o++pGejAYd60mmfXxV/8juXoKhtVkB9Z8x7KVYf82LPzKL4vSkk67xjD
	dA+nryHoT7+ceVD9cESR8ZFtrpk3Oixu27sEpdZDGG4Q7zTNMxRNdt1pv75Qzr8Z1L4Z4jLLAlQ
	bQLWMk2yi4KmrJUnq2/alfAzyCO4/ejzjM518FURJHVTMZ
X-Gm-Gg: AZFdTZeUVQejtYQOhUJ/V3w23JvwJdTsw1GOc7NCKaPfxcayE5LiO1F7pVi/wSWdyeX
	5eteXVlsyc3sNGU81+reyUMl0PA3+r4tDQgnzdXYKHC69OQEv/7dvOXtPI0JJRQBBYktrSgTSJV
	rwMFIj4KXNyyjzX5dCjr1LX0JQfm1l+OWNIi655K2xjzLM7eC2WP415MLx7A==
X-Received: by 2002:a17:90b:5287:b0:3b0:d35d:bb86 with SMTP id 98e67ed59e1d1-3b41c8fe261mr20370985a91.15.1795693890478;
        Thu, 26 Nov 2026 03:51:30 -0800 (PST)
X-Received: by 2002:a17:90b:5287:b0:3b0:d35d:bb86 with SMTP id
 98e67ed59e1d1-3b41c8fe261mr20370971a91.15.1795693890029; Thu, 26 Nov 2026
 03:51:30 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <4779892.LvFx2qVVIh@rafael.j.wysocki>
In-Reply-To: <4779892.LvFx2qVVIh@rafael.j.wysocki>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 12:51:19 +0100
X-Gm-Features: Aa3M54purnSPAv_lCCDcNWj7ExbQIuNGw6kpLYAci7euUlbWU1CPjrNeI3Ij5GE
Message-ID: <CAPx+jO8d-25kLQw9X0wW4i3YV4Jn+2Zr7_ZOT9rE10D99kPU_Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PM: runtime: Fix issues related to autosuspend
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Driver Core Development <driver-core@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6b081d43 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=oTMbCWg2ZTIKbyZXGosA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: IHLE23dmZVI6eoxj6rc1akcZLbVu0Ahy
X-Proofpoint-GUID: IHLE23dmZVI6eoxj6rc1akcZLbVu0Ahy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0NiBTYWx0ZWRfX4HrGTrIVpscO
 qgiBay+BeW1j6kVlIYCgKJKEQcqTBTwCEWUDjmcLQrogUHHEEuVFVkoYCMUtwdWmaHEPijgF8NU
 cOOr1WM5snP3SpkoDN8sTaOf1xXZJudUT4nASpG8Xk1OOy+NkghQt4gaRRysY/HWuvaJHPeoNeq
 JihaRnVHBw7OxiCqQPb//ORU1+rYUBtIQXOLblPV8SLZJIF+Faoowk0rwYXP7jun95GzdqXZi7U
 4rmMKEbGlQmv1nVPJl6A/4r4D1qr4DIlNiYonIMeQ36VxFUsvA6OQgoZDxi4jLlh57yDLLVpcN1
 Sd+dDksC4dvjh3bZWARBe4pflka2cal4ze3fmLhfqVgmOp4L5uf77dxJh5i/pY7Zo1+2nXQLO2T
 ti7pCKhPV4D6mdz3JPaXBdJl5wFvBUibcyUbtuj3p5hZSLMdwXNOYCbEVWvV/9US2NyPWJplPl7
 +1iJH2fC2xi6RNh+7Mw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0NiBTYWx0ZWRfX2MJ9hfUyhrB5
 O8NwV95meby0qiBMdyJPl1YBvoSVEcs6K+UveWSR4bg3mFFBXg8UbUMHHO5yFZ138iGnKpQvuEU
 vvSjKf0OBeQ54s7EyHAWeTEPB2JdAto=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260046

On Tue, Nov 24, 2026 at 4:40=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi All,
>
> This is a follow-up series for
>
> https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/c=
ommit/?h=3Dlinux-next&id=3D26236a3e8803f7e1ace104020d7f006edb220116
>
> which is in linux-next and it replaces
>
> https://lore.kernel.org/linux-pm/3076901.e9J7NaK4W3@rafael.j.wysocki/
>
> (hence v2).
>
> First of all, there is a potential issue with respecting autosuspend dela=
ys
> in pm_runtime_put_autosuspend() and pm_runtime_put_sync_autosuspend() tha=
t
> existed before the above commit, which is addressed in the first patch,
> and that fix is relevant for the other patches in the series.
>
> Second, the commit above overlooked some cases in which a running autosus=
pend
> timer may trigger between dropping a runtime PM reference to a device and
> updating its last_busy timestamp, which may cause the device to suspend
> without respecting its autosuspend delay.  Those cases are addressed by
> the second patch.
>
> Next, I was mistaken when I wrote this in the changelog of the above comm=
it:
>
>  Updating the last_busy timestamp when rpm_idle() returns an error
>  without calling rpm_suspend() is not useful because the device is then
>  going to remain active for an unknown amount of time and its autosuspend
>  delay needs to take effect later.
>
> There actually is a reason for doing this which is that an autosuspend ti=
mer
> (left behind by an intermediate runtime resume) may be running when rpm_i=
dle()
> runs and that autosuspend timer needs to be prevented from using a soon-t=
o-be-stale
> last_busy timestamp value.  That is addressed by the 3rd patch.
>
> Finally, the last patch updates a kerneldoc comment that has become outda=
ted after
> the commit above.
>
> For details, please see the patch changelogs.
>
> Thanks!
>
>
>

Again, thanks for working on this! For the series, please add:

Reviewed-by: Ulf Hansson <ulfh@kernel.org>

As somewhat also proven by the subject $series, there are some churns
that we need to deal with in regards to the intermediate rpm_idle()
phase. I am wondering if it perhaps may be the time to consider
removing it altogether, unless we still think it's useful of course.

In the past we have discussed introducing support for *multiple* (a
dynamical amount based on what the device supports) low power states
to runtime PM. When I started looking into how to implement it, I
stumbled over the rpm_idle() thing, which kind of prevented me from
moving forward at that point.

What do you think?

Kind regards
Uffe
