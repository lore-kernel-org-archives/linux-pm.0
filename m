Return-Path: <SRS0=519e=UD=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF332C282CE
	for <linux-pm@archiver.kernel.org>; Tue,  4 Jun 2019 07:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34CF24708
	for <linux-pm@archiver.kernel.org>; Tue,  4 Jun 2019 07:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfFDHcH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:32:07 -0400
Received: from verein.lst.de ([213.95.11.211]:33837 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfFDHcH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Jun 2019 03:32:07 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7DB5B68B02; Tue,  4 Jun 2019 09:31:40 +0200 (CEST)
Date:   Tue, 4 Jun 2019 09:31:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v3 2/3] nvme: add thermal zone devices
Message-ID: <20190604073140.GH15680@lst.de>
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com> <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com> <20190601090238.GD6453@lst.de> <CAC5umyiBmD6-3BNLfG7sNOe9jde8Ct16a9N_Ao3T_1_G1K_DDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC5umyiBmD6-3BNLfG7sNOe9jde8Ct16a9N_Ao3T_1_G1K_DDA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jun 02, 2019 at 10:19:08PM +0900, Akinobu Mita wrote:
> As long as the user space thermal governor is used, there is nothing more
> than that from a functional perspective.  And I suppose that this is used
> with user_space governor (i.e. there is still some work to be able to bind
> actual thermal cooling device).
> 
> The main purpose of this is to turn on a fan when overheated without
> polling the device that could prevent the lower power state transitions.
> But as you noted, we could do that with the existing AEN notifications
> through uevent.
> 
> So frankly speaking, the benefit of this is providing generic thermal sysfs
> interface and the tools like tmon (linux/tools/thermal/tmon) can show the
> nvme temperatures.

I'm just a little worried about bloating the nvme driver with features
that look kinda nifty but don't buy us much.  I'd rather keep at least
the core and PCIe drivers as minimal.  Now the thermal device support
is pretty small and except for the smart uevents I can't find anything
actually bad, but I'm not exactly excited either.
