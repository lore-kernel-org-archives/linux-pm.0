From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 2/2] PM / sleep: don't suspend parent when async child
 suspend_{noirq,early} fails
Date: Thu, 27 Oct 2016 09:03:07 -0700
Message-ID: <20161027160306.GA39629@google.com>
References: <1476923170-111986-1-git-send-email-briannorris@chromium.org>
 <1476923170-111986-2-git-send-email-briannorris@chromium.org>
 <20161020004610.GC78840@google.com>
 <20161027153406.GA3208@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35566 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936570AbcJ0QDK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Oct 2016 12:03:10 -0400
Received: by mail-pf0-f180.google.com with SMTP id s8so20335568pfj.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Oct 2016 09:03:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20161027153406.GA3208@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, linux-pm@vger.kernel.org, Chuansheng Liu <chuansheng.liu@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Thu, Oct 27, 2016 at 05:34:06PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 19, 2016 at 05:46:11PM -0700, Brian Norris wrote:
> > Ugh, as I hope the patch context makes clear, the subject should be
> > 
> > s/early/late/
> > 
> > as should the body of the commit message.
[...]
> > If the patch is otherwise acceptable, feel free to make the above edits.
> > Or I can fix them up if I send v2.
> 
> Please fix up, we should never have to hand-edit a changelog text...

Sorry, I figured it was possible to get review without spamming
everyone. If I was going to need a v2 anyway, for example, then why
bother for a trivial change.

I'll send v2 (of just this patch) shortly.

Thanks,
Brian
