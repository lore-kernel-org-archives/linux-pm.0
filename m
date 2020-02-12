Return-Path: <SRS0=mnou=4A=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8318BC3B186
	for <linux-pm@archiver.kernel.org>; Wed, 12 Feb 2020 18:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BF720661
	for <linux-pm@archiver.kernel.org>; Wed, 12 Feb 2020 18:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgBLSAs (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 12 Feb 2020 13:00:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37300 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBLSAr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 13:00:47 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j1wJZ-0001Lc-GL; Wed, 12 Feb 2020 18:00:45 +0000
Date:   Wed, 12 Feb 2020 19:00:44 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Miller <davem@davemloft.net>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rafael@kernel.org, pavel@ucw.cz,
        kuba@kernel.org, edumazet@google.com, stephen@networkplumber.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH net-next 00/10] net: fix sysfs permssions when device
 changes network
Message-ID: <20200212180044.uhxwthf5ljxrrnpe@wittgenstein>
References: <20200212104321.43570-1-christian.brauner@ubuntu.com>
 <20200212.095318.414327505774757849.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200212.095318.414327505774757849.davem@davemloft.net>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 12, 2020 at 09:53:18AM -0800, David Miller wrote:
> 
> net-next is closed

I just assumed it was open since rc1 has been out for a few days now.
Will resend once it reopens.
