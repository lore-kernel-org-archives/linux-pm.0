Return-Path: <SRS0=Yl30=UA=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B139C28CC1
	for <linux-pm@archiver.kernel.org>; Sat,  1 Jun 2019 09:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5857E2253C
	for <linux-pm@archiver.kernel.org>; Sat,  1 Jun 2019 09:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfFAJDE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 1 Jun 2019 05:03:04 -0400
Received: from verein.lst.de ([213.95.11.211]:45974 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbfFAJDE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 1 Jun 2019 05:03:04 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 63DD668AFE; Sat,  1 Jun 2019 11:02:38 +0200 (CEST)
Date:   Sat, 1 Jun 2019 11:02:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v3 2/3] nvme: add thermal zone devices
Message-ID: <20190601090238.GD6453@lst.de>
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com> <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 27, 2019 at 01:29:02AM +0900, Akinobu Mita wrote:
> The NVMe controller reports up to nine temperature values in the SMART /
> Health log page (the composite temperature and temperature sensor 1 through
> temperature sensor 8).
> 
> This provides these temperatures via thermal zone devices.

Can you explain a bit more why we'd do this?  I shows up some sysfs
files, but we could easily do that with nvme-cli, too.  Is there some
greater benefit of this integration?
