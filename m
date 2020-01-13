Return-Path: <SRS0=HpL5=3C=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EB9C33CAD
	for <linux-pm@archiver.kernel.org>; Mon, 13 Jan 2020 10:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4CE2081E
	for <linux-pm@archiver.kernel.org>; Mon, 13 Jan 2020 10:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578912404;
	bh=9nfkkDeMozwQgtAsa/kxNv2DZqX8c+CnCXZ7VRS9HlA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mFYfreteb6tba9+EQFxJRRIIvKYLvONAy48CNyuavc0W+OZUku2A/d8MU8jhkTxAm
	 dxWTRvcYTYHwvXpgyN1xmKDuMX+3HB6CkRTGk943YOfNLOCtN1ZeJ18oGR3zGh8T2k
	 5UTGJ2nj7RPk4qAFFuddAlRSNb5K+GCQt8mIRsqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgAMKqo (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:46:44 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38794 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgAMKqo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 05:46:44 -0500
Received: by mail-ot1-f66.google.com with SMTP id z9so6379420oth.5;
        Mon, 13 Jan 2020 02:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O3bZpE/ufziUWjC9uszYknO9uvEa5cBsIBbMoZQZJ7k=;
        b=ROd5+XJeJ0DKIIyGT7/VkhtaQUQh0+1hIARN8o44TmrupoVfkbovzXaN61ISrA98Qz
         UpkQ9ZGaA741mnTT7O/NX53bfgeNn8VxMvzEVXtLvePCI/ig0hDq1weJH9sYqv9i3jBT
         WuQpgdUeVtqI7mHDEaGH+JyKBFZ8AJd2Gujh/HFLA9T5FCe3ycHHsZpuGYhtZVxUcEoC
         BAzPNonnbrQhBFFe+2M8zn0b+3RRT8tL9sYbSvk1cSS0h80DRU6+TUCtsJOOmKEVKvse
         TxKk7DttcuCYwpPa3Bm5RaHiegdaRcDjXj0S2QEX1gV0mIrLEu1XXk17nKu3q1vmunqB
         2wjQ==
X-Gm-Message-State: APjAAAVjPYl+ud/QZ4ymwEKxKjj4zQMv/64ldOXCmS3/QCAAyRCz3Zfq
        YKBegIRQFgfKXSv1/tli1mdnxSrzrMEYdY/rLss=
X-Google-Smtp-Source: APXvYqwH+pvhAPxpctM2feYU9YWH9LSAQ8FM08ynn/WnToFcMkxV1/nNSQYMLhQMRIplaUlWJITa6Nn+IwUe+RTwfyo=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr13030835otd.266.1578912403187;
 Mon, 13 Jan 2020 02:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20200113182228.1.I3c4155635fe990891a2c98c874cc4a270c82fe1b@changeid>
In-Reply-To: <20200113182228.1.I3c4155635fe990891a2c98c874cc4a270c82fe1b@changeid>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Jan 2020 11:46:32 +0100
Message-ID: <CAJZ5v0i3Yu9GbbQ4Rubobbitvte1bJ0ARfq8jGJPQxRckx+hZQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: fix spelling mistake: "Whethet" -> "Whether"
To:     Harry Pan <harry.pan@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Harry Pan <gs0622@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 13, 2020 at 11:22 AM Harry Pan <harry.pan@intel.com> wrote:
>
> Fix a spelling typo in the comment, no function change.
>
> Signed-off-by: Harry Pan <harry.pan@intel.com>
>
> ---
>
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 8ab31702cf6a..4bd9cb33132c 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -172,7 +172,7 @@ struct vid_data {
>  /**
>   * struct global_params - Global parameters, mostly tunable via sysfs.
>   * @no_turbo:          Whether or not to use turbo P-states.
> - * @turbo_disabled:    Whethet or not turbo P-states are available at all,
> + * @turbo_disabled:    Whether or not turbo P-states are available at all,
>   *                     based on the MSR_IA32_MISC_ENABLE value and whether or
>   *                     not the maximum reported turbo P-state is different from
>   *                     the maximum reported non-turbo one.
> --

Applied as 5.6 material, thanks!
