Return-Path: <SRS0=iBKh=7B=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B497DC433DF
	for <linux-pm@archiver.kernel.org>; Tue, 19 May 2020 15:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840A320657
	for <linux-pm@archiver.kernel.org>; Tue, 19 May 2020 15:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589903031;
	bh=m2j7HuOHXkAbzLO6I5FYA6dFqjbBL3HFsyJ5j8o4z6E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fh7auH1+lEJMHdYG93zUKZXazGNfDZ3NqEkb3vfjhNqMS0ELxDu0qFxCgUPqXfEhf
	 uV2qgaKwANpABXuYxyi7/wn4LyCrE9zymdMoJZon8M5yChwePcAqDXfd/4o8A77nW/
	 rPi1ijYhYtct/HCxvfuDjbs6KwYgc3gCbY7WLxjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgESPnv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 19 May 2020 11:43:51 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:34964 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgESPnu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2020 11:43:50 -0400
Received: by mail-oo1-f67.google.com with SMTP id c187so49529ooc.2
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2020 08:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2j7HuOHXkAbzLO6I5FYA6dFqjbBL3HFsyJ5j8o4z6E=;
        b=o7TBsLxE6R8ge64E4BOPGz1GrKbqDp5YPEyDVoitECjE/5YLYjEQDe0+HNvfxSG1Rx
         gVLh3GSZvh/84e1vzUoO4j3trvaouVdkBoMEFsPnPyS7i7DvGOnEMyv3mKJc8DBQgNGv
         M6EAol3/i22oWvkFj2B/Qval8K17mAMcbObFw1jp65ncFT3cTjM4Ar8EDoH9HkwRrZGq
         RaPpqzbviWBlh6V7x+/6c/7LmnLfbzy5ReiPIAMxxDdAO5gifU5MsTOtygxobmA//0aN
         1GP9iH8Plb3NcDHeIGw0iXAnlAfd/gyGfQUW7SitXFPv3Xz5adfui56XfBZzu0lq5NAE
         XdHg==
X-Gm-Message-State: AOAM532yTeT6zHW8Ja+45nduwWyEiOvpog7yUaoHZFGVcV9WurwTlZL2
        HW3zQL+jL4CZaEwg3ab7vtfXTVZjUqGUCfw19l4=
X-Google-Smtp-Source: ABdhPJy3Gna95WyEhrWO3xW/XTKdjTv1EmyyHUDqdSWwzcphMvr3CJjo1El3vvxokdtfGFwCZYWlZ4TU55S4y+F6RkE=
X-Received: by 2002:a4a:a286:: with SMTP id h6mr17245048ool.38.1589903029084;
 Tue, 19 May 2020 08:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <1589869525-29893-1-git-send-email-guohanjun@huawei.com> <1589869525-29893-2-git-send-email-guohanjun@huawei.com>
In-Reply-To: <1589869525-29893-2-git-send-email-guohanjun@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 May 2020 17:43:37 +0200
Message-ID: <CAJZ5v0g=TvPE5K5Xumk+0OcZ2xmS+d9fsSHE-JQv=7OdHCM1jg@mail.gmail.com>
Subject: Re: [PATCH 1/6] cpuidle: sysfs: Fix the overlap for showing available governors
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 19, 2020 at 8:32 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> When showing the available governors, it's "%s " in scnprintf(),
> not "%s", so if the governor name has 15 characters, it will
> overlap with the later one, fix it by adding one more for the
> size.
>
> While we are at it, fix the minor coding style issue and remove
> the "/sizeof(char)" since sizeof(char) always equals 1.
>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> Reviewed-by: Doug Smythies <dsmythies@telus.net>
> Tested-by: Doug Smythies <dsmythies@telus.net>

All patches in this series applied as 5.8 material, thanks!
