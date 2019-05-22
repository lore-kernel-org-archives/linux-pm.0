Return-Path: <SRS0=xSzh=TW=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA95C282CE
	for <linux-pm@archiver.kernel.org>; Wed, 22 May 2019 15:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63E120881
	for <linux-pm@archiver.kernel.org>; Wed, 22 May 2019 15:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558540193;
	bh=GVaDf+8jMnRzNoxsnrTiR7Zx0EeR4IbMBtg21YZ7gsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P4LRLME62IUZ5Jud9Mmch/E5iaBulN0NpBq1VBVRrsoMUkkLt8XXdiqRfxBnQRhfm
	 l9/DmjooDeIkzwGSLNQaRR8XwJpf3hklIRHcRunKsWu1Sb8hhtyhPa0s5cILC/jB9f
	 4ilOaMI/re2YYr6G44H25r0X/ySBNUP0c3fL6ehY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfEVPtx (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 22 May 2019 11:49:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:55764 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729375AbfEVPtx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 May 2019 11:49:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 08:49:52 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 22 May 2019 08:49:51 -0700
Date:   Wed, 22 May 2019 09:44:48 -0600
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
Message-ID: <20190522154448.GA5393@localhost.localdomain>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
 <20190521161532.GD1639@localhost.localdomain>
 <CAC5umyi4t-r+0WbGjfa=_6ym_n=vcx5855nwL6NxuXH_HhYXkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC5umyi4t-r+0WbGjfa=_6ym_n=vcx5855nwL6NxuXH_HhYXkA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 23, 2019 at 12:44:04AM +0900, Akinobu Mita wrote:
> 2019年5月22日(水) 1:20 Keith Busch <kbusch@kernel.org>:
> >
> > On Wed, May 22, 2019 at 01:04:07AM +0900, Akinobu Mita wrote:
> > > +int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> > > +{
> > > +     struct nvme_smart_log *log;
> > > +     int ret;
> > > +     int i;
> > > +
> > > +     log = kzalloc(sizeof(*log), GFP_KERNEL);
> > > +     if (!log)
> > > +             return 0; /* non-fatal error */
> > > +
> > > +     ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> > > +                        log, sizeof(*log), 0);
> > > +     if (ret) {
> > > +             dev_err(ctrl->device, "Failed to get SMART log: %d\n", ret);
> > > +             ret = ret > 0 ? -EINVAL : ret;
> >
> > A ret > 0 means the device provided a response, so don't return a
> > negative for that condition, please. That's just going to break
> > controllers that don't provide smart data, like qemu.
> 
> After looking at __nvme_submit_sync_cmd(), it returns -EINTR if the device
> doesn't respond.  So, should this return a negative only when nvme_get_log()
> returns -EINTR?
> 
>         ret = nvme_get_log();
>         if (ret) {
>                 dev_err(...);
>                 if (ret != -EINTR)
>                         ret = 0;
>                 goto free_log;
>         }

We return a different negative error if we can't allocate a request,
like what happens if the controller is dead, like a surprise hot remove.

There's a simpler way to look at this: if ret >= 0, we may proceed,
otherwise we're done with this controller. Don't make it any more
complicated than that.
