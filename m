Return-Path: <SRS0=lp1B=ZX=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66984C432C0
	for <linux-pm@archiver.kernel.org>; Sun,  1 Dec 2019 19:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2CF2082E
	for <linux-pm@archiver.kernel.org>; Sun,  1 Dec 2019 19:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575230113;
	bh=GVnqatJjkI2d785STQM/Hp3Qg4fwIew62MDkFU1VYf8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Lfz9BFMr3d5RB3a6oWg3a9kmLVhcmgyKzgvQ7/2j90xojWg/z8NFNbhFXrcWnSuEN
	 vaSV+ZwAgcAvFHSuHXNTb1LBb3vOdgvbS88eNKvDoO6n3KEF4K/k+zP+spK332Fxj3
	 r6/TJN8qPir45It8tHWuQ915KOUgG+LWWAUcBz3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfLATzK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 1 Dec 2019 14:55:10 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42521 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfLATzK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Dec 2019 14:55:10 -0500
Received: by mail-oi1-f194.google.com with SMTP id j22so113861oij.9;
        Sun, 01 Dec 2019 11:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVnqatJjkI2d785STQM/Hp3Qg4fwIew62MDkFU1VYf8=;
        b=U3EYuS1dxNyqC6fvDfyJSmYGUhKM+qULTL6KGwTzYw2vpowLgnslT2YQattbTQSvYh
         Umu5OIVLuvmjJYGVhA5V1t35308+3Znj/yS0xk/DomYLPD4Imh5rdqWpzZP4vWwudULj
         vQeBM1/KASYzJgMxDwBJeWN1LtDodhViXHC1gvfevDEhfo406hZHMJFGG2UmNnLnwF0n
         EpRV/YX4spdUf7OYJTHUICl3OP1xZp5T31updUm9NmWNkvyq1uMyr2swqghWOQwHutha
         EzWkt8r6BwprG1SUbmQ5LY9QuPPEajJQdQy2KnoPL4d9nozkSXKLYv7n4Tmht9Y98qiB
         e4hg==
X-Gm-Message-State: APjAAAWzGA+u8F+3w8ywfj/Cb38kW5vLV/pUtNGT/LeNHNyj/7a7O7eW
        veSzXLV9jwNxUZkA4JE4GS/lQ4KtsoZs7Qpy447DIA==
X-Google-Smtp-Source: APXvYqxYLEKiaOGbRHJtdfln7+8FKWBYWG4GovfMLAoWPyghhvhXxos1xzBDaToO1KvOAi52s9rIRcX4BB+nubxdKaU=
X-Received: by 2002:a54:488d:: with SMTP id r13mr8948358oic.115.1575230109255;
 Sun, 01 Dec 2019 11:55:09 -0800 (PST)
MIME-Version: 1.0
References: <2787005.CsmIKtZlk9@kreacher> <alpine.DEB.2.21.1911291231510.6038@hp-x360n>
In-Reply-To: <alpine.DEB.2.21.1911291231510.6038@hp-x360n>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 1 Dec 2019 20:54:54 +0100
Message-ID: <CAJZ5v0hiSnjZ=ZuSqDsQK6CDxyFRMhUVWL+UP-QJoj9vkLo2vg@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI: PM: s2idle: Fix possible suspend lock-up
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 29, 2019 at 9:35 PM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> On Thu, 28 Nov 2019, Rafael J. Wysocki wrote:
>
> > Please test this series and let me know if it works for you too.
>
> I've tested this quite a few times against the issues reported on the Linux-PM
> mailing list ("resume failures if the charger is plugged in while suspended
> and the battery is at < 90%" and "spurious wakeups from the EC for non-power
> events") and this patchset has fixed both of these issues (the latter is
> especially surprising and welcome).
>
> I'm pretty happy with it; it's been a while since I've had a consistently
> cold laptop while suspended. Much thanks!

Thanks a lot for the testing and feedback, much appreciated!

I'll queue up this series for the next PM pull request.
