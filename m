Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415A440EBAD
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050053; cv=fail; b=R9Du3CHdXD6jnvKPr66xCq7zerblAtSrh8lJ1pEKi834b7bOIorpSU8nsQDRpEM+NJV2W2yUuMi1ffO0DnP2aKYRLH+Z7eLRhzQqM2tlZO2PjXP2QZvV/KHJOofqptTPWb6OhZhgG13Z310j/Rl8/EKDCfhZaOQDD8DonU4v6/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050053; c=relaxed/simple;
	bh=2m/MezBLD4L9Sm3qZKBo7QcHD2jdQUmxgA8N2cAddlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ycf9U20MP+t+MrKpV3krgyBm5FXXhLwo2fGs+NqFJ/i97yqRuA59pa6FC8U7UUjIbHQ+GZN8UUUtoZ7B3yvq8C6NCzB+S7qJ7xN9dIuj5uXSDMtg8NJknRnQETAV8ra4BLfAZhiZo/ElGK+4rGick+CiwZk25IxnQzcaO8/ngTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MxK7WhiR; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MxK7WhiR"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IDjW32716670
	for <linux-pm@vger.kernel.org>; Thu, 6 Aug 2026 14:00:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=lGo/gZLpo5Hr9mAvTJPcSXUi62nYZCQQZFmDq
	daORas=; b=MxK7WhiRX3PQSToO7bcU6y/HrAiDQ4GggX5OSGMGIpLAJDxgYypY1
	H0IL1GSSN65qK6FoF05Q8swRWZuHAjlUr9ZRdZmgkJt2IOTFrg/1ZdfrAyBLuq5Z
	dmD+BlhYyrA2lfq1b9LOomI3rnTR+8MXAewJasF/3ufqgJYZrgNcxnwPi77iNhEF
	VR0n0ZLwXW56djpAf7BMG0OnZi4vSl0YZ0rKw20vR5BIGY686sT53MBXcZmWNbIs
	OqjRpPlyt4FXcv052edU1Se+6Ustt5JPv4pRBFOpej/evv6aTtpJXnrrmqzCHEcr
	tNuvEv9Bw+Lw+2R94YYzyivuQslZI8raw==
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fup69rrn6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 14:00:50 -0700 (PDT)
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c1c25c44d15so318495366b.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 14:00:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786050049; cv=none;
        d=google.com; s=arc-20260327;
        b=OAWinet8f1f7dowt2rN+KC5Se3Um82AQPKi/4o8OS51/ByqkNIjp2iFzgm5MQ9uIv1
         td5+lxoL2YKFsYj3gnm2hnO3MYbs6JnEPnavC4YJd3L+Pi+QndZSQcaNGphkGVJzH5W2
         mWHfxz8zhwOfuTw9He8oKkBnybqVBJge3gBpaPujwgx0TtKHxIqlhLFNiRfdINTlIpuo
         KQXX0zC3KHUiDduY0iQwURVUpoQxYeUZk1wGX3Kh1hW9yhV16XDy4urcf4261f3+kuVh
         YFAKmw/al69mi5fb+i5dcoWemTk9LRQpcL/7e05dPlEetP8tjBN6rUYVGGS5fGsvVVN/
         fjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=nTp6hXk7VZVV5fQRPsG5rxZpnIFm2RbQ6Wg97lqHG98=;
        fh=5Jwh7FVE57eGngCrFkn1hIkTOYbR1FnUd9wTiHX/R3k=;
        b=f0ck7ORPpt3heq7696XPut/LMzdlhRCJSCN6iCMzX1UBsBthWF71yTEUjf+iixPWn1
         0gKyVM3h24JySPW3/ozDkOIOW52tjkcDCFM5Ow9DhjvhhdzIE/MH3y7pBV33K1/AZRzt
         j6kWnC0sKX0B2J8d/Q0O5upqhY0czZvJlVdiXJMeod5hh9B3Ca+/TzdrofiPANcr17Lq
         MxglZE3WnkF/TBGqQbE/2Dd4c/XdS6DWdT1tSQlEGLEAJlNkl4VRMQjqaQi+7Mv5vpEo
         WSeyYnoInmKBuIWIJ7WrfRkbVzTyLe9ymLr2ezXNkvmm7+AQI4OSqQ2wfxpJS73CVmBc
         ZOPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786050049; x=1786654849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nTp6hXk7VZVV5fQRPsG5rxZpnIFm2RbQ6Wg97lqHG98=;
        b=o8z/+mvtPSS0ARiaezEAkkdhG9+9z3l35GJWOCEbmzp3iQEGR/4hOKwgLkuflALN32
         0807wY9T8xzZFTOAk75n6JjawF3fQH/0Y2gls22TADNoQFhHA9aZPv/A8PxMo8BC6g9F
         YZk7uDuOvSMnNtve4npecJWjzHR5MZ9pK+Bh25ansWYrX3LQ2sSiqTpA0+eXaCmOkFk3
         2S8/kqkKgLYaYbttanzqP0zS43O413WEdXj5mAnjXt0TSkGNAcN7//G3z4CIfVIgmN+W
         eS6PFQ7WBXekmXOleVyPWKwZQanoK0P/p101NRIKbBs7A2LcyvAeSoMps40wQD5NjWDS
         THVA==
X-Forwarded-Encrypted: i=1; AHgh+RqULiV6VeHO7gBfEypNw7xQhaE85V1iARPG1hbZDETVmQL4O+R87ZEPzhu4WVkJwioJDXtF7ULmOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdZQiVyVb8NyfoJSNkUYdQBZPEtZMZPi/qoty1U9asKWFxaZ4N
	S8RQi41mT5OE97NPRVxdp5/wqKNl4vexvWsDHhJXR/+4PhNz7PnBj8LC5cBDc6S9A6yW2W8GUMM
	iF2lr2/j7UD0d2wz+Aj+EkSe8PVec9ldONW+y5pzeVLOtIkN1U2iHmrLxaHfoyg2RU2ays5B5j8
	yYhDfjaCPLwIh6zZak7QrquhlS3Emi6UYeJg==
X-Gm-Gg: AR+sD12wTBp5FaMGFxeRddOWqw4xEIklo52ksTkPMmtrVW8VZJkqDA6kXD3jx51OvRi
	LjK6YPldraxmy1FPtA6Hp7EFqnDQGN1Q9XpbaMWXFoV3S+FViznTob1zgOmsywUbJ0hY9BrW2it
	MOulqHwCFRLP6F8EpdP5eP49hjrSZxZ8TqLtT7gGBISOL9dPFcOHMAtBoFYeciDVW+0z6WBqxO
X-Received: by 2002:a17:906:99d4:b0:c1c:66d2:7718 with SMTP id a640c23a62f3a-c2039d5209dmr854596366b.14.1786050048697;
        Thu, 06 Aug 2026 14:00:48 -0700 (PDT)
X-Received: by 2002:a17:906:99d4:b0:c1c:66d2:7718 with SMTP id
 a640c23a62f3a-c2039d5209dmr854594766b.14.1786050048279; Thu, 06 Aug 2026
 14:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731102147.127082-1-git@jaseg.de> <CAPx+jO_dACmFfdy6v32=V31HYiBFeU0NpnvhVuFWvLQ0Ls845g@mail.gmail.com>
In-Reply-To: <CAPx+jO_dACmFfdy6v32=V31HYiBFeU0NpnvhVuFWvLQ0Ls845g@mail.gmail.com>
From: Saravana Kannan <saravanak@meta.com>
Date: Thu, 6 Aug 2026 14:00:35 -0700
X-Gm-Features: AUfX_mzSDNGyLEl-UUPi4Oxyi9XZAz5DTONgHQRD9ibtZ8HcFoU911_qnyQ_le0
Message-ID: <CAKJaZcON7n66Sk0RFAEiccw2G1aKF5jCR47Ph8+0RRY-Zz88aQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Wait for device link removals before
 dropping genpd->dev
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: jaseg <git@jaseg.de>, Saravana Kannan <saravanak@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE2MyBTYWx0ZWRfX5kGllrTpGN14
 EdY7SpWxq1NJOOxwqzTSqp2Q6tG28bQbmVSK5CUf7EXQvpWOLtxkabBZYxkzSAlA4BvR/r7yXi0
 4Q0eDnTwOVXsHobGTZuGmsAUmE6h6C0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE2MyBTYWx0ZWRfX657ZBYfrEwEZ
 eMykP6nGohfVssTMEYqSo2sRI0EWN9k1Fbxf1yOzA5QW73JGOGMx63dqYIXFZs5e1p9zAqlfO8J
 SSg0h/zFO+pOl9EWV3dvWFh2mE/pyylmajRg7lw34ImKcfWvm5utbI+Poi3S8C9PUIwdkfJnOdI
 KYDtzDB83Sz2jXz8aKRXGCfmT9ctTLXac5WIwNAevRmnTlniGCxPiFH/uJLRAq2C9MA63aujzUq
 oKtYXqxUbvYiwianrAFUU7QG/PhH1YgW/k55cyt9NgqBLqExiXVCw3wrEXrRju3jGxMmToTKB9g
 SsL809dRrJX8ea5i0EN2iRcQv5v5Ns75zome82gc0P3d838DelN53mes0110kBvnU42MZ6aK2CI
 0tIkXsSJk+kf+rCjZQebmUeNb1z8r/zekKUcB3dhps+j4g3rmKO2qGAFtKCAf9GvyDcNZMI/wou
 Ai8yvP+0rk2soWcImJA==
X-Proofpoint-GUID: V6XebDqzZSOY6IFvvQLnBXJomV-tFch2
X-Authority-Analysis: v=2.4 cv=IdC3n2qa c=1 sm=1 tr=0 ts=6a74f602 cx=c_pps
 a=edIAN7ErZTGbxav20d8A7Q==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=K7AIXQN9CNApSj4PEboA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=nIuFr-8touD1a-RngYHT:22
X-Proofpoint-ORIG-GUID: V6XebDqzZSOY6IFvvQLnBXJomV-tFch2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01

On Tue, Aug 4, 2026 at 7:31=E2=80=AFAM Ulf Hansson <ulf.hansson@oss.qualcom=
m.com> wrote:
>
> >
> + Saravana, Rafael, Danilo
>
> On Fri, Jul 31, 2026 at 12:21=E2=80=AFPM jaseg <git@jaseg.de> wrote:
> >
> > From: Jan Sebastian G=C3=B6tte <linux@jaseg.de>
> >
> > genpd->dev is embedded in struct generic_pm_domain and its release
> > function is empty, so providers free the containing genpd with a plain
> > kfree() once of_genpd_remove_last() returns, ignoring its refcount.
>
> Yes, there is certainly room for improvements in regards to reference
> counting and freeing data in genpd. It's moving slowly in the right
> direction though.
>
> Anyway, the release function is actually set to
> genpd_provider_release(), which ideally should free the data in the
> long run, but we haven't fully reached that point yet.
>
> That said, I guess you actually are referring to the ->remove()
> callback for the genpd_provider_drv, right?
>
> >
> > Since genpd->dev is registered on the genpd provider bus, fw_devlink
> > creates device links to it, and those are torn down asynchronously.
> > Nothing made genpd_remove() wait for those teardowns, so the provider
> > could free the memory backing genpd->dev while the queued workers still
> > used it.
> >
> > This is reachable at boot on qrb2210, where the firmware rejects PC mode
> > and psci_cpuidle_domain_probe() removes all the CPU PM domains before
> > returning -EPROBE_DEFER. The bug is asymptomatic on defconfig, but shows
> > up when enabling KASAN or INIT_ON_FREE_DEFAULT_ON. In some builds, it
> > causes the kernel to crash a few hundred ms into the boot.
> >
> > Call device_link_wait_removal() before dropping the final reference. All
> > link removal work is queued from device_del(), via
> > device_links_driver_cleanup() and device_links_purge(), which precedes
> > genpd_free_data(), and flush_workqueue() waits for it to complete.
> >
> > Note: This patch was LLM-assisted. I reproduced the issue and tested
> > this patch on hardware, and I did my best to verify it by hand. However,
> > I'm far from an expert in pmdomain, so YMMV.
> >
> > Assisted-by: Claude:claude-5-opus
> > Fixes: 18a3a510ecfd ("pmdomain: core: Add the genpd->dev to the genpd p=
rovider bus")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jan Sebastian G=C3=B6tte <linux@jaseg.de>
> > ---
> >  drivers/pmdomain/core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index 842c4169e290..4eeb980e5a40 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -2348,6 +2348,9 @@ static int genpd_alloc_data(struct generic_pm_dom=
ain *genpd)
> >
> >  static void genpd_free_data(struct generic_pm_domain *genpd)
> >  {
> > +       /* Pending device link removals still reference genpd->dev. */
> > +       device_link_wait_removal();
> > +
>
> Even if this fixes the issue, it looks wrong to me that drivers should
> have to deal with this themselves at device removal.
>
> In other words, I was expecting the driver core to deal with this for
> everyone, but that seems not to be the case. Hmm.

I agree.

 I'm not even sure if device_link_wait_removal() should have been
added. The point of refcounting is that we don't have to worry about
who releases in what order and the last one to release will have a
resource freed. Needing both ref counting and a say to sync feels
wrong. Let me take a closer look.

-Saravana

>
> Note that, the device removal should typically happen when the genpd
> provider calls of_genpd_del_provider() and it calls device_del().
>
> >         put_device(&genpd->dev);
> >         if (genpd->device_id !=3D -ENXIO)
> >                 ida_free(&genpd_ida, genpd->device_id);
> > --
> > 2.53.0
> >
>
> I will have a closer look at the driver core for this. In the
> meantime, maybe Saravana, Rafael or Danilo have some ideas already?
>
> Kind regards
> Uffe
