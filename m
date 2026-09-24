Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162264A2605
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264543; cv=pass; b=Szn30GRNF/gb8Ctpvq9+tgQKDWK07CfjpsKkjLtprUMPICxgpx0FiO3uGBccvB9LxKLxfooEUqMAphes24C8wzovHlxn50lTh2awt4Yh3pmvMoV8GGi32hCTr7CU9azCLaW3ueMWAaHT6ofP84SzHScR68zTb1A2VJ/19XyhkhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264543; c=relaxed/simple;
	bh=PyIrnipvkBWRV4hHOpoG3qPK65aPl0bzHYIyrKbgTzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gv5y0SgYEgIZzVCxZbGO2qx8o4ZkVxP09uDY2fR+ZPtZbgU3KseVwyWnS2dTYaHkzMapfCYrCM0vIFRsSSjJ4ejb6a7tazsfpfgxGWmsZ4Wj5CY/e7+Y0M3i3vjBUlr5CZnyGBIJQet5YZuI/8EgLAJt73DV4O59p+mUiVHelD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5nJqjG+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UiSN36fQ; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5nJqjG+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UiSN36fQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790264541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/64YUvNMf9EIe8aZXp3DzyY+LbONkg5uQf4LZYgGwC0=;
	b=N5nJqjG+CCqiKOUMIy+cAq9Ow0QOH/g8y7qkqripLHY+xA52Ulvj6QjC4UgfhNAE8f/NTQ
	ERP4l6jY5/34bDLO8j/YOXLeTbisjpqVsIkISSyPKLuKvnUmIF7dbd50s+oyMss6RvkYIO
	Gvg68S8FqYiBPUh24USVfCB6mx3/9Ew=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-_I9cBLzHOIulc3TiR5hhMA-1; Thu, 24 Sep 2026 11:42:19 -0400
X-MC-Unique: _I9cBLzHOIulc3TiR5hhMA-1
X-Mimecast-MFC-AGG-ID: _I9cBLzHOIulc3TiR5hhMA_1790264539
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-88322409239so44777807b3.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 08:42:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790264539; cv=none;
        d=google.com; s=arc-20260327;
        b=PvHhncrbmiFXe2EVuszes3BJjpFgOfCtH2s3zGbxqRim2xn5M4n3A6lTSLsW+lDviH
         sYgq/aMEsYntX1wQFyFnXY5W4uTZpe+63WDLCMdV9KMkM3+E20+Ty7ghu121Jenp2abE
         GznWcvpdl+I8k1whvBvcfAKPmWkA/2tvORTDtX0YwvyrfckZvhHbmtX4EBrQJh+HVI2R
         UrFQNNTh4HCAQriVpj2vxyAf3dGUAQxmulV/oL3PrI05ssgp0Z/vtaMz5+WdDYH1Xp3O
         CnUzHbio+3RDszEPncTpZKwCQtHz9uX24gc6nrbkEX+scFK7RTlcqIN+LQ5c865inKfa
         WFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/64YUvNMf9EIe8aZXp3DzyY+LbONkg5uQf4LZYgGwC0=;
        fh=fpz9mT79yfaA54GaqaKh/46BscfOHbCst2kBCyK1vYA=;
        b=e29RIhbLodis1dxeZ0+04plICSTLYCrhCp1zUgx74clWdUlxLw4DJuXt473Jp0b3Ic
         2XpH8JHitFCT2PA2BNSZ2AgfK4nrc1FHKEtE2+qvsZgVOXHpLoylKIz96XzHCu1icAa0
         Uz8AFPZoHgGVB20cMHgrE0eiYDFC1vUfOM1UygnBAo80/L09mgsTDuofVbKdUxF4yuhu
         IsZruhlsdUs4evEtiQUwj3zj2Ube6jC9enzXdxKVzPRou9TuwRqfKMDVp8fhikV+e2qQ
         VbtCvXG9Di6XvTAKEUv3o9KYgorfBz20nNHX6cfb4H6wczJp001aEAhswdEJK+5i+pJ0
         qGFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790264539; x=1790869339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/64YUvNMf9EIe8aZXp3DzyY+LbONkg5uQf4LZYgGwC0=;
        b=UiSN36fQL6QI7gOFKIRAXpB32KZvpgTZ0bYV/KBNmlIN6qm7jax60KwKrEHg+eMqa9
         udWcnbLBthounfjlspUNpVzA/a3M/L6qNzbO4BzIhnzqgD6x4PLAtrz7dbs16BVvHAlv
         kRf0aJ8GyBaHFCXd5a/GnXw3AuBUbbSzs4kH5Omcg1UxWjIYTVTLXFzBfq911Hg0J1v4
         jdF3NvIiJCHTWsgehT5JMOrPtI/KTgdCt2uGvHlNfNm1ZXHO0vFWZ9SJQXMWytDuNWZh
         54MEXb0EiRLNWgTC8Fbnwm5byWnbinwmAgKv+DglBTsNlbOPHxpIWgvG4r8ffXv1kwBs
         rFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790264539; x=1790869339;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/64YUvNMf9EIe8aZXp3DzyY+LbONkg5uQf4LZYgGwC0=;
        b=wrTjwGTyCVCEsnwLBFHYc8h9q8m+ouLEyT40hnENH8HKOsrCnqd1aehjSjDfHhyE9a
         mc83MtOCNC2g0KkeHlnVMqubRFv1wek95Ew2a20nms8ofmPzAD9V8DwDqLoI5IrgVr1E
         enyPUX3uUj+Xj5VUYWtsf2luE+hNFqdbMzChdIOpOxhBuxKQG1c9Ffn1H18OI9c8a5qy
         tJgIAuHqxIDpTR02nbpqNxlpkkGfPQm4XH3NUhE/j6E9VSWXqOq8oAhrTq5ATfAh7GOj
         RELFWl3TChrnIJZGmrvQm9G5vGzjkx1asVfoqUGNJLemac1heBS1lwoEuHUDGkSIBDdk
         5C6g==
X-Forwarded-Encrypted: i=1; AKwUvByiXpVjMnRT1MwJXDvIV1v6bPxDvqk0odFCQ2av5c+AiSdmDMaRFVBeHrzEoUFPLtGvCuMHdxD2bA==@vger.kernel.org
X-Gm-Message-State: AFuF++lPP+WBb2xi54wnaEMp71TgCQ6/g+AT3FYGhN1ouCxFAbt1eQqL
	ILnXL1BCZQKB6OlqbDtpCcn8sArYLzSc1iTS5P6ldcwUw+s87T0bU+Wm7Lcg3ueNAuCJ7hF2Ofd
	vnarD7Z9Df0jjnpCELM9bDTq5A89kehvCrEYRFyFHpOROgAwafqWiEj9K6KcHD0xnkf0GA71uZc
	r6dVNwiB23TcpoxlK+m9u4HkgfWaEN5FreCq4=
X-Gm-Gg: AYBFou3syAeiVGBnN1wtmM4qFiOVTLLOxE+feAg604ccm/K8yCoL/wZrA7L9Qn6FZ8+
	GJ8tHYRv4mWmEH+3IrUOWRC6fpqyg+MLgUCT5p4lDEAr7l1eJCQEfK5h9bq4Mxt3tGBqwHuUS3O
	Tr7Mbr/bVgT5AkQFjVqXzwcOxaK5z0ncD4Z4xhiPaXv6/9qUzlTZ6iOQ==
X-Received: by 2002:a05:690c:6e87:b0:8a7:91f8:1e8d with SMTP id 00721157ae682-8a791f82a3bmr9357507b3.53.1790264538940;
        Thu, 24 Sep 2026 08:42:18 -0700 (PDT)
X-Received: by 2002:a05:690c:6e87:b0:8a7:91f8:1e8d with SMTP id
 00721157ae682-8a791f82a3bmr9357067b3.53.1790264538368; Thu, 24 Sep 2026
 08:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-scm-device-api-v1-0-3573e2596c51@redhat.com>
 <bRb6NzJiFvNGB0X3BeiVytgZNlRv88LFlcaBwwFIFa3GtVZhn5bh9EoRRDliRtgsnlQNMddvcIPK-5HK9x7z9Q==@protonmail.internalid>
 <20260914-scm-device-api-v1-2-3573e2596c51@redhat.com> <49153dff-b4e0-43ac-aa82-15175fea6445@kernel.org>
In-Reply-To: <49153dff-b4e0-43ac-aa82-15175fea6445@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 24 Sep 2026 17:42:05 +0200
X-Gm-Features: AclHuK8NibWpN40MLtS8tk1TsaU8ZJKSI8cLr02zuHOUyaXDRMTCkw3xFezOa38
Message-ID: <CADSE00JcFOY0r6doD1Qpc0xtZ6HKsa4kFGsV0_FsNbb+yemmKg@mail.gmail.com>
Subject: Re: [PATCH 2/3] firmware: qcom: scm: pass qcom_scm through the
 exported API
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

On Wed, Sep 23, 2026 at 11:08=E2=80=AFPM Bryan O'Donoghue <bod@kernel.org> =
wrote:
>
> On 14/09/2026 13:41, Albert Esteve wrote:
> >   static int spm_cpuidle_drv_probe(struct platform_device *pdev)
> >   {
> > +     struct qcom_scm *scm =3D qcom_scm_get();
> >       int cpu, ret;
> >
> > -     if (!qcom_scm_is_available())
> > +     if (!scm)
> >               return -EPROBE_DEFER;
>
> Is this equivalent code ?
>
> Its also a bit confusing to me that the next patch adds a .available
> field to the qcom_scm struct.

I can see how this can be confusing. The problem with
qcom_scm_is_available(scm) is that callers did not have an SCM handle
yet. So drivers needed to search for it beforehand. Once I had to
repeat that a few times, I instead added qcom_scm_get(), which looks
up the bound instance and returns NULL if it is not ready (and still
uses qcom_scm_is_available() internally). So, !scm is the same check
as before, while we obtain the pointer for the following calls.

scm->available in the following patch replaces the __scm publication
flag when the global is removed. Until then, readiness is still based
on the static __scm validity.

>
> I see where you do get drvdata but I haven't managed to find in the
> series where the data gets set - haven't asked an LLM either - I think
> the logic to associate the scm pointer and get it should live together
> in one patch so that the logic is easier to find and reason about.

platform_set_drvdata() is already in qcom_scm_probe(); this series
only adds the dev_get_drvdata() / qcom_scm_get() lookups. I can
clarify this in the commit message so the set/get pairing is more
obvious.

BR,
Albert

>
> ---
> bod
>

