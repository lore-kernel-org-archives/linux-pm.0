Return-Path: <SRS0=AJ/8=YZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CB8CA9ECF
	for <linux-pm@archiver.kernel.org>; Fri,  1 Nov 2019 17:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4BA2085B
	for <linux-pm@archiver.kernel.org>; Fri,  1 Nov 2019 17:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572627757;
	bh=DajJe0mFj15gK2TgkfxM5mDbiFLnzq+6Bv8I4oC5BqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vBvOEMCiOnvS8pWE/U38C7mfMrcV9BDEzII3qfYJZQgDUkHDxMvoiuksPQHMfPbg+
	 0LYGKdELFRg/l/QovaDSOd9GYCJKd6Gg2J/wou0sN+AU4JYDKpRHCc232Qtz1Haxjn
	 gg6TYULtLF9k9LRriuI978B1QAR+6/bjLwyhXHVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfKARCg (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 1 Nov 2019 13:02:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40566 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbfKARCg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 13:02:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id p59so8025665edp.7
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2019 10:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2uoew/fPqh/5Cx3han3omflzNw7btngpjIhB4RSS554=;
        b=su0v+t2/zHb/+Ycbm8IoT85044e28DekaSi6pIlCuqpY1R9oMw8l1OT2BvcSf4KJCi
         28wYbaiQhULy7ahgvbTFo3THSqMo9HHRedD1dvUwZHc/RFOAngwJHWuXTS/qvzmMmowd
         6Wv12xdE5veqh6NvTviRqP7LQhFM/QgTbPPTdKMh2E930PdlVews9wks8wMzK4UXmsIc
         aHI8CflK8oNF+BhWXKnWaCNYOWhDjqUmsFrPcwJUcuy9M01tm8DqbjqyPi+IbVURqIno
         IttXnF+MHgdFETUc5WjimsPk/a3Yni3UA/MlD8tfweYcmGrecqaV8DhrmUyG3NGbz0dn
         hXGQ==
X-Gm-Message-State: APjAAAVdlAg7x9YIbv02/zIlnTRWxRXgteV0oar7Cg1Fvuf/cDP75Th8
        LBV8tVSlti6EY5iGvGMxfCFeUDYIWkB7GALr4Ycnew==
X-Google-Smtp-Source: APXvYqy6mcKjgVIUaNEoM2d4tSgLqIUk++sXg2gAMUCNlKSpAm+jXFoN4FjzdL8JEs8Rt+aTyaeufJNIPxyCL4iaoKA=
X-Received: by 2002:a50:bb48:: with SMTP id y66mr13868752ede.66.1572627754739;
 Fri, 01 Nov 2019 10:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191031131422.18887-1-rui.zhang@intel.com>
In-Reply-To: <20191031131422.18887-1-rui.zhang@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 1 Nov 2019 13:02:23 -0400
Message-ID: <CAJvTdKnjNwRDVukT_JONSTfzG-6kzxHFzNJoyWFpbmoHwTr45g@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: Add Cometlake support
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Applied -- thanks!

On Thu, Oct 31, 2019 at 9:14 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> From: Chen Yu <yu.c.chen@intel.com>
>
> From a turbostat point of view, Cometlake is like Kabylake.
>
> Suggested-by: Rui Zhang <rui.zhang@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 5d0fddda842c..985e195f066b 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -4610,6 +4610,8 @@ unsigned int intel_model_duplicates(unsigned int model)
>         case INTEL_FAM6_SKYLAKE:
>         case INTEL_FAM6_KABYLAKE_L:
>         case INTEL_FAM6_KABYLAKE:
> +       case INTEL_FAM6_COMETLAKE_L:
> +       case INTEL_FAM6_COMETLAKE:
>                 return INTEL_FAM6_SKYLAKE_L;
>
>         case INTEL_FAM6_ICELAKE_L:
> --
> 2.17.1
>


-- 
Len Brown, Intel Open Source Technology Center
