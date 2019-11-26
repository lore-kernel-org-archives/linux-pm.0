Return-Path: <SRS0=zVwF=ZS=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141D4C432C0
	for <linux-pm@archiver.kernel.org>; Tue, 26 Nov 2019 08:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53BC2073F
	for <linux-pm@archiver.kernel.org>; Tue, 26 Nov 2019 08:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574758401;
	bh=NZ9Zl70lsRuy5iGVUqC+aRmOLAAb4b0Vu/uNTNM53c4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Hn1RJZBAQ3QAauilVnTXCMU7hr75bawDXGLe694Rik7JeRMcuqV3DTvQcLbe1kns+
	 gg2k5VssF4BBa9w//YBDfV/vKmk+hsuCrAc4Ly5az3jnztpeiopKFBFlG+6JQtsyfS
	 ibqj8pFBtEFAngmn7dt6WXfmIyk51GW1HtKFUiyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfKZIxV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 26 Nov 2019 03:53:21 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34117 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfKZIxV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 03:53:21 -0500
Received: by mail-ot1-f41.google.com with SMTP id w11so15263383ote.1
        for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2019 00:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rw9+gyqErWSLTebO4ZzDN4mr4arZyAWG8jOO1fQiDjg=;
        b=ey2d9dVyKwqT/AkIUiC277u/5+CP1V5wN6+AUmiYbD/m7HuxL/3se3RwYDYwMQlIi0
         a/RrtbeUVnjXt5xkMQKPyhzUEjpo+UGW8a3VIdSDGFmSa3hgOsyBSKRnF3LPXVwl0iq2
         W9AnrbP9XsXimwBG/6y3hujpY1jNC3vuxqzXA8ogQTE0wJuaei540TiIRqasMNy/0qer
         bqcNta80cUcwsjP5Jp3hOCZxg1IWqBQoXMD1bpAo0Keo1T3kJ/fGZwmpia0xaB0lQeLi
         k7ucXyb6Jnf0qbcsdtrvKjn19a1igM8hiKJtGXpONmkFQJhXOd35bOMJ3iTDv3h66p+v
         kASA==
X-Gm-Message-State: APjAAAWoH/ryNauQrSOp/tPGoN9c/qI9GaNoJfVU7e+jEBOjnSiW3G2/
        hNS++VcYg7Q+96+8AvaK7tuuHSAqqFkUZ+M9j5I=
X-Google-Smtp-Source: APXvYqwSd46o1FS7PgF2nROZ+fdaumjnvJ+aiBF5Iw/xZPoKAybr6Z2RgyN6dtTeFevSHXa5XMjtx8gUXnjLH+WFIY0=
X-Received: by 2002:a9d:7483:: with SMTP id t3mr1589250otk.262.1574758400090;
 Tue, 26 Nov 2019 00:53:20 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <CAJZ5v0jQ3RY8An+V2VYH+ZKLC6=HrCYUMomM6jyEXJ47aeLT+A@mail.gmail.com>
 <CAJZ5v0gKvDb8=Y04DB3wQe0rK8Zfw5yNuAybV980ozxfmem=BQ@mail.gmail.com>
 <alpine.DEB.2.21.1911230213510.2531@hp-x360n> <CAJZ5v0i2oC-w1RJ2X35fYyHdysorjLRYs-OBn+y_r6ksEZzVtg@mail.gmail.com>
 <alpine.DEB.2.21.1911241929220.16116@hp-x360n> <CAJZ5v0ichG5N+yLyyX1BZhNf+Fk_xrvQ+9q4FeP3XVtxKp7yug@mail.gmail.com>
 <alpine.DEB.2.21.1911250812070.3858@hp-x360n> <CAJZ5v0hFjW-MG5Jxqx7maC0OH9XzrAPEVqzidQhTORTW5i1M1g@mail.gmail.com>
 <alpine.DEB.2.21.1911251501180.13123@hp-x360n>
In-Reply-To: <alpine.DEB.2.21.1911251501180.13123@hp-x360n>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Nov 2019 09:53:09 +0100
Message-ID: <CAJZ5v0i-wJEwK11Hx1_Q2XKsEZ35vkbhwz-JAQLtT+9gbHkTdw@mail.gmail.com>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep:
 Simplify suspend-to-idle control flow)
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 26, 2019 at 12:02 AM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> On Mon, 25 Nov 2019, Rafael J. Wysocki wrote:
>
> > So what exactly does happen when you try to suspend with
> > sleep_no_lps0?  Does it return to user space right away by itself
>
> Yeah. It's like it never suspends (or suspends quickly and comes right
> back; I didn't bother to look at the dmesg in those cases). I could find
> out if you wish, but- see my next E-mails.

It would be good to see how far it goes.

Please echo 1 to /sys/power/pm_debug_messages and send me a dmesg part
covering a suspend cycle with sleep_no_lps0 equal to 1.
