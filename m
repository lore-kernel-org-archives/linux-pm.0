Return-Path: <SRS0=6fVe=56=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B69FC2BA19
	for <linux-pm@archiver.kernel.org>; Tue, 14 Apr 2020 17:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8717920767
	for <linux-pm@archiver.kernel.org>; Tue, 14 Apr 2020 17:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502547AbgDNRpY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:45:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:52370 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502535AbgDNRpW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Apr 2020 13:45:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5EF96AAFD;
        Tue, 14 Apr 2020 17:45:19 +0000 (UTC)
Date:   Tue, 14 Apr 2020 19:45:19 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Ion Badulescu <ionut@badula.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org, Pensando Drivers <drivers@pensando.io>,
        Sebastian Reichel <sre@kernel.org>,
        Shannon Nelson <snelson@pensando.io>,
        Veaceslav Falico <vfalico@gmail.com>
Subject: Re: [PATCH net-next 1/4] drivers: Remove inclusion of vermagic header
Message-ID: <20200414174519.GJ31763@zn.tnic>
References: <20200414155732.1236944-1-leon@kernel.org>
 <20200414155732.1236944-2-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200414155732.1236944-2-leon@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 14, 2020 at 06:57:29PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Get rid of linux/vermagic.h includes, so that MODULE_ARCH_VERMAGIC from
> the arch header arch/x86/include/asm/module.h won't be redefined.
> 
>   In file included from ./include/linux/module.h:30,
>                    from drivers/net/ethernet/3com/3c515.c:56:
>   ./arch/x86/include/asm/module.h:73: warning: "MODULE_ARCH_VERMAGIC"
> redefined
>      73 | # define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY
>         |
>   In file included from drivers/net/ethernet/3com/3c515.c:25:
>   ./include/linux/vermagic.h:28: note: this is the location of the
> previous definition
>      28 | #define MODULE_ARCH_VERMAGIC ""
>         |
> 
> Fixes: 6bba2e89a88c ("net/3com: Delete driver and module versions from 3com drivers")
> Signed-off-by: Borislav Petkov <bp@suse.de>

Co-developed-by: Borislav Petkov <bp@suse.de>

> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/net/bonding/bonding_priv.h               | 2 +-
>  drivers/net/ethernet/3com/3c509.c                | 1 -
>  drivers/net/ethernet/3com/3c515.c                | 1 -
>  drivers/net/ethernet/adaptec/starfire.c          | 1 -
>  drivers/net/ethernet/pensando/ionic/ionic_main.c | 2 +-
>  drivers/power/supply/test_power.c                | 2 +-
>  net/ethtool/ioctl.c                              | 3 +--
>  7 files changed, 4 insertions(+), 8 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
