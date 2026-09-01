Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC2E38399A
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273078; cv=pass; b=h4+xdhSZfiOELl5MdF4Y8r0RjnwXcm7Xmvsz1N01cRhDAen8uqKrbTuVVKOvwGgIcoFMG3YS5olFbav8yaZ8shQ03ikR4s3DsV67UL2cbRLwpIPIlUar0ZWf20r08/N1IotInnF/wdUE06re9sy0FpfUeZW01Tp+zQgAQWCTo1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273078; c=relaxed/simple;
	bh=5JCE49kjhVD4CKDJFuR7VYFhCbO5kEQuzu/oho0PrZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWQDW8ODMEGz1O220OffsGQ5W6dzP9XcJq9B2wYLgI3pcdM9OkQzBsEcqes3TFc2BHsZf9WZod7+FU/2WrxVli4ncOBpwMivmrSpvVg2V3KBfxrG83qEFPqqWJUOEFi+EOh5BS9QqSKa4ux3tFAPQWZw16Kp9UibH4ppnY+PN8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ra0nvFJa; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ra0nvFJa"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c25099bb1fbso128448666b.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 07:31:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788273075; cv=none;
        d=google.com; s=arc-20260327;
        b=ItopBHg6aXUAPZc5m6JsmYrtkbLePMVmaWfwK/GnQ61oDvWM1ptKYLBcJi2/zDYgzj
         hQ3mQL2Y8sTLfUfzengPT/aXdwWsAVax/432KQGvKwsDD2NVRcDveMLbqe9x++zGhuJ6
         WrhPQ3zN6+jAM/jKkPY3svwefaop0qSXvN+IwHJrhUR9e7ajXs/HaZJoOJ6bP4x+MxLN
         s5ji+9UbMnSTnQo4mjbCvKh1kQNlHEqh9FQOOOc1L2Tf8jt5G3Q3/cEMNh8xNF0hEma0
         uCIeKzStoytgp+379b8QeB4iRD1IFWbJsB0NDcfwQmOcp1wKebh+2mllNuYeXuCQ4+YM
         Iupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=x0lgToU+YU3Inc+G+YzISxuhKl/BOokX3QBBmgvrxTc=;
        fh=Vp19XNqhGc+CIPYAR0b8qw0hyHlYkLlAnCI+o+hZfus=;
        b=prNBTeDSBKtDaVxvpRe0rpzqkmLWEVFQEGWvR5JZlWl4ltRfraFmbMcAlSu76LyXaj
         vR8TGDBWi417xwN6bJUCp5ipqTE5awYQ6wcCcitT3FNMj98BL3Tdq0XsFoRYUjUEsAQ5
         z8OSHtHWg4g57x+jjQrs03JGGmJeqILgbqMdeWTUbFMGVIm28InNlqSWMSKlQCejOkuA
         K6IpJj+8ih7I+jaa8wAtNKal0qdwitQdBMNZ+MVOtf3Zbbkk8+1qmNxEMqaPxEcta882
         LvLYcgNWMhCdmcJEbtC+adkNzwD6/feeKmYT0mnBd1PQRowu9bc1EwmmyoUi+Vll9AIh
         u6vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788273075; x=1788877875; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x0lgToU+YU3Inc+G+YzISxuhKl/BOokX3QBBmgvrxTc=;
        b=Ra0nvFJanSQ7SkN68JImzqcpaOmtuEL15S+/IRDIAVmT7x/rTpvhfH8yKuqsqtVFKq
         QTAFGWPmu0fk6JczX285Uryl2flqajJ9WjERZ/sJ2lV+/37uSniOxoXBndM4IzNC1tuA
         qsT5IHLkXCDt9/ay/2//d4DFVQvsjTfa6iufkPv1gLiECG6xcHMC3bQr9TJM6qWk+3zT
         c38gYxIM6UZqWUlrbG3EsJ22x8sQIeTTKseBWou/Nok1r5Vavd45oNMVu0ahoZ6kVzLT
         vhWEukICnaWe8mpItmxV6Pt7f0qTOFqAbEehcJgR6gt9gj0epqs/jljEU6JNsYJ1/NHQ
         adXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788273075; x=1788877875;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x0lgToU+YU3Inc+G+YzISxuhKl/BOokX3QBBmgvrxTc=;
        b=As/m9/YnerQfwADCesNaFpXZ0Ug+WDCOuBJzVC7DjmhCy5xZ/Za1Pk44ANiiXrmitT
         MXisGyQYz8BPzYxbKTqljAM4b5vUhVBWeT+S8rxInhoNqwpHp4js9QgpuHzH1EiKP2dS
         vABjCyPV6u6CYXWa4TBpta3bE3Q2Rw5LekhMaU8wdcKQZwYJEBvge71KGM6GTfabnhc/
         2TDwBgs4oQfQRsZljpyEdj1eYjQuOD9erWoliVY2es8qpKvWhEG9c7fwweYxqyZX9NGX
         eKIhRXSzSXZAfF+za/0NIIEGnyz+DeIj6RC8uhGboec4RNvxJgfUdyBE8hIFMN+YjEH5
         dYMg==
X-Forwarded-Encrypted: i=1; AHgh+RorNeDCSdMLgTp5DEJ2I0O8aOA5F8MmRSCBbNH7l5YIvuOYH3f/Hp77RmuEmrB7SvB/IVk2dED4Bg==@vger.kernel.org
X-Gm-Message-State: AFuF++kd2S7jpw71xn4Pj6awME04tV2UUd2WT27bWALWxOWRnZQBgu/u
	DlZhZOsbj1TSfW3GowrwZJBw63ZlI3QJR3HK1QGu1Pwlbw4kaBy/nazM4AvI+EaNw6V2gYWuPqN
	N+tVXKHkwwX3L77N5c9RccOcuRcQ9S/VuE74F
X-Gm-Gg: AYBFou1vs5kwnXNe7duBXKzvfg7s7yZBOsrUPr1pMz+XODVWxiCNYQZ/BPCmmM9zbls
	ENr7BqYeOEj/PrP73InF842LLdqWQuy1rQA+mvpEGF4bwHxvkt7zHLz2QeVBMacKa+BJtVFkEn4
	5skRVRVZhObkKKCKN1FYG4tnJGWonPH1GdqwLUlPdgZZbeK+umLvMZAaWSKaGeBLNCM2g9y5erc
	17XPsfj2VF2ZNqZWyGE7gEIPd3dxfnhw/b7gesquJrSEg++SIixgwuAJfvM8Au4PQt2cSxMyafA
	b3/tfsQGdtFM/xUs00CVFYfw3jVOQpcP3YqjK3KEyyBB1jBWFazurZtEvtdRo8q3giXwpzYyvlI
	kiZOT3/M6Ys0o2xbfnYzr6BG8hToH58qFMqs=
X-Received: by 2002:a17:907:97cd:b0:c20:1c9d:8d4b with SMTP id
 a640c23a62f3a-c2556bad5d4mr1984246166b.2.1788273075015; Tue, 01 Sep 2026
 07:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901092447.3028-1-sreeshankar0910@gmail.com>
 <prxk6xpxeoebz5da52a6bjgmaaop6mj55eemxdm5cjxm276tyi@jfeziqcrxtfv>
 <CAA-+ukJWFm1YOoWTO5TmuF8ymNuRGtsvOm4zruwUUEGpcmKNjA@mail.gmail.com> <as35xamspfwpmbravcz6g4miz4nfotgsmg5afchgudoh6fd3kz@kbp7kotpxyet>
In-Reply-To: <as35xamspfwpmbravcz6g4miz4nfotgsmg5afchgudoh6fd3kz@kbp7kotpxyet>
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Tue, 1 Sep 2026 20:01:04 +0530
X-Gm-Features: AcwNN1XCELOPcPvrH8u8ByY6Rzj-i1F5LZ1I1noSysoUtzBHJi3bLNMYR8sODV8
Message-ID: <CAA-+uk+k1sy1oCu8KiRod_MHWOPDzpQiVnD184srzhSggYZETA@mail.gmail.com>
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

On Tue, 1 Sept 2026 at 19:51, Abel Vesa <abel.vesa@oss.qualcomm.com> wrote:
>
> On 26-09-01 18:22:34, Sreeshankar K wrote:
> > On Tue, 1 Sept 2026 at 17:32, Abel Vesa <abel.vesa@oss.qualcomm.com> wrote:
> > >
> > > On 26-09-01 09:24:35, Sreeshankar K wrote:
> > > > This patchset introduces foundational upstream support for the Qualcomm SM7250
> > > > SoC (internally codenamed Lito).
> > > >
> > > > SM7250 is an ARMv8.2-A platform manufactured on a 7nm process, featuring an
> > > > octa-core Kryo 475 CPU configuration (1x Prime Cortex-A76, 1x Gold Cortex-A76,
> > > > and 6x Silver Cortex-A55) and Adreno 620 GPU.
> > > >
> > > > This patchset is organized as follows:
> > > > > Document relevant device tree bindings (SoC ID, Kryo 475 CPUs, SCM, PDC,
> > > > RPMh clocks/power domains, GCC and cpufreq hardware).
> > > > > Add driver support for SM7250 in socinfo, rpmh-clk, rpmhpd, and GCC.
> > > > > Add the base SoC DTSI (sm7250.dtsi) defining the cpus, PSCI,
> > > > interrupt controllers, clock providers, power domains, and reserved memory.
> > > >
> > > > Dependencies:
> > > > This patchset depends on the following patch:
> > > > > [PATCH] dt-bindings: clock: qcom,sm6375-gcc: Merge SM7150 into SM6375
> > > >   Link: https://lore.kernel.org/linux-arm-msm/20260817082457.64797-2-krzysztof.kozlowski@oss.qualcomm.com/T/#t
> > > >
> > > > Changelog [v9]:
> > > > > [PATCH v9 04/13]: clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
> > > >   Make all clk_init_data instances const across the driver.
> > >
> > > You sent 3 versions in less than 24 hours. Please slow down.
> > >
> > > Give a chance to the reviewers to have a look at each version before
> > > sending a new one.
> >
> >
> > I apologize for my actions. v7 was the intended new patchset. Unfortunately
> > there was an interruption during submission of patches, only 08/12
> > patches submitted.
> > That's why I submitted the v8 patchset.
>
> Yes, and now you have sent v9. So even without the v7, you still have 2
> version in just a couple of hours.

I will keep that in mind while submitting future patchset.

Thanks,
Sreeshankar K
