Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649D843F08F
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277588; cv=pass; b=ZI6JllVCRFrvtj1XH7W9gdTrGrQyQDoXiuRKA1aYH6vHVQgVoN2FGzs7ETbQDplJuKu//B+yiBrDhZ0M+EViaFp1WHu6y+xhKqhGhc8GUtOLNjbkU5JlrDbAH88tA5Zme/nQh+feOhn+0/s1/khU5CxQMxb7IJFP2d6ucW+i1bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277588; c=relaxed/simple;
	bh=rnICP/8ipFwPUYfbnkDLyV5xBmiEhD52APzyFmePejc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHuYAPzGu1TNyJyuaCDL5r8j5tK0GThbyH8SWyzaTA3Ys1cz4Z8pWnUJDPu9WdVjWKNVcdEYWgSZ4un8Fh73Ts25ozxHT4s5xlDYxTlkIiZVsx2ZOeImqBHL0KZfhGQF6CN1/xLoe+vA/Gd+dZbcgu6lgqlYPBlR1DwHjKmFxPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E2GM46wM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zc0gcE8O; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E2GM46wM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zc0gcE8O"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E8fh13002493
	for <linux-pm@vger.kernel.org>; Tue, 1 Sep 2026 15:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WOtmA72ZFF7SpeYfPs2ScSy02kZ26uUYXO+68oHg/tE=; b=E2GM46wMMsXHOkeh
	ceRe6MDPCujkNOr8IAO3QT15bc40jxWKVmhh6NtQyBzB7MRKSE3+bc1W4mbtJrS3
	PxHNnDxcP69Q44V9GjyEV/v6HOMlpUFoQJN3TvhRXB2glWhOauZba+BvlUgJKg6T
	tcTBNitlQ/MZzspJTjmsWl2UnKFcPHp4+WCoyYoDOiKWeNBnu1VZUBxHaV4wEgy0
	aFv8H2BzDMJcik87d0hLQDGOI0qlQeK7lHn1doY+c/dvT1mEJueUl7dciyObeM1X
	UD1Si8yn7RZq3WiSo8wsoknkFsAR89kX7fY0YemRrlFjs0ryDRBBreeu96Vwa75X
	eDla2A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdqbh2yu2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 15:46:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce8a76df2dso31909005ad.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 08:46:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788277586; cv=none;
        d=google.com; s=arc-20260327;
        b=AKuG7DFEb8DIHbBvMZ5HTsSHyWxAWiPiSmD97bmfnXvQf2YIZcExDf5U3T0BQk35V/
         H3ZzMFD/j6P4B2AXQ/scneDnIRY6BPD2C5l/HVj9ubcTnRGo/g9uF6+W7Hoxy9sHjCNZ
         AMvJ85LFo7SCQscr0jKHoMZUGM04g0P+FLkMBJJz1EZpqFmL+RuC9/RdJhLvYyXdU9Wi
         XJeOpbReMl4PPlf9mSPn3hb93ttT4DGdtpW+Jtgdc6nAikzsltBFbwmFcircno+BnrUC
         APYJ6fjOc9ybVtLVZR5GNbC6T/3gK/OGFevP+IMatwwVJWSPEIy9rBVzzz7s8Mdo3IN1
         znlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WOtmA72ZFF7SpeYfPs2ScSy02kZ26uUYXO+68oHg/tE=;
        fh=SZVejlJf9bUBjwC5PtqilmY8F0DqGtUTNdSko0qsBcI=;
        b=AnEGJLVHQKMDvNwPCiPVU9tDq7Jxu2EuFsVy+FE48Ibii1KOQecqCOmwxwpUy43v8o
         zIZivSEzp6ON/PG2oGXA64sRxU5cyJobuE3Xb4eB3tCJOCHQMdSvSizvF0kT85pJba1f
         A3YRasVct4u63brL5LU2YSEvFMMUeKEBhDORdX7wY+CxZiiaoBJA6rsOP3HiNBzS+rR6
         gkdGk0F26c/kqJWuhSooDVuumPZXJSgnfEQEFrBDgHDUOgNFhrUVs3QFq16gd3R5ptIy
         bC0Q/6ozGu8ogGW1TUH3VdryRtvY2f/n3wJUKP+2AXUgwwQRnoP+GSpu6X3z815xz6In
         vf7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788277586; x=1788882386; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WOtmA72ZFF7SpeYfPs2ScSy02kZ26uUYXO+68oHg/tE=;
        b=Zc0gcE8OcQyOt7ul7JhkIwLEhQe2ptxOIqE+Z54oxIBGn/Jm6Z+4umJPOm5fu9/KMZ
         QneE+qmv68GuZ04s1QvpyAXb5xuMCijQlij+yqoSIs47+gW7fszDwYSIFm6hlrfAYLOU
         BLgrb2h+9PHlFee+D1CDtFzHSfKqSEFnd/ashHoizwDYK02gjIatTZaKpYfPQvIl24XI
         3M5Nv4HkuzMFLaiVnNfWiJRpRM+bBTGXbZ0zlb4gSbiTfHC4TaJrYVRstU3o1OHZWKR/
         5nQpcQm2pYPfnrkTO8DDx9wpBhc/WioFGZ6HpFAlVdvlrLZS7w4hMjl/2vjMGC+qeXcI
         cODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277586; x=1788882386;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WOtmA72ZFF7SpeYfPs2ScSy02kZ26uUYXO+68oHg/tE=;
        b=iUy8671EWGE+09fzJ9xaYjFqQ7Lil2Lq5slQwr0THHpzjA1FS3XjS6HXZzDbIjKFf3
         Jcvd3brsGGAOgA/E61h5FTXP8ES+72DvPXdawXK9zzgwpvfqIRI0EozC7k7WB1zDuPs6
         fUrPf500/4TKjx1UJvxTKmIbCymBMbLqqJQTyiywh05QAcEzSsTI/QSpaNG0f/cTt6Ea
         81Tju2+y6IJ5m91cZdDWa14RC63QGizJYkJrbM92chCoTzvEw6eoPJC5M2PKz2DhYsIv
         dld5G6l6+C/GDwbX9DCmh2ykl5dzUox6Y9CzTF/nMAULbvVLZoo9KDnaFpEFJ7rM+gQs
         3ICg==
X-Forwarded-Encrypted: i=1; AKwUvBwFkZjkq9fvUB/TZhoysbUmSCFOMpBXtrJO4ysdR5pR+YBMTnO1D98G4U0NsNcJANv9b0EP4oM7rg==@vger.kernel.org
X-Gm-Message-State: AFuF++koi8PvO5Ar/mW4y74c7wztNp/sjEKDaGXTMBxI5aNpRQXhFy4G
	6DwhWQmctI2BYu7JtzRzrLuUZc3tmSz7ZtSBNOPxF+k8Z12JiqsCRdhu9WD3jB+o8W5EtWHdiSK
	/G0dpj2CjxQ63qi31U0FGB6g9GsEIcxYHzIHucvpjCrZE8kWIbtQOLrt2N1arChLkrBPhneUudK
	ixpuJfqCjTVtOaw58IiplASAu4MGYb8RXIbD08
X-Gm-Gg: AYBFou1rX8DcqjZjPJQe8fGYvkNINz01kBZ4f5HkRruEDRNdK7OgcU+Yd/EkokCnLYG
	h3XU28OFWp/5uzFMarH4oGFC3ClcqDtjYPgSLH6LL/F/iEcnVSHmX5iy+jBLCKd7vHibMXRpydN
	tgFifqzlFnh2uuQzu7DwS2w8uscQ6j6dTrxSblA2y8Nxqv5dGvyBSqYYMbiQ==
X-Received: by 2002:a17:903:3c65:b0:2c9:bf82:dd11 with SMTP id d9443c01a7336-2d94a784931mr142846675ad.7.1788277582879;
        Tue, 01 Sep 2026 08:46:22 -0700 (PDT)
X-Received: by 2002:a17:903:3c65:b0:2c9:bf82:dd11 with SMTP id
 d9443c01a7336-2d94a784931mr142844255ad.7.1788277581551; Tue, 01 Sep 2026
 08:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826135454.658615-1-shengchao.guo@oss.qualcomm.com>
In-Reply-To: <20260826135454.658615-1-shengchao.guo@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 17:46:09 +0200
X-Gm-Features: AcwNN1WYz_8rnm2ufJJ2jNPXi9qD6e76DvNVZfDobNOrG3sw9T-MJKxhGpSje5w
Message-ID: <CAPx+jO8RVUv=mqDZ-GeJa=dEYdNCK9L8Vi=UCDY9GqQ1TefCsQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add NMXC power domain for Nord SoC
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE0MCBTYWx0ZWRfX1zikNrmyC+SQ
 HQkBvy+8QkUiMLpX2AMjfYqjwIt4OoVOEwxlta9UJz2L4ADQk9Pd7wNM0rZ1GruDwigK1Pu5VPa
 CJ4+w2HvaKFxoU5xjBLC05xzboMzkL4=
X-Authority-Analysis: v=2.4 cv=R9wz39RX c=1 sm=1 tr=0 ts=6a96f352 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=vbPe28F0ARNTXUAfal8A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: wAdvD9HJH32y_A277vubnQjgPRjA5Q91
X-Proofpoint-ORIG-GUID: wAdvD9HJH32y_A277vubnQjgPRjA5Q91
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE0MCBTYWx0ZWRfX79kfQpxE+Xag
 vlY3AXd6hg4DuMKlukEXrxmWTI7wBBnaIH0/m+meso5d6OQlNflOXBnKXvU5Q9o71+WxqRjNNVj
 ljxMUAzA7i0jqKyRnZonogFxqIupjMmUqlxI9vIk4dmGyQzAfG/+DuS/onFvvm4JOuVX1YM+rYb
 XxCq1YgpiQBxV1JmIXm4J47Hh8kljUdkreT3V7mlXNK4/ujrFExCEfghsgbeBdvj1h1t9vdrb4f
 R6vQssT0uCai2zu1S0U17Iam7bGKpNXYV8+tqBkLrKDVsjSerEXjdgLRWKnQQgswQfUOhg+lBD6
 Aacpv+lMgY0ZrbwV5tvZNMkRTjXokl57s3QAH8ipbhPXRaLQBasa4Bgm3EvY9WMe1gkWE9Qly0O
 EurlYFR+jEQV61DZ/MHkEt3TJ0PG+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 spamscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010140

On Wed, Aug 26, 2026 at 3:55=E2=80=AFPM Shawn Guo
<shengchao.guo@oss.qualcomm.com> wrote:
>
> The Nord CDSP subsystems do not take their memory rail from the shared
> MX rail like all other Qualcomm SoCs, but from a dedicated NMXC RPMh
> resource. Add the nmxc.lvl RPMh resource and register it in the Nord
> power domain table.
>
> Changes for v2:
> - Drop remoteproc changes since "mx" of remoteproc is just the name of
>   memory rail input which can be wired up to NMXC power domain in DT
> - Link to v1: https://lore.kernel.org/all/20260826102746.633076-1-shengch=
ao.guo@oss.qualcomm.com/
>
> Anurag Pateriya (2):
>   dt-bindings: power: qcom,rpmhpd: Add NMXC power domain index
>   pmdomain: qcom: rpmhpd: Add NMXC power domain for Nord
>
>  drivers/pmdomain/qcom/rpmhpd.c          | 6 ++++++
>  include/dt-bindings/power/qcom,rpmhpd.h | 1 +
>  2 files changed, 7 insertions(+)
>

Applied for next, thanks!

Kind regards
Uffe
