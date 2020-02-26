Return-Path: <SRS0=X62Z=4O=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D709C4BA0B
	for <linux-pm@archiver.kernel.org>; Wed, 26 Feb 2020 08:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2D424650
	for <linux-pm@archiver.kernel.org>; Wed, 26 Feb 2020 08:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582705001;
	bh=AQwB89v8ebH3YVd21IcGyMfmH8x1a5GN9DmaECnRUtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MuawCnsetvqhLkEDPDfPa0StE38Urc625zgyON7MHHUWWk+O8h1Z6L5uidUzO7M8w
	 IwrCWRrd1iEwdhAjs6FfjuHNRkJRC4jYP4Y99RvLBkSJjipExF19T/I3WMz97RtOpS
	 X8dU3/DC9mNzT8TxQnD4Ild1Gv5i+C7RHVSEggUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgBZIQk (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:16:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbgBZIQk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Feb 2020 03:16:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20EC220714;
        Wed, 26 Feb 2020 08:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582704999;
        bh=AQwB89v8ebH3YVd21IcGyMfmH8x1a5GN9DmaECnRUtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PRkjcHSAHnkmQwJOgjia5+LSNgc5zjeYq7D4GjztfneR5zOA8+AegH3+z6+Gvw8Qy
         786HsZxrVEj7aQu6fJ0agvRqcfNvWR5n1PluH5fnb+uC5646ngnuMAAvjv5nNysBlz
         T+en5jyS/PR1Dd1a/NDtBbVXk4I/KvvxPHA6LYq4=
Date:   Wed, 26 Feb 2020 09:16:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 6/9] drivers/base/power: add dpm_sysfs_change_owner()
Message-ID: <20200226081636.GE24447@kroah.com>
References: <20200225131938.120447-1-christian.brauner@ubuntu.com>
 <20200225131938.120447-7-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225131938.120447-7-christian.brauner@ubuntu.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 25, 2020 at 02:19:35PM +0100, Christian Brauner wrote:
> Add a helper to change the owner of a device's power entries. This
> needs to happen when the ownership of a device is changed, e.g. when
> moving network devices between network namespaces.
> This function will be used to correctly account for ownership changes,
> e.g. when moving network devices between network namespaces.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
