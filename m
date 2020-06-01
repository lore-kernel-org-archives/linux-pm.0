Return-Path: <SRS0=FZcM=7O=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EF9C433E0
	for <linux-pm@archiver.kernel.org>; Mon,  1 Jun 2020 10:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F321206A4
	for <linux-pm@archiver.kernel.org>; Mon,  1 Jun 2020 10:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591009035;
	bh=WitvPwySzmD0GgPBRDISO+C8C7sQjRq82UQnHNa1mok=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=syL1ONQNIMZTNIePWfPY5f+UBAYTtT9IIRzsefMEiAKI59C6PcFgyn8PGKkrldLxN
	 8o+n6McS4JCm8r46MVHXXSp5+ZF4qG1FRLN47gsuMTSoFoupIkwc4opWP3iStoS7Hw
	 8aqXRzBFALjHmqnv3LR4ldAI3RUhXwLyCOMni8Po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgFAK5O (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 1 Jun 2020 06:57:14 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34333 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAK5N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2020 06:57:13 -0400
Received: by mail-oi1-f196.google.com with SMTP id w4so8550211oia.1
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2020 03:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6p3gRkmcNenifyX9yc6xx9fokHoaPxNxP8DLYDyavr0=;
        b=kddAGjZat5R99hBxSgNO/73HojbKk0eollfpphfnT79hS5nDjXN/7IyBXI5CzBv3W5
         G0f5v3cAOqPAipOtr93rAeTJ504boBqKnpojYEp82EwN7ujKvf0c+Ex7rtn+Xy3UKEun
         VfNgR9ojyFZueanCsriilHyG5cfTYRNTqokZj5m1GbFeXXuPRd4onc8qJ9VSpUtRHRvk
         sqkwUHx+o6uONhiU0yka/hd+glcH92aUd9dwEMWrFlk3KW/XB+v04ftcyQBK2KxXU3b/
         3ScMIie0aBjjRmBxZDitG06ZlsYzcEiSDhxGxuzno1Nc+u8vv9MaRVg6ElcLpnfYmWwg
         CaHQ==
X-Gm-Message-State: AOAM533JqMKTpM+Acgj3+ElP8jbTpGE3bP46lIEGrV6ofu+MI7Z+1jT2
        vxgiR/cPltajSp5iFzsQThUmqgAFUShSD6dKaKw=
X-Google-Smtp-Source: ABdhPJwiZ5MFe9B4AGzO72k/2DZcc+6a2v0919FEhmDC/9I/BckrigIxhp/pdMm5Pow8OcXzpZJodikj4qrn7Q7ajYw=
X-Received: by 2002:aca:4254:: with SMTP id p81mr13309271oia.68.1591009031922;
 Mon, 01 Jun 2020 03:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200601043440.c5oiuucf7wuqeasd@vireshk-i7> <20200601074230.xflri4k5tmrbyezo@vireshk-i7>
In-Reply-To: <20200601074230.xflri4k5tmrbyezo@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Jun 2020 12:56:55 +0200
Message-ID: <CAJZ5v0gmO8CJkG0h6o9CgjRONTZ4Zc7ZJqJucCfYcYp9ivng3g@mail.gmail.com>
Subject: Re: [GIT PULL] OPP changes for 5.8
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 1, 2020 at 9:42 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 01-06-20, 10:04, Viresh Kumar wrote:
> > Hi Rafael,
> >
> > This pull request contains:
> >
> > - support for interconnect bandwidth in the OPP core (Georgi Djakov,
> >   Saravana Kannan, Sibi Sankar, Viresh Kumar).
> >
> > - support for regulator enable/disable (Kamil Konieczny).
> >
> > This is based on three patches from the interconnect tree which shall
> > get merged via Greg's tree.
> >
> > -------------------------8<-------------------------
> >
> > The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:
> >
> >   Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
> >
> > for you to fetch changes up to 264c280442847ac7ed0bb89ac3a1e2e8859f25d8:
> >
> >   opp: Don't parse icc paths unnecessarily (2020-06-01 09:37:45 +0530)
> >
>
> Had to modify the top commit a bit, here are the pull details:
>
> The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:
>
>   Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to 45679f9b508f10c12a1e93cf2bdccbc1c594aa39:
>
>   opp: Don't parse icc paths unnecessarily (2020-06-01 13:10:15 +0530)

Pulled now, thanks!
