Return-Path: <SRS0=3na1=TV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9584C04AAF
	for <linux-pm@archiver.kernel.org>; Tue, 21 May 2019 16:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8DB217D8
	for <linux-pm@archiver.kernel.org>; Tue, 21 May 2019 16:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558455639;
	bh=PkTk4yFcGYfVUq9d4rdhM8wxrhZBpOhmH8sea8b9YTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nD+jh2Y/TG9OK3KzLG3zeEXQ8+POUhVwDCk/hbMBEr2lvyYoQyl4P0K4ogcAN0Xeu
	 KqN9VGiDsMYwSB4nRropzpZD5+a/6kBeLL8xQ/9pdb7ICp8Lo9Q85TN8+azLgEn+rP
	 cV533kQE5KS4fCqoqi2R9cbUNiTYGBi/8E5fYLBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfEUQUj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 21 May 2019 12:20:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:12243 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfEUQUj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 May 2019 12:20:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 09:20:38 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 21 May 2019 09:20:37 -0700
Date:   Tue, 21 May 2019 10:15:32 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@fb.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/4] nvme: add thermal zone infrastructure
Message-ID: <20190521161532.GD1639@localhost.localdomain>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 22, 2019 at 01:04:07AM +0900, Akinobu Mita wrote:
> +int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_smart_log *log;
> +	int ret;
> +	int i;
> +
> +	log = kzalloc(sizeof(*log), GFP_KERNEL);
> +	if (!log)
> +		return 0; /* non-fatal error */
> +
> +	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> +			   log, sizeof(*log), 0);
> +	if (ret) {
> +		dev_err(ctrl->device, "Failed to get SMART log: %d\n", ret);
> +		ret = ret > 0 ? -EINVAL : ret;

A ret > 0 means the device provided a response, so don't return a
negative for that condition, please. That's just going to break
controllers that don't provide smart data, like qemu.
