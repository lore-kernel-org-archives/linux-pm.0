Return-Path: <SRS0=ViTu=EI=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B3EC00A89
	for <linux-pm@archiver.kernel.org>; Mon,  2 Nov 2020 17:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F8120786
	for <linux-pm@archiver.kernel.org>; Mon,  2 Nov 2020 17:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604336750;
	bh=LcqrIQFfDCdWTL9tpxjITH9Ppiumlh1z3d/b1XvlX00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0Ubuw9AAojbqkwRns74gQNMLz+0jJV+NZUzgx68XguN4YyH5PPvrINENT+8S1/Qxt
	 Tiv8h45FqaEEOobkci1H8F0t72uKPc/2wLevWgb48wrlgZ8z4dGX5EO5jBmqLqZfZf
	 lJcZ5FjEaJXxLmL2IevSPgidHvZMhb4Q9MhKRp2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgKBRFt (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 2 Nov 2020 12:05:49 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38247 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbgKBRFt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 12:05:49 -0500
Received: by mail-ot1-f67.google.com with SMTP id b2so13246591ots.5;
        Mon, 02 Nov 2020 09:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SjTzdr85BCM3hL27uRA539CoNUKnQcDNUPKRqBAEp80=;
        b=PFrWv3ag9Xb2uAckmeGmczHjiSQUoN4iyxJD8+QnOBE5/8dRPLizQWJGI20L6k6uRy
         LXoMuWlUFJ2Gdvv7yMUoyZPjY/fZM5Aw3RGXAKsMafOUHerfA2w6mnLaU/mhVkWVuzwa
         DmJN69uG33poLcN8Itr3d0IFhUjyXgops/w2M00Kkb8VGUKWZOo/BKR4lnpL66Kqx+g2
         ojrtFlKBosA9GNSVCAuABJlGKf7pWfi2cP0SJxc/vi0JITm37rQ1lDUkzC4ht5KjYe3J
         7mumEXitOqgNr01xFDnYuWeC2A2d5MGBktqvf7G1RFuXP1w9noDZvn0WXYr3JCke7o5L
         ik0g==
X-Gm-Message-State: AOAM532y2giS6JUq5EToQtgqu+WlpDWWNUnLU5HpwfKMBkpXVGzSNcCa
        ixJ3qVQgEXmwQi4QxVsaE3BeAjgMBo4hC2Y4FvA=
X-Google-Smtp-Source: ABdhPJw/rxqnoGn+pmKUWx1OvqYDAX6zQv+/G2xCtaUWf7Gfsw9FZkC0nKlEjJutJAoT4Uy/63HKOaeUQTYxX58L3+M=
X-Received: by 2002:a05:6830:18cd:: with SMTP id v13mr13334663ote.206.1604336748985;
 Mon, 02 Nov 2020 09:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20201101141129.2280794-1-trix@redhat.com>
In-Reply-To: <20201101141129.2280794-1-trix@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Nov 2020 18:05:38 +0100
Message-ID: <CAJZ5v0jGxgv_GXG4yd7esyiA8XKA63S0pXbKD_eFAJX+ED8nyw@mail.gmail.com>
Subject: Re: [PATCH] powercap/intel_rapl: remove unneeded semicolon
To:     trix@redhat.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Nov 1, 2020 at 3:11 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> A semicolon is not needed after a switch statement.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 983d75bd5bd1..020373d6d3f1 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -613,7 +613,7 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
>         case ARBITRARY_UNIT:
>         default:
>                 return value;
> -       };
> +       }
>
>         if (to_raw)
>                 return div64_u64(value, units) * scale;
> --

Applied as 5.10-rc material, thanks!
