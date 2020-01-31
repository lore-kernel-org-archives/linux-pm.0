Return-Path: <SRS0=myG0=3U=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343BBC2D0DB
	for <linux-pm@archiver.kernel.org>; Fri, 31 Jan 2020 16:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5FD206F0
	for <linux-pm@archiver.kernel.org>; Fri, 31 Jan 2020 16:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfRSYyVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgAaQm5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 31 Jan 2020 11:42:57 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:35020 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgAaQm5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jan 2020 11:42:57 -0500
Received: by mail-io1-f46.google.com with SMTP id h8so8882282iob.2
        for <linux-pm@vger.kernel.org>; Fri, 31 Jan 2020 08:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AEGkjrTLpW8PFA2VZaMl3lbvTCkaclGATGocK1Pa8fU=;
        b=BfRSYyVAjh9apLPT58qkK5fl60JMzJX7IkxsBYHuGld4DbEOZpHjk5eYPcHgcyOadx
         GALgGV6qYj0DuVO0LLFFIEar7jblRPx8kf4D1Tch7d4rvFhbSNS2sJ9CBnhzpvXM7xZP
         pg+qBQ9TXU4dGhCS53hPdaIzUZqftzJWvYV4l1aDUQQQGgIznoB9X1TbcN5gcqCrn9uB
         Asa48Aurq7B1TV10467q5bTIW6L+bhqWdcQWUvVOXWJMSVH+ccfvlgkF7AiNpRgsBSAg
         cmavJ8l/GA9S/mO7eUkFc/4KJLbNEdL+eF/c4jvgrmGWLOcK9XaR3ZFIqTBeCk7/7xTd
         Hx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AEGkjrTLpW8PFA2VZaMl3lbvTCkaclGATGocK1Pa8fU=;
        b=llkbC8BELjpdTxq63t3HAP7IHpD9bjxc8JBDVqWvim66iGdk3D71liWPtqUvHDxIb4
         S+XswtiNXQdGE9fzIQV+mqYfrPVOoUkdQ+ZCFYHrF8kAmdYgiq0tRxoK4kgFktsYZbWv
         Lk0IniZWe/RcEmL5zAtzHi/y4X4PmhlyyWkaah4ZEgW26XfSGmNaBdBWZwRtV6ewAICv
         OkwFShAmxT7lFgpZ8jYQQPFaJgZQqCVVq7OmWvbIJc1Dj/RmSVstc421P0rX4pTWIiJM
         4FqMVgs7mjSDhuorYLPW7yODMj781eqY7E+O/lc8ag2qTzgkMJdop11WTjyb6HOYzW2E
         1K1g==
X-Gm-Message-State: APjAAAXryyS4CeFqcPjqlmf/iHLT2LYMT84VUJmIb1agjM0J0sIebmQ5
        ycVNNCUzStDcDj7JzvUd4VSuKw8iSY9vV4Lqsu26q0tQ
X-Google-Smtp-Source: APXvYqwiww2JiAt1+GjWEgjpJ78i6Rd/dHoE3IK+smX04GHuhI/LtUSbRAX+Lm71SQli7UV0NGRfaOMlSnOjbcUWCV4=
X-Received: by 2002:a02:13c2:: with SMTP id 185mr9387059jaz.0.1580488976363;
 Fri, 31 Jan 2020 08:42:56 -0800 (PST)
MIME-Version: 1.0
From:   Sagar Sawant <sagsaw.sawant@gmail.com>
Date:   Fri, 31 Jan 2020 22:12:44 +0530
Message-ID: <CAP6n3VR4COiv8E+oB96E+uN5n44ku7_f=0ZQyjKfHChHiooVog@mail.gmail.com>
Subject: Schedutil CPU Governor
To:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

Just began using the schedutil governor on my machine ... LinuxMint
19.3 Kernel 5.3.0-24 AMD A4-9125 4gb Ram.

I am pretty impressed by it.

But wanted to report one observation.

When I ran a youtube video in Firefox browser, the video at 480p only
in windowed mode, not even full  screen, I found that schedutil peaked
the CPU frequency to 2.6 GHZ which is actually the turbo frequency of
AMD processor. The max base frequency of the processor is 2.3 GHZ.

However, when I use the ondemand scheduler, the CPU frequency is
between 1.5 to 1.9GHZ.

So it seems that when the youtube video is being played schedutil
assumes CPU is pretty busy and hence bumps up the CPU speed.

Thought I could contribute by at least reporting.

Regards,
Sagar Sawant
