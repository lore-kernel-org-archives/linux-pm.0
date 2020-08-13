Return-Path: <SRS0=PvxO=BX=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EA3C433DF
	for <linux-pm@archiver.kernel.org>; Thu, 13 Aug 2020 22:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D45D320791
	for <linux-pm@archiver.kernel.org>; Thu, 13 Aug 2020 22:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597356015;
	bh=vlsWaYFVe3gItpXQqmeeuu7cRn1RXP8qOk+fIJGg/8w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lA5SoYMBOgyW7FZ4DQdImwjXy6Ftzx0WsDd/S2z0QcbBQ8KqNWd3LNfNe7bIcaMKG
	 leYVEVglRzYe7V2dU17Q3D9wV+WiwL9DktvwPOSL4kyq28sztqq1JoYdA2Eej2K1Z2
	 PZtDPmKTV/10sEZEkfANXH1QPTRBhWci6jDcw1OY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgHMWAP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 13 Aug 2020 18:00:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36593 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHMWAP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 18:00:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id ba10so5362540edb.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2020 15:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrqvKTbzKNLnM4toW8w+kWmLyw3OECNjlKk5RDKCbi4=;
        b=Qoj9hj6Zik3gabjlvWs7mSIgo7J1D4j6B/mGynlA/9ZPe3oMFJxIu2SNZbsL9bjPW6
         zTpNK0Y7dACJxzBGLHNWG0hKweKoxLmAyVsU4ZCUQeTUJLpUcrqeGuL8LedJTjBF0B5A
         sbNX2iF7FSb0oEwmoZ624KGI1RPw/0SsOpVUk/1JA+IH8Z4Ts4Tnxr/hQPt+JQPVhjjl
         Se0rzHyLRE5WYHT9H4bBzoX01e7r+XvcDrBEqOGtERVEP/QbTmrNZKTiEJiGH1XiJ6Wf
         4JW2yp9ahsGMKN4wG3vPF7KGH7/YziTpFJ4Prq/zFiyjEcVPVCbkLDBK9p3CAkwMdhvY
         cPaQ==
X-Gm-Message-State: AOAM532CGjl9nxaJZFnFUbuCu6hyQpdsdwdNmvyuVmdUJ3fOyOohupZH
        HR2FbYTNKCOL7+ZHX0jtv1C18kQAzwC+o53WeLTUNPrr
X-Google-Smtp-Source: ABdhPJx2+l+zOYc1sIMTJLaIQpvZOdJybVh1eYiFwTBf1GO9dqMZUI1QxRZ0kL/fHUSs/hVlsw53ArYLeTBYkUd1Gpg=
X-Received: by 2002:aa7:da04:: with SMTP id r4mr6838881eds.265.1597356013325;
 Thu, 13 Aug 2020 15:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200422220207.17425-1-rafael.antognolli@intel.com> <20200429221447.zsyd2gwc76zweum4@rantogno-mobl4.amr.corp.intel.com>
In-Reply-To: <20200429221447.zsyd2gwc76zweum4@rantogno-mobl4.amr.corp.intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 13 Aug 2020 18:00:02 -0400
Message-ID: <CAJvTdKk5H1MBJqQSG0BC9om6_h3-yJ==4xEh8YpTNzKpfQRGqg@mail.gmail.com>
Subject: Re: [PATCH 0/1] Add new GFXAMHz field to turbostat.
To:     Rafael Antognolli <rafael.antognolli@intel.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Looks reasonable, Rafael, thanks for the patch.

It doesn't apply cleanly to my top of tree, but if I can get it to
apply in min time later today, i'll do so.

On Wed, Apr 29, 2020 at 6:14 PM Rafael Antognolli
<rafael.antognolli@intel.com> wrote:
>
> Hi again...
>
> Does anyone feel like taking a look at this? Or maybe do their own
> implementation?
>
> Thank you,
> Rafael
>
> On Wed, Apr 22, 2020 at 03:02:06PM -0700, Rafael Antognolli wrote:
> > Hi,
> >
> > I work on the Mesa team at Intel and we have been using turbostat a lot
> > to monitor CPU and GPU frequency. However, turbostat only displays the
> > frequency read by
> > /sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz. We have been
> > also manually printing the content from gt_act_freq_mhz, but would be
> > nice if it was just another column in turbostat.
> >
> > The following patch adds that, with a field name called "GFXAMHz" (open
> > to better names, of course). Would it be reasonable to have such patch?
> >
> > If not, would you propose something else instead?
> >
> > Thank you!
> >
> > Rafael Antognolli (1):
> >   turbostat: Add a new GFXAMHz column that exposes gt_act_freq_mhz.
> >
> >  tools/power/x86/turbostat/turbostat.c | 50 +++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > --
> > 2.26.2
> >



-- 
Len Brown, Intel Open Source Technology Center
