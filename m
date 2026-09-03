Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4CB4A13AF
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2026 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437455; cv=pass; b=oWEM2HVhE0gneG9oS68sz2wthsI5yS5ZoePee6g7QgHkKtMbxbixxXCVZB0xp+9DnP4y4MEtp7geKl5T97dhHDzZfxe5XxA1PVIevZLStocjTdzEIZ62WDzwfWqOF1D1jRoLg4H0VI7beiieXc11fE/rZ+ua+vRH6kG2a0HlmDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437455; c=relaxed/simple;
	bh=hnNXpCXji6zf15Fguebf1c9k1bZfBsYb7wHW3Egg3ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtSMBhEXWpNH52TY+eaXDhvGBofnnnUfIdzwnLkHEmyR0qGB9dN1Pj+FrilQWcTdoW47L/z/e4dyy3WgcxFKzDVCFGO1xGD+UT68sDwbr3SVMwg0EVQXyJaDwOTHn8jjVMWRmK2sdHBvoPnrrO2lupO9DFOCPG5e4/f+GY5GrEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pamFi43F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ph+8Ufz7; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pamFi43F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ph+8Ufz7"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683BTNVv210429
	for <linux-pm@vger.kernel.org>; Thu, 3 Sep 2026 12:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lh4fD+uWvDhMwH/ekLaZEqNCYIa99pFh7Tly04mKBEw=; b=pamFi43F4zHnQ82j
	Q6+siTw2JB9UfBcuQ2veG1bJIBRnGC7e1ceJNC8IoU20lBNz8uYg88pSMxhVQFXF
	2b1RxyFpyhW1imbd6i7PbQ4BVSM5ZJX72s97o7pQ+g76rZPfoAwzblyOYeHkHnIz
	tjWD2ztCb+olcEhchgHBV9VGXyYpUZZh5BW4trpck/uqQoLSo48m8jPTdE1iGsD6
	3mfz2u6pbJOIdSnk5BIyc8VVWKpwDSTwd/rNwqh+0pBFO+MQtHwM/Yl5z/pz4AkO
	McssQdtjQ9aiWGsFMEHNwKKVekBLoi4BgTk3SB4li7puoN21AuePbfhQJKbRUra2
	QdgyPQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf82k854g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 12:10:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cec4226c70so27729555ad.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 05:10:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788437451; cv=none;
        d=google.com; s=arc-20260327;
        b=repg7I0SY1akmJyzQzjTagpeTHBaikuykTNC5SzoppvIbPZFx6jc80NVV4cuqMBldj
         0+kMplaFbavEru8VrUk7rkXeZOyvXHfYBOocRFawbgrdgekRsbW8fUQtb59aNDwkqX68
         +DFagTTJdGDJqLrOTgm5PdQ/M/YPYZ49WlHwGjZ4sbveVoDR3QUHOsX1UCx/XXIPACMp
         6cd2f8EzvQWHLO0PFVBhzkGBV2Q/KhmE664rpjhf7AvQbqoHiZCu8HxUUU/aKIeJoiOX
         06bWhgbL7HEdtmFT9dsR5+FaUfFtQZtOihQtmAF3xtkOHqvL3rw6FHmdy5ySgwvzy44O
         E6og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lh4fD+uWvDhMwH/ekLaZEqNCYIa99pFh7Tly04mKBEw=;
        fh=yEaAUjSHwsKEZoDIv7IRClbboPKXPwFUTh5sRIngvCo=;
        b=AtTuVOoM+RcNFERgoTe33x6qOirvGflB+8wgP4KYuJnPYssbQq/MWm/MN2DqklfPVZ
         KsiPHmorVqDV7gbvrbNUt+iVwTI7o/7qDXzCPSC1zV1Dsva+RjXXYfubB/1gJZXWFSfu
         9wNsBoHG5MZ+gvXK6zZusgdKB4t4vOtLTubGcLwc5AqLAQCIXrrVNaxTLl1jbEJUnHrf
         wugG1pgpWECjpqWQDJ7qiWCF4mQ9yXF71g13IJMlPHVTPai1s4SMFZMO+lJDhGaXMUPA
         r9MZqirVfP/igPp/yjIWzsLis9z8GkwnNCuOmMB99sNdd5BcjWInj6BpPaK8KfQ1ECAs
         /K7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788437451; x=1789042251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lh4fD+uWvDhMwH/ekLaZEqNCYIa99pFh7Tly04mKBEw=;
        b=Ph+8Ufz7t/M7cnAWbUIQK425wtIIKr0o4pSYKg0CqLoa/BWSbYvZqXtffLc9c/NJ0f
         ak7yjRariCelji60koTYQYW/zNF7eoglYWxEvZpUU6Uv0K3VZ57O4rHMk5S/VQdgU8Bh
         fnOr/YuEPlUrTgwHlWh8YRjoIDRzgTWO/uoIf+FzZY9xx89ta/sXbUfJXYh5gwC6AvJF
         uD6CRBlWquR686KSRt2ohA5uH+MC326H7Z9cHnsDJEIKKhNFTuBTdAWzgZaT88Fglonc
         tuvHzYED1cl4G3jGcvJc3gAP5olbtr8AdABdFTbqfdoLTRocRCXKcbt7dev5mVfvRx0o
         V+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437451; x=1789042251;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lh4fD+uWvDhMwH/ekLaZEqNCYIa99pFh7Tly04mKBEw=;
        b=ftSLQIP6lCTi5Sm1G8NUy4y4+s7C0EyyLTZV7J2ASS1GcajkmjLCTcFsZ/ozoBe6uE
         06BCRm2t+gxRrGGynww/yo02Q3jML8+w1C9bPZWZwqhha36AdffnIYnd0tt+MfS8fQFk
         bHl8yQMc9neUjpElPwDFI08cifUTfWRXzWO8K19/MsNmWBmyh4v1uW+N0UvtaThlJOc3
         YZsjZVcDKzm5gUrUtZXsVxZUVdnutjlC4JE+Ktzk+CZHEQunRJfL9yTs9oY7wOEBwSXU
         BzIMKKEFgmn7uG6nF/2TETxpesowSxsevWyJEm0ofqBjKicbQDucmHKLmjHGuP0d7DOp
         6F4A==
X-Forwarded-Encrypted: i=1; AKwUvBwimGtDAPjwvrMa8PRas2I9QfPrwvkrwXJaT9qrEr3ahBLiVlcpGNj2HAE9hlIKOCPaqzvLb4Y80g==@vger.kernel.org
X-Gm-Message-State: AFuF++kUyViLlp7//qUn106d9hqU/xyvRzPunya0i/UqWx/y1nMVHdSZ
	NT5MZVWZGKtEalYCB1iBqzx1IeY87getHhMGgZsEmCcEuY4VAM+DC4xHCpTKLX9IhooKUdNL0zw
	aC9m2CGAC5iBszWe9x2rGqKyfh26WF6/b4zmIppBhPZTXT1fG18XZOaH5GBhlHcn8uXAZLi2ea4
	lGVBg9DrT5BRjL1TuVZ73gAaeTVLCkeic+gjo8
X-Gm-Gg: AYBFou2ZaAcYInViHy2ze5YRLQk4XycOJ4XcCuGuX4A5DGO3qXBWKam+LgYTphyAZRm
	AnDCvcfniJcJvLAW7sAD7FALgZUBkte+OYCkCW70MQ+HDdwyG4BR7qxfVUqSAcTtLuiODcBbq8E
	JBTd2n80RvEqoAu4UDs+UHqN3dFBQ0HDrE/xFx3Zs6z2BuICPpvqsT+I8C2A==
X-Received: by 2002:a17:902:e947:b0:2da:c09d:b5d2 with SMTP id d9443c01a7336-2daec5f4a05mr171421405ad.3.1788437450999;
        Thu, 03 Sep 2026 05:10:50 -0700 (PDT)
X-Received: by 2002:a17:902:e947:b0:2da:c09d:b5d2 with SMTP id
 d9443c01a7336-2daec5f4a05mr171420605ad.3.1788437450509; Thu, 03 Sep 2026
 05:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901111441.122436-1-ulf.hansson@oss.qualcomm.com>
 <20260901111441.122436-2-ulf.hansson@oss.qualcomm.com> <c00f266d-b6c3-4988-a2b9-72c5e0389317@gmail.com>
In-Reply-To: <c00f266d-b6c3-4988-a2b9-72c5e0389317@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 14:10:38 +0200
X-Gm-Features: AcwNN1UpqhcrP8XuT2dq_C4AZNGB-kG49zty_zs5rwD8pwTsxOtau1KLx0kmPkA
Message-ID: <CAPx+jO_jfkRyFjB35wKGs8N-hjXtq21kuOD484F8U0TL16sWqA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] pmdomain: core: Rename genpd_status_on()
To: Dhruva G <goledhruva@gmail.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: _6n8qRu3oFOiZjWGWf-pLjxKDPvriieC
X-Proofpoint-ORIG-GUID: _6n8qRu3oFOiZjWGWf-pLjxKDPvriieC
X-Authority-Analysis: v=2.4 cv=OuJ/DS/t c=1 sm=1 tr=0 ts=6a9963cc cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=7CwLG3W57V6vwtOQApUA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEwNSBTYWx0ZWRfX+MA5V66q8Htt
 zeV5pxbkKhorOFCwkK/PYUejE2lci1UE11Tl35H5oWAGrbGJG7FUkQLOqZhNjH0g1SsFOE2IxCB
 pxSFj2+XlsFvb1HVtre/IwJEraavB4Mirj9+wOsF86IP0J9/ujqpBcKuE1gfwm7lBRv25g12eaw
 OpObjcJ8aN1EWTAtA9ZWOz1VKOryUXOYnZ4EZ6ifr5BTPR/AgI32iq5T5MHEubO+gum/yKDKSLl
 WJXKSZBHpj6eX57kkz7qjWEFuxb+WK+5o+hYd38tAGZu/5w0nG89mxigcn9m9mAMO3gvI3lthE1
 vXt668prAHHsvXFAHkDAPVKCwTtD9JKbF1KKTQalsMhW4ZE7NtgjiDO/Yjd0exunxbc2QqYlTef
 7WtLtDiysgAdBLhAGcPQry/aYlTbgaXBfXdxZZWLqHUEjtb4YQwre15Tp0gW/0kTEYLrU6UD9Z4
 XwITjJdfXLKKXzpOqwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEwNSBTYWx0ZWRfX5Bp2lojY10l+
 6r21WQUW0mxorRbKF582pEM+3F66UDtTEYAl95g2RL9cDpT+sTMQSlIAFTJ7fElDKfv6JtVS7KX
 yba0mrSyqM9LfY0zjpY0I/TjQW5+hMg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030105

On Thu, Sep 3, 2026 at 2:00=E2=80=AFPM Dhruva G <goledhruva@gmail.com> wrot=
e:
>
> Hi Ulf,
>
> On 01-09-2026 16:44, Ulf Hansson wrote:
> > Let's rename the internal function genpd_status_on() to
> > genpd_status_on_unlocked() to clarify its use.
> >
> > Suggested-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> > ---
>
> Optional:
> An additional line explaining why this otherwise unnecessary rename exist=
s:
>
> Rename the accessor to leave genpd_status_on() available for a lock-takin=
g wrapper
> introduced in a future commit.

Yeah, good point!

>
>
> >
> > Changes in v2:
> >       - New patch.
> >
> > ---
> >  drivers/pmdomain/core.c | 25 +++++++++++++------------
> >  1 file changed, 13 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index 842c4169e290..6ac1ce18fda3 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -173,7 +173,7 @@ static const struct genpd_lock_ops genpd_raw_spin_o=
ps =3D {
> >  #define genpd_lock_interruptible(p)  p->lock_ops->lock_interruptible(p=
)
> >  #define genpd_unlock(p)                      p->lock_ops->unlock(p)
> >
> > -#define genpd_status_on(genpd)               (genpd->status =3D=3D GEN=
PD_STATE_ON)
> > +#define genpd_status_on_unlocked(genpd)      (genpd->status =3D=3D GEN=
PD_STATE_ON)
> >  #define genpd_is_irq_safe(genpd)     (genpd->flags & GENPD_FLAG_IRQ_SA=
FE)
> >  #define genpd_is_always_on(genpd)    (genpd->flags & GENPD_FLAG_ALWAYS=
_ON)
> >  #define genpd_is_active_wakeup(genpd)        (genpd->flags & GENPD_FLA=
G_ACTIVE_WAKEUP)
> > @@ -771,7 +771,7 @@ EXPORT_SYMBOL_GPL(dev_pm_genpd_rpm_always_on);
> >   * @dev: Device to get the current power status
> >   *
> >   * This function checks whether the generic power domain associated wi=
th the
> > - * given device is on or not by verifying if genpd_status_on equals
> > + * given device is on or not by verifying if genpd_status_on_unlocked =
equals
> >   * GENPD_STATE_ON.
>
> Since we're fixing this anyway, It should describe comparing genpd->statu=
s with GENPD_STATE_ON, not the macro
> which expands to that logic ;)

Of course, my search/replace logic was too lazy.

>
> Anyway, nits only, LGTM otherwise.
>
> Reviewed-by: Dhruva Gole <goledhruva@gmail.com>
>
>

Thanks, I will send a new version to address your comments!

Kind regards
Uffe
