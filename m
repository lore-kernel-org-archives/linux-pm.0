Return-Path: <SRS0=6Td0=4I=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9667C11D07
	for <linux-pm@archiver.kernel.org>; Thu, 20 Feb 2020 11:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7624F24673
	for <linux-pm@archiver.kernel.org>; Thu, 20 Feb 2020 11:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582196512;
	bh=XA+MZZqMC4C3YhfpyUwhkCEhFaVy0Z2309SPCdm5MMA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0siPGzXgfszfsr3Ovf+iYKLfwV7wN0Wm2ywGYW7Q/R6eliYB7uylNoX1x3ISvX9hy
	 5oqngqw+Q2T4VesbNiVE69Z5/a+iDKO8B+KtahMLravuiIf5pQY5JhsTkQ3aUA13Rs
	 SkYerAw8bHLYqIOpIj4o3FbXGLnlpb1drI0m8RRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgBTLBv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 20 Feb 2020 06:01:51 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32853 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgBTLBv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 06:01:51 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so27163273oig.0;
        Thu, 20 Feb 2020 03:01:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcdTEUdWDm4jUDilWMJvR5LBjS5mmvllE0LeHYlzzTA=;
        b=H+IyoROtVV784nqI6OMlcygE33H5E5zbNhJhAqr8VqSYk+i1rrLMHDDIBD8hM7NPVJ
         qsCvmGMAimbOJyFL4n4P4SKSyNuweiNND8S8ROj1ksORZrDkjI8pSmesnycF3Ylwf27P
         yFYUwo14AFTs4NesQc83y9EqCoPcsz+URts7wruoKjuDRH9zX/bcVJfwVdsJYbGAVQgW
         s0/6C2+gb/xF8tcpwWCP6OjzwXyy3ywO/Am2HrBpY10tSt6CJkulKSaZ0IxQQqt1yjoe
         bVbd/PqVIvyZP/hFzsiHNoslVX7kvjpDdJ5AvTEvwfgO2K2B1z9E9YwMydIGXch04yRL
         CZyw==
X-Gm-Message-State: APjAAAUyfOv/cEslnIWrEHNwk522h/vXoBQTda4y7V1J0iJPNwfv53zF
        eS6QVy+NasRkdVU3Gbf+EzTdj6KhocAYYafoamuxBw==
X-Google-Smtp-Source: APXvYqxEeOSeZUODBnrZd79RwocCoiWnCZtiyGFX2ugncp6ZgSJlu0k1vpma+2aaDv97VLdkyiHCb5xEYomjp1ZalZ0=
X-Received: by 2002:a05:6808:8e1:: with SMTP id d1mr1508375oic.68.1582196510586;
 Thu, 20 Feb 2020 03:01:50 -0800 (PST)
MIME-Version: 1.0
References: <20200214140621.19796-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20200214140621.19796-1-alexandre.belloni@bootlin.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Feb 2020 12:01:39 +0100
Message-ID: <CAJZ5v0g-D4X=epZK2m8X=xnPA5fAPRa94uVw3zjwzyGsBgG=sQ@mail.gmail.com>
Subject: Re: [PATCH] PM / hibernate: fix typo "reserverd_size" -> "reserved_size"
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 14, 2020 at 3:06 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Fix a mistake in a variable name in a comment.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  kernel/power/snapshot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index ddade80ad276..d82b7b88d616 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1681,7 +1681,7 @@ static unsigned long minimum_image_size(unsigned long saveable)
>   * hibernation for allocations made while saving the image and for device
>   * drivers, in case they need to allocate memory from their hibernation
>   * callbacks (these two numbers are given by PAGES_FOR_IO (which is a rough
> - * estimate) and reserverd_size divided by PAGE_SIZE (which is tunable through
> + * estimate) and reserved_size divided by PAGE_SIZE (which is tunable through
>   * /sys/power/reserved_size, respectively).  To make this happen, we compute the
>   * total number of available page frames and allocate at least
>   *
> --

Applied as 5.6 material, thanks!
