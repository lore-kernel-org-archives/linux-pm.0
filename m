From: Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: [PATCH v2] PM / suspend: replacing printk
Date: Tue, 27 Oct 2015 20:26:54 +0100
Message-ID: <CAFLxGvwkk+DJ+AACoC6dG4M4jtnW=F=Qm082hFJHQSYoujc6PA@mail.gmail.com>
References: <saurabh.truth@gmail.com>
	<1445973676-4394-1-git-send-email-saurabh.truth@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34303 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965111AbbJ0T0z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 15:26:55 -0400
In-Reply-To: <1445973676-4394-1-git-send-email-saurabh.truth@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saurabh Sengar <saurabh.truth@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Tue, Oct 27, 2015 at 8:21 PM, Saurabh Sengar <saurabh.truth@gmail.com> wrote:
> replacing prink(s) with appropriate pr_info and pr_err
>
> Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>
> ---
>  kernel/power/suspend.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

In which way does this patch improve the existing code?
You describe what it does but not which problem it solves and
why this patch is necessary.

-- 
Thanks,
//richard
