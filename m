Return-Path: <SRS0=Ee89=4J=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3F8C35640
	for <linux-pm@archiver.kernel.org>; Fri, 21 Feb 2020 07:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708AC208C4
	for <linux-pm@archiver.kernel.org>; Fri, 21 Feb 2020 07:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582268810;
	bh=ibrqazvP5mvMOwUCp2reybsuyBDK4lb6LON7qdLNQKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q0GeJZL3VjOgKRJmvZTxCHyita+EvLxYGOK1Q1f6ACLej9V/E24VJN12K9Kda3eFO
	 MFMTUy3/jCmjqCdsPBZigFg1i4Zn+TiKwVOQGeJpYFwFKZqZeTzAynNXxKDOX/dvxO
	 r9A+yVSEV5v6DuZF30K+GLFAq+AHQqsCKu4R4yOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgBUHGt (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:06:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:55118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgBUHGt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Feb 2020 02:06:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66D1B2073A;
        Fri, 21 Feb 2020 07:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582268808;
        bh=ibrqazvP5mvMOwUCp2reybsuyBDK4lb6LON7qdLNQKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AiqXo5DUOrc+WENU0x9NQ1Sp6MlbU7WEXYFFVRpTC0Acy6oebhN9mo4khAd0wAAlv
         87wVVcI3//mqPbUPSgPAe7wUEfmwn7NAfdf/gAt15mqHi9g+L+eH69IdyBzI37Bg3U
         RAOaZMJbHXuVIUx40O0gQS7gF+GJ5/7nb9ddoTpE=
Date:   Fri, 21 Feb 2020 08:06:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Orson Zhai <orson.unisoc@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, mingmin.ling@unisoc.com,
        orsonzhai@gmail.com, jingchao.ye@unisoc.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] Revert "PM / devfreq: Modify the device name as
 devfreq(X) for sysfs"
Message-ID: <20200221070646.GA4103708@kroah.com>
References: <1582220224-1904-1-git-send-email-orson.unisoc@gmail.com>
 <20200220191513.GA3450796@kroah.com>
 <CALAqxLViRgGE8FsukCJL+doqk_GqabLDCtXBWem+VOGf9xXZdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLViRgGE8FsukCJL+doqk_GqabLDCtXBWem+VOGf9xXZdg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 20, 2020 at 11:47:41AM -0800, John Stultz wrote:
> On Thu, Feb 20, 2020 at 11:15 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Feb 21, 2020 at 01:37:04AM +0800, Orson Zhai wrote:
> > > This reverts commit 4585fbcb5331fc910b7e553ad3efd0dd7b320d14.
> > >
> > > The name changing as devfreq(X) breaks some user space applications,
> > > such as Android HAL from Unisoc and Hikey [1].
> > > The device name will be changed unexpectly after every boot depending
> > > on module init sequence. It will make trouble to setup some system
> > > configuration like selinux for Android.
> > >
> > > So we'd like to revert it back to old naming rule before any better
> > > way being found.
> > >
> > > [1] https://lkml.org/lkml/2018/5/8/1042
> > >
> > > Cc: John Stultz <john.stultz@linaro.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Orson Zhai <orson.unisoc@gmail.com>
> > >
> > > ---
> > >  drivers/devfreq/devfreq.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > > index cceee8b..7dcf209 100644
> > > --- a/drivers/devfreq/devfreq.c
> > > +++ b/drivers/devfreq/devfreq.c
> > > @@ -738,7 +738,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
> > >  {
> > >       struct devfreq *devfreq;
> > >       struct devfreq_governor *governor;
> > > -     static atomic_t devfreq_no = ATOMIC_INIT(-1);
> > >       int err = 0;
> > >
> > >       if (!dev || !profile || !governor_name) {
> > > @@ -800,8 +799,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
> > >       devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
> > >       atomic_set(&devfreq->suspend_count, 0);
> > >
> > > -     dev_set_name(&devfreq->dev, "devfreq%d",
> > > -                             atomic_inc_return(&devfreq_no));
> > > +     dev_set_name(&devfreq->dev, "%s", dev_name(dev));
> > >       err = device_register(&devfreq->dev);
> > >       if (err) {
> > >               mutex_unlock(&devfreq->lock);
> > > --
> > > 2.7.4
> > >
> >
> > Thanks for this, I agree, this needs to get back to the way things were
> > as it seems to break too many existing systems as-is.
> >
> > I'll queue this up in my tree now, thanks.
> 
> Oof this old thing. I unfortunately didn't get back to look at the
> devfreq name node issue or the compatibility links, since the impact
> of the regression (breaking the powerHAL's interactions with the gpu)
> wasn't as big as other problems we had. While the regression was
> frustrating, my only hesitancy at this point is that its been this way
> since 4.10, so reverting the problematic patch is likely to break any
> new users since then.

Looks like most users just revert that commit in their trees:
	https://source.codeaurora.org/quic/la/kernel/msm-4.14/commit/drivers/devfreq?h=msm-4.14&id=ccf273f6d89ad0fa8032e9225305ad6f62c7770c

So we should be ok here.

thanks,

greg k-h
