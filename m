Return-Path: <SRS0=AJ/8=YZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BA6CA9ECF
	for <linux-pm@archiver.kernel.org>; Fri,  1 Nov 2019 12:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAA021835
	for <linux-pm@archiver.kernel.org>; Fri,  1 Nov 2019 12:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572609817;
	bh=bQIZ9ql1z+orJ6tZbfwvwhvSrei/8dAbIzTz8s48GAU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vzBYIHvvuqRcrnbmZdcwtEh4CQAxQJqFwhOnSFldPwyZWqSniGNQZMHBIWkXNsS3e
	 QE2f0DF3QQlL2wFVUdlCxbzvB/GBxFgVdydRzQdsovODRbwQtG+gkUZHDGznUZamXl
	 H6JfendY+aogCBzr3et5yL/7FQmBeCO9TWxckAVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbfKAMDg (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:03:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45180 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfKAMDg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 08:03:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id k2so7912348oij.12
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2019 05:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZrok7cgkO94R/GUFiBWhLW1yCsEGrtv4jiMULTddOw=;
        b=hSRzv6n/kIRPaxProSIWJMVO5Dygku6BDhxK7S+1POvYRM+rdzM79TmoQuiVFgcRDh
         mHF+MhhbhoiVd8SxJ5gB8sES9sIob4L43LIHjPZeydKJgJypHsSanUiATJR2gN2SqITN
         fXnPZnTQhrRAhDPeJZHa7mnMm3W7Cf1VaQIgdyatcOX5piE5TC43BT7dEiVGtrecxEaR
         qzTNI13TG3Sql2wPbRev62xFyFWuG7dEyyRmqy8Erpa5m0VFEfWgN0hAAkjfg0kCzxNC
         TF6bZc6zx0Lvgt0Xkhun4m4FxkculGff8Cp1jYmK3qTYK1NO8RCU/n5Hq9nizajkSZVF
         G0Zw==
X-Gm-Message-State: APjAAAU2yJ3rKynRjhC8JkhUK3FmQ1c/TCgWnOWLDYKTC0C7tdz1byyV
        ojX1T0CHaofle7IWNXuxdqgk/x65lsFgsPJasfg=
X-Google-Smtp-Source: APXvYqz4jTyd+oOcqRgHj3HeRfxE9Zz96+rDD4WhjiNTdrLb8yg4tNy2W25a3lQBHR8UqRVWEf9W2yc6pERWLOD4Cjc=
X-Received: by 2002:aca:1b05:: with SMTP id b5mr5166663oib.103.1572609814909;
 Fri, 01 Nov 2019 05:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <c222deda79ad334ff4edcbd49ddda248685c4ee1.1572395990.git.leonard.crestez@nxp.com>
 <3169109.BFaCN5124U@kreacher> <20191031222356.GE27773@google.com>
In-Reply-To: <20191031222356.GE27773@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Nov 2019 13:03:23 +0100
Message-ID: <CAJZ5v0gu-kEXNYyAcpDgK712-Ca+iAtu7OPSW+ECJoiF9fV=eg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Add user_min/max_freq
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 31, 2019 at 11:24 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Thu, Oct 31, 2019 at 11:24:31AM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, October 30, 2019 1:41:49 AM CET Leonard Crestez wrote:
> > > Current values in scaling_min_freq and scaling_max freq can change on
> > > the fly due to event such as thermal monitoring.
> >
> > Which is intentional.
> >
> > > This behavior is confusing for userspace and because once an userspace
> > > limit is written to scaling_min/max_freq it is not possible to read it back.
> >
> > That can be argued both ways.
> >
> > It is also useful to know the effective constraints and arguably the ability
> > to read back the values that you have written is mostly needed for debugging
> > the code.
>
> Agreed that reading the values back is probably mostly useful for debugging.
>
> Reading the effective constraints is a debugging use case as well, userspace
> can't make any decisions based on values which might be in constant flux.

It sometimes helps to diagnose issues on production systems, though.
If you see those numbers change even without writing to the
attributes, for example, that indicates the existence of a source of
frequency constraints in the system (e.g. platform firmware) that
might have gone unnoticed otherwise.

> IMO the current interface is completely counterintuitive, I really hope we
> wouldn't implement it the same way if given a chance to do it again. If there
> is use for reading the effective constraints it should be exposed as a separate
> read-only attribute. Keep it simple (when possible).

I agree that such a design would have been better, but the existing
one cannot be changed this way now.  And I had not invented it. :-)
