Return-Path: <SRS0=SSH8=U2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFFEC4321A
	for <linux-pm@archiver.kernel.org>; Thu, 27 Jun 2019 22:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA11205F4
	for <linux-pm@archiver.kernel.org>; Thu, 27 Jun 2019 22:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfF0WDR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:03:17 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49672 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfF0WDR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 18:03:17 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 53583284a03059e6; Fri, 28 Jun 2019 00:03:15 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3] powercap/intel_rapl: add support for more Icelake platforms
Date:   Fri, 28 Jun 2019 00:03:15 +0200
Message-ID: <2810604.mF1Qch8YXu@kreacher>
In-Reply-To: <1560778395-15088-1-git-send-email-rui.zhang@intel.com>
References: <1560778395-15088-1-git-send-email-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, June 17, 2019 3:33:12 PM CEST Zhang Rui wrote:
> This patch series add intel_rapl support for more IceLake platforms including
> ICX, ICX-D and ICL desktop.
> 
> Note that all the patches depend on commit e35faeb64146
> ("x86/CPU: Add more Icelake model numbers") which is just merged in 5.2-rc5.
> 
> thanks,
> rui
> 
> 

All three applied, thanks!




