Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258ADC5517A
	for <linux-pm@archiver.kernel.org>; Tue, 10 Nov 2020 02:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D6A206D8
	for <linux-pm@archiver.kernel.org>; Tue, 10 Nov 2020 02:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zsg4iWoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbgKJCmH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 9 Nov 2020 21:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730767AbgKJCmH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 21:42:07 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3699DC0613CF;
        Mon,  9 Nov 2020 18:42:07 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id q3so11021133edr.12;
        Mon, 09 Nov 2020 18:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QCjYkiKx/BLbkTnM57KeeyWfIIziL5lqmCR+tLSMR44=;
        b=Zsg4iWoTqV4+rtURxHXllynTBuA4nWWvMo+UiK9CQ7lZHpjbkgmliNdf6e/WzPVjJY
         ehNqG21n+asoXlObj5AjawpWZnp6yjrKpzn869GVTby2zWUs29ytPtWYLKJ8ow8dmKxd
         2h4Q7FvGmEYCIyolTKuvEyRPw+OcxCj69Qr3TIp2rxhQYGaT3s7udWQN3fAwWplj0eJY
         P+A//XqNtHtiqDtKE9ViT9bw4EqdvHu9QoRMttlBlp1VLbFbTFa17dmI/mipbthaAw3V
         M8EsULKvB73OROdsSLQ3wjr48dj12OPx5uU/YDDYwQq0tb+w2LRno5CNGhY3FDRQi/xK
         vu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QCjYkiKx/BLbkTnM57KeeyWfIIziL5lqmCR+tLSMR44=;
        b=ikiaKmYe3uhQLzHoZRGrYln1U2hgFWv2ArQhhmuH/Sb1vehvXOjz0cbZKXIaVpl5wX
         enRf+ZgmEBCVMmqBaTIMLwweYoy+1zZSWRZV4K7WBwBIBHLotsyMnz0ZW60tbFKE3JBh
         SrRgnExShS98oE3NN1GR2ys+sbjZtEIq+uF4itiMjHb6TVSwrQSdvUIpikT7J9grAiLG
         j9pWSUoUqYoxYWhs4eE+KlmnKexQx0CCpTIpoeIrdmhZrwrjO756G3iwjpRIeUgBbKrp
         Ibmqjd7agVXURZ1FW3k+FwJJzXfGdWnNMYtezCO0J2PSRyG9bIMMMA3UY6acpKF6cfCm
         66dQ==
X-Gm-Message-State: AOAM530O6R6Vt5/SEZj+5gS2UX6+WXfRg2i13BjBHPr3ekPemf4a5v0H
        W7YUvIc4yXvmEhaNBhT3Ss2RGeLpK57o0CnT840=
X-Google-Smtp-Source: ABdhPJw9ZR4CJPCuMASm2QQ/j/4SMvjISo5Zk7ZNgeCoXiPCvzyuz63NEMfHWflBUgaN05eNycB1U3GZuVGAhk7ojiU=
X-Received: by 2002:aa7:d9c2:: with SMTP id v2mr18335063eds.95.1604976126023;
 Mon, 09 Nov 2020 18:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20201103151139.29690-1-pali@kernel.org> <20201103151139.29690-7-pali@kernel.org>
In-Reply-To: <20201103151139.29690-7-pali@kernel.org>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 10 Nov 2020 10:41:54 +0800
Message-ID: <CAEExFWsw-SbzS8+ORrOBR1BZD8h1rkkSjTq8AYQEw_gmPnH6ag@mail.gmail.com>
Subject: Re: [PATCH 6/9] cpufreq: sun50i: Add missing MODULE_DEVICE_TABLE
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 3, 2020 at 11:14 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this cpufreq driver when it is
> compiled as an external module.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Fixes: f328584f7bff8 ("cpufreq: Add sun50i nvmem based CPU scaling driver=
")
> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun=
50i-cpufreq-nvmem.c
> index 9907a165135b..2deed8d8773f 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -167,6 +167,7 @@ static const struct of_device_id sun50i_cpufreq_match=
_list[] =3D {
>         { .compatible =3D "allwinner,sun50i-h6" },
>         {}
>  };
> +MODULE_DEVICE_TABLE(of, sun50i_cpufreq_match_list);

Reviewed-by: Yangtao Li <tiny.windzz@gmail.com>

Thx!
