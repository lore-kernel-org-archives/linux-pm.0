Return-Path: <SRS0=IUcY=UT=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F735C43613
	for <linux-pm@archiver.kernel.org>; Thu, 20 Jun 2019 06:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585832070B
	for <linux-pm@archiver.kernel.org>; Thu, 20 Jun 2019 06:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfFTGgv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 20 Jun 2019 02:36:51 -0400
Received: from verein.lst.de ([213.95.11.211]:58071 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfFTGgv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Jun 2019 02:36:51 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6449368B05; Thu, 20 Jun 2019 08:36:20 +0200 (CEST)
Date:   Thu, 20 Jun 2019 08:36:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v4 0/3] nvme: add thermal zone devices
Message-ID: <20190620063619.GA21034@lst.de>
References: <1560439238-4054-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560439238-4054-1-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

So the code looks perfectly fine to me.  But I'm still not convinced we
have an important enough use case, and I'm worried about the AEN uevent
implication.

Keith, Sagi, Jens, any opinion?
