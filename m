Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F475C43334
	for <linux-pm@archiver.kernel.org>; Mon, 11 Jul 2022 10:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiGKKq2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 11 Jul 2022 06:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiGKKqC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jul 2022 06:46:02 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04135D59B;
        Mon, 11 Jul 2022 02:52:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 8A584E008C;
        Mon, 11 Jul 2022 02:52:15 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id H9ibHYm_PBeJ; Mon, 11 Jul 2022 02:52:14 -0700 (PDT)
Message-ID: <dda3847e74ddbcde86342210e44247973a24e5f6.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1657533134; bh=iLimf2jg+PrWCv8rSIAeBwdGcHhOvtI2YNGljf++jSo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=P/VgPJFzb1uFoAgpy92STrJj0cSHo9Cswi4+9iVaRkdzthFemZZaaJltiNeZtQWOP
         Bu7+gjypW9rpE3xCXPHd+bnqe0FDOWdtkfkiicAjkuQ/ll4ZM1VvzJ6+EYdyOHKZyh
         bcjzb4dSY1m3L1mHSHjGB8kd0QDuZHsj6ldRyfsxocPFN0Qq0BXrbdu0Nm0h4asfWv
         qjCHxjdhzUwlRjF1zOBjQjRfNgicAk+YxE9jQ2QXjsUj9fquvVkzKwIRCPs/14nLEo
         uxicwX624nUauMBMneWi5rQCPa/b+qplS5MTCzvNCCmlZ6Wfa4MnUdnRBn81QLhTns
         ZK7tvXWi4bTWQ==
Subject: Re: regulator: BD71837 PMIC resume during noirq phase?
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Mark Brown <broonie@kernel.org>
Cc:     matti.vaittinen@fi.rohmeurope.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Date:   Mon, 11 Jul 2022 11:52:10 +0200
In-Reply-To: <Yqhf7/3B0l9+3dQH@sirena.org.uk>
References: <573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm>
         <YqhSXuHMR6kuFu/A@sirena.org.uk>
         <8024d9e3b885941084740cb0fb2fc9117acdd069.camel@puri.sm>
         <Yqhf7/3B0l9+3dQH@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Dienstag, dem 14.06.2022 um 11:16 +0100 schrieb Mark Brown:
> On Tue, Jun 14, 2022 at 11:57:18AM +0200, Martin Kepplinger wrote:
> > Am Dienstag, dem 14.06.2022 um 10:18 +0100 schrieb Mark Brown:
> 
> > > Indeed - if a power domain is controlling regulators then I'd not
> > > expect
> > > things to go well if it tries to resume without interrupts, there
> > > will
> > > be some things that can be done purely with GPIOs but that's
> > > depending
> > > on the hardware having wired things up that way and the
> > > operations
> > > needed by the power domain mapping well onto what can be done
> > > with
> > > GPIOs.
> > 
> > and what's the danger when resuming power domains later?:
> 
> If there's a device that needs to early resume in a power domain that
> needs to do something on resume then presumably this will mess up the
> ordering.  You probably need a separate power domain type, or both
> operations.

hi Mark, the followup to this would be my first try to fix this:

https://lore.kernel.org/linux-arm-kernel/20220711094549.3445566-1-martin.kepplinger@puri.sm/T/#t

thank you for you help so far,

                             martin

