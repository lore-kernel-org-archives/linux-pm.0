Return-Path: <SRS0=TlO+=ST=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F90FC10F12
	for <linux-pm@archiver.kernel.org>; Wed, 17 Apr 2019 08:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AAF206BA
	for <linux-pm@archiver.kernel.org>; Wed, 17 Apr 2019 08:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555488619;
	bh=xaieY8dMDnLZzpUHs5v1AnT0u/QapT859qoM0X/D150=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Wqg94HBRzj675C4dpX2hCPxa+/yVFI3EKr5t2rFcHCJO/iNimkxpdluBlocw1Hp7m
	 tP46ChfYTfDMjmRRFf+lC7R9TaXGdI2507Snys9j+SFFkg7+m5CNDiWid5DUDDseR0
	 tNmmAMWVYLmGKSiZSfvRqRfESPoye0JxF6dJ/xVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfDQIKS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:10:18 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44809 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfDQIKS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Apr 2019 04:10:18 -0400
Received: by mail-oi1-f194.google.com with SMTP id i21so19277689oib.11
        for <linux-pm@vger.kernel.org>; Wed, 17 Apr 2019 01:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDEs/ebP4VYGVSfGLna/Th9mVUC8R5W0EiTtsocZWPo=;
        b=Ne58ZfNUhZktSxOjJ2PQQD2/rslAPZEJBHg2WIkpF9xbA9W/4B8eHcG/Y/3F2CyboU
         2YG240RtCnIi2cgPGZUj9HOIIUCKw+wbWr8liMzYEMHtdeX9a2HfMBMjxhlD4wXaVMed
         x82dTdcJMxXyW3x08a39UliQouAf0berj7byU6WqZnqaww+Hhrd2gFNK9eVebnQRN/9i
         vLbGrshEYjk7itQ6UXaQ+Z6js+yB62VpD2YDkDmZFJp96r8RSWlVt1Lnt8alUR8O67XC
         SnAaUKP8q52e5JyLTQwjm3dZS+2Lr1tz9O9wcQMYe7tenDAYUNnf2RqwoaWGrAIFw2Wn
         L/yA==
X-Gm-Message-State: APjAAAVul9xOkNqfCefvHomJ/6ct6AIY7w+eoRDz11j9QgpfoATgA9Oo
        aTPM6dI9t9N+CwPodfhu9krP9bS4IPRvF0WDoRo=
X-Google-Smtp-Source: APXvYqz4aViU/4IoF3zZaf8zCzfMZZNPjsN/tULroZSikG+WzFa0blqT4ZGq1elK/asJtD9y2i5ZDW4CeDOdD9hrNDw=
X-Received: by 2002:aca:6c47:: with SMTP id h68mr28217857oic.57.1555488617606;
 Wed, 17 Apr 2019 01:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190417022610epcms1p620ea173956cd58582ab4ceb47c55e4db@epcms1p6>
 <20190417022610epcms1p620ea173956cd58582ab4ceb47c55e4db@epcms1p6>
In-Reply-To: <20190417022610epcms1p620ea173956cd58582ab4ceb47c55e4db@epcms1p6>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 Apr 2019 10:10:05 +0200
Message-ID: <CAJZ5v0h+P0PNDma4NH6SnLy17U1qb9opOm5ZwJVAXNWWOfs5Vw@mail.gmail.com>
Subject: Re: [Pull Request] for Rafael, Linux-PM, from devfreq.
To:     Myungjoo Ham <myungjoo.ham@samsung.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "skannan@codeaurora.org" <skannan@codeaurora.org>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 17, 2019 at 4:26 AM MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>
> Dear Rafael,
>
> Here goes a pull-request for next / Linux-PM.
>
>
> Cheers,
> MyungJoo
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> The following changes since commit dc4060a5dc2557e6b5aa813bf5b73677299d62d2:
>
>   Linux 5.1-rc5 (2019-04-14 15:17:41 -0700)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git for-next
>
> for you to fetch changes up to cf451adfa392bd9ba36f31659dbe6a5010b46ef9:
>
>   PM / devfreq: add tracing for scheduling work (2019-04-16 09:29:18 +0900)

Pulled, thanks!

That said, next time can you please provide a high-level brief
description of what's being changed, so I can add it to my merge?

Cheers,
Rafael
