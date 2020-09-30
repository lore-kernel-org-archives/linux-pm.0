Return-Path: <SRS0=B0WI=DH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D43C4727C
	for <linux-pm@archiver.kernel.org>; Wed, 30 Sep 2020 15:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A4220738
	for <linux-pm@archiver.kernel.org>; Wed, 30 Sep 2020 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601480513;
	bh=zQv9vaKKC5bv01p/7fwt8eQnZ6OHQ9Uxe4wV/8stoWw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hgFQ/H5sbkbJQaBIsNfWHm9P7+7GTHQ4BZ1+uneE29vcE9pWL2CAGO8z1JIhjKih5
	 LdYMTAFk1SndC8IOlvUmtD6AUYBckgI8sl2IHo/ogKj6iz2GVcPFKPKfYK2K1ztoAH
	 lKGDuHK4bPFQOLe0oAPAzAC1uqLq3OYVrREDl7gE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgI3Plw (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:41:52 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40641 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgI3Plw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 11:41:52 -0400
Received: by mail-oi1-f195.google.com with SMTP id t76so2152547oif.7;
        Wed, 30 Sep 2020 08:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1boUtBUBLzQPw5c/Bp/DpOn4m94EkQSBe7ntlAkUbpc=;
        b=eBxUkvSK/LH2qsEUUrl7N6kzNcNMEGN3++4eP24oB6XU6tiYomcnhpHhhlJoJzVgTA
         4D78wt1HSNALVtzNz03kGoNCJvFdbAr8oy2Cgcjx2UZe9wmqjWKM3n6o5n83jfBuIiw7
         KvsaBCFdfnJnxZKJ9DM3sQu1dm4kh2IxBR0LoaXp/RW0HTZ5Es3PD5lwooSXniP2fNfg
         4OBudKd3bjYGesCK5zYTaso5qinLZLDKVPvpZ3VQ/LttiLZXtm4fKD8u5z8GzAARc4oB
         gDrrd//ilI8+xM3ao0ovp5Vi31FEEEPKi1OTc8ZsNNRjfbWt6OmJgqxcfFO+Iw6iKRyB
         Jo3g==
X-Gm-Message-State: AOAM5339ti5LDvC2G6RJkxlW1LEsyiSbBsiZOuX3g8vbyan9NDKpYsAF
        YTc4tCaO5mUL4b+PfFnWKQHYMxFWQYOCWXQJkZU=
X-Google-Smtp-Source: ABdhPJwO8Zwm2P/HdWE4ZaRyDRWRm98cReLmsfm15FI09hCLMOcfxwQoewDPg0eRsuAM+RE0tTlRapJKHKbdOBdHW+M=
X-Received: by 2002:aca:5b09:: with SMTP id p9mr1673233oib.68.1601480511860;
 Wed, 30 Sep 2020 08:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200929204157.26127-1-yoann.congal@smile.fr>
In-Reply-To: <20200929204157.26127-1-yoann.congal@smile.fr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Sep 2020 17:41:40 +0200
Message-ID: <CAJZ5v0h9Qkn8ymFjOVBR+WU1vDmb7CyDRsWT_Yo4yc8xVEn23A@mail.gmail.com>
Subject: Re: [PATCH] Documentation: PM: Fix a reStructuredText syntax error
To:     Yoann Congal <yoann.congal@smile.fr>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 29, 2020 at 10:43 PM Yoann Congal <yoann.congal@smile.fr> wrote:
>
> Fix a reStructuredText syntax error in the cpuidle PM admin-guide
> documentation: the ``...'' quotation marks are parsed as partial ''...''
> reStructuredText markup and break the output formatting.
>
> This change them to "...".
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
>  Documentation/admin-guide/pm/cpuidle.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
> index e70b365dbc60..191cfa4a450b 100644
> --- a/Documentation/admin-guide/pm/cpuidle.rst
> +++ b/Documentation/admin-guide/pm/cpuidle.rst
> @@ -690,7 +690,7 @@ which of the two parameters is added to the kernel command line.  In the
>  instruction of the CPUs (which, as a rule, suspends the execution of the program
>  and causes the hardware to attempt to enter the shallowest available idle state)
>  for this purpose, and if ``idle=poll`` is used, idle CPUs will execute a
> -more or less ``lightweight'' sequence of instructions in a tight loop.  [Note
> +more or less "lightweight" sequence of instructions in a tight loop.  [Note
>  that using ``idle=poll`` is somewhat drastic in many cases, as preventing idle
>  CPUs from saving almost any energy at all may not be the only effect of it.
>  For example, on Intel hardware it effectively prevents CPUs from using
> --

Applied as 5.9-rc8 material, thanks!
