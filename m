Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E673612F2
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001528; cv=pass; b=ZXt7J6g6VwLpCUbOjwBsUJaT0qUwXNtE8Y7aLIbOEUitIicnMTkgIN+kf8XavamL6caxLWxTDgJRD9jvu0pC6Cf7VXWMjjwFF7RowjdKN4nEPfKGVpsnWwC8YfKdVO7eq2aEo/XDtMJNbC5kslO4x4GhFRuJ8lFDgcAd6AGK63E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001528; c=relaxed/simple;
	bh=IwsBiS5Kw2Z/RhZj0wb09mDnODxDklN6UMehKi1xGQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOqeCIb/9uF+Ja3/iqW/bARswci1TWR9hc/pgGsOC3WbmIa5xNcFMbGU8iGEzu8TWic0dbIpTzZBOYdoDhIaspkqh75Zb6tfvitA23y4VxJ+8exXrw4NYfN1YvxXaEHq3awbJ6bKm415/z44nmAbowCV3w97ZrLrulHwapSzn8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A77iuLXs; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A77iuLXs"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ad79dfb6eso2560377d50.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 03:12:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774001525; cv=none;
        d=google.com; s=arc-20240605;
        b=lz3WbBQb047YAPnmXesgbnKXgBJ/fwKSoXLyeO493JPzvmsXsPOz4CNaxYlCBkBRk1
         0ncOh5nIgTov2lYCN9+lyCozJycK7w8wfGcjxpxi1ZdaD/4LHzGaOLNud2sg44Cq34GU
         oEPnIqY+qPpqGoKPAOw0FO5Vxy2ZcXAY+imVVCw/4MflmeEo5KdhNtgdJ7oN3oxKGWct
         Wqa6UH0o4d8byjAXiantSDEi0ifFunatn6dDwdKb1VIbs+2VJzx5Rqhk/+/SUgqMsza0
         mJ7gLRHeQnKf1DbzOSepAR3Cc/bqywTBZzmpzmT6UHomsE4M9D2ODFHqUSlgzXVxqeVE
         XH1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=p3gudBldHiO9irSnVwm2j95EhgFlXZixCDHw3KgOJUQ=;
        fh=lM3P9o8CvehgGUpWQmk45GZbmRq8IICXGPta/rNJ5mU=;
        b=dULPujGkfD69oeViCP44YfQFBOvkNXHMTNyNJEWnspw3r7d1rwIcAMgOpDlJb1AhKg
         UjOB6DSqFkPe9bFel7V98ICgY26Wt3XWJH+5rMDIkAwRKNSpkhOMXUDBKbmmXLPS+sx1
         aUntTFDBQYi1TDUVek6C/u6fVFyxBXclFnFFFMWlhG7Yow3k1cGTsIdDq/rBUgpCADnH
         GZ/6juBHV40Or0P5nwWG1AQjE1788JWpttE99JWkuAqYt3iLn7k4ezwRB/VjtDJOzpKl
         9hExuhr6vVTi0/BqOMA42TBu1Emm1PUVLKaxBiZ/vC8IcMl4r/6FLOXwJ4MoTed1eTbd
         bz8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774001525; x=1774606325; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p3gudBldHiO9irSnVwm2j95EhgFlXZixCDHw3KgOJUQ=;
        b=A77iuLXsXMuKzvjCWiivsn/MA7fHgbjZbEUkhLET33J8opzLLYth8bNc1q5rWkAEua
         xtAmYmg5Euoo11jj3q3OqFIhEhrtce7dHN1bwnCKyk+BI89AiztQcRucCO+ZRUVDuqo4
         Svrf4ergHcbfddfqRo7VK3fo1MM4GnpZfipivFvdJP18MOs7U9knqJx/cVEtZnmJVfIM
         UHBk6kbYN9NPjI0mmd15rD2lUX66KSP0uE/VOpLzGZbvI19xsqg6nnb0s9rD8TRL8q/+
         l3fSc+4oDMDviP9L2yRiJvCk+lYBRNHzvtv4oPM0SXbWnH1x5PHbCpxlS2YH+apGs3V7
         Tquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774001525; x=1774606325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3gudBldHiO9irSnVwm2j95EhgFlXZixCDHw3KgOJUQ=;
        b=o21vGQoBdGLBVKkmXGKUQE72TrW8TaKSqIFard6WSupVDESJs2BY+0//XlW46Ftgmt
         NC2ed9n4i/huJtPjfkmpl+a/SseGxyc3GrAL9XIhSYOV8hZP+Xmm7SO9iCh2qbM3/KjD
         kO6CJY7tzphrhTEany1aPuBkTPsZOdVD6DApZm23hrOrycEubA71ePSSmZ3lzUvOlMAo
         0v+AzdVhjHTwC8HD+qTOe4FX/K1223Lzfu3qn/KaI1RIafYLCNVKQWdTd0N7zBrZ2nT/
         Kgw1zXxF/LkhLFMlx3qd7Jid+wi9Dm9rv8gXoBw07L1Be1tx0XiXXS8+0txtZnxiT7yq
         a2bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQLsyO4zxbY7gyQ7vSeLeHGcl3+FBZEmBM9DeRdKYhjYKusjl7hnUEPFImZY8NSZraQuvfMe+bKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaTUKZokvtWzrzuachW8i3PQqYeBvwUaYCsZuRI5p91cfttkmO
	JZE78n6GaXAFi2EoeMT2PoRnW81XFeeBBmEZrb3595EbwEci0WiU7RCniiZBOfZgVmPobOkbFX3
	nZLcDc0ywNYAMcaIOqAFed0zgGwrQxHcEnk1mdm2Usg==
X-Gm-Gg: ATEYQzxphvAfpFp8aM1yfIloE1CslSb58y7UHs9nDP4dV2SbtBiLzWqIdZtmbzM335L
	Qv+bw7sAvtv0UpoU4cU/YhjxxMMGZzNZTrmHAH69UPIswAx49qL5ziwlsb6Q8flLVYWJVbHfJjU
	EhwQWG7HhP3g+eKj+VBX04aI5ZuEmAavz/NWPWTtpYBwLVnXXTqRncWOqZVLIG7a/0wc/PwEOMZ
	/XDY4nkrLoM6DKdhIUlALM+OtGppi8PYRUzUqE7iH4arTcifFN6ILCEe+FOz2SXq5o+KpCejzsc
	vgHiz70OPmQZqmD4sDE=
X-Received: by 2002:a05:690e:144d:b0:64c:b242:496c with SMTP id
 956f58d0204a3-64eaa6988f1mr2475533d50.13.1774001524902; Fri, 20 Mar 2026
 03:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303132305.438657-1-ulf.hansson@linaro.org>
 <20260303132305.438657-5-ulf.hansson@linaro.org> <CAMuHMdVZknduohmhed4dFBtXuSEowmfCJ=C8HeuCGXsCsvFyWQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVZknduohmhed4dFBtXuSEowmfCJ=C8HeuCGXsCsvFyWQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 20 Mar 2026 11:11:27 +0100
X-Gm-Features: AaiRm52guPM-55vQzjTo7JwQb-uKMa_ExbmU7uDj3JnKhw50rAvhtqkz3duhqS4
Message-ID: <CAPDyKFqBj9qm3Q1zGAgCZhs8m_FG-rXrgO8tQPcSJ8jmaxnHKw@mail.gmail.com>
Subject: Re: [PATCH 4/9] pmdomain: core: Add initial fine grained sync_state support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Saravana Kannan <saravanak@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Mar 2026 at 10:29, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> Thanks for your patch!
>
> On Tue, 3 Mar 2026 at 14:23, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > A onecell (#power-domain-cells = <1 or 2>; in DT) power domain provider
> > typically provides multiple independent power domains, each with their own
> > corresponding consumers. In these cases we have to wait for all consumers
> > for all the provided power domains before the ->sync_state() callback gets
> > called for the supplier.
> >
> > In a first step to improve this, let's implement support for fine grained
> > sync_state support a per genpd basis by using the ->queue_sync_state()
>
> ... support on a ...
>
> > callback. To take step by step, let's initially limit the improvement to
> > the internal genpd provider driver and to its corresponding genpd devices
> > for onecell providers.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
>
> > +static void genpd_queue_sync_state(struct device *dev)
> > +{
> > +       struct device_node *np = dev->of_node;
> > +       struct device_link *link;
> > +
> > +       if (!genpd_should_wait_for_consumer(np))
> > +               return;
> > +
> > +       list_for_each_entry(link, &dev->links.consumers, s_node) {
> > +               struct device *consumer = link->consumer;
> > +
> > +               pr_info("%s:%s con=%s\n", __func__, dev_name(dev),
> > +                       dev_name(consumer));
>
> pr_debug? Or better, dev_dbg(), so you don't have to add dev_name(dev)
> explicitly.
>
> However, the printed provider name is again the name of the first
> domain.  This is incorrect for all but the first domain of a onecell
> genpd provider, and thus confusing.

I agree, I think we should drop the print. In fact, this is a
left-over from my debugging, I didn't intend for it to be part of the
submission.

Although, perhaps there is a need for pr_debug/dev_dbg somewhere, but
I think we can better add those in separate patches on top instead.

>
> > +
> > +               if (!device_link_test(link, DL_FLAG_MANAGED))
> > +                       continue;
> > +
> > +               if (link->status == DL_STATE_ACTIVE)
> > +                       continue;
> > +
> > +               if (!consumer->of_node)
> > +                       continue;
> > +
> > +               /*
> > +                * A consumer device has not been probed yet. Let's parse its
> > +                * device node for the power-domains property, to find out the
> > +                * genpds it may belong to and then prevent sync state for them.
> > +                */
> > +               genpd_parse_for_consumer(np, consumer->of_node);
> > +       }
> > +
> > +       _genpd_queue_sync_state(np);
> > +}
> > +
> >  static void genpd_sync_state(struct device *dev)
> >  {
> >         return of_genpd_sync_state(dev->of_node);
>

Thanks for reviewing!

Kind regards
Uffe
