Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80696C10F11
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 07:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5352089F
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 07:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556091003;
	bh=r8gQYZheErueUQVc01z/iGjivz+5E5rIeGPZsgP7TVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dCNry3L3Hk0H8BC5/C8yuFwIyhyOEJopRB7/aeRm/7+60daA1RgP/Czm2LVpsnnkq
	 WgJUhKzMgqUJ+iAGEn83E243MMRnEtsHucTJNRLVYLmZNX6enXicyrK6b+bmAd4jnW
	 A57mtpp3PYAqT4ZiVSbc6A4FCmLcxCOGCA0xFsas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfDXHaC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:30:02 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33197 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDXHaC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Apr 2019 03:30:02 -0400
Received: by mail-oi1-f195.google.com with SMTP id e5so13495954oii.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2019 00:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n5cvP440R+898AuEaPDvzhCZdSUdXEuR4gBZWQTdqII=;
        b=ZbR34aERDbhbxemarfXgVr4hhaUot0Mx8ZGNP94WWd3wPVpDgoSKKiRkYC+VPnFSNr
         gCuxhg/DziDBFiQJ6cw4/xSDfJiKlykOOVDRBahKJYYQ0Iv+q9lzg/vkROIvSdvUmo1n
         7x4sKQXyZztCF2qwkn7ewBn6mDARPAhnETLe12CrY+QifaOw9BPtZo6IMx62TQEnEwt4
         jvyMuWmWZDn1qfQqLNFW1/eH64mtZuE2i72n50/+28TYUFWPbn3MH7+Cdau1v/7afZyV
         S3eB1R1Krm9xcSB6yUpmuAvZVMwWrivLZsNJUWzTbavD3q5xEYB+wJGSVWK5xF3Xdh4Q
         54tA==
X-Gm-Message-State: APjAAAVlxis2qs7KID2YYMN4Av+1elMrgh/SqNP2ZmCX30+cLJsnj/hX
        NHUUVLqdMk++kVstV1rUC2IvnJV3yU6Ify3kur0=
X-Google-Smtp-Source: APXvYqwCJGDAmcW+9j8VGK8ByuEl/DQCU3CpUDMploKrJDyZ8bKDP8NnJHqUErsp/uPj79lNUnQVa5uTEpJj44I2cuU=
X-Received: by 2002:aca:f511:: with SMTP id t17mr4399741oih.115.1556091001790;
 Wed, 24 Apr 2019 00:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <1556089181-4246-1-git-send-email-rui.zhang@intel.com>
In-Reply-To: <1556089181-4246-1-git-send-email-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Apr 2019 09:29:50 +0200
Message-ID: <CAJZ5v0gfAzgzDuTZgghsm7h48_DK+zTmT9pEGrsqdsQE4xU-WA@mail.gmail.com>
Subject: Re: [PATCH] PM: wakup: export wakeup irq when system aborts suspend
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 24, 2019 at 8:59 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> When suspend is aborted because of an ARMED irq, we can not get any
> useful information about which irq is triggered.

That should be provided via the /sys/power/pm_wakeup_irq attribute.

> Export the wakeup irq via suspend_resume trace event in this case.
>
> Signed-off-by: Brandt, Todd E <todd.e.brandt@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/base/power/wakeup.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index bb1ae17..d32bd91 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -875,6 +875,7 @@ void pm_system_irq_wakeup(unsigned int irq_number)
>  {
>         if (pm_wakeup_irq == 0) {
>                 pm_wakeup_irq = irq_number;
> +               trace_suspend_resume(TPS("irq_wakeup"), irq_number, true);

pm_wakeup_irq can be read from /sys/power/pm_wakeup_irq, so why is it
necessary to trace it additionally?

>                 pm_system_wakeup();
>         }
>  }
> --
