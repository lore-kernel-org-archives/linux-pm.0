Return-Path: <SRS0=iPxC=B6=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2873C433E3
	for <linux-pm@archiver.kernel.org>; Thu, 20 Aug 2020 10:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACCB220658
	for <linux-pm@archiver.kernel.org>; Thu, 20 Aug 2020 10:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgHTK2O (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:28:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:46132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731854AbgHTK1s (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Aug 2020 06:27:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53E5CAE33;
        Thu, 20 Aug 2020 10:28:14 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.com>
To:     shuah@kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpupower: speed up generating git version string
Date:   Thu, 20 Aug 2020 12:27:46 +0200
Message-ID: <1698400.ZyLY7WPuaR@c100>
In-Reply-To: <20200812094912.2648-1-martin.kaistra@linutronix.de>
References: <20200812094912.2648-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Mittwoch, 12. August 2020, 11:49:12 CEST schrieb Martin Kaistra:
> The variable VERSION is expanded for every use of CFLAGS. This causes
> "git describe" to get called multiple times on the kernel tree, which
> can be quite slow.
> 
> The git revision does not change during build, so we can use simple
> variable expansion to set VERSION.

Good catch,  thanks!

Acked-by: Thomas Renninger <trenn@suse.de>



