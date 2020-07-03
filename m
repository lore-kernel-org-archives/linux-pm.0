Return-Path: <SRS0=AobL=AO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F89CC433DF
	for <linux-pm@archiver.kernel.org>; Fri,  3 Jul 2020 14:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14018206BE
	for <linux-pm@archiver.kernel.org>; Fri,  3 Jul 2020 14:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593787820;
	bh=hQcrcb6p0HvbYrZ4PlEgUIsgF+hR83rMKe+F1n/8Lx4=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=SNw+VffKWjj55RY7fAto/IxKK/fn8PlhJRkU8p/z8kaSzBNza6bXRLTGxmXwRZ7TE
	 IrTGgqVBV12PXjbPPPAFrJNhGtmvzCydGfj86vv+AmkXG80LDKGh/kvK3734uTH1T8
	 08F2AEGl9U9ZzqaX9LcN4qAqq7Zw1b30BBs1bflw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgGCOuP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:50:15 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45801 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgGCOuM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2020 10:50:12 -0400
Received: by mail-ot1-f68.google.com with SMTP id h1so4681915otq.12;
        Fri, 03 Jul 2020 07:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vwkx7XgRaSUqdSbDPu09J5cnSNZxI1HAY90VoPthaf4=;
        b=XdKpbMmVWMgH05Sd6roUcZw42QyLN5IB46AiMA10E27M8icNqfpn2+R+IjBO057rks
         GoDjwGolxZ7P2CF6iND9TweOSMF7oIlIEjhAqjxSdTCVYFtXmP8cb+EiskCfRdpZLZT8
         2Ex+orq1tc8M/ORw7ycbfwJIY1+VeqVkkGsvcwEPvLCTBgxwAQr5jZdWCKF43aFuUA8+
         gi0fMUWdAQQoOVauh/Dj+iWhq2yf0tXAs1wWUK9+L6glggqquHTTnpqOng4l0i3DE7V/
         xj1lLi0nxczCC0pE7uAC2zRYheEyaXAIlM5sUjdjmQTWvDgEEXx+SPCd1JRwdPBptUgx
         Hplw==
X-Gm-Message-State: AOAM530VfB/JWrBq8qTH77eiVoeg0MGdlndou649odNKvWelwP8hfJq9
        1Skhunwe1obEyvGDGLl/hYXXCePkSkzr1ku+YrE4BbRS
X-Google-Smtp-Source: ABdhPJzSdT2tYATsIKze58HiO5B8tkM/ruu2s9oCskwKqJcSphj4R7zDTUGzesBgVA6w9B0GlNvGeGAM3D7scSJ1Dz0=
X-Received: by 2002:a9d:39f5:: with SMTP id y108mr31862558otb.262.1593787811768;
 Fri, 03 Jul 2020 07:50:11 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Jul 2020 16:50:01 +0200
Message-ID: <CAJZ5v0i=ovJcb+0PkVj=_RR4FaUVgSiR4ON0ay1RvOk7t8UUZg@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.8-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.8-rc4

with top-most commit ef0c44c3e51ba051c500620685ee0b476ef2cbdf

 Merge branch 'acpi-fan'

on top of commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68

 Linux 5.8-rc3

to receive ACPI updates for 5.8-rc4.

These add a new device ID for Intel Tiger Lake to the DPTF battery
participant driver (Srinivas Pandruvada) and fix the Tiger Lake fan
device ID (Sumeet Pawnikar).

Thanks!


---------------

Srinivas Pandruvada (1):
      ACPI: DPTF: Add battery participant for TigerLake

Sumeet Pawnikar (1):
      ACPI: fan: Fix Tiger Lake ACPI device ID

---------------

 drivers/acpi/dptf/dptf_power.c | 1 +
 drivers/acpi/fan.c             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
