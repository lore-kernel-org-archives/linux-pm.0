Return-Path: <SRS0=5pBW=S3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C2BC10F03
	for <linux-pm@archiver.kernel.org>; Thu, 25 Apr 2019 10:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EE120811
	for <linux-pm@archiver.kernel.org>; Thu, 25 Apr 2019 10:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmyNev+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfDYKxr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:53:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42448 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729089AbfDYKxr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Apr 2019 06:53:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id p20so23816396qtc.9
        for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2019 03:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bbteM2J1OS0fznjwkCa9uIRVim6faE/hgPnLCjvXWoY=;
        b=kmyNev+5N9Dp4m2ofoFjryIG/zrbZ1WObLsuDQTvxQixKfTd6IhvEuoHxIZ7WfpBIP
         UaudwtmrESbIsL4lFQQ8O5Mc5PLQCFnIcM/uGDKZt6fReW72z1goEZ1vBh7fwZvpt8N0
         EguzHxvxfopmlS7k34AlbyvBuHBpz9PJsyaO9nMs+7XSHUi9LbiK55phqNteufpEKSrl
         vh/Yd6WVNuKX4YL5HySd8DfI9DGI0wVJBZtT+Q0nUQuJ/nGqRLuzJEyWtoJCmnLzKrko
         vY0cDlL/6LIT5RPoDP5hCO8eZV7dGUr0k3INv8RfdhgJ7G4acQKm64aTzYvteLwgE0wf
         xosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbteM2J1OS0fznjwkCa9uIRVim6faE/hgPnLCjvXWoY=;
        b=qOq1AGADRKTMSsoQadvRs2VEFsZAn/F+HU2dYEdZXZxT4goeIibv9YjmXvtBdECZ9A
         yExQQftBfSCAWnyxepHzG4oeEgGqRu7ELE19z4FxH14epiZxbYq/VR+rYbul4UZJr5ro
         fAbkSltElgPZrjtwmdJDddwmUJUVcUNPGHqWq+UIJeloVrBGbruZoVxqZ8wBX90XpzO5
         Yh7H2uOYws18wgKyBgOCnICSXy2mTPR0h6IJf0RUxDMjX4N4nCyIm0RAUvDtlbkNe2kA
         BUiTg7Up7GC9B4nSlRL5PD31p/jrSt7mfoP7sVdoxorKAEsXRLOAouFepxHtJfRBmZbY
         BTZw==
X-Gm-Message-State: APjAAAXg0A2i6FW9SjPUP4SkuPSVPkx+AgE3zq8/o0VFfVy+CqGr7h+Y
        I+8+XyrScPGf4rM1zDs4Zw8fy9lV4hqbAKKQdwDu+g==
X-Google-Smtp-Source: APXvYqxViUbpermfU6+6Ze0b7ERh6nz2KaYoJJvuSz8IzQMc9KmZBZkBthAzEoMeRro8S9VQ5Y6bY4fFmaXGtxL4jQk=
X-Received: by 2002:ac8:19b4:: with SMTP id u49mr21011428qtj.300.1556189626509;
 Thu, 25 Apr 2019 03:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190424141439.GG14820@kadam>
In-Reply-To: <20190424141439.GG14820@kadam>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 25 Apr 2019 16:23:35 +0530
Message-ID: <CAP245DVZMO=oqQY=CMq1_v=NPPVku=-bx41dXuSejrDxhkwOaw@mail.gmail.com>
Subject: Re: [soc-thermal:for-kernelci 19/35] drivers/thermal/qcom/tsens-v0_1.c:189
 calibrate_8974() warn: passing zero to 'PTR_ERR'
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@01.org, kbuild-all@01.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 24, 2019 at 7:44 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git for-kernelci
> head:   0e50a5ee6b8a23c6798aae23efcd4b8e055c06ef
> commit: 5853cb769573b58c319fa62e1987d063b8c5b77e [19/35] drivers: thermal: tsens: Merge tsens-8974 into tsens-v0_1
>
> New smatch warnings:
> drivers/thermal/qcom/tsens-v0_1.c:228 calibrate_8974() warn: mask and shift to zero
>
> # https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/commit/?id=5853cb769573b58c319fa62e1987d063b8c5b77e
> git remote add soc-thermal https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
> git remote update soc-thermal
> git checkout 5853cb769573b58c319fa62e1987d063b8c5b77e
> vim +/PTR_ERR +189 drivers/thermal/qcom/tsens-v0_1.c
>
> 5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  216                     /* Fall through */
> 5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  217             case ONE_PT_CALIB:
> 5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  218             case ONE_PT_CALIB2:
> 5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  219                     base1 = bkp[0] & BASE1_MASK;
> 5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  220                     p1[0] = (bkp[0] & S0_P1_MASK) >> S0_P1_SHIFT;
> 5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  221                     p1[1] = (bkp[0] & S1_P1_MASK) >> S1_P1_SHIFT;
> 5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  222                     p1[2] = (bkp[0] & S2_P1_MASK) >> S2_P1_SHIFT;
> 5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  223                     p1[3] = (bkp[0] & S3_P1_MASK) >> S3_P1_SHIFT;
> 5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  224                     p1[4] = (bkp[1] & S4_P1_MASK);
> 5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  225                     p1[5] = (bkp[1] & S5_P1_MASK) >> S5_P1_SHIFT;
> 5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  226                     p1[6] = (bkp[1] & S6_P1_MASK) >> S6_P1_SHIFT;
> 5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  227                     p1[7] = (bkp[1] & S7_P1_MASK) >> S7_P1_SHIFT;
> 5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20 @228                     p1[8] = (bkp[2] & S8_P1_MASK_BKP) >> S8_P1_SHIFT;
>                                                                                                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> p1[8] always ends up being zero.  (I haven't look at the code, that's
> what the static checker is saying).

Yes, it seems that might be the case.

Eduardo, this commit is simply moving some old code around that I
didn't write. I'd prefer not to touch it in this series but instead
fix it in a separate series. The code move was done to enable a
rewrite, in any case.

Regards,
Amit
