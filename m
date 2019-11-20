Return-Path: <SRS0=7Ybf=ZM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82072C432C0
	for <linux-pm@archiver.kernel.org>; Wed, 20 Nov 2019 22:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D03C20895
	for <linux-pm@archiver.kernel.org>; Wed, 20 Nov 2019 22:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574289419;
	bh=MsP73j/TCAPbETzY9SW4Mtnp/AMIF4lbUWWljggg9zc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JLZKdCnsXnx5q3hgC/Q86dsGen1Ow3yeW64npkv4XiOOFeUVeuGU39O4xltU4A0Xk
	 v5nIeeBHJPjNCJ+0q1UTk0sGsdErNjjeV66XiyPfOcvyfRlMWEgcNG68BDO8Kn0oHx
	 Wvom+jDJvihNiZ9wL8x1izdZzZ5hoT8Ixhld7zV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfKTWg6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 20 Nov 2019 17:36:58 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:44087 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKTWg6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 17:36:58 -0500
Received: by mail-ot1-f48.google.com with SMTP id c19so1093912otr.11
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 14:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=myHFRg//BXqxgupoupGLt3gspBxW093kvd1Tmwb1RVU=;
        b=nGB+w5AxkO+gMZ8bAUf8qXnRklJl8fCZDPihZK4PMJuUEiMjisDfdDM27Fe1L73ssG
         eHkUvpjZhFIGig0A6Zjv1hSZnG7c05+7p0JP+u6VU/zWuJUrz3VCQhSfZhu/bAj1o+8f
         kCGPrAMn+Kkj8dfLqZ5Q0Z/bgrUYrXVIs17PYdtZ5EOnrfHrrZJLENqgoagRfrc9q6bb
         qFREep/FXBAz7YSuAQ/4sGV9DxaMcZ5AdlphPDKlo8uxg42CbDP/PNxU5KH+LPf4MPQz
         2+LQkR8w29l1ibkWjj0r+358xHkxe4NLFMxH1M7XpmJCOdAULQFF2+SxV4HdWLr8vrF2
         bk0Q==
X-Gm-Message-State: APjAAAVGyAW+dac6xSjzIv7oiWdSHru+bid3VGEoTihmmSV6vXBx1le/
        6KOBEqGIewwGfAJ+Xp6mOmUlD682RPHH+2hrl7Q=
X-Google-Smtp-Source: APXvYqwxlg6kSCDhKNuJDdrURCGSot1SEgUubMtFnoUzkO4krIMh83hfp73CeIHdHwHoLqzzkg0XvbmlFcOLVwpSx7o=
X-Received: by 2002:a9d:4c85:: with SMTP id m5mr3826223otf.118.1574289418016;
 Wed, 20 Nov 2019 14:36:58 -0800 (PST)
MIME-Version: 1.0
References: <CADnq5_Mxj7b1=DNuCr-2OeWp_UTE8To4Bwgf2QFoEixg2tyGCg@mail.gmail.com>
In-Reply-To: <CADnq5_Mxj7b1=DNuCr-2OeWp_UTE8To4Bwgf2QFoEixg2tyGCg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Nov 2019 23:36:46 +0100
Message-ID: <CAJZ5v0gCFY5BoPiJiPp5oC2EDiGOXBDg+6rrB8sj47KRVEJ15g@mail.gmail.com>
Subject: Re: PEP driver for Linux
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 20, 2019 at 11:30 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Hi,
>
> I'm trying to understand how to hook in a platform specific driver to
> support S0ix on Linux.  Windows defines a platform PEP (power engine
> plugin) driver which the platform uses to coordinate the the low power
> state of the SoC.  I'm not entirely sure how this would work on Linux.
> My understanding is that the all devices go through their suspend
> routines and then this PEP driver is responsible for putting the SOC
> into it's lowest power state.  On a lot of platforms the PEP driver
> interacts with a platform specific ACPI method to tell the platform
> which devices are suspended.  I'm not really sure how this should be
> handled on Linux.

It is done already, through the PEP device _DSM (see suspend-to-idle
support in drivers/acpi/sleep.c).

Thanks!
