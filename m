Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD92C433F5
	for <linux-pm@archiver.kernel.org>; Mon, 20 Sep 2021 20:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526EF604DC
	for <linux-pm@archiver.kernel.org>; Mon, 20 Sep 2021 20:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhITUez (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 20 Sep 2021 16:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230038AbhITUcz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Sep 2021 16:32:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7039610A0;
        Mon, 20 Sep 2021 20:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632169888;
        bh=10ZL7PgHe9lbjtgAcJZmau9cDawPBD9XsDzRb/RyzN8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V+/6CwVtDaudm8b/th6Nq7PIALw6HsqHtIajFBJVNKHbPDxgfLzRcp3lL7NXBH7FG
         ZfIVcH8WEeQ+8fFj+T4ItZDL0Aerbwktyhe3LayI3SNOA9pAT9jdfVWQb4PPrtyXjU
         C135f2loKqstaEwB28AiE5xL5Tq2QDidS5WrEBq1u2fOY/ThaG6v9SRPRRouc5T11b
         rZLl5WpATkbnCLH6FlapL7Jb4r73M8dT5svcT0zlqqsKVsr93Gfbs7vn30IAqBxcWx
         DBSUbDivrQRVnjJU9UJ4+H7BSgDWC5mFy3iVvOf9Kv6HqpIldaLoEyICZp+JJRWXYL
         3kGBUVAaT4eLQ==
Date:   Mon, 20 Sep 2021 13:31:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     <davem@davemloft.net>, <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <linux@armlinux.org.uk>, <f.fainelli@gmail.com>,
        <alexandre.belloni@bootlin.com>, <vladimir.oltean@nxp.com>,
        <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: Re: [RFC PATCH net-next 12/12] net: lan966x: add ethtool
 configuration and statistics
Message-ID: <20210920133126.642449aa@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210920095218.1108151-13-horatiu.vultur@microchip.com>
References: <20210920095218.1108151-1-horatiu.vultur@microchip.com>
        <20210920095218.1108151-13-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 20 Sep 2021 11:52:18 +0200 Horatiu Vultur wrote:
> +static void lan966x_get_eth_mac_stats(struct net_device *dev,
> +				      struct ethtool_eth_mac_stats *mac_stats)

Great to see this API used, please also consider adding RMON stats
since the seem to be present.
