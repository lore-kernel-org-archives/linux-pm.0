Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78CF3B0AD4
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267173; cv=pass; b=CwOkoOgHh71ENhSBVXxiAC1py+eSDzyAQAFxIinb5QtnDXmXrw3M6SogGXL1lASzjd8Uooy07Lwt+V4JaKavyqX4pR3jqxriLydMcQs2MZcMEem1BEew48pZrmYdMn9w62Q2A8WBnxCF4awga3n4TyFqmNM/OMUMnkWDQsTbrJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267173; c=relaxed/simple;
	bh=VG0JGy9V9Ess42oO7HJ1M9+yUlNIwa8iKwJ+GuLfhQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1FgNAR2GjLFFtKWa8/r65wobrDSxsLmntA7kyxIoKpPVmVV5RCXmutX6mfp4XUfzOkAspIam3rZFaIqFJ5e/RtvuahDkE1MHMbazensTtsfNZPyVGZwsBjZhy94S1uPX5KTXOTiDsGaIKzdiweCg4e0aeQlaMyXFSNJn7UUC9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APws7sjm; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APws7sjm"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a600a1caf8so1316813a12.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 05:52:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788267168; cv=none;
        d=google.com; s=arc-20260327;
        b=FDQyNy3EquBZb7U+di+0A/uyGT3qzZtQ4LQk8Pb/LKYFZ1snYL2Op1878DOMUQlEaO
         ha830ekNFCmsVws+pea+Wi7a7x6xMg0+9LFuOloprf+ej1jLHwCkTsnwQEVX3NkPZ9Na
         f67bq2Vxe17ri1M7CqcYQYFeRKTQ3srq3dohpTX/LnBR9gfjD2hTehJp3X0rZ2FBGEvV
         Iteyw+TjrtzalLXCQk2IpbDVtCJsJtN1OZAQd+TRVnlk53DRxELDSwkrTeapfsYtOnKC
         QRAYCdV+5wbJ0Ab1mromEd7xDR3QFqk3kEnAByG507kOPUKIOIzgcesuHQXmqG7Xh3YI
         aKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ssbA7eNLUxksYHjRqY8p3X4V4mfnV6KUS7EHrqUvZgc=;
        fh=ETKyh3uW5JGUC8WeB0ub6egn+TqpE4RTq+86+RNaPYs=;
        b=F1nGc+EkWuASkhbyMlKkWnmUDj587q3M2dh2pUxOfX1xWDvHnl6/kUddRZFLDh/B9n
         +sjzdsqHOrJYy54ziXgsnrylCu8UHiN+zPedHQox9BtlNGDzn9Y712DyyH0gsp6gQhyf
         X944qebFbuAbmTPo/sbDZUrlh+wRemT8HVDhTBnHWx8eTBR1ZP4qd6809vB8xHMzhOQi
         oE/Ilh8ag3xs8GMzY/9RUGy0AFwV29RmgDyfOsIjDnfikB5Sa5pdSY5sQpXRQt5475gw
         ywaURhVb0c4+ZcKCngWviqCH3qVaTyIqaJNGZ/q/MUQjwO4FGQCPZkWYF5QfDihuRzm9
         bndg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788267168; x=1788871968; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssbA7eNLUxksYHjRqY8p3X4V4mfnV6KUS7EHrqUvZgc=;
        b=APws7sjm7FGRX6eDqzMDTJ6cLbEvx5rf0JczDmKeh6lwitsuvAm68EWNBoHlcj9TZQ
         ryXUqotI5ZY1D783wL43Eqz9xwj2S9Ho3jCdeo2in8E+GMEDFdRa69LUAnc5UA2KwjzO
         HahJHGS0h7NSTdJ4fTQJ4AikeQWZihGAZwL7nEDnrjQNo0/3+OGPHFPoKh/R6H8v2k79
         YnnjDF3ZMrcQ9gfRiTmtODyPPoNCMiEcaDb/1ZIhjPr9an0sNK5/TgYfz8BsTOleITAt
         VAzFDN8mZUuUIqK6xijgMDpq5UXwiKPesyLA1o2p9BmtRoaZQ6OtUiOMcDt2p5o5Q7GA
         cDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788267168; x=1788871968;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ssbA7eNLUxksYHjRqY8p3X4V4mfnV6KUS7EHrqUvZgc=;
        b=cINYsIJ4EJuE7iACsdd7EgV640+WQHAyQdrljeWa+S8Vna/4Q+ouQ8kpLTlN9F+csI
         qJm+WW8Tjt0srDFmyF/LCiV4K3pHurgwCwZtIRnd0bnhRbYunuSfzJF13eRaXThNaWMm
         W2Y/aR3u5oV9NiWI112QOzVs+TNoolxtBlbkeDHgmQO0eJTlQCMxSlQTP3VycyxmVGzM
         /iPIYS1KYXahd/ta6iIKurPy9CL5CjgQgu4DG7Z4kVds18QCAUSzEBUuDIj52lsJY9I1
         gKBfOHjK8ZvzY0sX7bU5UDUjw67pkQ6fB8i3Rh0+VOGlw9scWsdu9Epg/fWCL4A7yh3s
         iY7A==
X-Forwarded-Encrypted: i=1; AKwUvBzEsb1PFaVr8r6zEHh00DngGAmEzlOxWAFXYfTgOX3S4AM8dtvPr2neBjCFmfq852P0a7xGfJLBDg==@vger.kernel.org
X-Gm-Message-State: AFuF++nd2EgnbcphSEfqRg8O3zpdlD+FQjQkt0kRkPKsK4Zfff48xc0m
	LCFj8mcGvucfdnBtt4pP7QK5oIkEg4Ap6Dv2IAnIsJmg15fFyYYfzI3SY4+XPEmlq1tg/efhtrN
	/4zVAfmiAlVF7pquWhAN+S4zqNE9VoJc=
X-Gm-Gg: AYBFou3YteGHUisT9sYG3rueHQeXewsu73Hvs+mS9pMa4uAT+dD9xWkNxk4LWRbGGkd
	9CSZT+DUzX5BEtZARASd0FNyK0XZvLgVKEhL6H6Lif7KDG2Fy871mRlIFsCSn1eIMXmLcXLWvHz
	poCY8lg3tmUihQTbVQ08CrBY9FE5oqvLRohFCbZWhfizLTMwdKT20ami4h8/Lf/7ps31ExnnRLC
	zNSkSiAX1BYiJSYfwKtv5MBFMPfJFOJg8Rgm2hrHMj12ikc7psFipa6zuoh8VkiiHYb31zJrCgz
	YvxF5glqRNl4qStH8mpITcVh4031Wfz14YGYQ8TOjWnUNPnbFZFEwRJG287Km1ftfuidO+ltJqC
	rU0w=
X-Received: by 2002:a05:6402:44c2:b0:6a6:32f6:c with SMTP id
 4fb4d7f45d1cf-6a632f6013amr11282461a12.18.1788267168126; Tue, 01 Sep 2026
 05:52:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901092447.3028-1-sreeshankar0910@gmail.com> <prxk6xpxeoebz5da52a6bjgmaaop6mj55eemxdm5cjxm276tyi@jfeziqcrxtfv>
In-Reply-To: <prxk6xpxeoebz5da52a6bjgmaaop6mj55eemxdm5cjxm276tyi@jfeziqcrxtfv>
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Tue, 1 Sep 2026 18:22:34 +0530
X-Gm-Features: AcwNN1U55mxl5Buv8KaT17jt0XFpq4P8gD6bW6R2dqKayvNk2vS1r-azwArTaqc
Message-ID: <CAA-+ukJWFm1YOoWTO5TmuF8ymNuRGtsvOm4zruwUUEGpcmKNjA@mail.gmail.com>
Subject: Re: [PATCH v9 00/12] Add initial support for Qualcomm SM7250 SoC
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: andersson@kernel.org, sboyd@kernel.org, bmasney+clk@redhat.com, 
	jbrunet+clk@baylibre.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org, 
	konradybcio@kernel.org, tglx@kernel.org, ulfh@kernel.org, radu@rendec.net, 
	taniya.das@oss.qualcomm.com, danila@mainlining.org, davidwronek@gmail.com, 
	mani@kernel.org, robimarko@gmail.com, linux@gurudas.dev, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Sept 2026 at 17:32, Abel Vesa <abel.vesa@oss.qualcomm.com> wrote:
>
> On 26-09-01 09:24:35, Sreeshankar K wrote:
> > This patchset introduces foundational upstream support for the Qualcomm SM7250
> > SoC (internally codenamed Lito).
> >
> > SM7250 is an ARMv8.2-A platform manufactured on a 7nm process, featuring an
> > octa-core Kryo 475 CPU configuration (1x Prime Cortex-A76, 1x Gold Cortex-A76,
> > and 6x Silver Cortex-A55) and Adreno 620 GPU.
> >
> > This patchset is organized as follows:
> > > Document relevant device tree bindings (SoC ID, Kryo 475 CPUs, SCM, PDC,
> > RPMh clocks/power domains, GCC and cpufreq hardware).
> > > Add driver support for SM7250 in socinfo, rpmh-clk, rpmhpd, and GCC.
> > > Add the base SoC DTSI (sm7250.dtsi) defining the cpus, PSCI,
> > interrupt controllers, clock providers, power domains, and reserved memory.
> >
> > Dependencies:
> > This patchset depends on the following patch:
> > > [PATCH] dt-bindings: clock: qcom,sm6375-gcc: Merge SM7150 into SM6375
> >   Link: https://lore.kernel.org/linux-arm-msm/20260817082457.64797-2-krzysztof.kozlowski@oss.qualcomm.com/T/#t
> >
> > Changelog [v9]:
> > > [PATCH v9 04/13]: clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
> >   Make all clk_init_data instances const across the driver.
>
> You sent 3 versions in less than 24 hours. Please slow down.
>
> Give a chance to the reviewers to have a look at each version before
> sending a new one.


I apologize for my actions. v7 was the intended new patchset. Unfortunately
there was an interruption during submission of patches, only 08/12
patches submitted.
That's why I submitted the v8 patchset.

Regards,
Sreeshankar K
