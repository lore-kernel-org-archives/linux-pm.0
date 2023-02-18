Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6913C6379F
	for <linux-pm@archiver.kernel.org>; Sat, 18 Feb 2023 20:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBRUgV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 18 Feb 2023 15:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjBRUgU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Feb 2023 15:36:20 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A74412F13
        for <linux-pm@vger.kernel.org>; Sat, 18 Feb 2023 12:36:18 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-53686f3b330so14567347b3.11
        for <linux-pm@vger.kernel.org>; Sat, 18 Feb 2023 12:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zRZc0dQnGhvTqq+U+Af9pmr62Ej13myeHTMYLtCgPVE=;
        b=DJT3lVNgKXKJdIlID0MT7eModsNU48nrQc1fJd3ui4wzOYOQ1oKgsYoenhtkMtqBPk
         /8xVOdvuhyWg6J10mIqNFH7CD1CeOM3+cLBGhD4aEFX+4Xno+92xJAEu9x/qJSNGBHIf
         xgVdYW8ukUhle3Bky2UZqgT/VttGY9s3uMmNqMNdwNJKs/c1bpuOhUfbFgQmZ+uQ0zzD
         waP3UG9VT82DfpSF5lBstVL+T0Cz10/Y7raFTxjCazlkC6nsO/ChQdPzymEYjIsXHA4d
         E6iMj0fDjdKBf9/h0wyDxtiflwiN80gOpuYGJwTtw9ivNC6VcGF2/nSKn94wMAKW3EF9
         BJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRZc0dQnGhvTqq+U+Af9pmr62Ej13myeHTMYLtCgPVE=;
        b=h+5vT/Vb+jWmLct2JbEoygZBuyFA8bdUQKx8i6LIcilCI7rPpj/nn/kUKYSyqy3X3f
         j1cRHfhh04+CXVTaNWxrhXXD6onQty19bGLcaEB4flsUpfIam94Ll6p8eDOTPUcssFI7
         GladiDFnWlCjL18NmMG2E7506Vm5wa4rQgrNEa7syFlihRnwV7Mu/vJgX6CxmSHBHZBI
         tW1OpZWSCpvIhZjzGc2TokuBIFfwAsdsqLcAFmCgLDAYeixPpIPBxqnJ5ixiwk4weN9u
         pki7YwLjF4PWAcaf5K073PVHERzMpYdHLIuitlR8q6s9ZOv9GGBXQS8gMbISA/q91dtg
         XbIQ==
X-Gm-Message-State: AO0yUKX7Yvtc+GG2c5JN4uaL/qmtbY7G9JSgQnjaPmHhVChhkrP2SL1j
        3dPrOAJFvhhtIgWfmsORxmgbfMou2MK2fuV8Rz3JcQ==
X-Google-Smtp-Source: AK7set8quw15Bqc+0QWbimOwzwNnb5QDs+/xKDJoWKlIL9Ch9uIbwRdKWK4vj2GGj+Q/UI3Ou/64971MYbkSQf+7q50=
X-Received: by 2002:a0d:c405:0:b0:527:3e8:5bab with SMTP id
 g5-20020a0dc405000000b0052703e85babmr1620322ywd.306.1676752577751; Sat, 18
 Feb 2023 12:36:17 -0800 (PST)
MIME-Version: 1.0
References: <20230121112947.53433-1-robimarko@gmail.com> <20230121112947.53433-4-robimarko@gmail.com>
 <d71e8a18-8a09-c722-d9dd-b2d48615828f@linaro.org>
In-Reply-To: <d71e8a18-8a09-c722-d9dd-b2d48615828f@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 18 Feb 2023 22:36:07 +0200
Message-ID: <CAA8EJppwNVtUjB7fUZSCrZ88Ssbhmc4HD6oA2nV0uEx+vHBXUw@mail.gmail.com>
Subject: Re: [PATCH 4/4] cpufreq: qcom-nvmem: make qcom_cpufreq_get_msm_id()
 return the SoC ID
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        agross@kernel.org, andersson@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 18 Feb 2023 at 16:43, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 21.01.2023 12:29, Robert Marko wrote:
> > Currently, qcom_cpufreq_get_msm_id() does not simply return the SoC ID
> > after getting it via SMEM call but instead uses an enum to encode the
> > matched SMEM ID to 2 variants of MSM8996 which are then used in
> > qcom_cpufreq_kryo_name_version() to set the supported version.
> >
> > This prevents qcom_cpufreq_get_msm_id() from being universal and its doing
> > more than its name suggests, so lets make it just return the SoC ID
> > directly which allows matching directly on the SoC ID and removes the need
> > for msm8996_version enum which simplifies the driver.
> > It also allows reusing the qcom_cpufreq_get_msm_id() for new SoC-s.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  drivers/cpufreq/qcom-cpufreq-nvmem.c | 44 ++++++++--------------------
> >  1 file changed, 12 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > index da55d2e1925a..9deaf9521d6d 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > @@ -32,12 +32,6 @@
> >
> >  #include <dt-bindings/arm/qcom,ids.h>
> >
> > -enum _msm8996_version {
> > -     MSM8996_V3,
> > -     MSM8996_SG,
> > -     NUM_OF_MSM8996_VERSIONS,
> > -};
> > -
> >  struct qcom_cpufreq_drv;
> >
> >  struct qcom_cpufreq_match_data {
> > @@ -134,30 +128,16 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
> >       dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
> >  }
> >
> > -static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
> > +static int qcom_cpufreq_get_msm_id(void)
> This should be u32 as info->id is __le32
>
> And please export this function from socinfo, it'll come in
> useful for other drivers!

How? In my opinion newer drivers should use compat strings rather than
depending on the SoC ID. If we were not bound with the compatibility
for msm8996pro device trees already using higher bits, we could have
dropped this part too.

-- 
With best wishes
Dmitry
