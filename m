Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899C2C433FE
	for <linux-pm@archiver.kernel.org>; Mon, 20 Sep 2021 11:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7438D60F56
	for <linux-pm@archiver.kernel.org>; Mon, 20 Sep 2021 11:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhITLyG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 20 Sep 2021 07:54:06 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49940 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhITLyF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Sep 2021 07:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=yGE8gpbmE7JEaUwJzRYJcDw6OeJj0fv2qAbkqApHilU=; b=v8ypol8CHDW+nq/kmj6lcE3eP5
        IqSiooPJCsz5hzR9c7OrsObf4jclmAW9+rLtNr1Vea8nQaCEyfoXMLkfYzfDIRsjpQuNpP8n5IxjF
        ba4WqRbR9MAKoZxT66EtLc569vI/AV0bbLjbyhC1iIzVgQ92D1F9StzFQOYn+ANSfxPo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mSHqA-007UX0-Ba; Mon, 20 Sep 2021 13:52:06 +0200
Date:   Mon, 20 Sep 2021 13:52:06 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     davem@davemloft.net, kuba@kernel.org, robh+dt@kernel.org,
        linux@armlinux.org.uk, f.fainelli@gmail.com,
        alexandre.belloni@bootlin.com, vladimir.oltean@nxp.com,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH net-next 01/12] net: mdio: mscc-miim: Fix the mdio
 controller
Message-ID: <YUh15ieAzBiCVeX9@lunn.ch>
References: <20210920095218.1108151-1-horatiu.vultur@microchip.com>
 <20210920095218.1108151-2-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920095218.1108151-2-horatiu.vultur@microchip.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 20, 2021 at 11:52:07AM +0200, Horatiu Vultur wrote:
> According to the documentation the second resource is optional. But the
> blamed commit ignores that and if the resource is not there it just
> fails.
> 
> This patch reverts that to still allow the second resource to be
> optional because other SoC have the some MDIO controller and doesn't
> need to second resource.
> 
> Fixes: 672a1c394950 ("net: mdio: mscc-miim: Make use of the helper function devm_platform_ioremap_resource()")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Hi Moratiu

The script kiddies might come long and 'fix' this again. Maybe
consider adding devm_platform_ioremap_resource_optional(), following
the pattern of other _optional() API calls. Otherwise add a comment.

    Andrew
