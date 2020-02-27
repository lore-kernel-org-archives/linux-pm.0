Return-Path: <SRS0=WjjV=4P=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF47C4BA06
	for <linux-pm@archiver.kernel.org>; Thu, 27 Feb 2020 04:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC93024683
	for <linux-pm@archiver.kernel.org>; Thu, 27 Feb 2020 04:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgB0EPZ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 26 Feb 2020 23:15:25 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36874 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbgB0EPZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 23:15:25 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 35CC815B4633C;
        Wed, 26 Feb 2020 20:15:24 -0800 (PST)
Date:   Wed, 26 Feb 2020 20:15:21 -0800 (PST)
Message-Id: <20200226.201521.831786980010249804.davem@davemloft.net>
To:     christian.brauner@ubuntu.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rafael@kernel.org, pavel@ucw.cz,
        kuba@kernel.org, edumazet@google.com, stephen@networkplumber.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/9] net: fix sysfs permssions when device changes
 network
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200227033719.1652190-1-christian.brauner@ubuntu.com>
References: <20200227033719.1652190-1-christian.brauner@ubuntu.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Feb 2020 20:15:24 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Series applied and I will push out after the build test passes.

Thanks.
