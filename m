Return-Path: <SRS0=NsZF=A7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF6BC433E1
	for <linux-pm@archiver.kernel.org>; Mon, 20 Jul 2020 08:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 664E621775
	for <linux-pm@archiver.kernel.org>; Mon, 20 Jul 2020 08:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="u7nt3GoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgGTI2P (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTI2O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2020 04:28:14 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D63C061794;
        Mon, 20 Jul 2020 01:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O6HfgQ+/4qiZLGt2UojtUQ3Ga/x/jgpuR6s1a87yytM=; b=u7nt3GoCT7WBM27aXRtZnWNUD
        bXmH223IdV7epuWwcz8hui1tkCQJvtfRu5hvQZkEMVcZmE60DFtMY8VD0hNJF0UubpeKhjIsXV0KV
        wQml0xJTy9YZPIFESQKbMFRQY60X5KxoYD+m9vVq/30t4DlNFeJ74X0DZFJ31zENrDfg0+5XChBMX
        87NF0WKQXOkI7CpKZnM+RFs8y8HtoYgi00zTMK9U3om7Pv5aPxBmcCtvotb9ASctJZcL52BbW6iaN
        ag23tbDPGsTcJCtj6GmQypV1xEXZSJxh7N56EzdK+u3BZNeqU0YuZqMpVsbmrfqihoSQCkOba0Wvx
        SXgUBjiBg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41816)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jxR9b-0002m6-AD; Mon, 20 Jul 2020 09:28:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jxR9X-0004pY-Ga; Mon, 20 Jul 2020 09:28:03 +0100
Date:   Mon, 20 Jul 2020 09:28:03 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Ondrej Jirman <megous@megous.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "open list:ALLWINNER THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-sunxi@googlegroups.com, Zhang Rui <rui.zhang@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] thermal: sun8i: Be loud when probe fails
Message-ID: <20200720082803.GS1551@shell.armlinux.org.uk>
References: <20200708105527.868987-1-megous@megous.com>
 <20200708110301.GB1551@shell.armlinux.org.uk>
 <86689f81367716e3f88ec363edd0d302deca0a1f.camel@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86689f81367716e3f88ec363edd0d302deca0a1f.camel@aosc.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 20, 2020 at 03:55:26PM +0800, Icenowy Zheng wrote:
> 在 2020-07-08星期三的 12:03 +0100，Russell King - ARM Linux admin写道：
> > On Wed, Jul 08, 2020 at 12:55:27PM +0200, Ondrej Jirman wrote:
> > > I noticed several mobile Linux distributions failing to enable the
> > > thermal regulation correctly, because the kernel is silent
> > > when thermal driver fails to probe. Add enough error reporting
> > > to debug issues and warn users in case thermal sensor is failing
> > > to probe.
> > > 
> > > Failing to notify users means, that SoC can easily overheat under
> > > load.
> > > 
> > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > > ---
> > >  drivers/thermal/sun8i_thermal.c | 55 ++++++++++++++++++++++++++---
> > > ----
> > >  1 file changed, 43 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/thermal/sun8i_thermal.c
> > > b/drivers/thermal/sun8i_thermal.c
> > > index 74d73be16496..9065e79ae743 100644
> > > --- a/drivers/thermal/sun8i_thermal.c
> > > +++ b/drivers/thermal/sun8i_thermal.c
> > > @@ -287,8 +287,12 @@ static int sun8i_ths_calibrate(struct
> > > ths_device *tmdev)
> > >  
> > >  	calcell = devm_nvmem_cell_get(dev, "calibration");
> > >  	if (IS_ERR(calcell)) {
> > > +		dev_err(dev, "Failed to get calibration nvmem cell
> > > (%ld)\n",
> > > +			PTR_ERR(calcell));
> > 
> > Consider using:
> > 
> > 		dev_err(dev, "Failed to get calibration nvmem cell
> > (%pe)\n",
> > 			calcell);
> > 
> > which means the kernel can print the symbolic errno value.
> 
> Oh interesting format here.
> 
> When we need to deal with a int return value, is it "%e"?

No, because that will lose the ability for the compiler to check the
format string and arguments correspond.  All the extensions are
documented at Documentation/core-api/printk-formats.rst.

Use %pe and ERR_PTR(...) to print an integer -ve errno return value.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
