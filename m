Return-Path: <SRS0=3Wtg=WW=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CFCC3A59E
	for <linux-pm@archiver.kernel.org>; Mon, 26 Aug 2019 08:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273E9206BA
	for <linux-pm@archiver.kernel.org>; Mon, 26 Aug 2019 08:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566807153;
	bh=xkUTdc1/Eg9akd5zAACwXcDFwgAOXrTsSgXPwXltM/w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cVsR/JrmKU80Hzj4QU31ObycHQ3GSLiJPAw6qIk/L41wqAHYvlA2Ho2qp8t70mMgG
	 fmniNU1i7rUrqazbz69dareASxwOx3h4ihULZku7dVAeMGM2ErAo5FGJtQv/GFMTV2
	 4GBwUvd866QzVaKipgXlLINEOjHF7OzcbotOLgPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbfHZIMc (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 26 Aug 2019 04:12:32 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:41778 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730400AbfHZIMc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2019 04:12:32 -0400
Received: by mail-ot1-f52.google.com with SMTP id o101so14357630ota.8
        for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2019 01:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dm/hza7H8fMbOftXAhtVZhAuQXjAizf7aBRGPiBet98=;
        b=q6s+puoBPpnNYXr6l58Ncc6CQiErpUMCIEvVebF4fEGrFHRYfTB4qKjprNeKB/Pjal
         lrwNR7sCmImGqV6qctPsn5SqYBu4RU8LQf235cSLxOyqLiYr/CREqXO/2XomqThgBoId
         JmWrM0QfMsyv9LuClkxbQybwDTzLYgAcEgYP4qNWuOVu3R1i2tnpMFJuu0udPidxdbc8
         bGBqpOpI9Wjt3Ar+ztlEUGO4QZVQwgRHv/gINKObxnhZ5F+Hxq51J1lEaHTDP7sZzpMy
         98t7T9VGZ6Tz9amIdCQ3DS1X117NTqGcpxGs7kCOGhhFAUjXsZC2a0Zy49UZ06v60o0V
         s1zA==
X-Gm-Message-State: APjAAAWzlXS18HXi9uNeMEHHQrcrWcxtacjjbkUf2Wy/RhKD+Ak2bu71
        xsauYvLC+fZgTp/8yksQpj1udukPzkyxXbXp1hA=
X-Google-Smtp-Source: APXvYqx7u/1fMdlozltDf7NSNQpMqK/xSwNSHT6HY5cfF2Fs1LSA2R1/YlBBH8FhhuZHkrh5wHPsFLmwAGzWSmP8WWQ=
X-Received: by 2002:a05:6830:1e0c:: with SMTP id s12mr9501391otr.262.1566807151366;
 Mon, 26 Aug 2019 01:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ0PZbTpbzRmUq5gUBDr8ScGY7S-iqN9GhJJLrgB6Jqfxjw61Q@mail.gmail.com>
In-Reply-To: <CAJ0PZbTpbzRmUq5gUBDr8ScGY7S-iqN9GhJJLrgB6Jqfxjw61Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Aug 2019 10:12:17 +0200
Message-ID: <CAJZ5v0ipEMst=QCBjWAkD1BpLNK0Ad2SoQYDXsr2LwsxV-bN+w@mail.gmail.com>
Subject: Re: [PULL REQUEST for Rafael, Linux-PM] PM / devfreq fixes and driver updates
To:     MyungJoo Ham <myungjoo.ham@gmail.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Aug 25, 2019 at 6:57 AM MyungJoo Ham <myungjoo.ham@gmail.com> wrote:
>
> Dear Rafael,
>
> Here goes pull request from PM / devfreq with device driver updates and fixes.
>
> Cheers,
> MyungJoo
>
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:
>
>   Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)
>
> are available in the git repository at:
>
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
> tags/pullreq201908
>
> for you to fetch changes up to 0ef7c7cce43f6ecc2b96d447e69b2900a9655f7c:
>
>   PM / devfreq: passive: Use non-devm notifiers (2019-08-25 12:47:31 +0900)
>
> - ----------------------------------------------------------------
> Pull Request from devfreq to PM
>
> This series include:
>
> - - Tegra driver fixes
> - - new Tegra devices
> - - Rockchip fixes
> - - Exynos-bus fixes
> - - Event: add "event type"
> - - Passive: notifier updates

Pulled, thanks!
