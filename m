Return-Path: <SRS0=mZbj=TP=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A0CC04E53
	for <linux-pm@archiver.kernel.org>; Wed, 15 May 2019 17:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32B020881
	for <linux-pm@archiver.kernel.org>; Wed, 15 May 2019 17:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557940120;
	bh=ktgdv5ZOjN9ymcGuxvUu2RKhPUPkwJWiR1oWk8uEkQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rof67T2YJt50TfnjFei2VfOH5i9qxMI75sj4v1dk+fpS8AR0yB/3j9FB7cVJjGlDc
	 AHqO24ygAleV6BkjQ8gRZLXoyf9FVtDO2PsuammOczYEVDrzT/LCWXx1gB+Fxuzdlp
	 zqcxx8CUK0UOcDgl+fT20j3Judsp3l+CdRp7iayA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfEORIj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 15 May 2019 13:08:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:25513 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfEORIj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 May 2019 13:08:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 10:08:38 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 15 May 2019 10:08:38 -0700
Date:   Wed, 15 May 2019 11:03:20 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-pci: support thermal zone
Message-ID: <20190515170320.GA21663@localhost.localdomain>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-3-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557933437-4693-3-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 16, 2019 at 12:17:17AM +0900, Akinobu Mita wrote:
> This enables to use thermal zone interfaces for NVMe
> temperature sensors.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  drivers/nvme/host/pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index fad5395..88a25dc 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2470,6 +2470,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
>  	if (dev->ctrl.admin_q)
>  		blk_put_queue(dev->ctrl.admin_q);
>  	kfree(dev->queues);
> +	nvme_thermal_zones_unregister(&dev->ctrl);

This unregister should probably go in the nvme_remove() rather than in
the last reference release.
