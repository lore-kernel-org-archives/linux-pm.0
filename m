Return-Path: <SRS0=2C7a=TB=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864D6C43219
	for <linux-pm@archiver.kernel.org>; Wed,  1 May 2019 08:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C20721734
	for <linux-pm@archiver.kernel.org>; Wed,  1 May 2019 08:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556699972;
	bh=hsL6LTXn/4787Cieov8fFQD8yF7YnmKHX2pZJWiOiGE=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=ZZHhD9NtRGDCvsCEVvTsC6rMenNfYRNy0HhLtmsiL8HDKnDAekOO7m9NWCqZVblq5
	 JWhLd2dXKUNjPCaw7/RX6GnY+zPHUtwV7UcRE8L0PEWLdrgwb00J6VvwGU5oIQy5zs
	 4CHJGAbU//XcPCCJGf1NcYTU0HhEdYA1eZ8JEsKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfEAIjb (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 1 May 2019 04:39:31 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39409 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfEAIjb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 04:39:31 -0400
Received: by mail-oi1-f196.google.com with SMTP id n187so13379533oih.6;
        Wed, 01 May 2019 01:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8LW2GhzSCuZKTF5GZRiwaIj0ovgzsQ1pCVkKzVY4yMY=;
        b=lO1wGanIlG6VaeqZLFDO/b6cWLmAHpd2nGsmm6Jnnak9lsIZijTA8U8I9Fmqu8/iY4
         y528p80pKNOsFx85lYDCUJOUu73Ky1ocsBBn/P49noTCufRars7b+qgZGog5xkDvPp/w
         ZOL9HdzzvjAkFS5vunY3hu48eu6PKhWAhBWuXTPHui9y51nCu+VQUrHGa3ELOQb4Dv90
         9ITpIbc2cqYJWzIVk3DQOpjeob7xPb1bdGaCSECtCcVUluAu51xv04hQeEicnR4qe2l8
         xfS9+DzT1MuwSqKuv1iL0eDWZ8hdY84BFmIGDSvW9kd/b0cwPOUoZjB+q8YEnTes8O1f
         Tkuw==
X-Gm-Message-State: APjAAAV73UFUMuR0DhoePgRPegm1P8fqkpX53+dxcYHHMc1YhEIIyLqw
        pnEqpjFrY/1V5w/eITPGNnvX2dAcKzF0uKhPlL9JoDUi
X-Google-Smtp-Source: APXvYqwB3CY8o7/otJ306S5xVVYxPA2bfkoDWPHdOGqpRorGe2vrXXRZ1LYrHjOAPHcqL/M+FC5P9HaGcMXgFj3EVhg=
X-Received: by 2002:aca:5304:: with SMTP id h4mr5666284oib.115.1556699970277;
 Wed, 01 May 2019 01:39:30 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 May 2019 10:39:19 +0200
Message-ID:
 <CAJZ5v0i73At_cTv2FJEgSzcqnWUuVnDY-cyX5XWDGFw1f9fnQA@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.1-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190501083919.LKi2DsG-AjHKhrT3HHANySVHa_cP8SwsZ9wUBZc5Ksk@z>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.1-rc8

with top-most commit 2c2a2fb1e2a9256714338875bede6b7cbd4b9542

 Revert "ACPICA: Clear status of GPEs before enabling them"

on top of commit 37624b58542fb9f2d9a70e6ea006ef8a5f66c30b

 Linux 5.1-rc7

to receive an ACPI fix for 5.1-rc8 (or final 5.1).

This reverts a recent ACPICA change that caused initialization to
fail on systems with Thunderbolt docking stations connected at the
init time.

Thanks!


---------------

Rafael J. Wysocki (1):
      Revert "ACPICA: Clear status of GPEs before enabling them"

---------------

 drivers/acpi/acpica/evgpe.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)
