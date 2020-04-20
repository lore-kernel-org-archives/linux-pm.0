Return-Path: <SRS0=NFLV=6E=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7ABC3A5A0
	for <linux-pm@archiver.kernel.org>; Mon, 20 Apr 2020 17:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5553120CC7
	for <linux-pm@archiver.kernel.org>; Mon, 20 Apr 2020 17:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587403409;
	bh=DI88VDkhxPMO6/QoP8n3nDMfyH/KSc6tfIYnzyvZA3s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YPSY6j9UzCghu5ymyScTocHPFNBj7GaF+YXsaeOoRBmwWKmzC0qch4JFsHfcIoDXC
	 rz3WlGd8KjbXunogpO5R/PxJarCiWnBLB5iZo4tRqG3dajOTaNWabRl8dMBDcmUFw6
	 JaTbz1PvyfX7zAon1QBfX0ij0XZoT3XoEv+1TLFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgDTRX2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:23:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbgDTRX2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Apr 2020 13:23:28 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3A5D21D79;
        Mon, 20 Apr 2020 17:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587403407;
        bh=DI88VDkhxPMO6/QoP8n3nDMfyH/KSc6tfIYnzyvZA3s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RP30BYvqxyB56UNbQoslKq2mY+Nvy5MbTO6mLFf4vjs9LFwj0rznHIuN7ETT2Uiv+
         G/G1IcS/as/T8h8JfI8gxzEqZWzDveiKtVBuW3hAgdNjrIrMozgfyqHpUM/mi1doDT
         qcq31+w/4NEezQpVUVSmTObJurJ0cD1/ykj5qavA=
Received: by mail-qk1-f177.google.com with SMTP id v7so11553851qkc.0;
        Mon, 20 Apr 2020 10:23:27 -0700 (PDT)
X-Gm-Message-State: AGi0PuYJXXSGXdMAX2vRkSqRvV2RK8j/00s0YrQKP6NeJyL7eeWt0GPZ
        dOUiME0kk4WuFySDNLanWQvKm0sKX8qKvAF8VQ==
X-Google-Smtp-Source: APiQypKHdn+KVCIskUEoQxaMBsi+u+k4KDRvBbLImg2XBjqZjn3n0++TU7x+18KzMjSkNRtotrBw2UAfk+eYU9mXBpw=
X-Received: by 2002:a37:61cd:: with SMTP id v196mr17255124qkb.393.1587403406913;
 Mon, 20 Apr 2020 10:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200419170810.5738-1-robh@kernel.org> <20200419170810.5738-5-robh@kernel.org>
 <CAK8P3a2BZLti5pLrru8s-45Yz54SA0JZbyjvYEstSDJZfnzEmA@mail.gmail.com>
In-Reply-To: <CAK8P3a2BZLti5pLrru8s-45Yz54SA0JZbyjvYEstSDJZfnzEmA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 20 Apr 2020 12:23:13 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Hk_WuK=c+eHi1Kz3EPzm=zOw2ctETXEySPH1WgAGjug@mail.gmail.com>
Message-ID: <CAL_Jsq+Hk_WuK=c+eHi1Kz3EPzm=zOw2ctETXEySPH1WgAGjug@mail.gmail.com>
Subject: Re: [PATCH 04/17] power/reset: vexpress: Support building as a module
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 20, 2020 at 10:24 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Apr 19, 2020 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
> >
> > Enable building the VExpress power-off/reset driver as a module.
>
> Your change allows loading and unloading the driver, but actually
> unloading is a bug with the current implementation, as there is no
> 'release' handler to undo the _vexpress_register_restart_handler()
> function.

And also to save and restore pm_power_off...

> It should not be hard to add a release handler, or you could just
> mark the function as non-unloadable by only having a module_init()
> but no module_exit() function.
>
> I suppose if you do the latter, there should also be a suppress_bind_attrs
> flag in the device_driver. This is a preexisting bug.

I may just drop this patch. I wrote it and then realized I don't need
it as PSCI can be used instead.

Rob
