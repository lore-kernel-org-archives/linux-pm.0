Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBF8C10F11
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 20:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01698204FD
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 20:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r5Afy20U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfDXUJP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:09:15 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46469 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730519AbfDXUJP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Apr 2019 16:09:15 -0400
Received: by mail-qt1-f196.google.com with SMTP id w26so15065716qto.13
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2019 13:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDZGP5KSclojoZTOU/iD4xGm6mbSVyYcUR1EAbRdEI8=;
        b=r5Afy20Urdin9VXbj3H+4mtGg6FEzaln3tCOiG50eninnjIxjTugb4EY0oHKrLzCFN
         Iq0OBoqbVHmO8kU8Nc8dM5t0a4fSS9DKciox290t+0zqC0g6XvyNiM/dEg3Ei67XA+tr
         R0+vQJ4mn2VGOPN6sDQCg7epS6W3Q3nlcJy9j2IWF7MirHHpWJflLRQYvgibhfErXSKy
         zYtcFSBSmY1PJdcJL4V/otBnXikjpT0SPBJTcbDwoGH9P63AGGKPajTYZ09dBkWICmdI
         QvtYRb7E+nfcdewP9NN1Q1kuYiOUMrmUkwmxKyZ+HxpAARZLrwWryReMUuSJTQE9FY6c
         7OyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDZGP5KSclojoZTOU/iD4xGm6mbSVyYcUR1EAbRdEI8=;
        b=SRJYEPeHOKJgTNR7/6r+t6uR9g+ord/Gs3qLJEp7GOuVtHwk4KUZsrtV4ptdadykPS
         pcti+YKVkoriANxHatSrfQQRsYME6jxh+5kx9ZG7P3SLKhKGAKn6gyoNK7CmxtbMRpRs
         bYGFWQ+1GmUs7FmOsoKZtVym3TmJuHowtBqzB4lfBFzjEEfS4b1oS9EJk7ZE+67gP+Hm
         FbK58fPKQPUzY3Gxq47Ksi9x7JTjLizqqHIA6FnD0oAaEa5FXg1BPtUN6fIEG1J/ysNz
         JZ6rc9Xpg4/x1NG/cUaZ8u5pxb0Mn0Id5mn0Z4KrWyjRIwnTZAI27TtOhJvAPrecOJHA
         MJ8g==
X-Gm-Message-State: APjAAAX44EoNJUmGBFOiS/DcXOy9odGlSZeF50qujlpVzjbY35KW2Q5Z
        CzJ67mhsXiToGU3kHGzyvwfas3ENLAApHy//9h7sWcCK
X-Google-Smtp-Source: APXvYqwtCz/UtyOxhlDW7Kc69rnGno7aGfpsykvfWvfmhvDYfW7ZM+Zu+7z7g7jGqmgyQGF04OfL2JgiwOPb6sQ4tGI=
X-Received: by 2002:a0c:b0ef:: with SMTP id p44mr27694712qvc.127.1556136554103;
 Wed, 24 Apr 2019 13:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <201904240154.EAoubNVL%lkp@intel.com> <20190423170720.GA81562@lkp-kbuild05>
In-Reply-To: <20190423170720.GA81562@lkp-kbuild05>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 25 Apr 2019 01:39:02 +0530
Message-ID: <CAP245DXUmDSiWBbkMWn68_NinXgAVpfZ_V6zjr3YrGUXusLr=g@mail.gmail.com>
Subject: Re: [RFC PATCH soc-thermal] drivers: thermal: tsens: tsens_v0_1_feat
 can be static
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Linux PM list <linux-pm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 23, 2019 at 10:37 PM kbuild test robot <lkp@intel.com> wrote:
>
>
> Fixes: 5be1c7f5f9ce ("drivers: thermal: tsens: Introduce reg_fields to deal with register description")
> Signed-off-by: kbuild test robot <lkp@intel.com>

Hi Eduardo,

Would you like me to fold these fixes back in and respin the series for merge?

Regards,
Amit


> ---
>  tsens-v0_1.c |    4 ++--
>  tsens-v2.c   |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index d171a4a..a7560e9 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -319,14 +319,14 @@ static int calibrate_8974(struct tsens_priv *priv)
>
>  /* v0.1: 8916, 8974 */
>
> -const struct tsens_features tsens_v0_1_feat = {
> +static const struct tsens_features tsens_v0_1_feat = {
>         .ver_major      = VER_0_1,
>         .crit_int       = 0,
>         .adc            = 1,
>         .srot_split     = 1,
>  };
>
> -const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
> +static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
>         /* ----- SROT ------ */
>         /* No VERSION information */
>
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index e15a302..b58f5af 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -83,14 +83,14 @@ static int get_temp_tsens_v2(struct tsens_priv *priv, int id, int *temp)
>
>  /* v2.x: 8996, 8998, sdm845 */
>
> -const struct tsens_features tsens_v2_feat = {
> +static const struct tsens_features tsens_v2_feat = {
>         .ver_major      = VER_2_X,
>         .crit_int       = 1,
>         .adc            = 0,
>         .srot_split     = 1,
>  };
>
> -const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
> +static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>         /* ----- SROT ------ */
>         /* VERSION */
>         [VER_MAJOR] = REG_FIELD(SROT_HW_VER_OFF, 28, 31),
