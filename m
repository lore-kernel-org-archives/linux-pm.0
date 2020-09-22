Return-Path: <SRS0=E4ep=C7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D5DC4363D
	for <linux-pm@archiver.kernel.org>; Tue, 22 Sep 2020 18:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CAAC2376F
	for <linux-pm@archiver.kernel.org>; Tue, 22 Sep 2020 18:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600798203;
	bh=uaItol4wtc5K8HGpLTVZ6lP+kCCJZgipmgq8/k/nsLw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aFdE74KVY4ZYlWA+xIuNnW4UrTy0z/Cw1Y3AI88qC6DKCK83z5IPv1Ph6i0FevFjP
	 /CeQI6aPcm+G7NAmUmgklOtxSfUdjd59FVlsvTv4lzGbWFgNc5JdIrQSLKV3KY7hKg
	 p5C6v2ctiZY02bVQOY98XWBGN/x5AfvYp2hV8Bz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgIVSKC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 22 Sep 2020 14:10:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36091 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIVSKC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 14:10:02 -0400
Received: by mail-ot1-f65.google.com with SMTP id 60so16493213otw.3;
        Tue, 22 Sep 2020 11:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QlEFQywiRvQ+twIdPEytuB76I+eeUqwGo5y837O5NTw=;
        b=UxtnBsdYI3gtx80sUdtPkHnwB/PKO9fSAAXiojwMfFKjWzfn6VI/n/dxzEnRebSVQ1
         MG+1n/CTeNgLTuCJB35bzWlP5DD5MpG/F8Vn1Oy02faittTjYTdbTzYQUSwtql6DKIuw
         IMnFFwdWI6VF6jsXB9AAm2YKmFBHVLgZK2M4HImKFoEpCWnFyxCYMd/+udd2it2ddaVs
         w+nfuLcOPQcTZ+1N8WWWwido7Em0u8kKe0b39akg+TwjpDj1U5BFpQAPYFS6H1E14Wo3
         rJAf7YfPnS87D71ejucgGvR6xun2zuz/sYYOoV/KWnzsgUW+RC0U7YzuffNT8bTIVDO0
         XqJQ==
X-Gm-Message-State: AOAM530XxT/qdmeNkYBHnTnb6DDZF8oRMA4nac4LDt35Ho+tpi266Krn
        b6MjX7v+UX+pbSbK/15DSv5cw3kFxpS8h3RKxzk=
X-Google-Smtp-Source: ABdhPJwUpZDHHTzTy1g5JIq4eTe38ytasJLBpv6A6KDB4zbQkCI699I7UAQrTcvHDTxL6m3f5PamHeA/GSi0n1p+j1o=
X-Received: by 2002:a05:6830:150a:: with SMTP id k10mr3429624otp.167.1600798201380;
 Tue, 22 Sep 2020 11:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200918201633.27017-1-khilman@baylibre.com>
In-Reply-To: <20200918201633.27017-1-khilman@baylibre.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Sep 2020 20:09:50 +0200
Message-ID: <CAJZ5v0gzk_h09kJnWnagAL3E7TVmCqFO2E52Dewwyj6NRgKd=w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: drop myself from PM AVS drivers
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 18, 2020 at 10:16 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> I haven't had the time or the expertise to adequately review and
> maintain these drivers for awhile, so make it official.

Well, fair enough, so applied as 5.10 material.

But this means that I'm going to stop picking up AVS drivers changes myself.

I'll be expecting someone to step in and become a proper maintainer of
them and send pull requests either to me or to arm-soc.

Cheers!

> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index deaafb617361..f1bf6071c438 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5361,7 +5361,6 @@ F:        include/linux/kobj*
>  F:     lib/kobj*
>
>  DRIVERS FOR ADAPTIVE VOLTAGE SCALING (AVS)
> -M:     Kevin Hilman <khilman@kernel.org>
>  M:     Nishanth Menon <nm@ti.com>
>  L:     linux-pm@vger.kernel.org
>  S:     Maintained
> --
> 2.28.0
>
