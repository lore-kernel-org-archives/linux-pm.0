Return-Path: <SRS0=+XkI=CE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4AAC433E1
	for <linux-pm@archiver.kernel.org>; Wed, 26 Aug 2020 16:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15469206FA
	for <linux-pm@archiver.kernel.org>; Wed, 26 Aug 2020 16:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598460250;
	bh=dfYr6CYWgQj98xVxl8Q5x5xGHRsKSNMhee+sMqhJkwY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BxpFX5zIMIiK4ZOZ8M2aQ3o64mpe92DZM9yz7zfT8IIvhsLAcRTFkTyNuO0MwhJFU
	 BU0i4yyAj12JBtH0tL6ZbFY4Xc1z3Y7pYs4fl41gbVIdqGBgenUPtWLMvB1Yoh6oTj
	 W5i2Q1qLyZ3WmuumFGelxW1P9wnTaYYcKkwolUho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgHZQoH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:44:07 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37432 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgHZQoE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 12:44:04 -0400
Received: by mail-ot1-f68.google.com with SMTP id k2so2036621ots.4;
        Wed, 26 Aug 2020 09:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jH4wibIHuCcEwllO6DgrXF/htZORsEMet+armapO0n0=;
        b=mJz0ibDAzHUK5eOzee7cy9gJNm/wZbWf3Tse5wx0FUeIma8PLLVQymxWvE2ZpNSR65
         APMnHye9F1nDw8omv7M/Ei9Nt//puJEDDnxXdEwr4L40RjbjU/qcx/IbG+fCKHI3UmqK
         9xBJ6u7KsKdO1rQ9/vuZ7RZMI4MYPBU38pID2ucqP78BWInx8hdeBCvXp1sXOUfwOPh+
         iOBpvN4JcsjwiSvL57GuzXatQYkSNS7kMi+s9xc/5mNTnbBtkDAzIY0eZmuV0pfqlwFj
         EM+4eXKXacDOMZIBisFhB3/0GaoCTgNET+naR5xXivtwIDtoUmT1QP6rhNopPuvozu1D
         V08g==
X-Gm-Message-State: AOAM531+rT9YWOY1Uhh73NObLxsXel3zhgIkuLQkhBdTglZUBXpIlh6I
        uvrSvwk3cJHA/FJ3jfq5A9gylHTsRo2sCVEVAEI=
X-Google-Smtp-Source: ABdhPJz5xiffM35sGX3JT3AaPNyDW+xPveZU3bIPUBQ9aDyDpJEp5TWnii7aoLt8i3odYg6WgzZj4iL5bRKsHms97C4=
X-Received: by 2002:a9d:5c06:: with SMTP id o6mr10542989otk.262.1598460243163;
 Wed, 26 Aug 2020 09:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200826120421.44356-1-guilhem@barpilot.io> <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
 <CAGX5Wg2OOgY6d1RH514Kh9D6b+siga+jzH7qubcmE+ukq+6KKA@mail.gmail.com>
 <d0ca671465e6ce72c6c4d5178440ebc1e4814da8.camel@gmail.com>
 <e82c121057c4496238d3de7f7c919b7039d23b7c.camel@gmail.com>
 <CAGX5Wg0LrzPwf=2pGrQHAbFMVkOoYDxOoFa+ZmLBYshPvZQUXg@mail.gmail.com>
 <8fa7622dacc03f2fbd67e810f53389e3ede544e8.camel@intel.com>
 <CAGX5Wg0=K5AaTut5KH3R3+oasM5MM7PaJ9Z_L56xSNckMbWC9g@mail.gmail.com>
 <CAJZ5v0j4FXH26rZCjM9Csd56skPVbRpM7iFcKYAFMmLFX54+bg@mail.gmail.com> <e9e6823d63fe2b9938e43a14c136b89aec0c503b.camel@gmail.com>
In-Reply-To: <e9e6823d63fe2b9938e43a14c136b89aec0c503b.camel@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Aug 2020 18:43:52 +0200
Message-ID: <CAJZ5v0gPY+7YBeWwszoNBwsbKLFOEeuLaekdX62_gvbHXB8xoA@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Guilhem Lettron <guilhem@barpilot.io>,
        Zhang Rui <rui.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 26, 2020 at 6:39 PM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> On Wed, 2020-08-26 at 18:02 +0200, Rafael J. Wysocki wrote:
> > To that end, I would try to upgrade the graphics firmware and see if
> > you can get some nonzero PC8 residency then.
>
> I am curious, somehow that patch makes a difference.

It does make a difference, because it makes the processor spend more
time in PC2.  Which very well may be because the processor cannot
enter deeper C-states.
