Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ED749F11D
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262047; cv=pass; b=m69bATfWExbqIHqX2eRrveOeGiwsQYStdmQtwFCXfC4X/JPXwpfzKLM1OQ1NCh6/R/asbci/NpLa0rNdpd4c9+fXGVlDvhYdIax2Xs9dklroDCTDpytKC5F/zl10lTkQVtbU9s6QE+4Hm9SkDyQbf1U0SlbyujCTIgtYFn+9o4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262047; c=relaxed/simple;
	bh=iuUfA02SH2tSSicml2K0I3xqm9pZO7ThoY25b+dKE6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrwi0JiUtIyY6LmgsPfc4as+RY7vEUlMCAUg2BdazvVP1A/QuJdINMG3FpyCi2LOa4d8x1VBZ73tgGjhoM6MR1ekRjX/U0cAjoesiRLBwf5i6VLBXxA3rrzxWkVHHet2/TmQBJtzT5o5BqvhDoVQs6V8uqvEVOyw86FbWOqR0jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/tUKF+G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVDl+InI; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/tUKF+G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVDl+InI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790262042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKTy1DV5Z8HP/0nQigR4wkQdWVD6m+LzXDtQhSwKE3c=;
	b=h/tUKF+GjUa0Y1mVfe+yVQYzqWASfzm5/7k9EnciidAxox34sO54UF/voll/xmfgUGq8aH
	2EuBMW79l/Z623eXVcIWgACtfc3pUpSLhU2X0CCIjiSoAnZNr0R9gBnRC0wKqcY3lHBoz7
	YK/Z34l3bpo15gnKhX3liV6LGOef2uo=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-LIiwvhZXOZa8N4IbtYx5DA-1; Thu, 24 Sep 2026 11:00:41 -0400
X-MC-Unique: LIiwvhZXOZa8N4IbtYx5DA-1
X-Mimecast-MFC-AGG-ID: LIiwvhZXOZa8N4IbtYx5DA_1790262040
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8a1d3de9eb8so14300007b3.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 08:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790262040; cv=none;
        d=google.com; s=arc-20260327;
        b=fBITr5yC703yaREPhE4TUd3vhUYp+msURqWId9h+gIG5upkmZSHllcev1ZRcd+T37e
         WH45jr0WIzR+xNr19E+bYPmbOf+QNqr+35X8LomHAZgM7bmR0l/y4L8MHQdMyyBxSLoo
         EZ1udZWAz6gZ81tc3bNopm2r8ljeS9Qy8BJNcxVdKAmIngQd4ewl8FV/cZ3eGjLpXdTh
         YmOvkzna0zZs9yT3zWO/EHc9DCmYdbJs0CthwIHgAMyPV4j1hVN09qNeHa4fqFG5/3sx
         c0o49f7jJzUNap5OkD/ZVSTQAYJgH1T961mAqMx1CBbuFRzT3GSUcuQ3PlfAB14Q9kYC
         87/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YKTy1DV5Z8HP/0nQigR4wkQdWVD6m+LzXDtQhSwKE3c=;
        fh=Xfv/nUxL+8OPcNsE4z460U8WdgZHr999QpKQcQbPyVs=;
        b=sIXt8qoj0f5FjDNOv6SC/0ihxfLBYMaJ8d3LCaty/9g/PwrAfXIiaYA691j7UZoNER
         vbZP4UwKJjzOFoVBlvYMNv/AFv8MhChEAAxQ1o+VqQiuqG60EpJkfxxdGciAZLfeL5pZ
         gdnPtFL7oX+DpGD/Uj+M8cJmlEFf9o8reR4/JunwVftOfb7ynoHS1oPGkSsu7FwR5fGm
         4VpYQLDebYEPs1NTnG3lSfBDnJpmkLo7oDHnBkidMTRgE47KUF6E+ErNsdBQY9+vRyt6
         2UWTNaIvFg2LcowiJzfu8ojcRhQ8+bzuo4zwgCopEG/hMKW19hoYYAoP5ravlNF+/KUc
         n+Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790262040; x=1790866840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YKTy1DV5Z8HP/0nQigR4wkQdWVD6m+LzXDtQhSwKE3c=;
        b=MVDl+InINlRiSWNoJ+zSo3dPDLpLFAx8rHOQcJPrFcrb0dFjn331QV2IRGTQ7mSLf2
         FzOGnMoq9jW909FTyZADgpBVLgDHXWeUVGIDkPw+aeVry1O2IqecYbQhdHv53moD09Gd
         M6/R10IHRh/oSqPNOZRSalRoelc2p/FUbgk8NWsvk10oj8K0P0i/+6Kb2SJNz7+VGtS3
         EHiUnog1bSJUloT5Ezfcd6Fbhr/4NApXO579lYUqr0j5S8iaQ1FgRSVlUokp15A2kalc
         H92GZLmjxY5Dvm/8H/oqzwnBKNx9aSsXGI80NbQvadYeVqffYhdBjfmMsucgQUH6nslq
         hc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790262040; x=1790866840;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YKTy1DV5Z8HP/0nQigR4wkQdWVD6m+LzXDtQhSwKE3c=;
        b=nJzZz2Wi3/teS9uroXTtlMeMEE1jF05/8LJ6FUjPdcOkLB39aaCEY44tNrC2VhvksH
         +QE13KUSK6Hg1fTSY3OG8l1hvIgsVm4HRhUYcwN9oc8+uIAyu8pG1YI1q5WRI1xd7R+J
         +uOy41EB3e/sm0RDr4wn3KjHbn2jBuNmckKgMmXXFTIqSoM427EzSaMZr4IhTNAiccEm
         6l3iHk3FrAHaL4NROWxm6bx9AP/+iP0Co4p8s6suQtvv2Pc1w6GxPWZIGyViGLeZyMgi
         JamVzwmM2eN2dgXA7mpHcv5opf96r4+GTphVvH2TNEOnBEcz6N1U+UnCIpUviCjySJ9G
         3+5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwUR+5+RHm1013GASbK5nEq0GB+ts+DD8oquRWb599Vwuf8ovCGXniSfjOM98C6aini776vFVY8fQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kTFwDB/TXEbuC5e7oA3IDDs5AMYL6YuB+lcHN71kok/FDfNpq/
	wTyVYthfnA/ciRh4iEtdfNfy7D2+cO6IhIZF61n5uxyC+LP4b2+ooa5+MCPy0c3F2e2lhTVc/bC
	XFwNqzWrrMSIwRfRKasJ7Mw0kLkWxJf/rRwaWks6IiZejrtjLyG+jigk1q4eL/qDIghPAhJWhAE
	lVqFqi46vS3/dNqNe5ITpe1CJ6jii/C3nRLLo=
X-Gm-Gg: AYBFou1JqthB3ktn3bCqBz5lEaTMpDhkp31UcCua8TKC8q1Qra3TpkATOqS9DIxIRRv
	1+G6WoL6Exd7hUDuEa78uJ2F4L+3Ruv2N0niNdFXxp0Kcjkg9uB4+YjcFRCQ10vh0E11nLRmWEV
	n/GLFnxDkLt7Ooh7wg5G/QA3Q1t2XxZUvUB43+zKu+e6qd1oHrB7vBZg==
X-Received: by 2002:a05:690c:f04:b0:8a4:af43:6941 with SMTP id 00721157ae682-8a64e5d7328mr16132277b3.20.1790262039570;
        Thu, 24 Sep 2026 08:00:39 -0700 (PDT)
X-Received: by 2002:a05:690c:f04:b0:8a4:af43:6941 with SMTP id
 00721157ae682-8a64e5d7328mr16131377b3.20.1790262038827; Thu, 24 Sep 2026
 08:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-scm-device-api-v1-0-3573e2596c51@redhat.com>
 <EKwbCgCnxbNX4p95qJ3xoytzeNBBLc2L_HOVWr-S-y8n7pNOIToj37TyoXRcLyIK1gjq_IvbreQ331gw6jIK9Q==@protonmail.internalid>
 <20260914-scm-device-api-v1-1-3573e2596c51@redhat.com> <b1340496-1ff3-4ad7-87c3-36d2162efbfa@kernel.org>
In-Reply-To: <b1340496-1ff3-4ad7-87c3-36d2162efbfa@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 24 Sep 2026 17:00:27 +0200
X-Gm-Features: AclHuK_S1nrFMWot6v8DC6klfULfaNk07isgmJtfP7BYAekyrR84kzWx2Uw9qhE
Message-ID: <CADSE00JhFYhDV2cuVxZwVTX6LTe8zH0-BR=-Fhv+6UXeFxq_Zw@mail.gmail.com>
Subject: Re: [PATCH 1/3] firmware: qcom: scm: pass qcom_scm to internal helpers
To: "Bryan O'Donoghue" <bod@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Russell King <linux@armlinux.org.uk>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Sean Paul <sean@poorly.run>, Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jesszhan0024@gmail.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, 
	Sumit Garg <sumit.garg@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Brian Norris <briannorris@chromium.org>, 
	Govind Singh <govinds@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>, 
	Kalle Valo <kvalo@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, iommu@lists.linux.dev, 
	linux-media@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 11:00=E2=80=AFPM Bryan O'Donoghue <bod@kernel.org> =
wrote:
>
> On 14/09/2026 13:41, Albert Esteve wrote:
> >   int qcom_scm_pas_auth_and_reset(u32 pas_id)
> >   {
> > -     return __qcom_scm_pas_auth_and_reset(__scm->dev, pas_id);
> > +     struct qcom_scm *scm =3D __scm;
> > +
> > +     return __qcom_scm_pas_auth_and_reset(scm->dev, pas_id);
> >   }
> >   EXPORT_SYMBOL_GPL(qcom_scm_pas_auth_and_reset);
>
> Why make this change at all though ?
>
> It takes a pointer to the file static _scm
>
> The reset of the patch looks straight-forward to me but this change
> caught my eye.

Yeah, this change isn't useful. I aimed to avoid passing __scm to
function calls but it does nothing in this patch, it'd be better to
change it directly in the next patch that changes the signature.

BR,
Albert

>
> ---
> bod
>

