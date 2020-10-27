Return-Path: <SRS0=A9Dn=EC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964A6C4363A
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 18:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B4FA207E8
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 18:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603822522;
	bh=B4SNgFGsNhaJGFPbLy26xPVVSdhoEFHyvxxsGBLByUQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tYcpL9DvE7AXDreq1+mIF/bzCumtlZ1j/JC4qZZMYKK4qHh8zCM8qFYnxdUgIt3VS
	 l9oc0soVuv6l0Bpecsr+tP4Qcv7p5mROCWmMG6K3IaLveoj8clOGixpshUWJrSOo4V
	 kZ49waTx6zaRnwtmHoJUJPxPbPG5ftRRgldH+p/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1826029AbgJ0SPV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 27 Oct 2020 14:15:21 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:35357 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756361AbgJ0SPT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 14:15:19 -0400
Received: by mail-oo1-f68.google.com with SMTP id n16so560270ooj.2;
        Tue, 27 Oct 2020 11:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2dok45yhaRnIcTqCubcIb/b2anQyaAQwImVQf/Na3Y=;
        b=ck81QMG+M2Kr38q+4/TgGvHYJLJi4S8Bye1aHJKy3KWGkqr61lpFh9y4v4Y5is13Nc
         XBE2+xpIO/pUde1Wetonkr2lXiekSU+OQocGt7zHmwJVa2edrSPJFcuDrzQb2cgnmRLj
         s4YDJwtB6HBEKn8iqnfqTGSzAzP7ZTJTuS5DGfLFtCqvL+Kbl4hKmVG/V9kOgp7NnURM
         jTOu8Q+Xzx+qm+SDAPT3306btv8meLMWMN6x8XJXHyVJnoG+Y4stP82q3+gx8AOT/DfG
         +YZdV2Z4ROPSM0CxOhbFIN/vXk0lLY4RTIgVs5g483spDUFKMc1VPweYId24eqIdCufM
         m42g==
X-Gm-Message-State: AOAM5338wTUR1zRlRH+tQyWxJl30xvHOH08s+xDvdsVr7Fx8smkNM9ZD
        V1YcHtq1YUt0dPMAVn9OB1CxixUdN1hdW5E5SFg=
X-Google-Smtp-Source: ABdhPJyHgyvdIkXdXHc9qAAC9APnfwLpfPgElkuVsTmXd7ixIP5oTtu+ZRGaKCORK5xRhIyTceH+yzE0wVfl1jv6aYA=
X-Received: by 2002:a4a:d815:: with SMTP id f21mr2776641oov.44.1603822517820;
 Tue, 27 Oct 2020 11:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201027124319.1448-1-jackie.zamow@gmail.com>
In-Reply-To: <20201027124319.1448-1-jackie.zamow@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Oct 2020 19:15:06 +0100
Message-ID: <CAJZ5v0jo8B-vpSyet7u04To5M7tE79JyXZFe0jVqUzhsDfhsbg@mail.gmail.com>
Subject: Re: [PATCH] power: fix typo in kernel/power/process.c
To:     Jackie Zamow <jackie.zamow@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 27, 2020 at 1:43 PM Jackie Zamow <jackie.zamow@gmail.com> wrote:
>
> This patch fixes a typo found in the function freeze_processes()
>
> Signed-off-by: Jackie Zamow <jackie.zamow@gmail.com>
>
> ---
>  kernel/power/process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 4b6a54da7e65..45b054b7b5ec 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -146,7 +146,7 @@ int freeze_processes(void)
>         BUG_ON(in_atomic());
>
>         /*
> -        * Now that the whole userspace is frozen we need to disbale
> +        * Now that the whole userspace is frozen we need to disable
>          * the OOM killer to disallow any further interference with
>          * killable tasks. There is no guarantee oom victims will
>          * ever reach a point they go away we have to wait with a timeout.
> --

Applied as 5.10-rc material with some subject and changelog edits, thanks!
