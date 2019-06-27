Return-Path: <SRS0=SSH8=U2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1279C4321A
	for <linux-pm@archiver.kernel.org>; Thu, 27 Jun 2019 21:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F11208E3
	for <linux-pm@archiver.kernel.org>; Thu, 27 Jun 2019 21:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561671282;
	bh=z6vxvgcooVit0w1dMZ8RHDfMVLlV/WSxXIdDPr2/djY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Qk0MEcy+oCArZxRKpKqgUYnRFgW1GHM7JmdlDh2nrw2ymUhLlHrF+q6N1D3M8j3CE
	 8ZwOQrKQJfPQldYCyv22z/ipXr/taIgt/vTLFY5IHfk6z9iehGq4m08qiKvQGGpEvd
	 93rjthfFTY9dDqJ7oFQBuE74ij5WbWC9j5KmK5I8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfF0Vem (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:34:42 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41396 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfF0Vem (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:34:42 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so3526773ota.8
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2019 14:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y+AaJx3KDxvObWQHNBpCXdRZgBJlDteWyk6o/dNLc7E=;
        b=cCqi4VuBvkoYvYSVJ8a2PIIovwaJGzVPc4D7md+eFdLhmbNSvlvmLkMIf3oS2VLfBX
         Xv4k3LzrQX4eVyrlALQWFSSuvZs83Qxtr4hskWWlaG8ZZqMr/PcIH7LPr90COs3YIloX
         p7id/oXVweP9y84zhQ41ufHQnbkCMTeC5DSZLrEmvfO80bsgEuXru1MQfhSgPtZgPJjn
         h7NWCFMPXO4wjFXkeH02726b0fsCy8SAISNDVCwVosh2G0sjVKUQWm84w7k7fhwTOmkd
         MF17Kgql/x+FgFni1BxvfsiIbcP6U709CW82tFAPCtkyyfiGnYQq73pgYv/KjmXoJDtS
         87iA==
X-Gm-Message-State: APjAAAULotsKQHz2t0rAXu0z3F5wYQLJFTnASUQZ6KrO/f0K17r/pAlR
        O/2rDNXm1N/1ClQuyBW0zlFaIj99cl3ZVOHMeTI=
X-Google-Smtp-Source: APXvYqwhIOGnE3+nCiMYpr9kNlR8WAVvaB73GPsewHRu8hL5Ls/mInKzy4V51HgwlShmxbybbU0m2vqOxdDNIuNNCJM=
X-Received: by 2002:a9d:5d15:: with SMTP id b21mr5301439oti.262.1561671281406;
 Thu, 27 Jun 2019 14:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190626072027.kjqfwwbvacn2s47o@vireshk-i7>
In-Reply-To: <20190626072027.kjqfwwbvacn2s47o@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Jun 2019 23:34:30 +0200
Message-ID: <CAJZ5v0jxZOjhsgGeb7zHbuNL0AUQBXiezD1LfOrC51Q9V-mCXw@mail.gmail.com>
Subject: Re: [GIT PULL] OPP changes for 5.3
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 26, 2019 at 9:20 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains:
>
> - OPP core changes to support a wider range of devices, like IO
>   devices (Rajendra Nayak and Stehpen Boyd).
> - Fixes around genpd_virt_devs (Viresh Kumar).
> - Fix for platform with set_opp() callback (Dmitry Osipenko).
>
> --
> viresh
>
> -------------------------8<-------------------------
>
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
>
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to 560d1bcad715c215e7ffe5d7cffe045974b623d0:
>
>   opp: Don't use IS_ERR on invalid supplies (2019-06-24 12:48:29 +0530)
>

Pulled, thanks!
