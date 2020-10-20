Return-Path: <SRS0=6IJd=D3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D521EC433DF
	for <linux-pm@archiver.kernel.org>; Tue, 20 Oct 2020 11:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451A722282
	for <linux-pm@archiver.kernel.org>; Tue, 20 Oct 2020 11:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603194114;
	bh=5pDYbga30vyj+2CHLY7BNWCxMcu6q9Ooc20QO3VIUp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b4c5O0iYkbyWSRCITjW4GQwEb+d7J290NFeRIw24bcOhb1RHySEoft/mIKOAo8U0U
	 Ukf4eebefqQoYKLJJDzDN+mlK/QAXEi2zgvDcDIDu1L0++wfIQMYxk9qFbzY8QhOlr
	 wv+aYcZLjg2YbTfN8gV27Pb0aSxO2FXZwdsT71Bg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393482AbgJTLlx (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 20 Oct 2020 07:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393480AbgJTLlw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Oct 2020 07:41:52 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D91DC2098B;
        Tue, 20 Oct 2020 11:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603194112;
        bh=5pDYbga30vyj+2CHLY7BNWCxMcu6q9Ooc20QO3VIUp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gJxuZNlkyLEffynWWK+1+GqfOG4qkwrXdMcAIsTSTFJl5S/0f1Be5oIDj9aIqzVCi
         AG2XAYKcLSCd+thJsmmneyoMKzKaqyhx6T3jPDP4O5hqsiGfejSun8XQnTq8RMyPra
         VBk34202VqhTWX9gIbbWWM7RbNRldDkUjEAB1OK4=
Date:   Tue, 20 Oct 2020 13:42:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joseph Jang <josephjang@google.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com
Subject: Re: [PATCH] power: suspend: Replace dpm_watchdog by sleep timer
Message-ID: <20201020114234.GA554297@kroah.com>
References: <20201020095611.1763815-1-josephjang@google.com>
 <20201020110810.GA194512@kroah.com>
 <CAPaOXETgmHATQMM55C+2BKTQDyEnXYjknhWY7KB1jqKYynE-+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPaOXETgmHATQMM55C+2BKTQDyEnXYjknhWY7KB1jqKYynE-+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Tue, Oct 20, 2020 at 07:11:56PM +0800, Joseph Jang wrote:
> It is the same version, I just changed the commit message and removed
> dpm_watchdog.

That is not the "same version", you need to properly version your
patches when you send them as the documentation states to.

Otherwise your patches will just be ignored.

Perhaps you might want to get some more experience getting patches
accepted before trying to change core kernel code?  Try working in
drivers/staging/* on code cleanups?

good luck!

greg k-h
